import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';

enum AppThemeMode { light, dark, system }

class ThemeManager extends ChangeNotifier {
  static const _key = 'theme_mode';

  AppThemeMode _mode = AppThemeMode.dark;
  bool _isDarkMode = true;

  AppThemeMode get mode => _mode;
  bool get isDarkMode => _isDarkMode;

  ThemeMode get flutterMode {
    switch (_mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  ThemeManager() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_key);

    if (value != null) {
      _mode = AppThemeMode.values.firstWhere(
        (e) => e.name == value,
        orElse: () => AppThemeMode.dark,
      );
    }
    _isDarkMode = _mode == AppThemeMode.dark;
    notifyListeners();
  }

  Future<void> setMode(AppThemeMode newMode) async {
    _mode = newMode;
    _isDarkMode = newMode == AppThemeMode.dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, newMode.name);
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _mode = _mode == AppThemeMode.dark ? AppThemeMode.light : AppThemeMode.dark;
    _isDarkMode = _mode == AppThemeMode.dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, _mode.name);
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    _mode = value ? AppThemeMode.dark : AppThemeMode.light;
    _isDarkMode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, _mode.name);
    notifyListeners();
  }

  Future<void> setThemeModeIndex(int index) async {
    _mode = index == 1 ? AppThemeMode.dark : AppThemeMode.light;
    _isDarkMode = index == 1;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, _mode.name);
    notifyListeners();
  }

  ThemeData get currentTheme => _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
}
