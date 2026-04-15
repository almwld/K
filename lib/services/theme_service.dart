import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

enum AppThemeMode {
  light,
  dark,
  blue,
  green,
}

class ThemeService {
  static const String _themeModeKey = 'app_theme_mode';
  
  static final Map<AppThemeMode, String> modeNames = {
    AppThemeMode.light: '☀️ نهاري',
    AppThemeMode.dark: '🌙 ليلي',
    AppThemeMode.blue: '🔵 أزرق',
    AppThemeMode.green: '🟢 أخضر',
  };
  
  static final Map<AppThemeMode, IconData> modeIcons = {
    AppThemeMode.light: Icons.light_mode,
    AppThemeMode.dark: Icons.dark_mode,
    AppThemeMode.blue: Icons.water_drop,
    AppThemeMode.green: Icons.eco,
  };
  
  static final Map<AppThemeMode, Color> primaryColors = {
    AppThemeMode.light: AppTheme.goldColor,
    AppThemeMode.dark: AppTheme.goldColor,
    AppThemeMode.blue: AppTheme.blueColor,
    AppThemeMode.green: AppTheme.greenColor,
  };

  static Future<void> saveThemeMode(AppThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, mode.index);
  }

  static Future<AppThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_themeModeKey) ?? 0;
    return AppThemeMode.values[index];
  }

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

  static Future<Color> getThemeColor() async {
    final mode = await getThemeMode();
    return primaryColors[mode]!;
  }
}
