import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Brand Colors - Premium Gold Palette
  static const Color goldPrimary = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFF4E4A6);
  static const Color goldDark = Color(0xFFB8860B);
  static const Color goldAccent = Color(0xFFFFD700);
  
  // Dark Theme Colors - نفس ألوان السبلاش
  static const Color darkBackground = Color(0xFF1A1A2E);
  static const Color darkSurface = Color(0xFF16213E);
  static const Color darkCard = Color(0xFF0F3460);
  static const Color darkElevated = Color(0xFF1A2A4A);
  
  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF5F5F5);
  static const Color lightElevated = Color(0xFFEEEEEE);
  
  // Semantic Colors
  static const Color success = Color(0xFF00C853);
  static const Color error = Color(0xFFFF1744);
  static const Color warning = Color(0xFFFF9100);
  static const Color info = Color(0xFF00B0FF);
  
  // Gradient Definitions
  static const LinearGradient goldGradient = LinearGradient(
    colors: [goldPrimary, goldLight, goldAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // نفس تدرج السبلاش
  static const LinearGradient splashGradient = LinearGradient(
    colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadow Definitions
  static List<BoxShadow> get goldShadow => [
    BoxShadow(
      color: goldPrimary.withOpacity(0.3),
      blurRadius: 20,
      spreadRadius: 2,
      offset: const Offset(0, 8),
    ),
  ];
  
  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 15,
      spreadRadius: 0,
      offset: const Offset(0, 5),
    ),
  ];

  // ============ Dark Theme (مثل السبلاش) ============
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: goldPrimary,
      fontFamily: 'Changa',
      colorScheme: const ColorScheme.dark(
        primary: goldPrimary,
        secondary: goldLight,
        surface: darkSurface,
        background: darkBackground,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: Colors.white,
        onBackground: Colors.white,
        error: error,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkSurface.withOpacity(0.95),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: const TextStyle(
          color: goldPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Changa',
        ),
        iconTheme: const IconThemeData(color: goldPrimary),
      ),
      cardTheme: CardTheme(
        color: darkCard,
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkSurface,
        selectedItemColor: goldPrimary,
        unselectedItemColor: Colors.grey[500],
        type: BottomNavigationBarType.fixed,
        elevation: 20,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Changa',
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Changa',
          fontSize: 11,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: goldPrimary,
        foregroundColor: Colors.black,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Colors.white, fontFamily: 'Changa', fontWeight: FontWeight.w700),
        displayMedium: TextStyle(color: Colors.white, fontFamily: 'Changa', fontWeight: FontWeight.w700),
        displaySmall: TextStyle(color: Colors.white, fontFamily: 'Changa', fontWeight: FontWeight.w600),
        headlineLarge: TextStyle(color: Colors.white, fontFamily: 'Changa', fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(color: Colors.white, fontFamily: 'Changa', fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(color: Colors.white, fontFamily: 'Changa', fontWeight: FontWeight.w600),
        titleLarge: TextStyle(color: Colors.white, fontFamily: 'Changa', fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: Colors.white, fontFamily: 'Changa', fontWeight: FontWeight.w500),
        titleSmall: TextStyle(color: Colors.white70, fontFamily: 'Changa', fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: Colors.white, fontFamily: 'Changa', fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(color: Colors.white70, fontFamily: 'Changa', fontWeight: FontWeight.w400),
        bodySmall: TextStyle(color: Colors.white54, fontFamily: 'Changa', fontWeight: FontWeight.w400),
        labelLarge: TextStyle(color: Colors.white, fontFamily: 'Changa', fontWeight: FontWeight.w500),
        labelMedium: TextStyle(color: Colors.white70, fontFamily: 'Changa', fontWeight: FontWeight.w500),
        labelSmall: TextStyle(color: Colors.white54, fontFamily: 'Changa', fontWeight: FontWeight.w400),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: goldPrimary, width: 2),
        ),
        hintStyle: TextStyle(color: Colors.grey[500], fontFamily: 'Changa'),
        labelStyle: const TextStyle(color: Colors.white70, fontFamily: 'Changa'),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: goldPrimary,
          foregroundColor: Colors.black,
          elevation: 8,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Changa',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 24,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey[800],
        thickness: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: darkElevated,
        selectedColor: goldPrimary.withOpacity(0.2),
        labelStyle: const TextStyle(fontFamily: 'Changa'),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // ============ Light Theme (ذهبي) ============
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackground,
      primaryColor: goldDark,
      fontFamily: 'Changa',
      colorScheme: const ColorScheme.light(
        primary: goldDark,
        secondary: goldPrimary,
        surface: lightSurface,
        background: lightBackground,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Color(0xFF1A1A1A),
        onBackground: Color(0xFF1A1A1A),
        error: error,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: lightSurface.withOpacity(0.95),
        foregroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: const TextStyle(
          color: Color(0xFF1A1A1A),
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Changa',
        ),
        iconTheme: const IconThemeData(color: goldDark),
      ),
      cardTheme: CardTheme(
        color: lightCard,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: lightSurface,
        selectedItemColor: goldDark,
        unselectedItemColor: Colors.grey[500],
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Changa',
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Changa',
          fontSize: 11,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: goldDark,
        foregroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Color(0xFF1A1A1A), fontFamily: 'Changa', fontWeight: FontWeight.w700),
        displayMedium: TextStyle(color: Color(0xFF1A1A1A), fontFamily: 'Changa', fontWeight: FontWeight.w700),
        displaySmall: TextStyle(color: Color(0xFF1A1A1A), fontFamily: 'Changa', fontWeight: FontWeight.w600),
        headlineLarge: TextStyle(color: Color(0xFF1A1A1A), fontFamily: 'Changa', fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(color: Color(0xFF1A1A1A), fontFamily: 'Changa', fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(color: Color(0xFF1A1A1A), fontFamily: 'Changa', fontWeight: FontWeight.w600),
        titleLarge: TextStyle(color: Color(0xFF1A1A1A), fontFamily: 'Changa', fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: Color(0xFF1A1A1A), fontFamily: 'Changa', fontWeight: FontWeight.w500),
        titleSmall: TextStyle(color: Color(0xFF666666), fontFamily: 'Changa', fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: Color(0xFF1A1A1A), fontFamily: 'Changa', fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(color: Color(0xFF666666), fontFamily: 'Changa', fontWeight: FontWeight.w400),
        bodySmall: TextStyle(color: Color(0xFF999999), fontFamily: 'Changa', fontWeight: FontWeight.w400),
        labelLarge: TextStyle(color: Color(0xFF1A1A1A), fontFamily: 'Changa', fontWeight: FontWeight.w500),
        labelMedium: TextStyle(color: Color(0xFF666666), fontFamily: 'Changa', fontWeight: FontWeight.w500),
        labelSmall: TextStyle(color: Color(0xFF999999), fontFamily: 'Changa', fontWeight: FontWeight.w400),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: goldDark, width: 2),
        ),
        hintStyle: TextStyle(color: Colors.grey[500], fontFamily: 'Changa'),
        labelStyle: TextStyle(color: Colors.grey[700], fontFamily: 'Changa'),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: goldDark,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Changa',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF1A1A1A),
        size: 24,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey[300],
        thickness: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: lightElevated,
        selectedColor: goldDark.withOpacity(0.2),
        labelStyle: const TextStyle(fontFamily: 'Changa'),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
