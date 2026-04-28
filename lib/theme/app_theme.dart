import 'package:flutter/material.dart';

class AppTheme {
  static const Color gold = Color(0xFFD4AF37);
  static const Color goldColor = Color(0xFFD4AF37);
  static const Color goldDark = Color(0xFFB8962E);
  static const Color goldLight = Color(0xFFF4E4A6);
  static const Color binanceDark = Color(0xFF0B0E11);
  static const Color binanceCard = Color(0xFF1E2329);
  static const Color binanceBorder = Color(0xFF2B3139);
  static const Color binanceGold = Color(0xFFD4AF37);
  static const Color binanceGreen = Color(0xFF0ECB81);
  static const Color binanceRed = Color(0xFFF6465D);
  static const Color binanceGoldLight = Color(0xFFF4E4A6);
  static const Color nightBackground = Color(0xFF0F172A);
  static const Color nightSurface = Color(0xFF16213E);
  static const Color nightCard = Color(0xFF1A2A44);
  static const Color darkSurface = Color(0xFF16213E);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color serviceBlue = Color(0xFF2196F3);
  static const Color serviceGreen = Color(0xFF4CAF50);
  static const Color serviceOrange = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textMuted = Color(0xFF5E6673);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);
  static const Color lightTextSecondary = Color(0xFF6B7280);

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

  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? darkSurface : lightSurface;
  }

  static Color getPrimaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? textSecondary : Colors.grey.shade600;
  }

  static Color getTextColor(BuildContext context) {
    return getPrimaryTextColor(context);
  }

  static Color getDividerColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? binanceBorder : Colors.grey.shade300;
  }

  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? binanceCard : lightCard;
  }

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Changa',
    primaryColor: goldDark,
    scaffoldBackgroundColor: lightBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      color: lightCard,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Changa',
    primaryColor: gold,
    scaffoldBackgroundColor: binanceDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0B0E11),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      color: binanceCard,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
  );
}
