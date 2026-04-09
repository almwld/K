import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/message_model.dart';
import '../models/conversation_model.dart';

class ChatService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  
  List<ConversationModel> _conversations = [];
  List<MessageModel> _messages = [];
  bool _isLoading = false;
  String? _currentConversationId;
  RealtimeChannel? _messagesChannel;
  RealtimeChannel? _conversationsChannel;

  List<ConversationModel> get conversations => _conversations;
  List<MessageModel> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get currentConversationId => _currentConversationId;

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();
    
    await loadConversations();
    _listenForNewConversations();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadConversations() async {
    final currentUserId = _supabase.auth.currentUser?.id;
    if (currentUserId == null) return;

    final response = await _supabase
        .from('conversations')
        .select('''
          *,
          user1:user1_id(id, name, avatar_url),
          user2:user2_id(id, name, avatar_url)
        ''')
        .or('user1_id.eq.$currentUserId,user2_id.eq.$currentUserId')
        .order('updated_at', ascending: false);

    _conversations = (response as List).map((conv) {
      final otherUser = conv['user1_id']['id'] == currentUserId 
          ? conv['user2_id'] 
          : conv['user1_id'];
      return ConversationModel(
        id: conv['id'],
        userId: otherUser['id'],
        userName: otherUser['name'] ?? 'مستخدم',
        userAvatar: otherUser['avatar_url'],
        lastMessage: conv['last_message'] ?? '',
        lastMessageTime: DateTime.parse(conv['last_message_time'] ?? conv['created_at']),
        unreadCount: conv['${currentUserId == conv['user1_id']['id'] ? 'user1_unread_count' : 'user2_unread_count'}'] ?? 0,
      );
    }).toList();
    
    notifyListeners();
  }

  Future<void> openConversation(String conversationId) async {
    _currentConversationId = conversationId;
    await loadMessages();
    await markMessagesAsRead();
    _listenForNewMessages();
    notifyListeners();
  }

  Future<void> loadMessages() async {
    if (_currentConversationId == null) return;

    final response = await _supabase
        .from('messages')
        .select()
        .eq('conversation_id', _currentConversationId!)
        .order('created_at', ascending: true);

    _messages = (response as List).map((msg) => MessageModel.fromJson(msg)).toList();
    MessageModel.currentUserId = _supabase.auth.currentUser?.id ?? '';
    notifyListeners();
  }

  Future<void> sendMessage(String message) async {
    if (_currentConversationId == null || message.trim().isEmpty) return;

    final currentUserId = _supabase.auth.currentUser?.id;
    if (currentUserId == null) return;

    final tempId = DateTime.now().millisecondsSinceEpoch.toString();
    final tempMessage = MessageModel(
      id: tempId,
      conversationId: _currentConversationId!,
      senderId: currentUserId,
      message: message,
      createdAt: DateTime.now(),
      isSending: true,
    );

    _messages.add(tempMessage);
    notifyListeners();

    try {
      final response = await _supabase.from('messages').insert({
        'conversation_id': _currentConversationId,
        'sender_id': currentUserId,
        'message': message,
      }).select();

      if (response.isNotEmpty) {
        final index = _messages.indexWhere((m) => m.id == tempId);
        if (index != -1) {
          _messages[index] = MessageModel.fromJson(response[0]);
          _messages[index].isSending = false;
          notifyListeners();
        }
      }
    } catch (e) {
      final index = _messages.indexWhere((m) => m.id == tempId);
      if (index != -1) {
        _messages.removeAt(index);
        notifyListeners();
      }
      debugPrint('Error sending message: $e');
    }
  }

  Future<void> markMessagesAsRead() async {
    if (_currentConversationId == null) return;

    final currentUserId = _supabase.auth.currentUser?.id;
    if (currentUserId == null) return;

    await _supabase
        .from('messages')
        .update({'is_read': true})
        .eq('conversation_id', _currentConversationId!)
        .neq('sender_id', currentUserId)
        .eq('is_read', false);
  }

  void _listenForNewMessages() {
    if (_messagesChannel != null) {
      _messagesChannel?.unsubscribe();
    }

    if (_currentConversationId == null) return;

    _messagesChannel = _supabase
        .channel('messages:${_currentConversationId}')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'messages',
          callback: (payload) {
            final newMessage = MessageModel.fromJson(payload.newRecord);
            if (newMessage.senderId != _supabase.auth.currentUser?.id) {
              _messages.add(newMessage);
              notifyListeners();
              markMessagesAsRead();
            }
          },
        )
        .subscribe();
  }

  void _listenForNewConversations() {
    final currentUserId = _supabase.auth.currentUser?.id;
    if (currentUserId == null) return;

    _conversationsChannel = _supabase
        .channel('conversations')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'conversations',
          callback: (payload) {
            loadConversations();
          },
        )
        .subscribe();
  }

  void dispose() {
    _messagesChannel?.unsubscribe();
    _conversationsChannel?.unsubscribe();
    super.dispose();
  }
}
