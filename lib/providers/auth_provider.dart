import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _error;
  String? _userType;
  String? _userName;
  String? _userPhone;

  bool get isLoggedIn => _isLoggedIn;
  String? get error => _error;
  String? get userType => _userType;
  String? get userName => _userName;
  String? get userPhone => _userPhone;

  AuthProvider() {
    _loadLoginState();
  }

  Future<void> _loadLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    _userType = prefs.getString('user_type');
    _userName = prefs.getString('user_name');
    _userPhone = prefs.getString('user_phone');
    notifyListeners();
  }

  // تسجيل الدخول
  Future<bool> signIn(String email, String password) async {
    try {
      _error = null;
      // في وضع التطوير - قبول أي بيانات
      await Future.delayed(const Duration(milliseconds: 500));
      
      _isLoggedIn = true;
      _userName = email.split('@').first;
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('user_name', _userName);
      
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // تسجيل حساب جديد
  Future<bool> signUp(String phone, String password, {String? name}) async {
    try {
      _error = null;
      await Future.delayed(const Duration(milliseconds: 500));
      
      _isLoggedIn = true;
      _userName = name ?? 'مستخدم';
      _userPhone = phone;
      _userType = 'customer';
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('user_name', _userName);
      await prefs.setString('user_phone', phone);
      await prefs.setString('user_type', 'customer');
      
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // إعادة تعيين كلمة المرور
  Future<bool> resetPassword(String phoneOrEmail) async {
    try {
      _error = null;
      await Future.delayed(const Duration(milliseconds: 500));
      // في وضع التطوير - دائماً ناجح
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // الدخول كضيف
  void loginAsGuest() {
    _isLoggedIn = false;
    _userType = 'guest';
    _userName = 'زائر';
    notifyListeners();
  }

  // تسجيل الخروج
  Future<void> logout() async {
    _isLoggedIn = false;
    _userType = null;
    _userName = null;
    _userPhone = null;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_logged_in');
    await prefs.remove('user_type');
    await prefs.remove('user_name');
    await prefs.remove('user_phone');
    
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
