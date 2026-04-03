import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  
  bool _biometricEnabled = false;
  bool _twoFactorEnabled = false;
  bool _isBiometricAvailable = false;
  
  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
  }
  
  Future<void> _checkBiometricAvailability() async {
    final isAvailable = await _localAuth.canCheckBiometrics;
    final isDeviceSupported = await _localAuth.isDeviceSupported();
    setState(() {
      _isBiometricAvailable = isAvailable && isDeviceSupported;
    });
  }
  
  Future<void> _toggleBiometric(bool value) async {
    if (value && _isBiometricAvailable) {
      final authenticated = await _localAuth.authenticate(
        localizedReason: 'سجل دخولك باستخدام بصمتك أو وجهك',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      if (authenticated) {
        setState(() => _biometricEnabled = true);
        _showSnackBar('تم تفعيل المصادقة البيومترية', Colors.green);
      } else {
        _showSnackBar('فشل التحقق من الهوية', Colors.red);
      }
    } else if (!value) {
      setState(() => _biometricEnabled = false);
      _showSnackBar('تم تعطيل المصادقة البيومترية', Colors.orange);
    }
  }
  
  Future<void> _toggleTwoFactor(bool value) async {
    if (value) {
      _showSetup2FADialog();
    } else {
      setState(() => _twoFactorEnabled = false);
      _showSnackBar('تم تعطيل المصادقة الثنائية', Colors.orange);
    }
  }
  
  void _showSetup2FADialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تفعيل المصادقة الثنائية'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code, size: 80),
            SizedBox(height: 16),
            Text('امسح رمز QR باستخدام تطبيق Google Authenticator'),
            SizedBox(height: 8),
            SelectableText('ABC123XYZ', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _twoFactorEnabled = true);
              _showSnackBar('تم تفعيل المصادقة الثنائية', Colors.green);
            },
            child: const Text('تفعيل'),
          ),
        ],
      ),
    );
  }
  
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الأمان'),
      body: ListView(
        children: [
          _buildSection('حماية الحساب'),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.fingerprint, color: AppTheme.goldColor),
            ),
            title: const Text('المصادقة البيومترية'),
            subtitle: Text(_isBiometricAvailable ? 'بصمة الإصبع / التعرف على الوجه' : 'غير مدعوم على هذا الجهاز'),
            trailing: Switch(value: _biometricEnabled, onChanged: _isBiometricAvailable ? _toggleBiometric : null, activeColor: AppTheme.goldColor),
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.security, color: AppTheme.goldColor),
            ),
            title: const Text('المصادقة الثنائية (2FA)'),
            subtitle: const Text('حماية إضافية للحساب'),
            trailing: Switch(value: _twoFactorEnabled, onChanged: _toggleTwoFactor, activeColor: AppTheme.goldColor),
          ),
          _buildSection('جلسات الدخول'),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.devices, color: AppTheme.goldColor),
            ),
            title: const Text('الأجهزة المتصلة'),
            subtitle: const Text('إدارة الأجهزة المسجلة'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.pushNamed(context, '/connected_devices'),
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.history, color: AppTheme.goldColor),
            ),
            title: const Text('سجل تسجيل الدخول'),
            subtitle: const Text('آخر 10 جلسات دخول'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.pushNamed(context, '/login_history'),
          ),
          _buildSection('الخصوصية'),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.visibility_off, color: AppTheme.goldColor),
            ),
            title: const Text('إعدادات الخصوصية'),
            subtitle: const Text('التحكم في من يرى معلوماتك'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.pushNamed(context, '/privacy_settings'),
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.block, color: AppTheme.goldColor),
            ),
            title: const Text('الحظر والإبلاغ'),
            subtitle: const Text('إدارة المستخدمين المحظورين'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.pushNamed(context, '/privacy_block'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(title, style: const TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }
}
