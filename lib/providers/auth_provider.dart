import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/cache/local_storage_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isGuest = false;
  UserModel? _userData;

  bool get isLoggedIn => _isLoggedIn;
  bool get isGuest => _isGuest;
  UserModel? get userData => _userData;
  String? get userName => _userData?.fullName;
  String? get userEmail => _userData?.email;
  String? get userAvatar => _userData?.avatarUrl;
  String? get userType => _userData?.userType;

  AuthProvider() {
    _loadAuthState();
  }

  void _loadAuthState() {
    _isLoggedIn = LocalStorageService.isLoggedIn();
    final userDataMap = LocalStorageService.getUserData();
    if (userDataMap != null) {
      _userData = UserModel.fromJson(userDataMap);
    }
    _isGuest = LocalStorageService.getBool('is_guest', defaultValue: false);
    notifyListeners();
  }

  Future<void> login(UserModel userData, {bool isGuest = false}) async {
    _isLoggedIn = true;
    _isGuest = isGuest;
    _userData = userData;

    await LocalStorageService.saveUserData(userData.toJson());
    await LocalStorageService.setBool('is_guest', isGuest);

    notifyListeners();
  }

  Future<void> loginAsGuest() async {
    final guestData = UserModel(
      id: 'guest_${DateTime.now().millisecondsSinceEpoch}',
      fullName: 'ضيف',
      email: 'guest@flexyemen.com',
      phone: '',
      userType: 'guest',
    );
    await login(guestData, isGuest: true);
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _isGuest = false;
    _userData = null;

    await LocalStorageService.clearUserData();
    await LocalStorageService.setBool('is_guest', false);

    notifyListeners();
  }

  Future<void> updateUserData(Map<String, dynamic> userData) async {
    if (_userData != null) {
      final updatedData = {..._userData!.toJson(), ...userData};
      _userData = UserModel.fromJson(updatedData);
      await LocalStorageService.saveUserData(updatedData);
      notifyListeners();
    }
  }

  bool get canAccessFullFeatures => _isLoggedIn && !_isGuest;
}
