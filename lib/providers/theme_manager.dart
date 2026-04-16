import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

class ThemeManager extends ChangeNotifier {
  static const String _themeModeKey = 'theme_mode_index';
  int _themeModeIndex = 1; // افتراضي: داكن
  
  ThemeMode get themeMode {
    switch (_themeModeIndex) {
      case 0: return ThemeMode.light;
      case 1: return ThemeMode.dark;
      default: return ThemeMode.system;
    }
  }
  
  bool get isDarkMode => _themeModeIndex == 1;
  bool get isLightMode => _themeModeIndex == 0;
  bool get isSystemMode => _themeModeIndex == 2;
  
  String get modeName {
    switch (_themeModeIndex) {
      case 0: return 'نهاري';
      case 1: return 'داكن';
      default: return 'النظام';
    }
  }
  
  IconData get modeIcon {
    switch (_themeModeIndex) {
      case 0: return Icons.light_mode;
      case 1: return Icons.dark_mode;
      default: return Icons.settings_suggest;
    }
  }

  ThemeManager() {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    _themeModeIndex = prefs.getInt(_themeModeKey) ?? 1;
    notifyListeners();
  }

  Future<void> setThemeModeIndex(int index) async {
    _themeModeIndex = index;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, index);
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    if (_themeModeIndex == 0) {
      await setThemeModeIndex(1);
    } else if (_themeModeIndex == 1) {
      await setThemeModeIndex(0);
    } else {
      await setThemeModeIndex(1);
    }
  }

  Color get primaryColor {
    switch (_themeModeIndex) {
      case 0: return AppTheme.goldColor;
      case 1: return AppTheme.navyGold;
      default: 
        return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark 
            ? AppTheme.navyGold 
            : AppTheme.goldColor;
    }
  }
}
