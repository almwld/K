import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_manager.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.navyPrimary : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المظهر'),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          
          // اختيار الوضع
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.getCardColor(context),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'اختر مظهر التطبيق',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                
                // نهاري
                RadioListTile<int>(
                  value: 0,
                  groupValue: themeManager.isLightMode ? 0 : (themeManager.isDarkMode ? 1 : 2),
                  onChanged: (value) => themeManager.setThemeModeIndex(0),
                  title: const Text('الوضع النهاري'),
                  subtitle: const Text('ذهبي مع أبيض - مظهر كلاسيكي'),
                  secondary: const Icon(Icons.light_mode, color: AppTheme.goldColor),
                ),
                
                // داكن
                RadioListTile<int>(
                  value: 1,
                  groupValue: themeManager.isLightMode ? 0 : (themeManager.isDarkMode ? 1 : 2),
                  onChanged: (value) => themeManager.setThemeModeIndex(1),
                  title: const Text('الوضع الداكن'),
                  subtitle: const Text('كحلي داكن - مريح للعين'),
                  secondary: const Icon(Icons.dark_mode, color: AppTheme.navyGold),
                ),
                
                // النظام
                RadioListTile<int>(
                  value: 2,
                  groupValue: themeManager.isLightMode ? 0 : (themeManager.isDarkMode ? 1 : 2),
                  onChanged: (value) => themeManager.setThemeModeIndex(2),
                  title: const Text('وضع النظام'),
                  subtitle: const Text('يتغير تلقائياً حسب إعدادات الجهاز'),
                  secondary: Icon(Icons.settings_suggest, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // معاينة سريعة
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.getCardColor(context),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'معاينة',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildPreviewButton('أساسي', AppTheme.getCardColor(context)),
                    _buildPreviewButton('ذهبي', AppTheme.goldColor),
                    _buildPreviewButton('أزرق', AppTheme.navyAccent),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewButton(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color == AppTheme.goldColor ? Colors.white : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
