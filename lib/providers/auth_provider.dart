import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  // دالة لتسجيل الدخول (سيتم استدعاؤها من LoginScreen)
  Future<bool> signIn(String email, String password) async {
    // هنا يتم منطق التحقق من الخادم
    // للتبسيط، سنقوم بتغيير الحالة مباشرة
    _isLoggedIn = true;
    notifyListeners();
    return true;
  }

  // دالة لتسجيل الخروج
  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  // لتجربة الدخول كضيف (يمكن جعله لا يغير _isLoggedIn أو يجعله false)
  void loginAsGuest() {
    _isLoggedIn = false; // يبقى كضيف
    notifyListeners();
  }
}
