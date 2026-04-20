import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class SecuritySettingsScreen extends StatelessWidget {
  const SecuritySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الأمان'),
      body: ListView(
        children: [
          _buildSection('حماية الحساب'),
          _buildItem(context, Icons.lock, 'تغيير كلمة المرور', () {
            Navigator.pushNamed(context, '/change_password');
          }),
          _buildItem(context, Icons.fingerprint, 'المصادقة البيومترية', () {
            Navigator.pushNamed(context, '/biometric_auth');
          }),
          _buildItem(context, Icons.phone_android, 'الأجهزة المتصلة', () {
            Navigator.pushNamed(context, '/connected_devices');
          }),
          _buildItem(context, Icons.history, 'سجل تسجيل الدخول', () {
            Navigator.pushNamed(context, '/login_history');
          }),
          
          _buildSection('الخصوصية'),
          _buildItem(context, Icons.visibility_off, 'إعدادات الخصوصية', () {
            Navigator.pushNamed(context, '/privacy_settings');
          }),
          _buildItem(context, Icons.block, 'الحظر', () {}),
          _buildItem(context, Icons.report, 'الإبلاغ', () {}),
          
          _buildSection('المصادقة الثنائية'),
          SwitchListTile(
            secondary: const Icon(Icons.security, color: AppTheme.gold),
            title: const Text('تفعيل 2FA'),
            subtitle: const Text('حماية إضافية للحساب'),
            value: false,
            onChanged: (v) {},
            activeColor: AppTheme.gold,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: AppTheme.gold,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.gold),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

