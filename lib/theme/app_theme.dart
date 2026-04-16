import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // ============ الألوان الرئيسية ============
  
  // الثيم الذهبي (نهاري)
  static const Color goldColor = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFE5C158);
  static const Color goldDark = Color(0xFFB8860B);
  
  // الثيم الداكن (أزرق داكن مائل للرمادي - Dark Blue Gray)
  static const Color darkBlueGray = Color(0xFF1A2530);
  static const Color darkBlueGrayLight = Color(0xFF2C3E50);
  static const Color darkBlueGrayCard = Color(0xFF243447);
  static const Color darkBlueGrayAccent = Color(0xFF3498DB);
  
  // ألوان عامة
  static const Color success = Color(0xFF00C853);
  static const Color error = Color(0xFFFF3D00);
  static const Color warning = Color(0xFFFFA000);
  
  // ألوان الخلفيات للوضع النهاري
  static const Color lightBackground = Color(0xFFF5F7FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF8F9FA);

  // ============================================
  // الثيم النهاري (ذهبي + أبيض)
  // ============================================
  static ThemeData get lightTheme => ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.light,
    primaryColor: goldColor,
    scaffoldBackgroundColor: lightBackground,
    useMaterial3: true,
    
    colorScheme: const ColorScheme.light(
      primary: goldColor,
      secondary: goldLight,
      surface: lightSurface,
      error: error,
    ),
    
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: lightSurface,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
        letterSpacing: 1.5,
      ),
      iconTheme: IconThemeData(color: goldColor),
    ),
    
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: lightSurface,
      selectedItemColor: goldColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    
    cardTheme: CardTheme(
      color: lightCard,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: goldColor,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: goldColor,
        side: const BorderSide(color: goldColor),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightCard,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: goldColor, width: 2),
      ),
      hintStyle: TextStyle(
        color: Colors.grey[500],
        fontFamily: 'Cairo',
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 16,
        color: Colors.black87,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 14,
        color: Colors.black54,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 12,
        color: Colors.grey,
      ),
    ),
    
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return goldColor;
        return Colors.grey;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return goldColor.withOpacity(0.5);
        return Colors.grey.withOpacity(0.3);
      }),
    ),
    
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: goldColor,
    ),
    
    tabBarTheme: const TabBarTheme(
      labelColor: goldColor,
      unselectedLabelColor: Colors.grey,
      indicatorColor: goldColor,
    ),
    
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: goldColor,
      foregroundColor: Colors.white,
    ),
  );

  // ============================================
  // الثيم الداكن (أزرق داكن مائل للرمادي - Dark Blue Gray)
  // ============================================
  static ThemeData get darkTheme => ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.dark,
    primaryColor: darkBlueGrayAccent,
    scaffoldBackgroundColor: darkBlueGray,
    useMaterial3: true,
    
    colorScheme: const ColorScheme.dark(
      primary: darkBlueGrayAccent,
      secondary: darkBlueGrayAccent,
      surface: darkBlueGrayCard,
      error: error,
    ),
    
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.5,
      ),
      iconTheme: IconThemeData(color: darkBlueGrayAccent),
    ),
    
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkBlueGrayCard,
      selectedItemColor: darkBlueGrayAccent,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    
    cardTheme: CardTheme(
      color: darkBlueGrayCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkBlueGrayAccent,
        foregroundColor: Colors.white,
        elevation: 4,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: darkBlueGrayAccent,
        side: const BorderSide(color: darkBlueGrayAccent),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkBlueGrayCard,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: darkBlueGrayAccent, width: 2),
      ),
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontFamily: 'Cairo',
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 16,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 14,
        color: Colors.white70,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 12,
        color: Colors.grey,
      ),
    ),
    
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return darkBlueGrayAccent;
        return Colors.grey;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return darkBlueGrayAccent.withOpacity(0.5);
        return Colors.grey.withOpacity(0.3);
      }),
    ),
    
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: darkBlueGrayAccent,
    ),
    
    tabBarTheme: const TabBarTheme(
      labelColor: darkBlueGrayAccent,
      unselectedLabelColor: Colors.grey,
      indicatorColor: darkBlueGrayAccent,
    ),
    
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: darkBlueGrayAccent,
      foregroundColor: Colors.white,
    ),
  );

  // ============ دوال مساعدة ============
  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? Colors.white 
        : Colors.black87;
  }

  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? Colors.white70 
        : Colors.black54;
  }

  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkBlueGrayCard 
        : lightCard;
  }

  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkBlueGray 
        : lightBackground;
  }
  
  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkBlueGrayCard 
        : lightSurface;
  }
}
