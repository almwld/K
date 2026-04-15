import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ============ الألوان الأساسية ============
  static const Color goldColor = Color(0xFFD4AF37);
  static const Color goldDark = Color(0xFFB8860B);
  static const Color goldLight = Color(0xFFF5D675);
  
  static const Color blueColor = Color(0xFF2196F3);
  static const Color blueDark = Color(0xFF1976D2);
  static const Color blueLight = Color(0xFF64B5F6);
  
  static const Color greenColor = Color(0xFF4CAF50);
  static const Color greenDark = Color(0xFF388E3C);
  static const Color greenLight = Color(0xFF81C784);
  
  // ألوان عامة
  static const Color success = Color(0xFF2ECC71);
  static const Color error = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFF39C12);
  
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCard = Color(0xFF2C2C2C);
  
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFAFAFA);

  // ============================================
  // 1️⃣ الثيم النهاري (ذهبي)
  // ============================================
  static ThemeData get lightTheme {
    return _buildTheme(
      primaryColor: goldColor,
      secondaryColor: goldDark,
      lightColor: goldLight,
      brightness: Brightness.light,
      background: lightBackground,
      surface: lightSurface,
      card: lightCard,
      textColor: Colors.black87,
      textSecondary: Colors.grey[700]!,
    );
  }

  // ============================================
  // 2️⃣ الثيم الليلي (داكن مع لمسات ذهبية)
  // ============================================
  static ThemeData get darkTheme {
    return _buildTheme(
      primaryColor: goldColor,
      secondaryColor: goldDark,
      lightColor: goldLight,
      brightness: Brightness.dark,
      background: darkBackground,
      surface: darkSurface,
      card: darkCard,
      textColor: Colors.white,
      textSecondary: Colors.grey[400]!,
    );
  }

  // ============================================
  // 3️⃣ الثيم الأزرق (كامل)
  // ============================================
  static ThemeData get blueTheme {
    return _buildTheme(
      primaryColor: blueColor,
      secondaryColor: blueDark,
      lightColor: blueLight,
      brightness: Brightness.light,
      background: const Color(0xFFE3F2FD),  // أزرق فاتح جداً للخلفية
      surface: Colors.white,
      card: Colors.white,
      textColor: Colors.black87,
      textSecondary: Colors.grey[700]!,
    );
  }

  // ============================================
  // 4️⃣ الثيم الأخضر (كامل)
  // ============================================
  static ThemeData get greenTheme {
    return _buildTheme(
      primaryColor: greenColor,
      secondaryColor: greenDark,
      lightColor: greenLight,
      brightness: Brightness.light,
      background: const Color(0xFFE8F5E9),  // أخضر فاتح جداً للخلفية
      surface: Colors.white,
      card: Colors.white,
      textColor: Colors.black87,
      textSecondary: Colors.grey[700]!,
    );
  }

  // ============================================
  // دالة بناء الثيم المشتركة
  // ============================================
  static ThemeData _buildTheme({
    required Color primaryColor,
    required Color secondaryColor,
    required Color lightColor,
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color card,
    required Color textColor,
    required Color textSecondary,
  }) {
    final isDark = brightness == Brightness.dark;
    
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: background,
      cardColor: card,
      fontFamily: 'Changa',
      
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primaryColor,
        onPrimary: isDark ? Colors.black : Colors.white,
        secondary: secondaryColor,
        onSecondary: isDark ? Colors.black : Colors.white,
        error: error,
        onError: Colors.white,
        surface: surface,
        onSurface: textColor,
        background: background,
        onBackground: textColor,
      ),
      
      // شريط التطبيق
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.changa(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.black : Colors.white,
        ),
        iconTheme: IconThemeData(
          color: isDark ? Colors.black : Colors.white,
        ),
      ),
      
      // شريط التنقل السفلي
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: primaryColor,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      
      // الأزرار المرتفعة
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: isDark ? Colors.black : Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.changa(fontWeight: FontWeight.bold),
        ),
      ),
      
      // الأزرار المحددة
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: BorderSide(color: primaryColor),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      
      // أزرار النص
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primaryColor),
      ),
      
      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: isDark ? Colors.black : Colors.white,
      ),
      
      // البطاقات
      cardTheme: CardTheme(
        color: card,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      
      // حقول الإدخال
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? darkCard : Colors.grey[100],
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
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: TextStyle(color: textSecondary),
        hintStyle: TextStyle(color: textSecondary.withOpacity(0.7)),
      ),
      
      // أيقونات
      iconTheme: IconThemeData(color: textSecondary),
      primaryIconTheme: IconThemeData(color: primaryColor),
      
      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) return primaryColor;
          return Colors.grey;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) return primaryColor.withOpacity(0.5);
          return Colors.grey.withOpacity(0.3);
        }),
      ),
      
      // Checkbox
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) return primaryColor;
          return Colors.transparent;
        }),
        checkColor: MaterialStateProperty.all(Colors.white),
        side: BorderSide(color: primaryColor, width: 2),
      ),
      
      // Radio
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(primaryColor),
      ),
      
      // شريط التقدم
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primaryColor,
        circularTrackColor: primaryColor.withOpacity(0.2),
        linearTrackColor: primaryColor.withOpacity(0.2),
      ),
      
      // النصوص
      textTheme: TextTheme(
        displayLarge: GoogleFonts.changa(fontSize: 32, fontWeight: FontWeight.bold, color: textColor),
        displayMedium: GoogleFonts.changa(fontSize: 28, fontWeight: FontWeight.bold, color: textColor),
        displaySmall: GoogleFonts.changa(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
        headlineLarge: GoogleFonts.changa(fontSize: 22, fontWeight: FontWeight.bold, color: textColor),
        headlineMedium: GoogleFonts.changa(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
        headlineSmall: GoogleFonts.changa(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
        titleLarge: GoogleFonts.changa(fontSize: 16, fontWeight: FontWeight.w600, color: textColor),
        titleMedium: GoogleFonts.changa(fontSize: 14, fontWeight: FontWeight.w600, color: textColor),
        titleSmall: GoogleFonts.changa(fontSize: 12, fontWeight: FontWeight.w600, color: textColor),
        bodyLarge: GoogleFonts.changa(fontSize: 16, color: textColor),
        bodyMedium: GoogleFonts.changa(fontSize: 14, color: textColor),
        bodySmall: GoogleFonts.changa(fontSize: 12, color: textSecondary),
      ),
      
      // تبويبات
      tabBarTheme: TabBarTheme(
        labelColor: primaryColor,
        unselectedLabelColor: textSecondary,
        indicatorColor: primaryColor,
      ),
    );
  }

  // ============ دوال مساعدة ============
  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? Colors.white 
        : Colors.black87;
  }

  static Color getCardColor(BuildContext context) {
    return Theme.of(context).cardColor;
  }

  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }
}
