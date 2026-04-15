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
  List<ChatMessage> get messages => _messages;

  Future<void> init() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _conversations = [
      ConversationModel(id: '1', name: 'دعم فني', lastMessage: 'كيف يمكنني مساعدتك؟', time: 'الآن', unreadCount: 0, avatar: '🛠️', isOnline: true),
      ConversationModel(id: '2', name: 'المبيعات', lastMessage: 'لدينا عرض خاص اليوم', time: 'منذ ساعة', unreadCount: 2, avatar: '🛒', isOnline: true),
      ConversationModel(id: '3', name: 'خدمة العملاء', lastMessage: 'شكراً لتواصلك معنا', time: 'أمس', unreadCount: 0, avatar: '📞', isOnline: false),
    ];
    _conversationsController.add(_conversations);
  }

  Future<List<ConversationModel>> getConversations() async {
    return _conversations;
  }

  Future<void> openConversation(String conversationId) async {
    _messages = [
      ChatMessage(id: '1', senderId: 'bot', content: 'مرحباً! أنا المساعد الذكي لفلكس يمن. كيف يمكنني مساعدتك اليوم؟ 😊', timestamp: DateTime.now().subtract(const Duration(minutes: 5)), isRead: true, type: MessageType.text),
      ChatMessage(id: '2', senderId: 'user', content: 'مرحباً، أريد الاستفسار عن منتج', timestamp: DateTime.now().subtract(const Duration(minutes: 4)), isRead: true, type: MessageType.text),
      ChatMessage(id: '3', senderId: 'bot', content: 'بالطبع! أي منتج تريد معرفة المزيد عنه؟ لدينا إلكترونيات، أزياء، عقارات، سيارات، وغيرها الكثير 🛍️', timestamp: DateTime.now().subtract(const Duration(minutes: 3)), isRead: true, type: MessageType.text),
    ];
    _messagesController.add(_messages);
  }

  Future<List<ChatMessage>> getMessages(String conversationId) async {
    if (_messages.isEmpty) {
      await openConversation(conversationId);
    }
    return _messages;
  }

  Future<void> sendMessage(String conversationId, String content, {MessageType type = MessageType.text}) async {
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'user',
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
      content: botReply,
      timestamp: DateTime.now(),
      isRead: true,
      type: MessageType.text,
    );
    _messages.add(botMessage);
    _messagesController.add(_messages);
  }

  Future<void> markAsRead(String conversationId) async {
    // Mark messages as read
  }

  void dispose() {
    _messagesController.close();
    _conversationsController.close();
  }
}
