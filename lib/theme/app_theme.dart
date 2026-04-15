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
  
  // ============ ألوان الحالة ============
  static const Color success = Color(0xFF2ECC71);
  static const Color error = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFF39C12);
  static const Color info = Color(0xFF3498DB);
  
  // ============ ألوان الوضع الداكن ============
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCard = Color(0xFF2C2C2C);
  
  // ============ ألوان الوضع النهاري ============
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFAFAFA);
  
  // ============ التدرجات ============
  static const LinearGradient goldGradient = LinearGradient(
    colors: [goldColor, goldLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ============ الثيم النهاري (ذهبي) ============
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

  // ============ الثيم الليلي ============
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

  // ============ الثيم الأزرق ============
  static ThemeData get blueTheme {
    return _buildTheme(
      primaryColor: blueColor,
      secondaryColor: blueDark,
      lightColor: blueLight,
      brightness: Brightness.light,
      background: const Color(0xFFE3F2FD),
      surface: Colors.white,
      card: Colors.white,
      textColor: Colors.black87,
      textSecondary: Colors.grey[700]!,
    );
  }

  // ============ الثيم الأخضر ============
  static ThemeData get greenTheme {
    return _buildTheme(
      primaryColor: greenColor,
      secondaryColor: greenDark,
      lightColor: greenLight,
      brightness: Brightness.light,
      background: const Color(0xFFE8F5E9),
      surface: Colors.white,
      card: Colors.white,
      textColor: Colors.black87,
      textSecondary: Colors.grey[700]!,
    );
  }

  // ============ دالة بناء الثيم ============
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.changa(fontWeight: FontWeight.bold),
        ),
      ),
      
      cardTheme: CardTheme(
        color: card,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? darkCard : Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      
      textTheme: TextTheme(
        titleLarge: GoogleFonts.changa(fontSize: 16, fontWeight: FontWeight.w600, color: textColor),
        titleMedium: GoogleFonts.changa(fontSize: 14, fontWeight: FontWeight.w600, color: textColor),
        bodyLarge: GoogleFonts.changa(fontSize: 16, color: textColor),
        bodyMedium: GoogleFonts.changa(fontSize: 14, color: textColor),
        bodySmall: GoogleFonts.changa(fontSize: 12, color: textSecondary),
      ),
    );
  }

  // ============ دوال مساعدة ============
  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? Colors.white 
        : Colors.black87;
  }

  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? Colors.grey[400]! 
        : Colors.grey[600]!;
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
