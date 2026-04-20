import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const SimpleAppBar(title: 'المظهر'),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('اختر مظهر التطبيق', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                RadioListTile<int>(
                  value: 0,
                  groupValue: !themeManager.isDarkMode ? 0 : 1,
                  onChanged: (value) => themeManager.setThemeModeIndex(0),
                  title: const Text('الوضع النهاري'),
                  subtitle: const Text('مظهر كلاسيكي أنيق'),
                  secondary: Icon(Icons.light_mode, color: AppTheme.gold),
                ),
                RadioListTile<int>(
                  value: 1,
                  groupValue: !themeManager.isDarkMode ? 0 : 1,
                  onChanged: (value) => themeManager.setThemeModeIndex(1),
                  title: const Text('الوضع الداكن'),
                  subtitle: const Text('مظهر فاخر مع لمسات ذهبية'),
                  secondary: Icon(Icons.dark_mode, color: AppTheme.gold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

