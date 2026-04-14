import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MiniMaxService {
  static final MiniMaxService _instance = MiniMaxService._internal();
  factory MiniMaxService() => _instance;
  MiniMaxService._internal();

  late String _apiKey;
  late String _groupId;
  final String _baseUrl = 'https://api.minimax.chat/v1';

  Future<void> init() async {
    await dotenv.load();
    _apiKey = dotenv.env['MINIMAX_API_KEY'] ?? '';
    _groupId = dotenv.env['MINIMAX_GROUP_ID'] ?? '';
    print('✅ MiniMax initialized');
  }

  Future<String> chat(String message) async {
    if (_apiKey.isEmpty) {
      return '⚠️ مفتاح API غير موجود. الرجاء إضافة المفتاح في ملف .env';
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
              'content': 'أنت مساعد ذكي لمتجر فلكس يمن. أجب بالعربية بشكل مفيد ومختصر. ساعد العملاء في استفساراتهم عن المنتجات والأسعار والشحن.'
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
        return '⚠️ حدث خطأ في الاتصال بالخادم. الرجاء المحاولة مرة أخرى.';
      }
    } catch (e) {
      return '⚠️ خطأ في الاتصال. تأكد من اتصالك بالإنترنت.';
    }
  }
}
