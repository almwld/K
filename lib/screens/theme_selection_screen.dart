import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_manager.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class ThemeSelectionScreen extends StatelessWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();
    
    return Scaffold(
      appBar: const SimpleAppBar(title: 'اختر المظهر'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'اختر المظهر الذي يناسبك',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          
          // الوضع النهاري
          _buildThemeCard(
            context: context,
            title: 'الوضع النهاري',
            subtitle: 'ذهبي مع أبيض - مظهر كلاسيكي',
            icon: Icons.light_mode,
            color: AppTheme.goldColor,
            isSelected: themeManager.isLightMode,
            onTap: () => themeManager.setThemeModeIndex(0),
          ),
          
          // الوضع الداكن
          _buildThemeCard(
            context: context,
            title: 'الوضع الداكن',
            subtitle: 'كحلي داكن - مريح للعين',
            icon: Icons.dark_mode,
            color: AppTheme.navyGold,
            isSelected: themeManager.isDarkMode,
            onTap: () => themeManager.setThemeModeIndex(1),
          ),
          
          // وضع النظام
          _buildThemeCard(
            context: context,
            title: 'وضع النظام',
            subtitle: 'يتغير تلقائياً حسب إعدادات الجهاز',
            icon: Icons.settings_suggest,
            color: Colors.grey,
            isSelected: themeManager.isDarkMode == false && themeManager.isLightMode == false,
            onTap: () => themeManager.setThemeModeIndex(2),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                ],
              ),
            ),
            if (isSelected) Icon(Icons.check_circle, color: color),
          ],
        ),
      ),
    );
  }
}
