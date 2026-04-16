import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/chat_model.dart';

class ChatService {
  final SupabaseClient _client = Supabase.instance.client;
  
  StreamSubscription<RealtimeMessage>? _conversationSubscription;
  StreamSubscription<RealtimeMessage>? _messageSubscription;
  
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

  // تهيئة المحادثات والاستماع للتحديثات
  Future<void> initialize() async {
    if (_currentUserId == null) return;
    
    await _loadConversations();
    _subscribeToConversations();
  }

  // تحميل جميع محادثات المستخدم
  Future<void> _loadConversations() async {
    try {
      final response = await _client
          .from('conversations')
          .select()
          .or('customer_id.eq.$_currentUserId,merchant_id.eq.$_currentUserId')
          .order('last_message_time', ascending: false);

      _conversations = response.map<ConversationModel>((json) => 
        ConversationModel.fromJson(json)
      ).toList();
      
      _conversationsController.add(_conversations);
    } catch (e) {
      print('Error loading conversations: $e');
      // استخدام بيانات وهمية للتجربة
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

  // الاشتراك في تحديثات المحادثات
  void _subscribeToConversations() {
    _conversationSubscription = _client
        .from('conversations')
        .stream(primaryKey: ['id'])
        .listen((event) {
          _loadConversations();
        });
  }

  // تحميل رسائل محادثة معينة
  Future<void> loadMessages(String conversationId) async {
    try {
      final response = await _client
          .from('messages')
          .select()
          .eq('conversation_id', conversationId)
          .order('created_at', ascending: true);

      _messages = response.map<MessageModel>((json) => 
        MessageModel.fromJson(json)
      ).toList();
      
      _messagesController.add(_messages);
      
      // الاشتراك في الرسائل الجديدة
      _subscribeToMessages(conversationId);
      
      // تعليم الرسائل كمقروءة
      await _markMessagesAsRead(conversationId);
    } catch (e) {
      print('Error loading messages: $e');
      _loadMockMessages(conversationId);
    }
  }

  // بيانات وهمية للرسائل
  void _loadMockMessages(String conversationId) {
    if (conversationId == '1') {
      _messages = [
        MessageModel(
          id: '1',
          conversationId: '1',
          senderId: _currentUserId ?? 'customer1',
          senderName: 'أحمد محمد',
          senderAvatar: 'https://ui-avatars.com/api/?name=Ahmed&background=D4AF37&color=fff',
          content: 'السلام عليكم، هل آيفون 15 برو متوفر؟',
          timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
          isRead: true,
        ),
        MessageModel(
          id: '2',
          conversationId: '1',
          senderId: 'merchant1',
          senderName: 'إلكترونيات الحديثة',
          senderAvatar: 'https://ui-avatars.com/api/?name=Electronics&background=2196F3&color=fff',
          content: 'وعليكم السلام، نعم متوفر. اللون الأسود والفضي',
          timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
          isRead: true,
        ),
        MessageModel(
          id: '3',
          conversationId: '1',
          senderId: _currentUserId ?? 'customer1',
          senderName: 'أحمد محمد',
          senderAvatar: 'https://ui-avatars.com/api/?name=Ahmed&background=D4AF37&color=fff',
          content: 'كم السعر؟',
          timestamp: DateTime.now().subtract(const Duration(minutes: 20)),
          isRead: true,
        ),
        MessageModel(
          id: '4',
          conversationId: '1',
          senderId: 'merchant1',
          senderName: 'إلكترونيات الحديثة',
          senderAvatar: 'https://ui-avatars.com/api/?name=Electronics&background=2196F3&color=fff',
          content: 'السعر 5200 ريال مع ضمان سنتين',
          timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
          isRead: true,
        ),
        MessageModel(
          id: '5',
          conversationId: '1',
          senderId: 'merchant1',
          senderName: 'إلكترونيات الحديثة',
          senderAvatar: 'https://ui-avatars.com/api/?name=Electronics&background=2196F3&color=fff',
          content: 'هل تريد طلب المنتج؟',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          isRead: false,
        ),
      ];
    } else {
      _messages = [
        MessageModel(
          id: '1',
          conversationId: conversationId,
          senderId: _currentUserId ?? 'customer1',
          senderName: 'أحمد محمد',
          senderAvatar: 'https://ui-avatars.com/api/?name=Ahmed&background=D4AF37&color=fff',
          content: 'مرحباً، أريد طلب مندي لحم',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          isRead: true,
        ),
        MessageModel(
          id: '2',
          conversationId: conversationId,
          senderId: 'merchant2',
          senderName: 'مطعم اليمن للمندي',
          senderAvatar: 'https://ui-avatars.com/api/?name=Restaurant&background=4CAF50&color=fff',
          content: 'تم استلام طلبك. سيتم التوصيل خلال 45 دقيقة',
          timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
          isRead: true,
        ),
      ];
    }
    _messagesController.add(_messages);
  }

  // الاشتراك في الرسائل الجديدة
  void _subscribeToMessages(String conversationId) {
    _messageSubscription?.cancel();
    _messageSubscription = _client
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('conversation_id', conversationId)
        .listen((event) {
          _loadMessagesFromEvent(event, conversationId);
        });
  }

  void _loadMessagesFromEvent(RealtimeMessage event, String conversationId) {
    // تحديث الرسائل عند وصول رسالة جديدة
    if (event.newRecord != null) {
      final newMessage = MessageModel.fromJson(event.newRecord!);
      if (!_messages.any((m) => m.id == newMessage.id)) {
        _messages.add(newMessage);
        _messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
        _messagesController.add(_messages);
      }
    }
  }

  // إرسال رسالة جديدة
  Future<void> sendMessage({
    required String conversationId,
    required String content,
    required String receiverId,
    MessageType type = MessageType.text,
    String? imageUrl,
  }) async {
    final message = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      conversationId: conversationId,
      senderId: _currentUserId!,
      senderName: 'أحمد محمد', // يجب جلبها من المستخدم الحالي
      senderAvatar: 'https://ui-avatars.com/api/?name=Ahmed&background=D4AF37&color=fff',
      content: content,
      timestamp: DateTime.now(),
      isRead: false,
      type: type,
      imageUrl: imageUrl,
    );

    try {
      await _client.from('messages').insert(message.toJson());
      
      // تحديث آخر رسالة في المحادثة
      await _client.from('conversations').update({
        'last_message': content,
        'last_message_time': DateTime.now().toIso8601String(),
      }).eq('id', conversationId);
      
      // إضافة الرسالة محلياً
      _messages.add(message);
      _messagesController.add(_messages);
    } catch (e) {
      print('Error sending message: $e');
      // إضافة محلياً فقط للتجربة
      _messages.add(message);
      _messagesController.add(_messages);
    }
  }

  // إنشاء محادثة جديدة
  Future<String> createConversation({
    required String merchantId,
    required String merchantName,
    required String merchantAvatar,
    String? productId,
    String? productName,
    String? productImage,
  }) async {
    final conversation = ConversationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      customerId: _currentUserId!,
      customerName: 'أحمد محمد',
      customerAvatar: 'https://ui-avatars.com/api/?name=Ahmed&background=D4AF37&color=fff',
      merchantId: merchantId,
      merchantName: merchantName,
      merchantAvatar: merchantAvatar,
      lastMessage: 'بداية محادثة جديدة',
      lastMessageTime: DateTime.now(),
      unreadCount: 0,
      productId: productId,
      productName: productName,
      productImage: productImage,
    );

    try {
      await _client.from('conversations').insert(conversation.toJson());
      _conversations.insert(0, conversation);
      _conversationsController.add(_conversations);
    } catch (e) {
      print('Error creating conversation: $e');
      _conversations.insert(0, conversation);
      _conversationsController.add(_conversations);
    }

    return conversation.id;
  }

  // تعليم الرسائل كمقروءة
  Future<void> _markMessagesAsRead(String conversationId) async {
    try {
      await _client
          .from('messages')
          .update({'is_read': true})
          .eq('conversation_id', conversationId)
          .neq('sender_id', _currentUserId);
    } catch (e) {
      print('Error marking messages as read: $e');
    }
  }

  // إلغاء الاشتراكات
  void dispose() {
    _conversationSubscription?.cancel();
    _messageSubscription?.cancel();
    _conversationsController.close();
    _messagesController.close();
  }
}
