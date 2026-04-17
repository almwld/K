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
  static const Color background = Color(0xFFF0F9FF);
  static const Color surface = Color(0xFFFFFFFF);
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
  static const Color info = Color(0xFF3B82F6);
  
  // ألوان المنتجات
  static const Color availableBadge = Color(0xFF10B981);
  static const Color unavailableBadge = Color(0xFFEF4444);
  static const Color priceColor = Color(0xFF1E40AF);
  
  // متغيرات للتوافق مع الكود القديم
  static const Color goldColor = goldAccent;
  static const Color goldPrimary = goldAccent;
  static const Color lightBackground = background;
  static const Color lightSurface = surface;
  static const Color lightCard = surface;
  static const Color darkBackground = background;
  static const Color darkCard = surface;
  static const Color darkSurface = surface;
  static const Color navyPrimary = primaryBlue;
  static const Color navyCard = surface;
  static const Color navyDark = bottomBar;
  static const Color navyGold = goldAccent;
  static const Color navyAccent = lightBlue;
  
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

  // ============ الثيم الأزرق الفاتح ============
  static ThemeData get lightTheme => ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.light,
    primaryColor: primaryBlue,
    scaffoldBackgroundColor: background,
    useMaterial3: true,
    
    colorScheme: const ColorScheme.light(
      primary: primaryBlue,
      secondary: lightBlue,
      surface: surface,
      error: error,
      onPrimary: Colors.white,
      onSurface: textPrimary,
    ),
    
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: surface,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: true,
      titleTextStyle: TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.w600, color: primaryBlue),
      iconTheme: IconThemeData(color: primaryBlue),
    ),
    
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: bottomBar,
      selectedItemColor: primaryBlue,
      unselectedItemColor: textMuted,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    
    cardTheme: CardTheme(
      color: surface,
      elevation: 3,
      shadowColor: primaryBlue.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: textLight.withOpacity(0.3))),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: primaryBlue, width: 2)),
      hintStyle: const TextStyle(color: textLight),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    
    textTheme: TextTheme(
      titleLarge: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600, color: textPrimary),
      titleMedium: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w500, color: textPrimary),
      bodyLarge: GoogleFonts.cairo(fontSize: 14, color: textSecondary),
      bodyMedium: GoogleFonts.cairo(fontSize: 13, color: textSecondary),
    ),
    
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryBlue,
      foregroundColor: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: primaryBlue),
    tabBarTheme: TabBarTheme(labelColor: primaryBlue, unselectedLabelColor: textMuted, indicatorColor: primaryBlue),
  );

  // ============ الثيم الداكن ============
  static ThemeData get darkTheme => lightTheme;

  // ============ دوال مساعدة ============
  static Color getTextColor(BuildContext context) => textPrimary;
  static Color getSecondaryTextColor(BuildContext context) => textSecondary;
  static Color getCardColor(BuildContext context) => surface;
  static Color getBackgroundColor(BuildContext context) => background;
  static Color getSurfaceColor(BuildContext context) => surface;
}
