import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // ============ الألوان الرئيسية ============
  
  // الثيم الذهبي (نهاري)
  static const Color goldColor = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFE5C158);
  static const Color goldDark = Color(0xFFB8860B);
  
  // الثيم الداكن - كحلي (Navy Blue)
  static const Color navyPrimary = Color(0xFF1A2A44);
  static const Color navyCard = Color(0xFF223A5E);
  static const Color navyDark = Color(0xFF0F1A2E);
  static const Color navyAccent = Color(0xFF3B82F6);
  static const Color navyGold = Color(0xFFD4AF37);
  
  // متغيرات للتوافق
  static const Color darkBackground = navyPrimary;
  static const Color darkCard = navyCard;
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF1F5F9);
  
  // ألوان الحالة
  static const Color success = Color(0xFF059669);
  static const Color error = Color(0xFF991B1B);
  static const Color warning = Color(0xFFD97706);
  static const Color info = Color(0xFF2563EB);
  
  // ألوان النصوص
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA0A0A0);
  static const Color textMuted = Color(0xFF6B7280);
  
  // التدرجات
  static const LinearGradient goldGradient = LinearGradient(
    colors: [goldColor, goldLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ============ الثيم النهاري ============
  static ThemeData get lightTheme => ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.light,
    primaryColor: goldColor,
    scaffoldBackgroundColor: lightBackground,
    useMaterial3: true,
    colorScheme: const ColorScheme.light(primary: goldColor, secondary: goldLight, surface: lightSurface, error: error),
    appBarTheme: const AppBarTheme(elevation: 0, backgroundColor: lightSurface, centerTitle: true, titleTextStyle: TextStyle(fontFamily: 'Cairo', fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)), iconTheme: IconThemeData(color: goldColor)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: lightSurface, selectedItemColor: goldColor, unselectedItemColor: Color(0xFF94A3B8), type: BottomNavigationBarType.fixed, elevation: 8),
    cardTheme: CardTheme(color: lightCard, elevation: 4, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: goldColor, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: lightCard, border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: goldColor, width: 2)), contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
    textTheme: const TextTheme(headlineLarge: TextStyle(fontFamily: 'Cairo', fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)), bodyLarge: TextStyle(fontFamily: 'Cairo', fontSize: 16, color: Color(0xFF1E293B)), bodyMedium: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: Color(0xFF475569))),
  );

  // ============ الثيم الداكن ============
  static ThemeData get darkTheme => ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.dark,
    primaryColor: navyGold,
    scaffoldBackgroundColor: navyPrimary,
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(primary: navyGold, secondary: navyAccent, surface: navyCard, error: error),
    appBarTheme: const AppBarTheme(elevation: 0, backgroundColor: Colors.transparent, systemOverlayStyle: SystemUiOverlayStyle.light, centerTitle: true, titleTextStyle: TextStyle(fontFamily: 'Cairo', fontSize: 22, fontWeight: FontWeight.bold, color: navyGold), iconTheme: IconThemeData(color: navyGold)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: navyDark, selectedItemColor: navyGold, unselectedItemColor: textSecondary, type: BottomNavigationBarType.fixed, elevation: 8),
    cardTheme: CardTheme(color: navyCard, elevation: 6, shadowColor: Colors.black.withOpacity(0.3), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: Colors.white.withOpacity(0.05)))),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: navyGold, foregroundColor: navyPrimary, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: navyCard, border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: navyGold, width: 2)), hintStyle: const TextStyle(color: textSecondary), contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
    textTheme: const TextTheme(headlineLarge: TextStyle(fontFamily: 'Cairo', fontSize: 24, fontWeight: FontWeight.bold, color: textPrimary), bodyLarge: TextStyle(fontFamily: 'Cairo', fontSize: 16, color: textPrimary), bodyMedium: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: textSecondary)),
  );

  // ============ دوال مساعدة ============
  static Color getTextColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? textPrimary : const Color(0xFF1E293B);
  static Color getSecondaryTextColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? textSecondary : const Color(0xFF475569);
  static Color getCardColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? navyCard : lightCard;
  static Color getBackgroundColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? navyPrimary : lightBackground;
  static Color getSurfaceColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? navyDark : lightSurface;
}

// متغيرات إضافية

// متغيرات إضافية

// متغيرات إضافية

// متغيرات إضافية للتوافق
static const Color darkSurface = Color(0xFF223A5E);
