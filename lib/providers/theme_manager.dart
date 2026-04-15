import 'package:flutter/material.dart';
import '../services/cache/local_storage_service.dart';

class ThemeManager extends ChangeNotifier {
  bool _isDarkMode = false;
  final LocalStorageService _storage = LocalStorageService();

  bool get isDarkMode => _isDarkMode;

  ThemeManager() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    await _storage.init();
    final savedTheme = _storage.getThemeMode();
    _isDarkMode = savedTheme == 'dark';
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _storage.saveThemeMode(_isDarkMode ? 'dark' : 'light');
    notifyListeners();
  }

  Future<void> setTheme(bool isDark) async {
    _isDarkMode = isDark;
    await _storage.saveThemeMode(_isDarkMode ? 'dark' : 'light');
    notifyListeners();
  }
}
