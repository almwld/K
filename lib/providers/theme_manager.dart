import 'package:flutter/material.dart';

enum ThemeModeOption { light, dark, system }

class ThemeManager extends ChangeNotifier {
  ThemeModeOption _themeMode = ThemeModeOption.dark;

  ThemeModeOption get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeModeOption.dark;

  void setThemeMode(ThemeModeOption mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeMode == ThemeModeOption.dark) {
      _themeMode = ThemeModeOption.light;
    } else {
      _themeMode = ThemeModeOption.dark;
    }
    notifyListeners();
  }

  void setDarkMode() {
    _themeMode = ThemeModeOption.dark;
    notifyListeners();
  }

  void setLightMode() {
    _themeMode = ThemeModeOption.light;
    notifyListeners();
  }

  ThemeData getThemeData() {
    switch (_themeMode) {
      case ThemeModeOption.light:
        return ThemeData.light();
      case ThemeModeOption.dark:
        return ThemeData.dark();
      case ThemeModeOption.system:
        return ThemeData.system();
    }
  }
}
