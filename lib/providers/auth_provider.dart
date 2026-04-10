import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;
  String get userName => _user?.fullName ?? 'مستخدم';
  String get userEmail => _user?.email ?? '';
  String? get userAvatar => _user?.avatarUrl;

  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        _user = UserModel(
          id: response.user!.id,
          email: email,
          fullName: response.user!.userMetadata?['name'] ?? '',
        );
      }
    } catch (e) {
      print('خطأ في تسجيل الدخول: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );
      if (response.user != null) {
        _user = UserModel(
          id: response.user!.id,
          email: email,
          fullName: name,
        );
      }
    } catch (e) {
      print('خطأ في إنشاء الحساب: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
    _user = null;
    notifyListeners();
  }
}
