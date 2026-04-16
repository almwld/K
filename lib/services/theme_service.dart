import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

enum AppThemeMode {
  light,  // نهاري (ذهبي + أبيض)
  dark,   // ليلي (أزرق داكن مائل للرمادي)
}

class ThemeService {
  static const String _themeModeKey = 'app_theme_mode';
  
  static final Map<AppThemeMode, String> modeNames = {
    AppThemeMode.light: 'نهاري',
    AppThemeMode.dark: 'داكن',
  };
  
  static final Map<AppThemeMode, IconData> modeIcons = {
    AppThemeMode.light: Icons.light_mode,
    AppThemeMode.dark: Icons.dark_mode,
  };
  
  static final Map<AppThemeMode, Color> primaryColors = {
    AppThemeMode.light: AppTheme.goldColor,
    AppThemeMode.dark: AppTheme.darkBlueGrayAccent,
  };
  
  static final Map<AppThemeMode, String> descriptions = {
    AppThemeMode.light: 'ذهبي مع أبيض - مظهر كلاسيكي أنيق',
    AppThemeMode.dark: 'أزرق داكن مائل للرمادي - مريح للعين',
  };

  static Future<void> saveThemeMode(AppThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, mode.index);
  }

  static Future<AppThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_themeModeKey) ?? 1; // افتراضي: داكن
    return AppThemeMode.values[index];
  }

  static ThemeData getThemeData(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return AppTheme.lightTheme;
      case AppThemeMode.dark:
        return AppTheme.darkTheme;
    }
  }

  static Future<Color> getThemeColor() async {
    final mode = await getThemeMode();
    return primaryColors[mode]!;
  }
}
