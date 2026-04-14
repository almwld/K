import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EmailService {
  static final EmailService _instance = EmailService._internal();
  factory EmailService() => _instance;
  EmailService._internal();

  late String _apiKey;
  final String _baseUrl = 'https://api.resend.com';

  Future<void> init() async {
    await dotenv.load();
    _apiKey = dotenv.env['RESEND_API_KEY'] ?? '';
  }

  Future<bool> sendVerificationEmail(String to, String name, String verificationLink) async {
    if (_apiKey.isEmpty) return false;

    final html = '''
    <!DOCTYPE html>
    <html dir="rtl" lang="ar">
    <head>
      <meta charset="UTF-8">
      <title>تأكيد بريدك الإلكتروني</title>
      <style>
        body { font-family: 'Tajawal', sans-serif; background: #f5f5f5; padding: 20px; }
        .container { max-width: 600px; margin: 0 auto; background: white; border-radius: 20px; overflow: hidden; }
        .header { background: linear-gradient(135deg, #D4AF37, #FFD700); padding: 30px; text-align: center; }
        .logo { font-size: 28px; font-weight: bold; color: #000; }
        .content { padding: 30px; }
        .button { background: #D4AF37; color: #000; padding: 12px 30px; text-decoration: none; border-radius: 25px; display: inline-block; }
        .footer { background: #f8f9fa; padding: 20px; text-align: center; font-size: 12px; color: #666; }
      </style>
    </head>
    <body>
      <div class="container">
        <div class="header">
          <div class="logo">🛍️ فلكس اليمن</div>
        </div>
        <div class="content">
          <h2>مرحباً $name! 👋</h2>
          <p>شكراً لانضمامك إلى <strong>فلكس اليمن</strong>.</p>
          <p>يرجى النقر على الزر أدناه لتأكيد بريدك الإلكتروني:</p>
          <div style="text-align: center; margin: 30px 0;">
            <a href="$verificationLink" class="button">✅ تأكيد البريد الإلكتروني</a>
          </div>
          <p>إذا لم تقم بإنشاء هذا الحساب، يمكنك تجاهل هذا البريد.</p>
        </div>
        <div class="footer">
          © 2024 فلكس اليمن - جميع الحقوق محفوظة
        </div>
      </div>
    </body>
    </html>
    ''';
    
    return await _sendEmail(to, 'تأكيد بريدك الإلكتروني - فلكس اليمن', html);
  }

  Future<bool> sendPasswordResetEmail(String to, String resetLink) async {
    if (_apiKey.isEmpty) return false;

    final html = '''
    <!DOCTYPE html>
    <html dir="rtl" lang="ar">
    <head>
      <meta charset="UTF-8">
      <title>إعادة تعيين كلمة المرور</title>
      <style>
        body { font-family: 'Tajawal', sans-serif; background: #f5f5f5; padding: 20px; }
        .container { max-width: 600px; margin: 0 auto; background: white; border-radius: 20px; overflow: hidden; }
        .header { background: linear-gradient(135deg, #D4AF37, #FFD700); padding: 30px; text-align: center; }
        .reset-code { background: #f0f0f0; padding: 15px; font-size: 24px; letter-spacing: 4px; text-align: center; font-family: monospace; }
        .button { background: #D4AF37; color: #000; padding: 12px 30px; text-decoration: none; border-radius: 25px; display: inline-block; }
      </style>
    </head>
    <body>
      <div class="container">
        <div class="header">
          <div class="logo">🔐 فلكس اليمن</div>
        </div>
        <div class="content">
          <h2>إعادة تعيين كلمة المرور</h2>
          <p>لقد طلبت إعادة تعيين كلمة المرور لحسابك.</p>
          <div style="text-align: center; margin: 30px 0;">
            <a href="$resetLink" class="button">🔄 إعادة تعيين كلمة المرور</a>
          </div>
          <p>هذا الرابط صالح لمدة 24 ساعة.</p>
          <p>إذا لم تطلب هذا التغيير، يمكنك تجاهل هذا البريد.</p>
        </div>
        <div class="footer">
          © 2024 فلكس اليمن - جميع الحقوق محفوظة
        </div>
      </div>
    </body>
    </html>
    ''';
    
    return await _sendEmail(to, 'إعادة تعيين كلمة المرور - فلكس اليمن', html);
  }

  Future<bool> _sendEmail(String to, String subject, String html) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/emails'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'from': 'Flex Yemen <noreply@resend.dev>',
          'to': [to],
          'subject': subject,
          'html': html,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('❌ خطأ في إرسال البريد: $e');
      return false;
    }
  }
}
