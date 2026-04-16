import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;
  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _initAuth();
  }

  void _initAuth() {
    _user = _client.auth.currentUser;
    _client.auth.onAuthStateChange.listen((AuthState state) {
      _user = state.session?.user;
      notifyListeners();
    });
  }

  // تنسيق المعرف (جوال أو بريد)
  String _formatIdentifier(String input) {
    // إزالة المسافات
    input = input.trim();
    
    // التحقق إذا كان رقم جوال
    final isPhone = RegExp(r'^[0-9]{9,15}$').hasMatch(input);
    if (isPhone) {
      return '$input@flexyemen.com';
    }
    
    // إذا كان بريد إلكتروني، تأكد من صحته
    final isEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input);
    if (isEmail) {
      return input;
    }
    
    // إذا لم يكن أي منهما، استخدمه كما هو
    return input;
  }

  Future<bool> signIn(String identifier, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final email = _formatIdentifier(identifier);
      print('محاولة تسجيل الدخول: $email');
      
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      _user = response.user;
      _isLoading = false;
      notifyListeners();
      
      print('✅ تم تسجيل الدخول بنجاح: ${_user?.email}');
      return true;
    } on AuthException catch (e) {
      print('❌ AuthException: ${e.message}');
      _error = _handleAuthError(e.message);
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      print('❌ خطأ غير متوقع: $e');
      _error = 'حدث خطأ في الاتصال. الرجاء المحاولة لاحقاً.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(String identifier, String password, {String? name}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final email = _formatIdentifier(identifier);
      print('محاولة إنشاء حساب: $email');
      
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': name ?? 'مستخدم فلكس يمن',
          'phone': identifier,
        },
      );
      
      _user = response.user;
      _isLoading = false;
      notifyListeners();
      
      print('✅ تم إنشاء الحساب بنجاح');
      return true;
    } on AuthException catch (e) {
      print('❌ AuthException: ${e.message}');
      _error = _handleAuthError(e.message);
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      print('❌ خطأ غير متوقع: $e');
      _error = 'حدث خطأ في الاتصال. الرجاء المحاولة لاحقاً.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
      _user = null;
      notifyListeners();
    } catch (e) {
      print('❌ خطأ في تسجيل الخروج: $e');
    }
  }

  Future<bool> resetPassword(String identifier) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final email = _formatIdentifier(identifier);
      await _client.auth.resetPasswordForEmail(email);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('❌ خطأ في استعادة كلمة المرور: $e');
      _error = 'حدث خطأ في استعادة كلمة المرور';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  String _handleAuthError(String error) {
    if (error.contains('Invalid login credentials')) {
      return 'رقم الجوال/البريد أو كلمة المرور غير صحيحة';
    }
    if (error.contains('Email not confirmed')) {
      return 'الرجاء تأكيد الحساب أولاً';
    }
    if (error.contains('User already registered')) {
      return 'هذا الحساب مسجل مسبقاً';
    }
    if (error.contains('Password should be at least 6 characters')) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    if (error.contains('Invalid API key')) {
      return 'خطأ في المفتاح - الرجاء التحقق من الإعدادات';
    }
    return 'حدث خطأ: $error';
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
