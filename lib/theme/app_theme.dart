import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // الألوان الأساسية
  static const Color goldColor = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFF3E5AB);
  static const Color goldDark = Color(0xFFB8860B);
  
  static const Color darkBackground = Color(0xFF121212);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color darkCard = Color(0xFF1E1E1E);
  static const Color lightCard = Colors.white;
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color lightSurface = Colors.white;
  static const Color error = Color(0xFFE74C3C);
  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFF39C12);
  static const Color info = Color(0xFF3498DB);
  
  static const Color darkText = Colors.white;
  static const Color lightText = Colors.black87;
  static const Color darkTextSecondary = Colors.white70;
  static const Color lightTextSecondary = Colors.black54;
  
  static const Color darkDivider = Colors.white24;
  static const Color lightDivider = Colors.black12;

  // التدرجات
  static LinearGradient get goldGradient {
    return const LinearGradient(
      colors: [goldColor, goldLight],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  // دوال مساعدة
  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? darkCard : lightCard;
  }
  
  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? darkSurface : lightSurface;
  }
  
  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? darkText : lightText;
  }
  
  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? darkTextSecondary : lightTextSecondary;
  }
  
  static Color getDividerColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? darkDivider : lightDivider;
  }
  
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? darkBackground : lightBackground;
  }

  // الثيمات
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: goldColor,
      scaffoldBackgroundColor: lightBackground,
      colorScheme: const ColorScheme.light(
        primary: goldColor,
        secondary: goldLight,
        surface: lightSurface,
        background: lightBackground,
        error: error,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: lightText,
        onBackground: lightText,
      ),
      textTheme: GoogleFonts.changaTextTheme(ThemeData.light().textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightSurface,
        foregroundColor: lightText,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: goldColor,
      scaffoldBackgroundColor: darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: goldColor,
        secondary: goldLight,
        surface: darkSurface,
        background: darkBackground,
        error: error,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: darkText,
        onBackground: darkText,
      ),
      textTheme: GoogleFonts.changaTextTheme(ThemeData.dark().textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurface,
        foregroundColor: goldColor,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
