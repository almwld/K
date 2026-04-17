import 'package:flutter/material.dart';

class AppTheme {
  // الألوان الذهبية الأساسية
  static const Color goldColor = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFF4E4A6);
  static const Color goldDark = Color(0xFFAA8C2C);
  
  // ألوان الوضع الداكن
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkCard = Color(0xFF2A2A2A);
  
  // ألوان الوضع النهاري
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF0F0F0);
  
  // ألوان إضافية
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  // ألوان الخدمات
  static const Color serviceOrange = Color(0xFFFF9800);
  static const Color serviceRed = Color(0xFFE53935);
  static const Color serviceGreen = Color(0xFF4CAF50);
  static const Color serviceBlue = Color(0xFF2196F3);
  static const Color servicePurple = Color(0xFF9C27B0);
  static const Color serviceTeal = Color(0xFF009688);
  static const Color servicePink = Color(0xFFE91E63);
  static const Color serviceIndigo = Color(0xFF3F51B5);
  static const Color serviceAmber = Color(0xFFFFC107);

  // للتوافق مع الكود القديم
  static const Color goldAccent = goldColor;
  static const Color primaryBlue = goldColor;
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;
  static const Color textMuted = Colors.white54;
  static const Color priceColor = goldColor;

  // الثيم الداكن (الأساسي)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: goldColor,
      fontFamily: 'Cairo',
      
      colorScheme: const ColorScheme.dark(
        primary: goldColor,
        secondary: goldLight,
        surface: darkSurface,
        background: darkBackground,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: Colors.white,
        onBackground: Colors.white,
      ),
      
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurface,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),
        iconTheme: IconThemeData(color: goldColor),
      ),
      
      cardTheme: CardTheme(
        color: darkCard,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkSurface,
        selectedItemColor: goldColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
      
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: goldColor,
        foregroundColor: Colors.black,
      ),
      
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: Colors.white, fontFamily: 'Cairo'),
        bodyMedium: TextStyle(color: Colors.white70, fontFamily: 'Cairo'),
        bodySmall: TextStyle(color: Colors.white54, fontFamily: 'Cairo'),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkCard,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: goldColor, width: 2)),
        hintStyle: TextStyle(color: Colors.grey[400], fontFamily: 'Cairo'),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: goldColor,
          foregroundColor: Colors.black,
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // الثيم النهاري
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackground,
      primaryColor: goldDark,
      fontFamily: 'Cairo',
      
      colorScheme: const ColorScheme.light(
        primary: goldDark,
        secondary: goldColor,
        surface: lightSurface,
        background: lightBackground,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black87,
        onBackground: Colors.black87,
      ),
      
      appBarTheme: const AppBarTheme(
        backgroundColor: lightSurface,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),
        iconTheme: IconThemeData(color: goldDark),
      ),
      
      cardTheme: CardTheme(
        color: lightCard,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: lightSurface,
        selectedItemColor: goldDark,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
      
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: goldDark,
        foregroundColor: Colors.white,
      ),
      
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.black87, fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: Colors.black87, fontFamily: 'Cairo', fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: Colors.black87, fontFamily: 'Cairo'),
        bodyMedium: TextStyle(color: Colors.black54, fontFamily: 'Cairo'),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightCard,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: goldDark, width: 2)),
        hintStyle: TextStyle(color: Colors.grey[600], fontFamily: 'Cairo'),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: goldDark,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // دوال مساعدة
  static Color getTextColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87;
  static Color getSecondaryTextColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54;
  static Color getCardColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? darkCard : lightCard;
  static Color getBackgroundColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? darkBackground : lightBackground;
  static Color getSurfaceColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? darkSurface : lightSurface;
}
