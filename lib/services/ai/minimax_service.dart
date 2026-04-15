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

  Future<void> init() async {
    if (!_isInitialized) {
      await dotenv.load();
      _apiKey = dotenv.env['MINIMAX_API_KEY'];
      _groupId = dotenv.env['MINIMAX_GROUP_ID'] ?? '1871489234567890123';
      _isInitialized = true;
    }
  }

  // محادثة مع المساعد الذكي
  Future<String> chat(String message, {List<Map<String, String>>? history}) async {
    await init();

    if (_apiKey == null || _apiKey!.isEmpty) {
      return 'عذراً، لم يتم تكوين المساعد الذكي بعد. الرجاء إضافة مفتاح API.';
    }

    try {
      final messages = <Map<String, String>>[
        {
          'role': 'system',
          'content': 'أنت مساعد ذكي لمنصة "فلكس يمن" (Flex Yemen)، وهي منصة تجارة إلكترونية ومحفظة رقمية يمنية. مهمتك مساعدة المستخدمين في التسوق، الدفع، الشحن، والاستفسارات المتعلقة بالمنصة. كن ودوداً ومفيداً، وأجب باللغة العربية الفصحى مع لمسة يمنية خفيفة. قدم إجابات مختصرة ومفيدة.'
        },
      ];

      if (history != null && history.isNotEmpty) {
        messages.addAll(history);
      }

      messages.add({
        'role': 'user',
        'content': message,
      });

      final response = await http.post(
        Uri.parse('$_baseUrl/text/chatcompletion_v2'),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'abab6.5s-chat',
          'messages': messages,
          'temperature': 0.7,
          'max_tokens': 500,
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['reply'] != null && data['reply'].isNotEmpty) {
          return data['reply'];
        }
        return 'عذراً، لم أتمكن من فهم سؤالك. هل يمكنك إعادة الصياغة؟';
      } else if (response.statusCode == 401) {
        return 'عذراً، مفتاح API غير صالح. الرجاء التحقق من الإعدادات.';
      } else if (response.statusCode == 429) {
        return 'عذراً، تم تجاوز الحد المسموح من الطلبات. الرجاء المحاولة لاحقاً.';
      } else {
        return 'عذراً، حدث خطأ في الاتصال بالمساعد الذكي. الرجاء المحاولة لاحقاً.';
      }
    } on TimeoutException {
      return 'عذراً، استغرق الرد وقتاً طويلاً. الرجاء المحاولة مرة أخرى.';
    } catch (e) {
      return 'عذراً، حدث خطأ غير متوقع: ${e.toString()}';
    }
  }

  // محادثة متدفقة (Stream)
  Stream<String> chatStream(String message, {List<Map<String, String>>? history}) async* {
    await init();

    if (_apiKey == null || _apiKey!.isEmpty) {
      yield 'عذراً، لم يتم تكوين المساعد الذكي بعد.';
      return;
    }

    try {
      final messages = <Map<String, String>>[
        {
          'role': 'system',
          'content': 'أنت مساعد ذكي لمنصة "فلكس يمن" (Flex Yemen)، منصة تجارة إلكترونية ومحفظة رقمية يمنية. أجب بالعربية بشكل مفيد وودود.'
        },
      ];

      if (history != null && history.isNotEmpty) {
        messages.addAll(history);
      }

      messages.add({
        'role': 'user',
        'content': message,
      });

      final request = http.Request('POST', Uri.parse('$_baseUrl/text/chatcompletion_v2'))
        ..headers.addAll({
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        })
        ..body = jsonEncode({
          'model': 'abab6.5s-chat',
          'messages': messages,
          'temperature': 0.7,
          'max_tokens': 500,
          'stream': true,
        });

      final response = await request.send();
      
      await for (final chunk in response.stream.transform(utf8.decoder)) {
        for (final line in chunk.split('\n')) {
          if (line.startsWith('data: ')) {
            final data = line.substring(6);
            if (data != '[DONE]') {
              try {
                final json = jsonDecode(data);
                if (json['delta'] != null && json['delta']['content'] != null) {
                  yield json['delta']['content'];
                }
              } catch (e) {
                // تجاهل أخطاء التحليل
              }
            }
          }
        }
      }
    } catch (e) {
      yield 'عذراً، حدث خطأ: ${e.toString()}';
    }
  }
}
