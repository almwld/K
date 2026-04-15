import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// أنواع أوضاع المنصة
enum AppThemeMode {
  light,   // نهاري (ذهبي)
  dark,    // ليلي
  blue,    // أزرق
  green,   // أخضر
}

class ThemeService {
  static const String _themeModeKey = 'app_theme_mode';
  
  // أسماء الأوضاع
  static final Map<AppThemeMode, String> modeNames = {
    AppThemeMode.light: '☀️ نهاري',
    AppThemeMode.dark: '🌙 ليلي',
    AppThemeMode.blue: '🔵 أزرق',
    AppThemeMode.green: '🟢 أخضر',
  };
  
  // أيقونات الأوضاع
  static final Map<AppThemeMode, IconData> modeIcons = {
    AppThemeMode.light: Icons.light_mode,
    AppThemeMode.dark: Icons.dark_mode,
    AppThemeMode.blue: Icons.water_drop,
    AppThemeMode.green: Icons.eco,
  };
  
  // الألوان الرئيسية لكل وضع
  static final Map<AppThemeMode, Color> primaryColors = {
    AppThemeMode.light: const Color(0xFFD4AF37),  // ذهبي
    AppThemeMode.dark: const Color(0xFFD4AF37),   // ذهبي (في الليلي)
    AppThemeMode.blue: const Color(0xFF2196F3),   // أزرق
    AppThemeMode.green: const Color(0xFF4CAF50),  // أخضر
  };
  
  // الألوان الثانوية
  static final Map<AppThemeMode, Color> secondaryColors = {
    AppThemeMode.light: const Color(0xFFB8860B),
    AppThemeMode.dark: const Color(0xFFB8860B),
    AppThemeMode.blue: const Color(0xFF1976D2),
    AppThemeMode.green: const Color(0xFF388E3C),
  };

  // حفظ الوضع الحالي
  static Future<void> saveThemeMode(AppThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, mode.index);
  }

  // استرجاع الوضع الحالي
  static Future<AppThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_themeModeKey) ?? 0;
    return AppThemeMode.values[index];
  }

  // الحصول على الثيم الكامل حسب الوضع
  static ThemeData getThemeData(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return AppTheme.lightTheme;
      case AppThemeMode.dark:
        return AppTheme.darkTheme;
      case AppThemeMode.blue:
        return AppTheme.blueTheme;
      case AppThemeMode.green:
        return AppTheme.greenTheme;
    }
  }
}
