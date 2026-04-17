import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ============ Premium Light Blue Theme ============
  
  // الأزرق الفاتح المتموج - ألوان رئيسية
  static const Color primaryBlue = Color(0xFF3B82F6);       // أزرق أساسي
  static const Color lightBlue = Color(0xFF60A5FA);         // أزرق فاتح
  static const Color deepBlue = Color(0xFF1E40AF);          // أزرق غامق للتدرجات
  static const Color skyBlue = Color(0xFF93C5FD);           // أزرق سماوي
  
  // لمسات ذهبية للفخامة
  static const Color goldAccent = Color(0xFFD4AF37);        // ذهبي للتحديد
  static const Color goldLight = Color(0xFFFBBF24);         // ذهبي فاتح
  
  // خلفيات فاتحة
  static const Color background = Color(0xFFF0F9FF);        // أزرق فاتح جداً (متموج)
  static const Color surface = Color(0xFFFFFFFF);            // أبيض للبطاقات
  static const Color bottomBar = Color(0xFFFFFFFF);          // أبيض للشريط السفلي
  static const Color waveGradient = Color(0xFFE0F2FE);       // لون الموجة
  
  // النصوص
  static const Color textPrimary = Color(0xFF1E293B);        // أسود مائل للرمادي
  static const Color textSecondary = Color(0xFF475569);      // رمادي متوسط
  static const Color textMuted = Color(0xFF64748B);          // رمادي فاتح
  static const Color textLight = Color(0xFF94A3B8);          // رمادي خفيف
  
  // ألوان الحالة
  static const Color success = Color(0xFF10B981);            // أخضر
  static const Color error = Color(0xFFEF4444);              // أحمر
  static const Color warning = Color(0xFFF59E0B);            // برتقالي
  static const Color info = Color(0xFF3B82F6);               // أزرق
  
  // ألوان المنتجات
  static const Color availableBadge = Color(0xFF10B981);     // أخضر - متوفر
  static const Color unavailableBadge = Color(0xFFEF4444);   // أحمر - غير متوفر
  static const Color priceColor = Color(0xFF1E40AF);         // أزرق غامق للسعر
  
  // متغيرات للتوافق
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
  
  static const LinearGradient waveGradientFull = LinearGradient(
    colors: [Color(0xFFE0F2FE), Color(0xFFBAE6FD), Color(0xFF7DD3FC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ============ الثيم الأزرق الفاتح المتموج ============
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
    
    // شريط التطبيق - أبيض مع أزرق
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: surface,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primaryBlue,
        letterSpacing: 1.2,
      ),
      iconTheme: IconThemeData(color: primaryBlue),
    ),
    
    // شريط التنقل السفلي
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: bottomBar,
      selectedItemColor: primaryBlue,
      unselectedItemColor: textMuted,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    
    // البطاقات - بيضاء مع ظل أزرق خفيف
    cardTheme: CardTheme(
      color: surface,
      elevation: 3,
      shadowColor: primaryBlue.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    
    // الأزرار - زرقاء
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: primaryBlue.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
    ),
    
    // الأزرار المحددة
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryBlue,
        side: const BorderSide(color: primaryBlue, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    
    // حقول الإدخال
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: textLight.withOpacity(0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: textLight.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: primaryBlue, width: 2),
      ),
      hintStyle: const TextStyle(color: textLight, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    
    // النصوص
    textTheme: TextTheme(
      displayLarge: GoogleFonts.cairo(fontSize: 28, fontWeight: FontWeight.w600, color: textPrimary),
      displayMedium: GoogleFonts.cairo(fontSize: 24, fontWeight: FontWeight.w600, color: textPrimary),
      headlineLarge: GoogleFonts.cairo(fontSize: 22, fontWeight: FontWeight.w600, color: textPrimary),
      headlineMedium: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w500, color: textPrimary),
      titleLarge: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600, color: textPrimary),
      titleMedium: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w500, color: textPrimary),
      bodyLarge: GoogleFonts.cairo(fontSize: 14, color: textSecondary),
      bodyMedium: GoogleFonts.cairo(fontSize: 13, color: textSecondary),
      bodySmall: GoogleFonts.cairo(fontSize: 12, color: textMuted),
      labelLarge: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w500, color: primaryBlue),
    ),
    
    // Floating Action Button - أزرق
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryBlue,
      foregroundColor: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    
    // شريط التقدم - أزرق
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryBlue,
      circularTrackColor: Color(0xFFE0F2FE),
    ),
    
    // التبويبات - أزرق
    tabBarTheme: TabBarTheme(
      labelColor: primaryBlue,
      unselectedLabelColor: textMuted,
      indicatorColor: primaryBlue,
      indicatorSize: TabBarIndicatorSize.label,
    ),
    
    // شرائح التمرير
    sliderTheme: SliderThemeData(
      activeTrackColor: primaryBlue,
      inactiveTrackColor: const Color(0xFFE0F2FE),
      thumbColor: primaryBlue,
      overlayColor: primaryBlue.withOpacity(0.2),
    ),
    
    // مربعات الاختيار
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return primaryBlue;
        return textMuted;
      }),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
    
    // القوائم المنبثقة
    popupMenuTheme: PopupMenuThemeData(
      color: surface,
      textStyle: const TextStyle(color: textPrimary),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    
    // رقاقة التصفية
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFE0F2FE),
      selectedColor: primaryBlue,
      checkmarkColor: Colors.white,
      labelStyle: const TextStyle(color: textPrimary),
      secondaryLabelStyle: const TextStyle(color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    ),
    
    // أيقونات
    iconTheme: const IconThemeData(color: textSecondary),
    primaryIconTheme: const IconThemeData(color: primaryBlue),
  );

  // ============ الثيم الداكن (للتطبيقات التي تدعم الوضعين) ============
  static ThemeData get darkTheme => lightTheme;

  // ============ دوال مساعدة ============
  static Color getTextColor(BuildContext context) => textPrimary;
  static Color getSecondaryTextColor(BuildContext context) => textSecondary;
  static Color getCardColor(BuildContext context) => surface;
  static Color getBackgroundColor(BuildContext context) => background;
  static Color getSurfaceColor(BuildContext context) => surface;
}

// ============ متغيرات للتوافق مع الكود القديم ============
static const Color goldDark = goldAccent;
static const Color goldLight = Color(0xFFFBBF24);
