import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // 🌙 Night (كحلي فاخر)
  static const Color nightBackground = Color(0xFF0F172A);
  static const Color nightSurface = Color(0xFF16213E);
  static const Color nightCard = Color(0xFF1A2A44);

  // ☀️ Light
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF5F5F5);

  // ✨ Brand
  static const Color gold = Color(0xFFD4AF37);
  static const Color goldDark = Color(0xFFB8962E);
  static const Color goldLight = Color(0xFFF4E4A6);

  // ⚠️ Status
  static const Color error = Color(0xFFB00020);
  static const Color success = Color(0xFF00C853);
  static const Color warning = Color(0xFFFF9100);

  // 🎨 Service Colors
  static const Color serviceBlue = Color(0xFF2196F3);
  static const Color serviceOrange = Color(0xFFFF9800);
  static const Color serviceRed = Color(0xFFE53935);
  static const Color serviceGreen = Color(0xFF4CAF50);

  // ✅ دوال مساعدة
  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? nightCard 
        : lightCard;
  }

  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? Colors.white70 
        : Colors.black54;
  }

  static LinearGradient get goldGradient => const LinearGradient(
    colors: [gold, goldLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ================= DARK =================
  static ThemeData get darkTheme {
    final scheme = const ColorScheme.dark(
      primary: gold,
      secondary: goldDark,
      background: nightBackground,
      surface: nightSurface,
      error: error,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onBackground: Colors.white,
      onSurface: Colors.white,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Changa',
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.background,

      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface.withOpacity(0.95),
        foregroundColor: scheme.onSurface,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: const TextStyle(
          fontFamily: 'Changa',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: gold),
      ),

      cardTheme: CardTheme(
        color: nightCard,
        elevation: 6,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: gold.withOpacity(0.08)),
        ),
      ),

      textTheme: const TextTheme(
        titleLarge: TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold, color: Colors.white),
        titleMedium: TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.w600, color: Colors.white),
        bodyLarge: TextStyle(fontFamily: 'Changa', color: Colors.white),
        bodyMedium: TextStyle(fontFamily: 'Changa', color: Colors.white70),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: nightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: gold, width: 2),
        ),
        hintStyle: const TextStyle(fontFamily: 'Changa', color: Colors.white54),
        labelStyle: const TextStyle(fontFamily: 'Changa', color: Colors.white70),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: gold,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Changa',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: nightSurface,
        selectedItemColor: gold,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontFamily: 'Changa', fontSize: 12),
        unselectedLabelStyle: TextStyle(fontFamily: 'Changa', fontSize: 11),
      ),

      splashColor: gold.withOpacity(0.2),
      highlightColor: gold.withOpacity(0.1),
    );
  }

  // ================= LIGHT =================
  static ThemeData get lightTheme {
    final scheme = const ColorScheme.light(
      primary: goldDark,
      secondary: gold,
      background: lightBackground,
      surface: lightSurface,
      error: error,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onBackground: Colors.black,
      onSurface: Colors.black,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Changa',
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.background,

      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface.withOpacity(0.95),
        foregroundColor: scheme.onSurface,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: const TextStyle(
          fontFamily: 'Changa',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        iconTheme: const IconThemeData(color: goldDark),
      ),

      cardTheme: CardTheme(
        color: lightCard,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),

      textTheme: const TextTheme(
        titleLarge: TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold, color: Colors.black),
        titleMedium: TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.w600, color: Colors.black),
        bodyLarge: TextStyle(fontFamily: 'Changa', color: Colors.black87),
        bodyMedium: TextStyle(fontFamily: 'Changa', color: Colors.black54),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: goldDark, width: 2),
        ),
        hintStyle: const TextStyle(fontFamily: 'Changa', color: Colors.black45),
        labelStyle: const TextStyle(fontFamily: 'Changa', color: Colors.black54),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: goldDark,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Changa',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: lightSurface,
        selectedItemColor: goldDark,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontFamily: 'Changa', fontSize: 12),
        unselectedLabelStyle: TextStyle(fontFamily: 'Changa', fontSize: 11),
      ),

      splashColor: goldDark.withOpacity(0.2),
      highlightColor: goldDark.withOpacity(0.1),
    );
  }
}

// دوال إضافية
static Color getTextColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark 
      ? Colors.white 
      : Colors.black87;
}

static Color getDividerColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark 
      ? const Color(0xFF3C3C3C) 
      : const Color(0xFFE0E0E0);
}
