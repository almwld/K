import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/biometric_service.dart';
import '../theme/app_theme.dart';
import 'biometric_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final BiometricService _biometricService = BiometricService();
  bool _isLoading = true;
  bool _showBiometricOption = false;
  String? _savedUserId;

  @override
  void initState() {
    super.initState();
    _checkSavedUser();
  }

  Future<void> _checkSavedUser() async {
    setState(() => _isLoading = true);
    
    final userData = await _biometricService.getUserData();
    final biometricEnabled = await _biometricService.getBiometricPreference();
    
    if (userData['user_id'] != null && biometricEnabled) {
      setState(() {
        _savedUserId = userData['user_id'];
        _showBiometricOption = true;
      });
    }
    
    setState(() => _isLoading = false);
  }

  Future<void> _loginWithBiometric() async {
    final success = await _biometricService.authenticateWithBiometrics(
      reason: 'استخدم بصمتك للدخول إلى حسابك',
      title: 'تسجيل الدخول',
      subtitle: 'مرحباً بعودتك',
    );
    
    if (success && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BiometricScreen(userId: _savedUserId!),
        ),
      );
    }
  }

  Future<void> _loginWithPassword() async {
    // محاكاة تسجيل الدخول
    final userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
    await _biometricService.saveUserData(userId, 'token_123');
    
    // عرض خيار تفعيل البصمة
    if (mounted) {
      _showEnableBiometricDialog();
    }
  }

  void _showEnableBiometricDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('تفعيل المصادقة البيومترية'),
        content: const Text('هل تريد تفعيل البصمة لتسجيل الدخول السريع في المرات القادمة؟'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _goToHome();
            },
            child: const Text('ليس الآن'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await _biometricService.authenticateWithBiometrics(
                reason: 'تأكيد هويتك لتفعيل البصمة',
                title: 'تفعيل البصمة',
              );
              
              if (success && mounted) {
                await _biometricService.saveBiometricPreference(true);
                _goToHome();
              } else if (mounted) {
                _goToHome();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.goldColor,
            ),
            child: const Text('تفعيل'),
          ),
        ],
      ),
    );
  }

  void _goToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text(
                'Flex Yemen',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.goldColor,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'السوق الإلكتروني اليمني',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 60),
              
              if (_showBiometricOption) ...[
                ElevatedButton(
                  onPressed: _loginWithBiometric,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.goldColor,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    '🔐 تسجيل الدخول بالبصمة',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              
              ElevatedButton(
                onPressed: _loginWithPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.goldColor.withOpacity(0.9),
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'تسجيل الدخول',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
