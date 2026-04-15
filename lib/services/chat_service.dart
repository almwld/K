import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/chat_message.dart';

class ChatService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  
  List<ChatMessage> _messages = [];
  List<Map<String, dynamic>> _conversations = [];
  bool _isLoading = false;
  String? _currentConversationId;
  RealtimeChannel? _messagesChannel;

  List<ChatMessage> get messages => _messages;
  List<Map<String, dynamic>> get conversations => _conversations;
  bool get isLoading => _isLoading;
  String? get currentConversationId => _currentConversationId;

  Future<void> loadConversations() async {
    _isLoading = true;
    notifyListeners();

    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    final response = await _supabase
        .from('conversations')
        .select('''
          *,
          user1:profiles!conversations_user1_id_fkey(id, name, avatar_url),
          user2:profiles!conversations_user2_id_fkey(id, name, avatar_url)
        ''')
        .or('user1_id.eq.$userId,user2_id.eq.$userId')
        .order('updated_at', ascending: false);

    _conversations = List<Map<String, dynamic>>.from(response);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> openConversation(String conversationId) async {
    _currentConversationId = conversationId;
    await _loadMessages(conversationId);
    _listenForNewMessages(conversationId);
    notifyListeners();
  }

  Future<void> _loadMessages(String conversationId) async {
    final response = await _supabase
        .from('messages')
        .select()
        .eq('conversation_id', conversationId)
        .order('created_at', ascending: true);

    _messages = (response as List).map((msg) => ChatMessage.fromJson(msg)).toList();
    ChatMessage.currentUserId = _supabase.auth.currentUser?.id ?? '';
    notifyListeners();
  }

  Future<void> sendMessage(String conversationId, String message, {String type = 'text', String? mediaUrl}) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    final response = await _supabase.from('messages').insert({
      'conversation_id': conversationId,
      'sender_id': userId,
      'message': message,
      'type': type,
      'media_url': mediaUrl,
      'created_at': DateTime.now().toIso8601String(),
    }).select();

    if (response.isNotEmpty) {
      final newMessage = ChatMessage.fromJson(response[0]);
      _messages.add(newMessage);
      notifyListeners();
    }
  }

  void _listenForNewMessages(String conversationId) {
    if (_messagesChannel != null) {
      _messagesChannel?.unsubscribe();
    }

    _messagesChannel = _supabase
        .channel('messages:$conversationId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'messages',
          callback: (payload) {
            final newMessage = ChatMessage.fromJson(payload.newRecord);
            if (newMessage.senderId != _supabase.auth.currentUser?.id) {
              _messages.add(newMessage);
              notifyListeners();
            }
          },
        )
        .subscribe();
  }

  Future<void> markAsRead(String messageId) async {
    await _supabase
        .from('messages')
        .update({'is_read': true})
        .eq('id', messageId);
  }

  Future<void> addReaction(String messageId, String reaction) async {
    await _supabase
        .from('messages')
        .update({'reaction': reaction})
        .eq('id', messageId);
  }

  void dispose() {
    _messagesChannel?.unsubscribe();
    super.dispose();
  }
}
