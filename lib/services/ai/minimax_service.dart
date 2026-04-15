import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MiniMaxService {
  static final MiniMaxService _instance = MiniMaxService._internal();
  factory MiniMaxService() => _instance;
  MiniMaxService._internal();

  late String _apiKey;
  final String _baseUrl = 'https://api.minimax.chat/v1';

  Future<void> init() async {
    await dotenv.load();
    _apiKey = dotenv.env['MINIMAX_API_KEY'] ?? '';
    if (_apiKey.isEmpty) {
      print('⚠️ MiniMax API Key not found in .env');
    }
  }

  Future<String> chat(String message) async {
    if (_apiKey.isEmpty) {
      return _getMockResponse(message);
    }

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'abab6.5s-chat',
          'messages': [
            {
              'role': 'system',
              'content': 'أنت مساعد ذكي لمتجر فلكس يمن. أجب بالعربية بشكل مفيد ومختصر.'
            },
            {
              'role': 'user',
              'content': message
            }
          ],
          'temperature': 0.7,
          'max_tokens': 500,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'] ?? 'عذراً، لم أستطع معالجة طلبك.';
      } else {
        return '⚠️ حدث خطأ في الاتصال بالخادم.';
      }
    } catch (e) {
      return _getMockResponse(message);
    }
  }

  String _getMockResponse(String message) {
    if (message.contains('سعر')) {
      return '💰 الأسعار تبدأ من 1000 ريال. يمكنك الاطلاع على التفاصيل في صفحة المنتج.';
    }
    if (message.contains('شحن')) {
      return '🚚 نوفر خدمة التوصيل لجميع المحافظات خلال 3-5 أيام عمل.';
    }
    return 'شكراً لتواصلك مع فريق دعم فلكس يمن. كيف يمكننا مساعدتك؟ 😊';
  }
}
