import 'package:flutter/material.dart';

class AppTheme {
  // ==================== الألوان الأساسية (Binance Style) ====================
  static const Color binanceDark = Color(0xFF0B0E11);
  static const Color binanceCard = Color(0xFF1E2329);
  static const Color binanceBorder = Color(0xFF2B3139);
  static const Color binanceGold = Color(0xFFD4AF37);
  static const Color binanceGreen = Color(0xFF0ECB81);
  static const Color binanceRed = Color(0xFFF6465D);
  
  // ==================== ألوان Flex Yemen (كحلي فاخر) ====================
  static const Color nightBackground = Color(0xFF0F172A);
  static const Color nightSurface = Color(0xFF16213E);
  static const Color nightCard = Color(0xFF1A2A44);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightCard = Color(0xFFFFFFFF);
  
  // ==================== ألوان ذهبية ====================
  static const Color gold = Color(0xFFD4AF37);
  static const Color goldDark = Color(0xFFB8962E);
  static const Color goldLight = Color(0xFFF4E4A6);
  
  // ==================== ألوان خدمية ====================
  static const Color serviceBlue = Color(0xFF2196F3);
  static const Color serviceGreen = Color(0xFF4CAF50);
  static const Color serviceOrange = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  
  // ==================== ألوان النصوص ====================
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textMuted = Color(0xFF5E6673);
  
  // ==================== التدرجات (Gradients) ====================
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
  
  static const LinearGradient darkNavyGradient = LinearGradient(
    colors: [Color(0xFF0F172A), Color(0xFF16213E), Color(0xFF1A2A44)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // ==================== الثيمات ====================
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: gold,
    scaffoldBackgroundColor: lightBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: lightBackground,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
  );
  
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: gold,
    scaffoldBackgroundColor: binanceDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: binanceDark,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );
  
  // ==================== دوال مساعدة ====================
  static Color getPrimaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
  }
  
  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? textSecondary : Colors.grey.shade600;
  }
  
  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? binanceCard : lightCard;
  }
  
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? binanceDark : lightBackground;
  }
}
