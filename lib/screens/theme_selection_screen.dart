import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_manager.dart';

class ThemeSelectionScreen extends StatelessWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        title: const Text('اختيار المظهر', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.binanceDark,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildThemeOption(
              context,
              title: 'الوضع المظلم',
              description: 'تصميم داكن فاخر',
              icon: Icons.dark_mode,
              isSelected: themeManager.themeMode == ThemeMode.dark,
              onTap: () => themeManager.setThemeMode(ThemeMode.dark),
            ),
            const SizedBox(height: 16),
            _buildThemeOption(
              context,
              title: 'الوضع الفاتح',
              description: 'تصميم مشرق وأنيق',
              icon: Icons.light_mode,
              isSelected: themeManager.themeMode == ThemeMode.light,
              onTap: () => themeManager.setThemeMode(ThemeMode.light),
            ),
            const SizedBox(height: 16),
            _buildThemeOption(
              context,
              title: 'النظام',
              description: 'مطابقة إعدادات الجهاز',
              icon: Icons.phone_android,
              isSelected: themeManager.themeMode == ThemeMode.system,
              onTap: () => themeManager.setThemeMode(ThemeMode.system),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.binanceCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.binanceGold : AppTheme.binanceBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppTheme.binanceGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppTheme.binanceGold, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppTheme.binanceGold, size: 24),
          ],
        ),
      ),
    );
  }
}
