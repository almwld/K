import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/chat_model.dart';

class ChatService {
  final SupabaseClient _client = Supabase.instance.client;
  
  final _conversationsController = StreamController<List<ConversationModel>>.broadcast();
  final _messagesController = StreamController<List<MessageModel>>.broadcast();
  
  List<ConversationModel> _conversations = [];
  List<MessageModel> _messages = [];
  String? _currentUserId;

  Stream<List<ConversationModel>> get conversationsStream => _conversationsController.stream;
  Stream<List<MessageModel>> get messagesStream => _messagesController.stream;
  List<ConversationModel> get conversations => _conversations;
  List<MessageModel> get messages => _messages;

  ChatService() {
    _currentUserId = _client.auth.currentUser?.id;
  }

  // تهيئة المحادثات
  Future<void> initialize() async {
    if (_currentUserId == null) return;
    await _loadConversations();
  }

  // تحميل جميع محادثات المستخدم
  Future<void> _loadConversations() async {
    try {
      final response = await _client
          .from('conversations')
          .select()
          .or('customer_id.eq.$_currentUserId,merchant_id.eq.$_currentUserId')
          .order('last_message_time', ascending: false);

      _conversations = (response as List).map<ConversationModel>((json) => 
        ConversationModel.fromJson(json as Map<String, dynamic>)
      ).toList();
      
      _conversationsController.add(_conversations);
    } catch (e) {
      _loadMockConversations();
    }
  }

  // بيانات وهمية للتجربة
  void _loadMockConversations() {
    _conversations = [
      ConversationModel(
        id: '1',
        customerId: _currentUserId ?? 'customer1',
        customerName: 'أحمد محمد',
        customerAvatar: 'https://ui-avatars.com/api/?name=Ahmed&background=D4AF37&color=fff',
        merchantId: 'merchant1',
        merchantName: 'إلكترونيات الحديثة',
        merchantAvatar: 'https://ui-avatars.com/api/?name=Electronics&background=2196F3&color=fff',
        lastMessage: 'هل المنتج متوفر؟',
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
        unreadCount: 2,
        productName: 'آيفون 15 برو',
        productImage: 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=200',
      ),
      ConversationModel(
        id: '2',
        customerId: _currentUserId ?? 'customer1',
        customerName: 'أحمد محمد',
        customerAvatar: 'https://ui-avatars.com/api/?name=Ahmed&background=D4AF37&color=fff',
        merchantId: 'merchant2',
        merchantName: 'مطعم اليمن للمندي',
        merchantAvatar: 'https://ui-avatars.com/api/?name=Restaurant&background=4CAF50&color=fff',
        lastMessage: 'تم تأكيد طلبك',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
        unreadCount: 0,
      ),
    ];
    _conversationsController.add(_conversations);
  }

  // فتح محادثة
  Future<void> openConversation(String conversationId) async {
    await loadMessages(conversationId);
  }

  // تحميل رسائل محادثة
  Future<void> loadMessages(String conversationId) async {
    try {
      final response = await _client
          .from('messages')
          .select()
          .eq('conversation_id', conversationId)
          .order('created_at', ascending: true);

      _messages = (response as List).map<MessageModel>((json) => 
        MessageModel.fromJson(json as Map<String, dynamic>)
      ).toList();
      
      _messagesController.add(_messages);
    } catch (e) {
      _loadMockMessages(conversationId);
    }
  }

  // الحصول على رسائل محادثة
  Future<List<MessageModel>> getMessages(String conversationId) async {
    await loadMessages(conversationId);
    return _messages;
  }

  // بيانات وهمية للرسائل
  void _loadMockMessages(String conversationId) {
    if (conversationId == '1') {
      _messages = [
        MessageModel(
          id: '1', conversationId: '1',
          senderId: _currentUserId ?? 'customer1',
          senderName: 'أحمد محمد',
          senderAvatar: 'https://ui-avatars.com/api/?name=Ahmed&background=D4AF37&color=fff',
          content: 'السلام عليكم، هل آيفون 15 برو متوفر؟',
          timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
          isRead: true,
        ),
        MessageModel(
          id: '2', conversationId: '1',
          senderId: 'merchant1',
          senderName: 'إلكترونيات الحديثة',
          senderAvatar: 'https://ui-avatars.com/api/?name=Electronics&background=2196F3&color=fff',
          content: 'وعليكم السلام، نعم متوفر',
          timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
          isRead: true,
        ),
        MessageModel(
          id: '3', conversationId: '1',
          senderId: 'merchant1',
          senderName: 'إلكترونيات الحديثة',
          senderAvatar: 'https://ui-avatars.com/api/?name=Electronics&background=2196F3&color=fff',
          content: 'السعر 5200 ريال مع ضمان سنتين',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          isRead: false,
        ),
      ];
    } else {
      _messages = [
        MessageModel(
          id: '1', conversationId: conversationId,
          senderId: _currentUserId ?? 'customer1',
          senderName: 'أحمد محمد',
          senderAvatar: 'https://ui-avatars.com/api/?name=Ahmed&background=D4AF37&color=fff',
          content: 'مرحباً، أريد طلب مندي لحم',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          isRead: true,
        ),
        MessageModel(
          id: '2', conversationId: conversationId,
          senderId: 'merchant2',
          senderName: 'مطعم اليمن للمندي',
          senderAvatar: 'https://ui-avatars.com/api/?name=Restaurant&background=4CAF50&color=fff',
          content: 'تم استلام طلبك',
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          isRead: true,
        ),
      ];
    }
    _messagesController.add(_messages);
  }

  // إرسال رسالة
  Future<void> sendMessage(String conversationId, String content) async {
    final message = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      conversationId: conversationId,
      senderId: _currentUserId!,
      senderName: 'أحمد محمد',
      senderAvatar: 'https://ui-avatars.com/api/?name=Ahmed&background=D4AF37&color=fff',
      content: content,
      timestamp: DateTime.now(),
      isRead: false,
    );

    _messages.add(message);
    _messagesController.add(_messages);

    try {
      await _client.from('messages').insert(message.toJson());
      await _client.from('conversations').update({
        'last_message': content,
        'last_message_time': DateTime.now().toIso8601String(),
      }).eq('id', conversationId);
    } catch (e) {
      // تجاهل الخطأ - تمت الإضافة محلياً
    }
  }

  void dispose() {
    _conversationsController.close();
    _messagesController.close();
  }
}
