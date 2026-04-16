import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ============ الألوان الأساسية ============
  
  // الثيم الأزرق
  static const Color bluePrimary = Color(0xFF2196F3);
  static const Color blueDark = Color(0xFF1565C0);
  static const Color blueLight = Color(0xFF64B5F6);
  
  // الثيم الأخضر
  static const Color greenPrimary = Color(0xFF4CAF50);
  static const Color greenDark = Color(0xFF2E7D32);
  static const Color greenLight = Color(0xFF81C784);
  
  // الثيم الذهبي
  static const Color goldPrimary = Color(0xFFD4AF37);
  static const Color goldDark = Color(0xFFB8860B);
  static const Color goldLight = Color(0xFFF5D675);
  
  // ألوان عامة
  static const Color success = Color(0xFF00C853);
  static const Color error = Color(0xFFFF3D00);
  static const Color warning = Color(0xFFFFA000);
  
  // خلفيات
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCard = Color(0xFF2C2C2C);
  
  static const Color lightBackground = Color(0xFFF5F7FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF8F9FA);

  // للتوافق مع الكود القديم
  static const Color goldColor = goldPrimary;
  
  static const LinearGradient goldGradient = LinearGradient(
    colors: [goldPrimary, goldLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ============ الثيم الأزرق ============
  static ThemeData get blueTheme {
    return _buildTheme(
      primaryColor: bluePrimary,
      secondaryColor: blueDark,
      brightness: Brightness.light,
      background: lightBackground,
      surface: lightSurface,
      card: lightCard,
      textColor: const Color(0xFF1E293B),
      textSecondary: const Color(0xFF64748B),
    );
  }

  // ============ الثيم الأخضر ============
  static ThemeData get greenTheme {
    return _buildTheme(
      primaryColor: greenPrimary,
      secondaryColor: greenDark,
      brightness: Brightness.light,
      background: const Color(0xFFE8F5E9),
      surface: Colors.white,
      card: const Color(0xFFF1F8E9),
      textColor: const Color(0xFF1E293B),
      textSecondary: const Color(0xFF64748B),
    );
  }

  // ============ الثيم الذهبي ============
  static ThemeData get goldTheme {
    return _buildTheme(
      primaryColor: goldPrimary,
      secondaryColor: goldDark,
      brightness: Brightness.light,
      background: lightBackground,
      surface: lightSurface,
      card: lightCard,
      textColor: const Color(0xFF1E293B),
      textSecondary: const Color(0xFF64748B),
    );
  }

  // ============ الثيم الداكن ============
  static ThemeData get darkTheme {
    return _buildTheme(
      primaryColor: goldPrimary,
      secondaryColor: goldDark,
      brightness: Brightness.dark,
      background: darkBackground,
      surface: darkSurface,
      card: darkCard,
      textColor: Colors.white,
      textSecondary: Colors.grey[400]!,
    );
  }

  // ============ دالة بناء الثيم ============
  static ThemeData _buildTheme({
    required Color primaryColor,
    required Color secondaryColor,
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
      
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: textColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.changa(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        iconTheme: IconThemeData(color: primaryColor),
      ),
      
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: primaryColor,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: isDark ? Colors.black : Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.changa(fontWeight: FontWeight.bold),
        ),
      ),
      
      cardTheme: CardTheme(
        color: card,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? darkCard : Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      
      textTheme: TextTheme(
        titleLarge: GoogleFonts.changa(fontSize: 16, fontWeight: FontWeight.w600, color: textColor),
        titleMedium: GoogleFonts.changa(fontSize: 14, fontWeight: FontWeight.w600, color: textColor),
        bodyLarge: GoogleFonts.changa(fontSize: 16, color: textColor),
        bodyMedium: GoogleFonts.changa(fontSize: 14, color: textColor),
        bodySmall: GoogleFonts.changa(fontSize: 12, color: textSecondary),
      ),
      
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: isDark ? Colors.black : Colors.white,
      ),
      
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primaryColor,
      ),
      
      tabBarTheme: TabBarTheme(
        labelColor: primaryColor,
        unselectedLabelColor: textSecondary,
        indicatorColor: primaryColor,
      ),
      
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return primaryColor;
          return Colors.grey;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return primaryColor.withOpacity(0.5);
          return Colors.grey.withOpacity(0.3);
        }),
      ),
    );
  }

  // ============ دوال مساعدة ============
  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? Colors.white 
        : const Color(0xFF1E293B);
  }

  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? Colors.grey[400]! 
        : const Color(0xFF64748B);
  }

  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkCard 
        : lightCard;
  }

  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkBackground 
        : lightBackground;
  }
  
  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkSurface 
        : lightSurface;
  }
}
