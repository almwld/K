import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الإعدادات'),
      body: ListView(
        children: [
          // حسابي
          _buildSection('الحساب'),
          _buildItem(context, Icons.person, 'إعدادات الحساب', 'تعديل الملف الشخصي', () {
            Navigator.pushNamed(context, '/account_info');
          }),
          _buildItem(context, Icons.lock, 'الأمان والخصوصية', 'كلمة المرور والمصادقة', () {
            Navigator.pushNamed(context, '/security_settings');
          }),
          
          // التطبيق
          _buildSection('التطبيق'),
          _buildItem(context, Icons.language, 'اللغة', 'العربية', () {
            Navigator.pushNamed(context, '/language');
          }),
          _buildItem(context, Icons.notifications, 'الإشعارات', 'إدارة الإشعارات', () {
            Navigator.pushNamed(context, '/notifications_settings');
          }),
          _buildItem(context, Icons.palette, 'المظهر', 'الوضع الداكن', () {
            // تبديل الثيم
          }),
          
          // الدعم
          _buildSection('الدعم والقانونية'),
          _buildItem(context, Icons.help, 'المساعدة والدعم', 'الأسئلة الشائعة', () {
            Navigator.pushNamed(context, '/help_support');
          }),
          _buildItem(context, Icons.description, 'الشروط والأحكام', 'سياسة الاستخدام', () {
            Navigator.pushNamed(context, '/terms');
          }),
          _buildItem(context, Icons.privacy_tip, 'سياسة الخصوصية', 'حماية البيانات', () {
            Navigator.pushNamed(context, '/privacy_policy');
          }),
          _buildItem(context, Icons.info, 'حول التطبيق', 'الإصدار 1.0.0', () {
            Navigator.pushNamed(context, '/about');
          }),
          
          // خروج
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: const Icon(Icons.logout),
              label: const Text('تسجيل الخروج'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 32),
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
          color: AppTheme.goldColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, IconData icon, String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.goldColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppTheme.goldColor),
      ),
      title: Text(title),
      subtitle: Text(subtitle, style: TextStyle(color: AppTheme.darkTextSecondary)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
