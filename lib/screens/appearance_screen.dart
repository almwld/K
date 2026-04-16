import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_manager.dart';
import '../services/theme_service.dart';
import '../widgets/simple_app_bar.dart';
import 'theme_selection_screen.dart';

class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();
    
    return Scaffold(
      appBar: const SimpleAppBar(title: 'المظهر'),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          
          // اختيار الثيم
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: themeManager.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(themeManager.modeIcon, color: themeManager.primaryColor),
            ),
            title: const Text('مظهر المنصة'),
            subtitle: Text(themeManager.modeName),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ThemeSelectionScreen()),
              );
            },
          ),
          
          const Divider(),
          
          // الوضع الداكن (تبديل سريع)
          SwitchListTile(
            secondary: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: themeManager.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.dark_mode, color: Colors.grey),
            ),
            title: const Text('الوضع الداكن'),
            subtitle: Text(themeManager.isDarkMode ? 'مفعل' : 'غير مفعل'),
            value: themeManager.isDarkMode,
            onChanged: (_) {
              // التبديل بين الداكن والذهبي
              if (themeManager.isDarkMode) {
                themeManager.setThemeMode(AppThemeMode.gold);
              } else {
                themeManager.setThemeMode(AppThemeMode.dark);
              }
            },
            activeColor: themeManager.primaryColor,
          ),
          
          const Divider(),
          
          // خيارات أخرى
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: themeManager.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.text_fields, color: Colors.grey),
            ),
            title: const Text('حجم الخط'),
            subtitle: const Text('متوسط'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
