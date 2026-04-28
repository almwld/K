import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // ============================================
  // الألوان الأساسية (Binance Style)
  // ============================================
  static const Color binanceDark = Color(0xFF0B0E11);
  static const Color binanceCard = Color(0xFF1E2329);
  static const Color binanceBorder = Color(0xFF2B3139);
  static const Color binanceGold = Color(0xFFD4AF37);
  static const Color binanceGreen = Color(0xFF0ECB81);
  static const Color binanceRed = Color(0xFFF6465D);

  // ألوان Flex Yemen
  static const Color nightBackground = Color(0xFF0F172A);
  static const Color nightSurface = Color(0xFF16213E);
  static const Color nightCard = Color(0xFF1A2A44);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFFFFFFF);

  // ألوان ذهبية
  static const Color gold = Color(0xFFD4AF37);
  static const Color goldDark = Color(0xFFB8962E);
  static const Color goldLight = Color(0xFFF4E4A6);
  static const Color binanceGoldLight = Color(0xFFF4E4A6);

  // ألوان خدمية
  static const Color serviceBlue = Color(0xFF2196F3);
  static const Color serviceGreen = Color(0xFF4CAF50);
  static const Color serviceOrange = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);

  // ألوان النصوص
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textMuted = Color(0xFF5E6673);

  // التدرجات
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFF4E4A6), Color(0xFFD4AF37), Color(0xFFAA8C2C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1E2329), Color(0xFF16213E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient binanceGoldGradient = LinearGradient(
    colors: [Color(0xFFF4E4A6), Color(0xFFD4AF37), Color(0xFFAA8C2C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ============================================
  // الثيم الفاتح الكامل
  // ============================================
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
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      splashColor: goldDark.withOpacity(0.2),
      highlightColor: goldDark.withOpacity(0.1),
    );
  }

  // ============================================
  // الثيم الداكن الكامل
  // ============================================
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
      splashColor: gold.withOpacity(0.2),
      highlightColor: gold.withOpacity(0.1),
    );
  }

  // ============================================
  // دوال مساعدة
  // ============================================
  static Color getPrimaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
  }

  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? textSecondary
        : Colors.grey.shade600;
  }

  static Color getTextColor(BuildContext context) {
    return getPrimaryTextColor(context);
  }

  static Color getDividerColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? binanceBorder
        : Colors.grey.shade300;
  }

  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? binanceCard
        : lightCard;
  }
}
