import 'package:flutter/material.dart';

enum ThemeModeOption { light, dark }

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
}
