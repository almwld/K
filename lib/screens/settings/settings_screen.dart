import '../theme_selection_screen.dart';
import '../../widgets/social_media_widget.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import '../appearance_screen.dart';
import '../notifications_settings_screen.dart';
import '../language_screen.dart';
import '../privacy_settings_screen.dart';
import '../security_settings_screen.dart';
import '../help_support_screen.dart';
import '../about_app_screen.dart';
import '../policy/privacy_policy_screen.dart';
import '../policy/terms_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الإعدادات'),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _buildSectionHeader('المظهر'),
          _buildSettingTile(context, Icons.palette_outlined, 'المظهر', 'فاتح / داكن', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AppearanceScreen()))),
          _buildSettingTile(context, Icons.language_outlined, 'اللغة', 'العربية', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LanguageScreen()))),
          
          const SizedBox(height: 16),
          _buildSectionHeader('الإشعارات'),
          _buildSettingTile(context, Icons.notifications_outlined, 'إعدادات الإشعارات', '', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsSettingsScreen()))),
          
          const SizedBox(height: 16),
          _buildSectionHeader('الخصوصية والأمان'),
          _buildSettingTile(context, Icons.lock_outline, 'الخصوصية', '', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacySettingsScreen()))),
          _buildSettingTile(context, Icons.security_outlined, 'الأمان', '', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SecuritySettingsScreen()))),
          
          const SizedBox(height: 16),
          _buildSectionHeader('الدعم والمساعدة'),
          _buildSettingTile(context, Icons.help_outline, 'المساعدة والدعم', '', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpSupportScreen()))),
          _buildSettingTile(context, Icons.info_outline, 'عن التطبيق', '', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutAppScreen()))),
          
          const SizedBox(height: 16),
          _buildSectionHeader('القانونية'),
          _buildSettingTile(context, Icons.privacy_tip_outlined, 'سياسة الخصوصية', '', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()))),
          _buildSettingTile(context, Icons.description_outlined, 'الشروط والأحكام', '', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsScreen()))),
          
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('الإصدار 2.0.0', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(title, style: TextStyle(color: AppTheme.goldPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }

  Widget _buildSettingTile(BuildContext context, IconData icon, String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppTheme.goldPrimary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: AppTheme.goldPrimary, size: 20)),
      title: Text(title),
      subtitle: subtitle.isNotEmpty ? Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])) : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    );
  }
}

// إضافة قسم مواقع التواصل الاجتماعي

// أضف هذا في نهاية Column قبل SizedBox الأخير
// const SocialMediaWidget(),

// إضافة في قائمة الإعدادات
  void _openThemeSelection(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ThemeSelectionScreen()),
    );
  }
