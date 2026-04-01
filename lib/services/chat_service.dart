import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // إنشاء محادثة جديدة
  Future<ChatModel?> createChat({
    required String userId1,
    required String userId2,
    required String productId,
    required String productTitle,
    required String productImage,
    required String user1Name,
    required String user2Name,
    String? user1Avatar,
    String? user2Avatar,
  }) async {
    try {
      final response = await _supabase.from('chats').insert({
        'user1_id': userId1,
        'user2_id': userId2,
        'product_id': productId,
        'product_title': productTitle,
        'product_image': productImage,
        'user1_name': user1Name,
        'user2_name': user2Name,
        'user1_avatar': user1Avatar,
        'user2_avatar': user2Avatar,
        'last_message': '',
        'last_message_time': DateTime.now().toIso8601String(),
        'created_at': DateTime.now().toIso8601String(),
      }).select().single();

      return ChatModel(
        id: response['id'],
        user1Id: response['user1_id'],
        user2Id: response['user2_id'],
        user1Name: response['user1_name'],
        user2Name: response['user2_name'],
        user1Avatar: response['user1_avatar'],
        user2Avatar: response['user2_avatar'],
        productId: response['product_id'],
        productTitle: response['product_title'],
        productImage: response['product_image'],
        lastMessage: response['last_message'] ?? '',
        lastMessageTime: DateTime.parse(response['last_message_time']),
        unreadCount: 0,
      );
    } catch (e) {
      debugPrint('Error creating chat: $e');
      return null;
    }
  }

  // جلب محادثات المستخدم
  Future<List<ChatModel>> getUserChats(String userId) async {
    try {
      final response = await _supabase
          .from('chats')
          .select()
          .or('user1_id.eq.$userId,user2_id.eq.$userId')
          .order('last_message_time', ascending: false);

      return response.map<ChatModel>((chat) => ChatModel(
        id: chat['id'],
        user1Id: chat['user1_id'],
        user2Id: chat['user2_id'],
        user1Name: chat['user1_name'],
        user2Name: chat['user2_name'],
        user1Avatar: chat['user1_avatar'],
        user2Avatar: chat['user2_avatar'],
        productId: chat['product_id'],
        productTitle: chat['product_title'],
        productImage: chat['product_image'],
        lastMessage: chat['last_message'] ?? '',
        lastMessageTime: DateTime.parse(chat['last_message_time']),
        unreadCount: chat['unread_count_${userId}'] ?? 0,
      )).toList();
    } catch (e) {
      debugPrint('Error getting chats: $e');
      return [];
    }
  }

  // الاستماع للرسائل الجديدة (Realtime)
  Stream<List<MessageModel>> listenToMessages(String chatId) {
    return _supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('chat_id', chatId)
        .order('created_at', ascending: true)
        .map((event) => event.map((msg) => MessageModel.fromJson(msg)).toList());
  }

  // إرسال رسالة
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String message,
    String? imageUrl,
    String? replyToId,
  }) async {
    try {
      await _supabase.from('messages').insert({
        'chat_id': chatId,
        'sender_id': senderId,
        'message': message,
        'image_url': imageUrl,
        'reply_to_id': replyToId,
        'created_at': DateTime.now().toIso8601String(),
      });

      // تحديث آخر رسالة في المحادثة
      await _supabase
          .from('chats')
          .update({
            'last_message': message,
            'last_message_time': DateTime.now().toIso8601String(),
          })
          .eq('id', chatId);
    } catch (e) {
      debugPrint('Error sending message: $e');
    }
  }

  // تحديث حالة القراءة
  Future<void> markMessagesAsRead(String chatId, String userId) async {
    try {
      await _supabase
          .from('messages')
          .update({'is_read': true})
          .eq('chat_id', chatId)
          .neq('sender_id', userId);
    } catch (e) {
      debugPrint('Error marking messages as read: $e');
    }
  }

  // حذف رسالة
  Future<void> deleteMessage(String messageId) async {
    try {
      await _supabase.from('messages').delete().eq('id', messageId);
    } catch (e) {
      debugPrint('Error deleting message: $e');
    }
  }
}
