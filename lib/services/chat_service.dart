import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/chat_message.dart';

class ChatService {
  final SupabaseClient _supabase = Supabase.instance.client;
  late RealtimeChannel _channel;
  
  final List<ChatMessage> _messages = [];
  final List<Function(ChatMessage)> _messageListeners = [];

  List<ChatMessage> get messages => _messages;

  Future<void> init(String conversationId) async {
    await _loadMessages(conversationId);
    _subscribeToMessages(conversationId);
  }

  Future<void> _loadMessages(String conversationId) async {
    final response = await _supabase
        .from('messages')
        .select()
        .eq('conversation_id', conversationId)
        .order('created_at', ascending: true)
        .limit(50);

    _messages.clear();
    for (var msg in response) {
      _messages.add(ChatMessage.fromJson(msg));
    }
  }

  void _subscribeToMessages(String conversationId) {
    _channel = _supabase
        .channel('messages:$conversationId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'messages',
          callback: (payload) {
            final newMessage = ChatMessage.fromJson(payload.newRecord);
            _messages.add(newMessage);
            for (var listener in _messageListeners) {
              listener(newMessage);
            }
          },
        )
        .subscribe();
  }

  Future<void> sendMessage(String conversationId, String message, {String type = 'text', String? mediaUrl}) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    await _supabase.from('messages').insert({
      'conversation_id': conversationId,
      'sender_id': userId,
      'message': message,
      'type': type,
      'media_url': mediaUrl,
      'created_at': DateTime.now().toIso8601String(),
    });
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

  void addMessageListener(Function(ChatMessage) listener) {
    _messageListeners.add(listener);
  }

  void dispose() {
    _channel.unsubscribe();
  }
}
