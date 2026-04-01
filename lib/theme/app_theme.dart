import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // اللون الذهبي الداكن الهادئ (Metallic Gold - Darker)
  static const Color goldColor = Color(0xFFD4AF37);      // ذهبي معدني داكن (هادئ)
  static const Color goldLight = Color(0xFFE5C158);      // ذهبي فاتح باهت
  static const Color goldDark = Color(0xFFB8941F);       // ذهبي داكن أكثر
  static const Color goldAccent = Color(0xFFC9A227);     // ذهبي متوسط
  
  // ألوان أخرى
  static const Color primaryColor = Color(0xFF1E88E5);
  static const Color secondaryColor = Color(0xFF43A047);
  static const Color accentColor = Color(0xFFFFB300);
  
  // الخلفيات
  static const Color darkBackground = Color(0xFF121212);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color lightSurface = Colors.white;
  
  // النصوص
  static const Color darkText = Color(0xFF212121);
  static const Color darkTextSecondary = Color(0xFF757575);
  static const Color lightText = Color(0xFFFFFFFF);
  static const Color lightTextSecondary = Color(0xFFB0B0B0);
  
  // الحالات
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF43A047);
  static const Color warning = Color(0xFFFFB300);
  static const Color info = Color(0xFF1E88E5);

  // دوال المساعدة
  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkSurface : lightSurface;
  }

  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkSurface : lightSurface;
  }

  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? lightText : darkText;
  }

  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? lightTextSecondary : darkTextSecondary;
  }

  static Color getDividerColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? const Color(0xFF424242) : const Color(0xFFE0E0E0);
  }

  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkBackground : lightBackground;
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: goldColor,
      scaffoldBackgroundColor: lightBackground,
      colorScheme: const ColorScheme.light(
        primary: goldColor,
        secondary: goldDark,
        surface: lightSurface,
        background: lightBackground,
        error: error,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: darkText,
        onBackground: darkText,
      ),
      textTheme: GoogleFonts.changaTextTheme(ThemeData.light().textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: goldColor,
        foregroundColor: Colors.black,
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
        onSurface: lightText,
        onBackground: lightText,
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

  static LinearGradient get goldGradient => const LinearGradient(
    colors: [goldColor, goldLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
