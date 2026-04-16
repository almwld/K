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

      print('=== MiniMax Request ===');
      print('API Key exists: ${_apiKey != null}');
      print('Message: $message');

      final response = await http.post(
        Uri.parse('$_baseUrl/text/chatcompletion_v2'),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      ).timeout(const Duration(seconds: 30));

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply = data['reply'] ?? data['choices']?[0]?['message']?['content'];
        
        if (reply != null && reply.isNotEmpty) {
          // إضافة رد المساعد للسجل
          _conversationHistory.add({
            'role': 'assistant',
            'content': reply,
          });
          
          // الحفاظ على حجم السجل (آخر 20 رسالة)
          if (_conversationHistory.length > 21) {
            _conversationHistory.removeRange(1, 3);
          }
          
          return reply;
        }
        return 'عذراً، لم أتمكن من فهم سؤالك. هل يمكنك إعادة الصياغة؟';
      } else if (response.statusCode == 401) {
        return 'عذراً، مفتاح API غير صالح. الرجاء التحقق من الإعدادات.';
      } else if (response.statusCode == 429) {
        return 'عذراً، تم تجاوز الحد المسموح من الطلبات. الرجاء المحاولة لاحقاً.';
      } else {
        print('Error response: ${response.body}');
        return 'عذراً، حدث خطأ في الاتصال بالمساعد الذكي. الرجاء المحاولة لاحقاً.';
      }
    } on TimeoutException {
      return 'عذراً، استغرق الرد وقتاً طويلاً. الرجاء المحاولة مرة أخرى.';
    } catch (e) {
      print('Exception: $e');
      return 'عذراً، حدث خطأ غير متوقع. الرجاء المحاولة لاحقاً.';
    }
  }

  // مسح سجل المحادثة
  void clearHistory() {
    _conversationHistory.clear();
    _conversationHistory.add({
      'role': 'system',
      'content': 'أنت المساعد الذكي لمنصة "فلكس يمن" (Flex Yemen)...'
    });
  }

  // الحصول على اقتراحات للأسئلة الشائعة
  List<String> getSuggestedQuestions() {
    return [
      'كيف يمكنني تتبع طلبي؟',
      'ما هي طرق الدفع المتاحة؟',
      'كم رسوم التوصيل؟',
      'كيف أتواصل مع البائع؟',
      'ما هي سياسة الاسترجاع؟',
      'كيف أضيف منتجاً للسلة؟',
    ];
  }
}
