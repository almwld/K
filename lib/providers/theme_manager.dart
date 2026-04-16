import 'package:flutter/material.dart';
import '../services/theme_service.dart';
import '../theme/app_theme.dart';

class ThemeManager extends ChangeNotifier {
  AppThemeMode _currentMode = AppThemeMode.dark;
  
  AppThemeMode get currentMode => _currentMode;
  String get modeName => ThemeService.modeNames[_currentMode]!;
  IconData get modeIcon => ThemeService.modeIcons[_currentMode]!;
  Color get primaryColor => ThemeService.primaryColors[_currentMode]!;
  bool get isDarkMode => _currentMode == AppThemeMode.dark;

  ThemeManager() {
    _loadMode();
  }

  Future<void> _loadMode() async {
    _currentMode = await ThemeService.getThemeMode();
    notifyListeners();
  }

  ThemeData get currentTheme {
    return ThemeService.getThemeData(_currentMode);
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    _currentMode = mode;
    await ThemeService.saveThemeMode(mode);
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final newMode = _currentMode == AppThemeMode.light 
        ? AppThemeMode.dark 
        : AppThemeMode.light;
    await setThemeMode(newMode);
  }
}
