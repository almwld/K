import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:shared_preferences/shared_preferences.dart';

class BiometricService {
  static final BiometricService _instance = BiometricService._internal();
  factory BiometricService() => _instance;
  BiometricService._internal();

  final LocalAuthentication _localAuth = LocalAuthentication();
  
  // أنواع البصمة المدعومة
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      print('خطأ في جلب أنواع البصمة: $e');
      return [];
    }
  }

  // التحقق من إمكانية استخدام البصمة
  Future<bool> isBiometricAvailable() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      return isAvailable && isDeviceSupported;
    } catch (e) {
      return false;
    }
  }

  // التحقق من وجود بصمة مسجلة
  Future<bool> hasEnrolledBiometrics() async {
    try {
      final enrolled = await _localAuth.getEnrolledBiometrics();
      return enrolled.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // المصادقة بالبصمة
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

  // حفظ تفضيل استخدام البصمة
  Future<void> saveBiometricPreference(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometric_enabled', enabled);
  }

  // جلب تفضيل استخدام البصمة
  Future<bool> getBiometricPreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('biometric_enabled') ?? false;
  }

  // حفظ بيانات المستخدم بعد المصادقة
  Future<void> saveUserData(String userId, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
    await prefs.setString('auth_token', token);
  }

  // استرجاع بيانات المستخدم
  Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'user_id': prefs.getString('user_id'),
      'auth_token': prefs.getString('auth_token'),
    };
  }

  // مسح بيانات المستخدم
  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('auth_token');
    await prefs.remove('biometric_enabled');
  }

  // الحصول على اسم نوع البصمة المناسب
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
