import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

enum AppThemeMode {
  blue,    // الوضع الأزرق
  green,   // الوضع الأخضر
  gold,    // الوضع الذهبي
  dark,    // الوضع الداكن (ليلي)
}

class ThemeService {
  static const String _themeModeKey = 'app_theme_mode';
  
  static final Map<AppThemeMode, String> modeNames = {
    AppThemeMode.blue: 'أزرق',
    AppThemeMode.green: 'أخضر',
    AppThemeMode.gold: 'ذهبي',
    AppThemeMode.dark: 'داكن',
  };
  
  static final Map<AppThemeMode, IconData> modeIcons = {
    AppThemeMode.blue: Icons.water_drop,
    AppThemeMode.green: Icons.eco,
    AppThemeMode.gold: Icons.star,
    AppThemeMode.dark: Icons.dark_mode,
  };
  
  static final Map<AppThemeMode, Color> primaryColors = {
    AppThemeMode.blue: const Color(0xFF2196F3),
    AppThemeMode.green: const Color(0xFF4CAF50),
    AppThemeMode.gold: const Color(0xFFD4AF37),
    AppThemeMode.dark: const Color(0xFFD4AF37),
  };
  
  static final Map<AppThemeMode, String> descriptions = {
    AppThemeMode.blue: 'منعش وحيوي - مثالي للاستخدام اليومي',
    AppThemeMode.green: 'طبيعي ومريح للعين - مناسب للقراءة',
    AppThemeMode.gold: 'فاخر وأنيق - يعكس هوية المنصة',
    AppThemeMode.dark: 'مريح في الإضاءة المنخفضة - موفر للبطارية',
  };

  static Future<void> saveThemeMode(AppThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, mode.index);
  }

  static Future<AppThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_themeModeKey) ?? 2; // افتراضي: ذهبي
    return AppThemeMode.values[index];
  }

  static ThemeData getThemeData(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.blue:
        return AppTheme.blueTheme;
      case AppThemeMode.green:
        return AppTheme.greenTheme;
      case AppThemeMode.gold:
        return AppTheme.goldTheme;
      case AppThemeMode.dark:
        return AppTheme.darkTheme;
    }
  }

  static Future<Color> getThemeColor() async {
    final mode = await getThemeMode();
    return primaryColors[mode]!;
  }
}
