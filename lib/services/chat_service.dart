import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  
  List<Map<String, dynamic>> _conversations = [];
  List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;
  String? _currentConversationId;
  RealtimeChannel? _messagesChannel;

  List<Map<String, dynamic>> get conversations => _conversations;
  List<Map<String, dynamic>> get messages => _messages;
  bool get isLoading => _isLoading;

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
          user1:user1_id(id, name, avatar_url),
          user2:user2_id(id, name, avatar_url)
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

    _messages = List<Map<String, dynamic>>.from(response);
    notifyListeners();
  }

  Future<void> sendMessage(String conversationId, String message) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    await _supabase.from('messages').insert({
      'conversation_id': conversationId,
      'sender_id': userId,
      'message': message,
      'created_at': DateTime.now().toIso8601String(),
    });

    await _loadMessages(conversationId);
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
            _loadMessages(conversationId);
          },
        )
        .subscribe();
  }

  Future<void> createConversation(String otherUserId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    final existing = await _supabase
        .from('conversations')
        .select()
        .or('and(user1_id.eq.$userId,user2_id.eq.$otherUserId),and(user1_id.eq.$otherUserId,user2_id.eq.$userId)')
        .maybeSingle();

    if (existing != null) {
      await openConversation(existing['id']);
      return;
    }

    final response = await _supabase.from('conversations').insert({
      'user1_id': userId,
      'user2_id': otherUserId,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    }).select();

    if (response.isNotEmpty) {
      await openConversation(response[0]['id']);
    }
  }

  void dispose() {
    _messagesChannel?.unsubscribe();
    super.dispose();
  }
}
