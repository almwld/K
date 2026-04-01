import 'package:flutter/material.dart';
import '../services/cache/local_storage_service.dart';

class ThemeManager extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeManager() {
    _loadTheme();
  }

  void _loadTheme() {
    _isDarkMode = LocalStorageService.isDarkMode();
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await LocalStorageService.setDarkMode(_isDarkMode);
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    if (_isDarkMode != value) {
      _isDarkMode = value;
      await LocalStorageService.setDarkMode(_isDarkMode);
      notifyListeners();
    }
  }
}
