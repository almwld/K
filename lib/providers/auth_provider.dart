import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
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
    _user = _authService.currentUser;
    _authService.authStateChanges.listen((AuthState state) {
      _user = state.session?.user;
      notifyListeners();
    });
  }

  Future<bool> signIn(String phone, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Format phone as email for Supabase (phone@flexyemen.com)
      final email = '$phone@flexyemen.com';
      await _authService.signIn(email: email, password: password);
      _user = _authService.currentUser;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = _handleError(e.toString());
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(String phone, String password, {String? name}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final email = '$phone@flexyemen.com';
      await _authService.signUp(
        email: email,
        password: password,
        data: {
          'full_name': name ?? 'مستخدم فلكس يمن',
          'phone': phone,
        },
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = _handleError(e.toString());
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }

  Future<bool> resetPassword(String phone) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final email = '$phone@flexyemen.com';
      await _authService.resetPassword(email);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = _handleError(e.toString());
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  String _handleError(String error) {
    if (error.contains('Invalid login credentials')) {
      return 'رقم الجوال أو كلمة المرور غير صحيحة';
    }
    if (error.contains('Email not confirmed')) {
      return 'الرجاء تأكيد رقم الجوال أولاً';
    }
    if (error.contains('User already registered')) {
      return 'رقم الجوال مسجل مسبقاً';
    }
    if (error.contains('Password should be at least 6 characters')) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    if (error.contains('Invalid API key')) {
      return 'خطأ في الاتصال بالخادم - الرجاء المحاولة لاحقاً';
    }
    return error;
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
