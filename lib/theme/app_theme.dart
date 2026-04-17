import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ============ Premium Light Blue Theme ============
  
  // الأزرق الفاتح المتموج - ألوان رئيسية
  static const Color primaryBlue = Color(0xFF3B82F6);
  static const Color lightBlue = Color(0xFF60A5FA);
  static const Color deepBlue = Color(0xFF1E40AF);
  static const Color skyBlue = Color(0xFF93C5FD);
  
  // لمسات ذهبية للفخامة
  static const Color goldAccent = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFFBBF24);
  static const Color goldDark = Color(0xFFB8860B);
  
  // خلفيات فاتحة
  static const Color lightBackground = Color(0xFFF0F9FF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color bottomBar = Color(0xFFFFFFFF);
  
  // النصوص
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textLight = Color(0xFF94A3B8);
  
  // ألوان الحالة
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  
  // ألوان المنتجات
  static const Color availableBadge = Color(0xFF10B981);
  static const Color unavailableBadge = Color(0xFFEF4444);
  static const Color priceColor = Color(0xFF1E40AF);
  
  // ============ متغيرات للتوافق مع الكود القديم ============
  static const Color goldColor = goldAccent;
  static const Color goldPrimary = goldAccent;
  static const Color goldGradientStart = goldAccent;
  static const Color goldGradientEnd = goldLight;
  
  // Navy (للوضع الداكن القديم)
  static const Color navyPrimary = Color(0xFF1A2A44);
  static const Color navyCard = Color(0xFF223A5E);
  static const Color navyDark = Color(0xFF0F1A2E);
  static const Color navyGold = goldAccent;
  static const Color navyAccent = lightBlue;
  
  // Dark mode
  static const Color darkBackground = navyPrimary;
  static const Color darkCard = navyCard;
  static const Color darkSurface = navyCard;
  
  // التدرجات
  static const LinearGradient goldGradient = LinearGradient(
    colors: [goldAccent, goldLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient blueGradient = LinearGradient(
    colors: [primaryBlue, lightBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ============ الثيم الأساسي ============
  static ThemeData get lightTheme => ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.light,
    primaryColor: primaryBlue,
    scaffoldBackgroundColor: lightBackground,
    useMaterial3: true,
    colorScheme: const ColorScheme.light(primary: primaryBlue, secondary: lightBlue, surface: lightSurface, error: error),
    appBarTheme: const AppBarTheme(elevation: 0, backgroundColor: lightSurface, centerTitle: true, titleTextStyle: TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.w600, color: primaryBlue), iconTheme: IconThemeData(color: primaryBlue)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: bottomBar, selectedItemColor: primaryBlue, unselectedItemColor: textMuted, type: BottomNavigationBarType.fixed, elevation: 0),
    cardTheme: CardTheme(color: lightSurface, elevation: 3, shadowColor: primaryBlue.withOpacity(0.1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: primaryBlue, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)))),
    inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: lightSurface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: textLight.withOpacity(0.3))), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: primaryBlue, width: 2)), hintStyle: const TextStyle(color: textLight), contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
    textTheme: TextTheme(titleLarge: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600, color: textPrimary), bodyLarge: GoogleFonts.cairo(fontSize: 14, color: textSecondary)),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: primaryBlue),
  );

  static ThemeData get darkTheme => lightTheme;

  // ============ دوال مساعدة ============
  static Color getTextColor(BuildContext context) => textPrimary;
  static Color getSecondaryTextColor(BuildContext context) => textSecondary;
  static Color getCardColor(BuildContext context) => lightSurface;
  static Color getBackgroundColor(BuildContext context) => lightBackground;
  static Color getSurfaceColor(BuildContext context) => lightSurface;
  
  // للتوافق مع ThemeManager
  static const Color background = lightBackground;
  static const Color surface = lightSurface;
}
