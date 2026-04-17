import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ============ ألوان Premium Dark Mode ============
  
  // الخلفيات - أسود فحمي ورمادي غامق
  static const Color background = Color(0xFF0D0D0D);      // أسود عميق
  static const Color surface = Color(0xFF1A1A2E);         // كحلي غامق للبطاقات
  static const Color bottomBar = Color(0xFF000000);       // أسود خالص للشريط السفلي
  
  // اللون الذهبي المطفي (Matte Gold)
  static const Color goldPrimary = Color(0xFFD4AF37);     // ذهبي أساسي
  static const Color goldLight = Color(0xFFE5C158);       // ذهبي فاتح
  static const Color goldDark = Color(0xFFB8860B);        // ذهبي غامق
  
  // النصوص
  static const Color textPrimary = Color(0xFFFFFFFF);     // أبيض ناصع
  static const Color textSecondary = Color(0xFFB3B3B3);   // رمادي فاتح
  static const Color textMuted = Color(0xFF757575);       // رمادي خافت
  
  // ألوان الحالة - أهدأ
  static const Color success = Color(0xFF2E7D32);
  static const Color error = Color(0xFFC62828);
  static const Color warning = Color(0xFFF57F17);
  
  // متغيرات للتوافق مع الكود القديم
  static const Color goldColor = goldPrimary;
  static const Color navyPrimary = background;
  static const Color navyCard = surface;
  static const Color navyDark = bottomBar;
  static const Color navyGold = goldPrimary;
  static const Color darkBackground = background;
  static const Color darkCard = surface;
  static const Color darkSurface = surface;
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF1F5F9);
  
  // التدرجات
  static const LinearGradient goldGradient = LinearGradient(
    colors: [goldPrimary, goldLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ============ الثيم الداكن الفاخر (Premium Dark) ============
  static ThemeData get darkTheme => ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.dark,
    primaryColor: goldPrimary,
    scaffoldBackgroundColor: background,
    useMaterial3: true,
    
    colorScheme: const ColorScheme.dark(
      primary: goldPrimary,
      secondary: goldLight,
      surface: surface,
      error: error,
      onPrimary: Colors.black,
      onSurface: textPrimary,
    ),
    
    // شريط التطبيق - شفاف مع نص ذهبي
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: goldPrimary,
        letterSpacing: 1.2,
      ),
      iconTheme: IconThemeData(color: goldPrimary),
    ),
    
    // شريط التنقل السفلي - أسود خالص مع أيقونات ذهبية
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: bottomBar,
      selectedItemColor: goldPrimary,
      unselectedItemColor: textMuted,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(fontSize: 10),
    ),
    
    // البطاقات - كحلي غامق مع حواف ناعمة
    cardTheme: CardTheme(
      color: surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.zero,
    ),
    
    // الأزرار - ذهبية بتصميم بسيط
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: goldPrimary,
        foregroundColor: Colors.black,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),
    
    // حقول الإدخال
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: goldPrimary, width: 1.5),
      ),
      hintStyle: const TextStyle(color: textMuted, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    
    // النصوص - Cairo بوزن خفيف للمظهر التقني
    textTheme: TextTheme(
      displayLarge: GoogleFonts.cairo(fontSize: 28, fontWeight: FontWeight.w300, color: textPrimary),
      displayMedium: GoogleFonts.cairo(fontSize: 24, fontWeight: FontWeight.w300, color: textPrimary),
      headlineLarge: GoogleFonts.cairo(fontSize: 22, fontWeight: FontWeight.w400, color: textPrimary),
      headlineMedium: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w500, color: textPrimary),
      titleLarge: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w500, color: textPrimary),
      titleMedium: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w400, color: textPrimary),
      bodyLarge: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w300, color: textSecondary),
      bodyMedium: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.w300, color: textSecondary),
      bodySmall: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.w300, color: textMuted),
      labelLarge: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w400, color: goldPrimary),
    ),
    
    // Floating Action Button - ذهبي بارز
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: goldPrimary,
      foregroundColor: Colors.black,
      elevation: 8,
      shape: const CircleBorder(),
      sizeConstraints: const BoxConstraints(minWidth: 60, minHeight: 60),
    ),
    
    // شريط التقدم
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: goldPrimary,
      circularTrackColor: surface,
    ),
    
    // التبويبات
    tabBarTheme: TabBarTheme(
      labelColor: goldPrimary,
      unselectedLabelColor: textMuted,
      indicatorColor: goldPrimary,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: const TextStyle(fontWeight: FontWeight.w500),
    ),
    
    // القوائم المنبثقة
    popupMenuTheme: PopupMenuThemeData(
      color: surface,
      textStyle: const TextStyle(color: textPrimary),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    
    // مربعات الاختيار
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return goldPrimary;
        return textMuted;
      }),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
    
    // شرائح التمرير
    sliderTheme: SliderThemeData(
      activeTrackColor: goldPrimary,
      inactiveTrackColor: surface,
      thumbColor: goldPrimary,
      overlayColor: goldPrimary.withOpacity(0.2),
    ),
  );

  // ============ الثيم النهاري (للتطبيقات التي تدعم الوضعين) ============
  static ThemeData get lightTheme => ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.light,
    primaryColor: goldPrimary,
    scaffoldBackgroundColor: lightBackground,
    useMaterial3: true,
    colorScheme: const ColorScheme.light(primary: goldPrimary, secondary: goldLight, surface: lightSurface, error: error),
    appBarTheme: const AppBarTheme(elevation: 0, backgroundColor: lightSurface, centerTitle: true, titleTextStyle: TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87), iconTheme: IconThemeData(color: goldPrimary)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: lightSurface, selectedItemColor: goldPrimary, unselectedItemColor: Colors.grey, type: BottomNavigationBarType.fixed, elevation: 0),
    cardTheme: CardTheme(color: lightCard, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: goldPrimary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
    textTheme: GoogleFonts.cairoTextTheme().copyWith(bodyLarge: const TextStyle(color: Colors.black87), bodyMedium: const TextStyle(color: Colors.black54)),
  );

  // ============ دوال مساعدة ============
  static Color getTextColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? textPrimary : Colors.black87;
  static Color getSecondaryTextColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? textSecondary : Colors.black54;
  static Color getCardColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? surface : lightCard;
  static Color getBackgroundColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? background : lightBackground;
  static Color getSurfaceColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? surface : lightSurface;
}
