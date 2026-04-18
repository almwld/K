import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// FLEX YEMEN - Global E-Commerce Platform Theme
/// Premium professional theme with gold accents
class AppTheme {
  // ============ Brand Colors - Premium Gold Palette ============
  static const Color goldPrimary = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFF4E4A6);
  static const Color goldDark = Color(0xFFB8860B);
  static const Color goldAccent = Color(0xFFFFD700);
  
  // ============ Dark Theme Colors ============
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color darkSurface = Color(0xFF141414);
  static const Color darkCard = Color(0xFF1E1E1E);
  static const Color darkElevated = Color(0xFF2A2A2A);
  
  // ============ Light Theme Colors ============
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF5F5F5);
  static const Color lightElevated = Color(0xFFEEEEEE);
  
  // ============ Semantic Colors ============
  static const Color success = Color(0xFF00C853);
  static const Color error = Color(0xFFFF1744);
  static const Color warning = Color(0xFFFF9100);
  static const Color info = Color(0xFF00B0FF);
  
  // ============ Service Colors ============
  static const Color serviceOrange = Color(0xFFFF9800);
  static const Color serviceRed = Color(0xFFE53935);
  static const Color serviceGreen = Color(0xFF4CAF50);
  static const Color serviceBlue = Color(0xFF2196F3);
  static const Color servicePurple = Color(0xFF9C27B0);
  static const Color serviceTeal = Color(0xFF009688);
  static const Color servicePink = Color(0xFFE91E63);
  static const Color serviceIndigo = Color(0xFF3F51B5);
  static const Color serviceAmber = Color(0xFFFFC107);
  
  // ============ Gradients ============
  static const LinearGradient goldGradient = LinearGradient(
    colors: [goldPrimary, goldLight, goldAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient darkGradient = LinearGradient(
    colors: [darkSurface, darkBackground],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static const LinearGradient premiumGradient = LinearGradient(
    colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ============ Shadows ============
  static List<BoxShadow> get goldShadow => [
    BoxShadow(
      color: goldPrimary.withOpacity(0.3),
      blurRadius: 20,
      spreadRadius: 2,
      offset: const Offset(0, 8),
    ),
  ];
  
  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 15,
      spreadRadius: 0,
      offset: const Offset(0, 5),
    ),
  ];

  // ============ Dark Theme ============
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: goldPrimary,
      fontFamily: 'Cairo',
      colorScheme: const ColorScheme.dark(
        primary: goldPrimary,
        secondary: goldLight,
        surface: darkSurface,
        background: darkBackground,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: Colors.white,
        onBackground: Colors.white,
        error: error,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkSurface.withOpacity(0.95),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),
        iconTheme: const IconThemeData(color: goldPrimary),
      ),
      cardTheme: CardTheme(
        color: darkCard,
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkSurface,
        selectedItemColor: goldPrimary,
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        elevation: 20,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 11,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: goldPrimary,
        foregroundColor: Colors.black,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontWeight: FontWeight.w700),
        displayMedium: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontWeight: FontWeight.w700),
        displaySmall: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontWeight: FontWeight.w600),
        headlineLarge: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontWeight: FontWeight.w600),
        titleLarge: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontWeight: FontWeight.w500),
        titleSmall: TextStyle(color: Colors.white70, fontFamily: 'Cairo', fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(color: Colors.white70, fontFamily: 'Cairo', fontWeight: FontWeight.w400),
        bodySmall: TextStyle(color: Colors.white54, fontFamily: 'Cairo', fontWeight: FontWeight.w400),
        labelLarge: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontWeight: FontWeight.w500),
        labelMedium: TextStyle(color: Colors.white70, fontFamily: 'Cairo', fontWeight: FontWeight.w500),
        labelSmall: TextStyle(color: Colors.white54, fontFamily: 'Cairo', fontWeight: FontWeight.w400),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: goldPrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: error, width: 2),
        ),
        hintStyle: TextStyle(color: Colors.grey[500], fontFamily: 'Cairo'),
        labelStyle: const TextStyle(color: Colors.white70, fontFamily: 'Cairo'),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: goldPrimary,
          foregroundColor: Colors.black,
          elevation: 8,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: goldPrimary,
          side: const BorderSide(color: goldPrimary, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: goldPrimary,
          textStyle: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w600),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 24,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey[800],
        thickness: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: darkElevated,
        selectedColor: goldPrimary.withOpacity(0.2),
        labelStyle: const TextStyle(fontFamily: 'Cairo'),
        secondaryLabelStyle: const TextStyle(fontFamily: 'Cairo'),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return goldPrimary;
          }
          return Colors.grey[600]!;
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return goldPrimary;
          }
          return Colors.grey[600]!;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return goldPrimary;
          }
          return Colors.grey[400]!;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return goldPrimary.withOpacity(0.5);
          }
          return Colors.grey[800]!;
        }),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: goldPrimary,
        circularTrackColor: Colors.white24,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: goldPrimary,
        inactiveTrackColor: Colors.grey[800],
        thumbColor: goldPrimary,
        overlayColor: goldPrimary.withOpacity(0.2),
        valueIndicatorColor: goldPrimary,
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.black,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ============ Light Theme ============
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackground,
      primaryColor: goldDark,
      fontFamily: 'Cairo',
      colorScheme: const ColorScheme.light(
        primary: goldDark,
        secondary: goldPrimary,
        surface: lightSurface,
        background: lightBackground,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Color(0xFF1A1A1A),
        onBackground: Color(0xFF1A1A1A),
        error: error,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: lightSurface.withOpacity(0.95),
        foregroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: const TextStyle(
          color: Color(0xFF1A1A1A),
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),
        iconTheme: const IconThemeData(color: goldDark),
      ),
      cardTheme: CardTheme(
        color: lightCard,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: lightSurface,
        selectedItemColor: goldDark,
        unselectedItemColor: Colors.grey[500],
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 11,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: goldDark,
        foregroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Color(0xFF1A1A1A), fontFamily: 'Cairo', fontWeight: FontWeight.w700),
        displayMedium: TextStyle(color: Color(0xFF1A1A1A), fontFamily: 'Cairo', fontWeight: FontWeight.w700),
        displaySmall: TextStyle(color: Color(0xFF1A1A1A), fontFamily: 'Cairo', fontWeight: FontWeight.w600),
        headlineLarge: TextStyle(color: Color(0xFF1A1A1A), fontFamily: 'Cairo', fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(color: Color(0xFF1A1A1A), fontFamily: 'Cairo', fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(color: Color(0xFF1A1A1A), fontFamily: 'Cairo', fontWeight: FontWeight.w600),
        titleLarge: TextStyle(color: Color(0xFF1A1A1A), fontFamily: 'Cairo', fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: Color(0xFF1A1A1A), fontFamily: 'Cairo', fontWeight: FontWeight.w500),
        titleSmall: TextStyle(color: Color(0xFF666666), fontFamily: 'Cairo', fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: Color(0xFF1A1A1A), fontFamily: 'Cairo', fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(color: Color(0xFF666666), fontFamily: 'Cairo', fontWeight: FontWeight.w400),
        bodySmall: TextStyle(color: Color(0xFF999999), fontFamily: 'Cairo', fontWeight: FontWeight.w400),
        labelLarge: TextStyle(color: Color(0xFF1A1A1A), fontFamily: 'Cairo', fontWeight: FontWeight.w500),
        labelMedium: TextStyle(color: Color(0xFF666666), fontFamily: 'Cairo', fontWeight: FontWeight.w500),
        labelSmall: TextStyle(color: Color(0xFF999999), fontFamily: 'Cairo', fontWeight: FontWeight.w400),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: goldDark, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: error, width: 2),
        ),
        hintStyle: TextStyle(color: Colors.grey[500], fontFamily: 'Cairo'),
        labelStyle: TextStyle(color: Colors.grey[700], fontFamily: 'Cairo'),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: goldDark,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: goldDark,
          side: const BorderSide(color: goldDark, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: goldDark,
          textStyle: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w600),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF1A1A1A),
        size: 24,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey[300],
        thickness: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: lightElevated,
        selectedColor: goldDark.withOpacity(0.2),
        labelStyle: const TextStyle(fontFamily: 'Cairo'),
        secondaryLabelStyle: const TextStyle(fontFamily: 'Cairo'),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return goldDark;
          }
          return Colors.grey[400]!;
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return goldDark;
          }
          return Colors.grey[400]!;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return goldDark;
          }
          return Colors.grey[300]!;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return goldDark.withOpacity(0.5);
          }
          return Colors.grey[300]!;
        }),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: goldDark,
        circularTrackColor: Colors.black12,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: goldDark,
        inactiveTrackColor: Colors.grey[300],
        thumbColor: goldDark,
        overlayColor: goldDark.withOpacity(0.2),
        valueIndicatorColor: goldDark,
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// Extension للتوافق مع الكود القديم فقط
/// يمكن حذف هذا الجزء بعد تحديث جميع الملفات
extension LegacyAppTheme on AppTheme {
  // ألوان قديمة
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color navyCard = Color(0xFF1E2A47);
  static const Color textMuted = Color(0xFF757575);
  static const Color textPrimary = Color(0xFF212121);
  static const Color priceColor = Color(0xFF4CAF50);
  
  // دوال قديمة
  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? AppTheme.darkCard 
        : AppTheme.lightCard;
  }
  
  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? Colors.white70 
        : const Color(0xFF666666);
  }
}

/// Theme Manager with Provider
class ThemeManager extends ChangeNotifier {
  static const String _themeKey = 'is_dark_mode';
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;
  bool get isLightMode => !_isDarkMode;  // ✅ للتوافق

  ThemeManager() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_themeKey) ?? true;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkMode);
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkMode);
    notifyListeners();
  }

  Future<void> setThemeModeIndex(int index) async {
    _isDarkMode = index == 1;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkMode);
    notifyListeners();
  }

  ThemeData get currentTheme => _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
  
  // ✅ للتوافق مع profile_screen.dart
  Color get primaryColor => _isDarkMode ? AppTheme.goldPrimary : AppTheme.goldDark;
}
