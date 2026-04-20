import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
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
          _buildThemeCard(
            context: context,
            title: 'الوضع الداكن',
            subtitle: 'مظهر فاخر مع لمسات ذهبية',
            icon: Icons.dark_mode,
            isSelected: themeManager.isDarkMode,
            onTap: () => themeManager.setThemeModeIndex(1),
          ),
          _buildThemeCard(
            context: context,
            title: 'الوضع النهاري',
            subtitle: 'مظهر كلاسيكي أنيق',
            icon: Icons.light_mode,
            isSelected: !themeManager.isDarkMode,
            onTap: () => themeManager.setThemeModeIndex(0),
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
            color: isSelected ? AppTheme.gold : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppTheme.gold.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppTheme.gold),
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
            if (isSelected) Icon(Icons.check_circle, color: AppTheme.gold),
          ],
        ),
      ),
    );
  }
}

