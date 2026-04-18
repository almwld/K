import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';

enum AppThemeMode {
  light,
  dark,
  system,
}

class ThemeService {
  static const String _themeModeKey = 'app_theme_mode';
  
  static final Map<AppThemeMode, String> modeNames = {
    AppThemeMode.light: 'نهاري',
    AppThemeMode.dark: 'داكن',
    AppThemeMode.system: 'النظام',
  };
  
  static final Map<AppThemeMode, IconData> modeIcons = {
    AppThemeMode.light: Icons.light_mode,
    AppThemeMode.dark: Icons.dark_mode,
    AppThemeMode.system: Icons.settings_suggest,
  };
  
  static final Map<AppThemeMode, Color> primaryColors = {
    AppThemeMode.light: AppTheme.gold,
    AppThemeMode.dark: AppTheme.navyGold,
    AppThemeMode.system: AppTheme.navyGold,
  };
  
  static final Map<AppThemeMode, String> descriptions = {
    AppThemeMode.light: 'ذهبي مع أبيض - مظهر كلاسيكي أنيق',
    AppThemeMode.dark: 'كحلي داكن - مريح للعين',
    AppThemeMode.system: 'يتغير تلقائياً حسب إعدادات الجهاز',
  };

  static Future<void> saveThemeMode(AppThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, mode.index);
  }

  static Future<AppThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_themeModeKey) ?? 1;
    return AppThemeMode.values[index];
  }

  static ThemeData getThemeData(AppThemeMode mode, [Brightness? systemBrightness]) {
    switch (mode) {
      case AppThemeMode.light:
        return AppTheme.lightTheme;
      case AppThemeMode.dark:
        return AppTheme.darkTheme;
      case AppThemeMode.system:
        final brightness = systemBrightness ?? 
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
        return brightness == Brightness.dark ? AppTheme.darkTheme : AppTheme.lightTheme;
    }
  }

  static Future<Color> getThemeColor() async {
    final mode = await getThemeMode();
    return primaryColors[mode]!;
  }
}
