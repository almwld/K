import 'package:flutter/material.dart';
import '../services/theme_service.dart';
import '../theme/app_theme.dart';

class ThemeManager extends ChangeNotifier {
  AppThemeMode _currentMode = AppThemeMode.light;
  bool _isDarkMode = false;
  
  AppThemeMode get currentMode => _currentMode;
  String get modeName => ThemeService.modeNames[_currentMode]!;
  IconData get modeIcon => ThemeService.modeIcons[_currentMode]!;
  Color get primaryColor => ThemeService.primaryColors[_currentMode]!;
  bool get isDarkMode => _isDarkMode;

  ThemeManager() {
    _loadMode();
  }

  Future<void> _loadMode() async {
    _currentMode = await ThemeService.getThemeMode();
    _isDarkMode = _currentMode == AppThemeMode.dark;
    notifyListeners();
  }

  ThemeData get currentTheme {
    if (_currentMode == AppThemeMode.dark) {
      return AppTheme.darkTheme;
    }
    return ThemeService.getThemeData(_currentMode);
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    _currentMode = mode;
    _isDarkMode = mode == AppThemeMode.dark;
    await ThemeService.saveThemeMode(mode);
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    if (_currentMode == AppThemeMode.light) {
      await setThemeMode(AppThemeMode.dark);
    } else if (_currentMode == AppThemeMode.dark) {
      await setThemeMode(AppThemeMode.light);
    }
  }
}
