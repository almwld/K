import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import 'about_screen.dart';
import 'account_settings_screen.dart';
import 'language_screen.dart';
import 'notifications_settings_screen.dart';
import 'security_settings_screen.dart';
import 'payment_methods_screen.dart';
import 'help_support_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  final List<Map<String, dynamic>> _settingsItems = const [
    {'title': 'معلومات الحساب', 'icon': Icons.person, 'color': 0xFF4CAF50, 'route': '/account_info'},
    {'title': 'اللغة', 'icon': Icons.language, 'color': 0xFF2196F3, 'route': '/language'},
    {'title': 'الإشعارات', 'icon': Icons.notifications, 'color': 0xFFFF9800, 'route': '/notifications_settings'},
    {'title': 'الأمان', 'icon': Icons.security, 'color': 0xFFE74C3C, 'route': '/security_settings'},
    {'title': 'طرق الدفع', 'icon': Icons.credit_card, 'color': 0xFF9C27B0, 'route': '/payment_methods'},
    {'title': 'المساعدة والدعم', 'icon': Icons.help, 'color': 0xFF00BCD4, 'route': '/help_support'},
    {'title': 'حول التطبيق', 'icon': Icons.info, 'color': 0xFF607D8B, 'route': '/about'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الإعدادات'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _settingsItems.length,
        itemBuilder: (context, index) {
          final item = _settingsItems[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: AppTheme.getCardColor(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Color(item['color']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item['icon'], color: Color(item['color']), size: 22),
              ),
              title: Text(
                item['title'],
                style: TextStyle(
                  fontFamily: 'Changa',
                  color: AppTheme.getTextColor(context),
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.pushNamed(context, item['route']),
            ),
          );
        },
      ),
    );
  }
}
