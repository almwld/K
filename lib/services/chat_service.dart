import 'dart:async';
import 'dart:math';
import '../models/chat_message.dart';
import '../models/conversation_model.dart';

class ChatService {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  final Random _random = Random();
  final _messagesController = StreamController<List<ChatMessage>>.broadcast();
  final _conversationsController = StreamController<List<ConversationModel>>.broadcast();
  
  List<ChatMessage> _messages = [];
  List<ConversationModel> _conversations = [];

  // ردود وهمية للدردشة
  final List<String> _botReplies = [
    'شكراً لتواصلك معنا! كيف يمكنني مساعدتك؟',
    'مرحباً! نحن سعداء بخدمتك.',
    'يمكنك تصفح منتجاتنا من الصفحة الرئيسية',
    'هل تحتاج مساعدة في شيء محدد؟',
    'سأقوم بالرد عليك في أقرب وقت',
    'شكراً لاهتمامك بمنتجاتنا',
    'نحن هنا لخدمتك على مدار الساعة',
    'هل تريد معرفة المزيد عن منتج معين؟',
  ];

  Stream<List<ChatMessage>> get messagesStream => _messagesController.stream;
  Stream<List<ConversationModel>> get conversationsStream => _conversationsController.stream;

  Future<void> init() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _conversations = [
      ConversationModel(id: '1', name: 'دعم فني', lastMessage: 'كيف يمكنني مساعدتك؟', time: 'الآن', unreadCount: 0, avatar: '🛠️'),
      ConversationModel(id: '2', name: 'المبيعات', lastMessage: 'لدينا عرض خاص اليوم', time: 'منذ ساعة', unreadCount: 2, avatar: '🛒'),
      ConversationModel(id: '3', name: 'خدمة العملاء', lastMessage: 'شكراً لتواصلك معنا', time: 'أمس', unreadCount: 0, avatar: '📞'),
    ];
    _conversationsController.add(_conversations);
  }

  Future<List<ConversationModel>> getConversations() async {
    return _conversations;
  }

  Future<List<ChatMessage>> getMessages(String conversationId) async {
    if (_messages.isEmpty) {
      _messages = [
        ChatMessage(id: '1', senderId: 'bot', receiverId: 'user', content: 'مرحباً! أنا المساعد الذكي لفلكس يمن. كيف يمكنني مساعدتك اليوم؟ 😊', timestamp: DateTime.now().subtract(const Duration(minutes: 5)), isRead: true, type: MessageType.text),
        ChatMessage(id: '2', senderId: 'user', receiverId: 'bot', content: 'مرحباً، أريد الاستفسار عن منتج', timestamp: DateTime.now().subtract(const Duration(minutes: 4)), isRead: true, type: MessageType.text),
        ChatMessage(id: '3', senderId: 'bot', receiverId: 'user', content: 'بالطبع! أي منتج تريد معرفة المزيد عنه؟ لدينا إلكترونيات، أزياء، عقارات، سيارات، وغيرها الكثير 🛍️', timestamp: DateTime.now().subtract(const Duration(minutes: 3)), isRead: true, type: MessageType.text),
      ];
    }
    return _messages;
  }

  Future<void> sendMessage(String conversationId, String content, {MessageType type = MessageType.text}) async {
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'user',
      receiverId: 'bot',
      content: content,
      timestamp: DateTime.now(),
      isRead: true,
      type: type,
    );
    _messages.add(userMessage);
    _messagesController.add(_messages);
    
    await Future.delayed(const Duration(seconds: 1));
    
    final botReply = _botReplies[_random.nextInt(_botReplies.length)];
    final botMessage = ChatMessage(
      id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
      senderId: 'bot',
      receiverId: 'user',
      content: botReply,
      timestamp: DateTime.now(),
      isRead: true,
      type: MessageType.text,
    );
    _messages.add(botMessage);
    _messagesController.add(_messages);
  }

  Future<void> markAsRead(String conversationId) async {}

  void dispose() {
    _messagesController.close();
    _conversationsController.close();
  }
}
