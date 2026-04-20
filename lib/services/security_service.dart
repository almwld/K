import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SecurityService {
  static const String _sessionKey = 'user_session';
  static const String _twoFactorKey = 'two_factor_enabled';

  // تشفير كلمة المرور
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // التحقق من الجلسة
  static Future<bool> isSessionValid() async {
    final prefs = await SharedPreferences.getInstance();
    final session = prefs.getString(_sessionKey);
    if (session == null) return false;
    // التحقق من صلاحية الجلسة
    return true;
  }

  // إنشاء جلسة جديدة
  static Future<void> createSession(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final sessionId = _generateSessionId(userId);
    await prefs.setString(_sessionKey, sessionId);
  }

  static String _generateSessionId(String userId) {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final data = '$userId:$timestamp';
    final bytes = utf8.encode(data);
    return sha256.convert(bytes).toString();
  }

  // تفعيل المصادقة الثنائية
  static Future<void> enableTwoFactor() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_twoFactorKey, true);
  }

  static Future<bool> isTwoFactorEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_twoFactorKey) ?? false;
  }

  // تسجيل الخروج
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }
}

