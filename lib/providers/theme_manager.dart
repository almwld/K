import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

class ThemeManager extends ChangeNotifier {
  static const String _themeModeKey = 'theme_mode';
  ThemeMode _themeMode = ThemeMode.dark; // افتراضي: داكن
  
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isLightMode => _themeMode == ThemeMode.light;
  bool get isSystemMode => _themeMode == ThemeMode.system;
  
  String get modeName {
    switch (_themeMode) {
      case ThemeMode.light: return 'نهاري';
      case ThemeMode.dark: return 'داكن';
      case ThemeMode.system: return 'النظام';
    }
  }
  
  IconData get modeIcon {
    switch (_themeMode) {
      case ThemeMode.light: return Icons.light_mode;
      case ThemeMode.dark: return Icons.dark_mode;
      case ThemeMode.system: return Icons.settings_suggest;
    }
  }

  ThemeManager() {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_themeModeKey) ?? 2; // افتراضي: system
    _themeMode = ThemeMode.values[index];
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, mode.index);
    notifyListeners();
  }

  // التبديل السريع بين النهاري والداكن
  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      await setThemeMode(ThemeMode.dark);
    } else if (_themeMode == ThemeMode.dark) {
      await setThemeMode(ThemeMode.light);
    } else {
      // إذا كان على وضع النظام، ننتقل إلى الداكن
      await setThemeMode(ThemeMode.dark);
    }
  }

  // التدوير بين الأوضاع الثلاثة
  Future<void> cycleTheme() async {
    final modes = ThemeMode.values;
    final nextIndex = (_themeMode.index + 1) % modes.length;
    await setThemeMode(modes[nextIndex]);
  }

  Color get primaryColor {
    switch (_themeMode) {
      case ThemeMode.light: return AppTheme.goldColor;
      case ThemeMode.dark: return AppTheme.navyGold;
      case ThemeMode.system: 
        // في وضع النظام، نعيد اللون حسب سطوع النظام الحالي
        return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark 
            ? AppTheme.navyGold 
            : AppTheme.goldColor;
    }
  }
}
