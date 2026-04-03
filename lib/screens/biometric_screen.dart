import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class BiometricScreen extends StatefulWidget {
  const BiometricScreen({super.key});

  @override
  State<BiometricScreen> createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  
  bool _isBiometricEnabled = false;
  bool _isBiometricAvailable = false;
  bool _isDeviceSupported = false;
  List<BiometricType> _availableBiometrics = [];
  
  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
  }
  
  Future<void> _checkBiometricAvailability() async {
    final isAvailable = await _localAuth.canCheckBiometrics;
    final isSupported = await _localAuth.isDeviceSupported();
    final biometrics = await _localAuth.getAvailableBiometrics();
    
    setState(() {
      _isBiometricAvailable = isAvailable;
      _isDeviceSupported = isSupported;
      _availableBiometrics = biometrics;
    });
  }
  
  String _getBiometricType() {
    if (_availableBiometrics.contains(BiometricType.face)) return 'التعرف على الوجه';
    if (_availableBiometrics.contains(BiometricType.fingerprint)) return 'بصمة الإصبع';
    if (_availableBiometrics.contains(BiometricType.iris)) return 'مسح العين';
    return 'المصادقة البيومترية';
  }
  
  Future<void> _enableBiometric() async {
    if (!_isDeviceSupported) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('جهازك لا يدعم المصادقة البيومترية'), backgroundColor: Colors.red),
      );
      return;
    }
    
    if (!_isBiometricAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لم يتم إعداد المصادقة البيومترية على جهازك'), backgroundColor: Colors.red),
      );
      return;
    }
    
    final authenticated = await _localAuth.authenticate(
      localizedReason: 'سجل دخولك باستخدام ${_getBiometricType()} لتأكيد هويتك',
      options: const AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true,
      ),
    );
    
    if (authenticated) {
      setState(() => _isBiometricEnabled = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم تفعيل ${_getBiometricType()} بنجاح'), backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل التحقق من الهوية'), backgroundColor: Colors.red),
      );
    }
  }
  
  Future<void> _disableBiometric() async {
    setState(() => _isBiometricEnabled = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم تعطيل المصادقة البيومترية'), backgroundColor: Colors.orange),
    );
  }
  
  Future<void> _testBiometric() async {
    final authenticated = await _localAuth.authenticate(
      localizedReason: 'اختبر ${_getBiometricType()} الخاص بك',
      options: const AuthenticationOptions(biometricOnly: true),
    );
    
    if (authenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم التحقق بنجاح'), backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل التحقق'), backgroundColor: Colors.red),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المصادقة البيومترية'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // أيقونات البيومترية
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppTheme.goldGradient,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _availableBiometrics.contains(BiometricType.face) ? Icons.face : Icons.fingerprint,
                size: 60,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            
            // حالة الجهاز
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.getCardColor(context),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildInfoRow('نوع المصادقة', _getBiometricType()),
                  _buildInfoRow('دعم الجهاز', _isDeviceSupported ? 'مدعوم ✅' : 'غير مدعوم ❌'),
                  _buildInfoRow('الحالة', _isBiometricEnabled ? 'مفعل ✅' : 'غير مفعل ❌'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // تفعيل/تعطيل
            if (!_isBiometricEnabled)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _enableBiometric,
                  icon: const Icon(Icons.fingerprint),
                  label: const Text('تفعيل المصادقة البيومترية'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.goldColor,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _disableBiometric,
                  icon: const Icon(Icons.lock_open),
                  label: const Text('تعطيل المصادقة البيومترية'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    foregroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            
            const SizedBox(height: 12),
            
            // اختبار
            if (_isBiometricEnabled)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _testBiometric,
                  icon: const Icon(Icons.check_circle),
                  label: Text('اختبار ${_getBiometricType()}'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppTheme.goldColor),
                    foregroundColor: AppTheme.goldColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            
            const SizedBox(height: 24),
            
            // معلومات
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.goldColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: AppTheme.goldColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'المصادقة البيومترية توفر طبقة إضافية من الأمان لحسابك. '
                      'سيتم طلب بصمتك أو وجهك عند تسجيل الدخول أو إجراء عمليات حساسة.',
                      style: TextStyle(fontSize: 12, color: AppTheme.getSecondaryTextColor(context)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: AppTheme.goldColor)),
        ],
      ),
    );
  }
}
