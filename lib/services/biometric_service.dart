import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:shared_preferences/shared_preferences.dart';

class BiometricService {
  static final BiometricService _instance = BiometricService._internal();
  factory BiometricService() => _instance;
  BiometricService._internal();

  final LocalAuthentication _localAuth = LocalAuthentication();
  
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      print('خطأ في جلب أنواع البصمة: $e');
      return [];
    }
  }

  Future<bool> isBiometricAvailable() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      return isAvailable && isDeviceSupported;
    } catch (e) {
      return false;
    }
  }

  Future<bool> hasEnrolledBiometrics() async {
    try {
      // طريقة جديدة للتحقق من وجود بصمات
      final isAvailable = await isBiometricAvailable();
      if (!isAvailable) return false;
      
      final biometrics = await getAvailableBiometrics();
      return biometrics.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<bool> authenticateWithBiometrics({
    required String reason,
    String? title,
    String? subtitle,
    String? cancelButtonTitle,
    bool stickyAuth = true,
  }) async {
    try {
      final isAvailable = await isBiometricAvailable();
      if (!isAvailable) {
        print('البصمة غير متوفرة على هذا الجهاز');
        return false;
      }

      final hasEnrolled = await hasEnrolledBiometrics();
      if (!hasEnrolled) {
        print('لا توجد بصمات مسجلة في الجهاز');
        return false;
      }

      final authenticated = await _localAuth.authenticate(
        localizedReason: reason,
        options: AuthenticationOptions(
          stickyAuth: stickyAuth,
          biometricOnly: true,
          sensitiveTransaction: true,
        ),
      );
      
      return authenticated;
    } on PlatformException catch (e) {
      print('خطأ في المصادقة: ${e.code} - ${e.message}');
      
      switch (e.code) {
        case auth_error.notAvailable:
          print('الميزة غير متوفرة');
        case auth_error.notEnrolled:
          print('لا توجد بصمات مسجلة');
        case auth_error.lockedOut:
          print('تم قفل البصمة - جرب مرة أخرى لاحقاً');
        case auth_error.passcodeNotSet:
          print('الرجاء تعيين رمز حماية للجهاز أولاً');
        default:
          print('خطأ غير معروف: ${e.message}');
      }
      return false;
    } catch (e) {
      print('خطأ عام: $e');
      return false;
    }
  }

  Future<void> saveBiometricPreference(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometric_enabled', enabled);
  }

  Future<bool> getBiometricPreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('biometric_enabled') ?? false;
  }

  Future<void> saveUserData(String userId, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
    await prefs.setString('auth_token', token);
  }

  Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'user_id': prefs.getString('user_id'),
      'auth_token': prefs.getString('auth_token'),
    };
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('auth_token');
    await prefs.remove('biometric_enabled');
  }

  String getBiometricTypeName(BiometricType type) {
    switch (type) {
      case BiometricType.face:
        return 'التعرف على الوجه';
      case BiometricType.fingerprint:
        return 'بصمة الإصبع';
      case BiometricType.iris:
        return 'مسح العين';
      default:
        return 'المصادقة البيومترية';
    }
  }
}

