import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // 🌙 Night (كحلي فاخر)
  static const Color nightBackground = Color(0xFF0F172A);
  static const Color nightSurface = Color(0xFF16213E);
  static const Color nightCard = Color(0xFF1A2A44);
  static const Color nightTextPrimary = Color(0xFFFFFFFF);
  static const Color nightTextSecondary = Color(0xFFB0B0B0);

  // ☀️ Light
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF5F5F5);
  static const Color lightTextPrimary = Color(0xFF1A1A1A);
  static const Color lightTextSecondary = Color(0xFF757575);

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

  static LinearGradient get goldGradient => const LinearGradient(
    colors: [gold, goldLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // دوال مساعدة
  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? nightCard
        : lightCard;
  }

  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? nightTextSecondary
        : lightTextSecondary;
  }

  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? nightTextPrimary
        : lightTextPrimary;
  }

  static Color getDividerColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF3C3C3C)
        : const Color(0xFFE0E0E0);
  }

  static Color getPrimaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? nightTextPrimary
        : lightTextPrimary;
  }

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
        titleTextStyle: const TextStyle(fontFamily: 'Changa', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        iconTheme: const IconThemeData(color: gold),
      ),
      cardTheme: CardTheme(
        color: nightCard,
        elevation: 6,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: BorderSide(color: gold.withOpacity(0.08))),
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
        titleTextStyle: const TextStyle(fontFamily: 'Changa', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        iconTheme: const IconThemeData(color: goldDark),
      ),
      splashColor: goldDark.withOpacity(0.2),
      highlightColor: goldDark.withOpacity(0.1),
    );
  }

  // ألوان إضافية للتوافق
  static const Color binanceDark = Color(0xFF0B0E11);
  static const Color binanceCard = Color(0xFF1E2329);
  static const Color binanceBorder = Color(0xFF2B3139);
  static const Color binanceGold = Color(0xFFF0B90B);
  static const Color binanceGreen = Color(0xFF0ECB81);
  static const Color binanceRed = Color(0xFFF6465D);

  static const LinearGradient redGradient = LinearGradient(
    colors: [Color(0xFFF6465D), Color(0xFFE53935)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
