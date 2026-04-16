import 'package:flutter/material.dart';
import '../services/theme_service.dart';
import '../theme/app_theme.dart';

class ThemeManager extends ChangeNotifier {
  AppThemeMode _currentMode = AppThemeMode.gold;
  
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

  // تغيير إلى الوضع التالي
  Future<void> cycleTheme() async {
    final modes = AppThemeMode.values;
    final nextIndex = (_currentMode.index + 1) % modes.length;
    await setThemeMode(modes[nextIndex]);
  }
}
