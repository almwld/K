import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

class ThemeService {
  static const String _colorKey = 'app_theme_color';

  static Future<Color> getThemeColor() async {
    final prefs = await SharedPreferences.getInstance();
    final colorHex = prefs.getString(_colorKey);
    if (colorHex != null && colorHex.isNotEmpty) {
      return Color(int.parse(colorHex));
    }
    return AppTheme.binanceGold;
  }

  static Future<void> saveThemeColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_colorKey, color.value.toRadixString(16));
  }

  static List<Color> get availableColors => [
    AppTheme.binanceGold,
    AppTheme.serviceBlue,
    AppTheme.binanceGreen,
    AppTheme.serviceOrange,
    Colors.purple,
    Colors.teal,
  ];

  static List<String> get colorNames => [
    'ذهبي',
    'أزرق',
    'أخضر',
    'برتقالي',
    'بنفسجي',
    'فيروزي',
  ];
}
