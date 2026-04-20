import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MiniMaxService {
  static final MiniMaxService _instance = MiniMaxService._internal();
  factory MiniMaxService() => _instance;
  MiniMaxService._internal();

  static const String _baseUrl = 'https://api.minimax.chat/v1';
  String? _apiKey;
  String? _groupId;
  bool _isInitialized = false;
  
  // سجل المحادثة للحفاظ على السياق
  final List<Map<String, String>> _conversationHistory = [];

  Future<void> init() async {
    if (!_isInitialized) {
      await dotenv.load();
      _apiKey = dotenv.env['MINIMAX_API_KEY'];
      _groupId = dotenv.env['MINIMAX_GROUP_ID'] ?? '1871489234567890123';
      _isInitialized = true;
      
      // إضافة رسالة النظام للسياق
      _conversationHistory.add({
        'role': 'system',
        'content': 'أنت المساعد الذكي لمنصة "فلكس يمن" (Flex Yemen)، وهي منصة تجارة إلكترونية ومحفظة رقمية يمنية. مهمتك مساعدة المستخدمين في:\n'
                   '- البحث عن المنتجات والأسعار\n'
                   '- تتبع الطلبات وحالة الشحن\n'
                   '- المساعدة في الدفع والمحافظ الإلكترونية\n'
                   '- الإجابة عن استفسارات المتجر\n'
                   '- تقديم نصائح التسوق\n'
                   'كن ودوداً ومفيداً، وأجب باللغة العربية الفصحى مع لمسة يمنية خفيفة. قدم إجابات مختصرة ومفيدة.'
      });
    }
  }

  // محادثة مع المساعد الذكي
  Future<String> chat(String message) async {
    await init();

    // التحقق من وجود المفتاح
    if (_apiKey == null || _apiKey!.isEmpty) {
      return 'عذراً، المساعد الذكي غير مفعل حالياً. الرجاء التواصل مع الدعم الفني.';
    }

    try {
      // إضافة رسالة المستخدم للسجل
      _conversationHistory.add({
        'role': 'user',
        'content': message,
      });

      // تجهيز الطلب
      final payload = {
        'model': 'abab6.5s-chat',
        'messages': _conversationHistory,
        'temperature': 0.7,
        'max_tokens': 500,
        'top_p': 0.95,
        'frequency_penalty': 0,
        'presence_penalty': 0,
      };

      print('