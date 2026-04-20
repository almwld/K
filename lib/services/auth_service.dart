import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  // تسجيل الدخول
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw 'حدث خطأ غير متوقع: ${e.toString()}';
    }
  }

  // إنشاء حساب جديد
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: data,
      );
      return response;
    } on AuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw 'حدث خطأ غير متوقع: ${e.toString()}';
    }
  }

  // تسجيل الخروج
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  // استعادة كلمة المرور
  Future<void> resetPassword(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw 'حدث خطأ غير متوقع: ${e.toString()}';
    }
  }

  // الحصول على المستخدم الحالي
  User? get currentUser => _client.auth.currentUser;

  // التحقق من حالة تسجيل الدخول
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  // معالجة أخطاء المصادقة
  String _handleAuthError(AuthException e) {
    switch (e.message) {
      case 'Invalid login credentials':
        return 'البريد الإلكتروني أو كلمة المرور غير صحيحة';
      case 'Email not confirmed':
        return 'الرجاء تأكيد البريد الإلكتروني أولاً';
      case 'User already registered':
        return 'البريد الإلكتروني مسجل مسبقاً';
      case 'Password should be at least 6 characters':
        return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
      case 'Invalid API key':
        return 'مفتاح API غير صالح - الرجاء التحقق من إعدادات Supabase';
      default:
        return e.message;
    }
  }
}

