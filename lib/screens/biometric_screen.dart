import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import '../services/biometric_service.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import 'home_screen.dart';

class BiometricScreen extends StatefulWidget {
  final String? userId;
  final String? redirectTo;
  
  const BiometricScreen({
    super.key, 
    this.userId,
    this.redirectTo,
  });

  @override
  State<BiometricScreen> createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> {
  final BiometricService _biometricService = BiometricService();
  bool _isBiometricAvailable = false;
  bool _hasEnrolledBiometrics = false;
  List<BiometricType> _availableBiometrics = [];
  bool _isLoading = true;
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    setState(() => _isLoading = true);
    
    final isAvailable = await _biometricService.isBiometricAvailable();
    final hasEnrolled = await _biometricService.hasEnrolledBiometrics();
    final biometrics = await _biometricService.getAvailableBiometrics();
    
    setState(() {
      _isBiometricAvailable = isAvailable;
      _hasEnrolledBiometrics = hasEnrolled;
      _availableBiometrics = biometrics;
      _isLoading = false;
    });
  }

  String _getBiometricIcon() {
    if (_availableBiometrics.contains(BiometricType.face)) return '😊';
    if (_availableBiometrics.contains(BiometricType.fingerprint)) return '👆';
    if (_availableBiometrics.contains(BiometricType.iris)) return '👁️';
    return '🔐';
  }

  String _getBiometricTypeText() {
    if (_availableBiometrics.contains(BiometricType.face)) return 'الوجه';
    if (_availableBiometrics.contains(BiometricType.fingerprint)) return 'البصمة';
    if (_availableBiometrics.contains(BiometricType.iris)) return 'العين';
    return 'البيومترية';
  }

  Future<void> _authenticate() async {
    if (_isAuthenticating) return;
    
    setState(() => _isAuthenticating = true);
    
    final success = await _biometricService.authenticateWithBiometrics(
      reason: 'الرجاء المصادقة للوصول إلى حسابك في Flex Yemen',
      title: 'المصادقة البيومترية',
      subtitle: 'استخدم ${_getBiometricTypeText()} للدخول',
      cancelButtonTitle: 'إلغاء',
    );
    
    setState(() => _isAuthenticating = false);
    
    if (success && mounted) {
      await _biometricService.saveBiometricPreference(true);
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('فشلت المصادقة. الرجاء المحاولة مرة أخرى'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _skipForNow() async {
    await _biometricService.saveBiometricPreference(false);
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark 
          ? AppTheme.nightBackground 
          : AppTheme.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading)
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.gold),
                )
              else if (!_isBiometricAvailable || !_hasEnrolledBiometrics)
                _buildNotAvailableWidget()
              else
                _buildBiometricWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotAvailableWidget() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.fingerprint,
            size: 60,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'المصادقة البيومترية غير متوفرة',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          _hasEnrolledBiometrics 
              ? 'الجهاز لا يدعم المصادقة البيومترية'
              : 'الرجاء إضافة بصمة أو وجه في إعدادات جهازك أولاً',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: _skipForNow,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.gold,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('تخطي الآن'),
        ),
      ],
    );
  }

  Widget _buildBiometricWidget() {
    return Column(
      children: [
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.gold, Color(0xFFFFD700)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.gold.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Center(
            child: Text(
              _getBiometricIcon(),
              style: const TextStyle(fontSize: 60),
            ),
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'مرحباً بعودتك',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'استخدم ${_getBiometricTypeText()} للدخول بسرعة وأمان',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: _isAuthenticating ? null : _authenticate,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.gold,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: _isAuthenticating
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  'المصادقة باستخدام ${_getBiometricTypeText()}',
                  style: const TextStyle(fontSize: 18),
                ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: _skipForNow,
          child: const Text(
            'تخطي الآن',
            style: TextStyle(color: AppTheme.gold),
          ),
        ),
      ],
    );
  }
}
