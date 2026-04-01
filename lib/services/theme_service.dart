import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String _colorKey = 'theme_color';
  static const String _isDarkKey = 'is_dark_mode';

  static List<Color> get availableColors => [
    const Color(0xFFD4AF37), // ذهبي
    const Color(0xFF2196F3), // أزرق
    const Color(0xFF4CAF50), // أخضر
    const Color(0xFF00BCD4), // سماوي
    const Color(0xFFFF9800), // برتقالي
    const Color(0xFF9C27B0), // بنفسجي
  ];

  static List<String> get colorNames => [
    'ذهبي',
    'أزرق',
    'أخضر',
    'سماوي',
    'برتقالي',
    'بنفسجي',
  ];

  static Future<void> saveThemeColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_colorKey, color.value);
  }

  static Future<Color> getThemeColor() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt(_colorKey);
    if (colorValue != null) {
      return Color(colorValue);
    }
    return availableColors[0]; // الذهبي الافتراضي
  }

  static String getColorName(Color color) {
    for (int i = 0; i < availableColors.length; i++) {
      if (availableColors[i].value == color.value) {
        return colorNames[i];
      }
    }
    return 'ذهبي';
  }

  static Future<void> setDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isDarkKey, isDark);
  }

  static Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isDarkKey) ?? false;
  }

  static Color getAdjustedColor(Color baseColor, bool isDark) {
    if (isDark) {
      // Make the color slightly lighter in dark mode for better visibility
      return Color.lerp(baseColor, Colors.white, 0.1) ?? baseColor;
    }
    return baseColor;
  }
}
