import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // ============ الألوان الرئيسية ============
  
  // الثيم الذهبي (نهاري)
  static const Color goldColor = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFE5C158);
  static const Color goldDark = Color(0xFFB8860B);
  
  // الثيم الداكن - كحلي / أزرق ليلي (Navy Blue / Midnight Blue)
  static const Color navyPrimary = Color(0xFF1A2A44);        // الكحلي الأساسي
  static const Color navyLight = Color(0xFF2A3A5C);          // كحلي فاتح
  static const Color navyDark = Color(0xFF0F1A2E);           // كحلي غامق
  static const Color navyAccent = Color(0xFF3B82F6);         // أزرق فاتح للتحديد
  static const Color navyGold = Color(0xFFD4AF37);           // لمسات ذهبية
  
  // ألوان عامة
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);
  
  // ألوان الخلفيات للوضع النهاري
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF1F5F9);

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
        color: Color(0xFF1E293B),
        letterSpacing: 1.5,
      ),
      iconTheme: IconThemeData(color: goldColor),
    ),
    
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: lightSurface,
      selectedItemColor: goldColor,
      unselectedItemColor: Color(0xFF94A3B8),
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
      hintStyle: const TextStyle(
        color: Color(0xFF94A3B8),
        fontFamily: 'Cairo',
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontFamily: 'Cairo', fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
      headlineMedium: TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
      titleLarge: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
      bodyLarge: TextStyle(fontFamily: 'Cairo', fontSize: 16, color: Color(0xFF1E293B)),
      bodyMedium: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: Color(0xFF475569)),
      labelSmall: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Color(0xFF94A3B8)),
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
    
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: goldColor),
    tabBarTheme: const TabBarTheme(labelColor: goldColor, unselectedLabelColor: Color(0xFF94A3B8), indicatorColor: goldColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: goldColor, foregroundColor: Colors.white),
  );

  // ============================================
  // الثيم الداكن (كحلي - Navy Blue / Midnight Blue)
  // ============================================
  static ThemeData get darkTheme => ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.dark,
    primaryColor: navyGold,
    scaffoldBackgroundColor: navyPrimary,
    useMaterial3: true,
    
    colorScheme: const ColorScheme.dark(
      primary: navyGold,
      secondary: navyAccent,
      surface: navyLight,
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
      iconTheme: IconThemeData(color: navyGold),
    ),
    
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: navyDark,
      selectedItemColor: navyGold,
      unselectedItemColor: Color(0xFF64748B),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    
    cardTheme: CardTheme(
      color: navyLight,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: navyGold,
        foregroundColor: navyPrimary,
        elevation: 4,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: navyGold,
        side: const BorderSide(color: navyGold),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: navyLight,
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
        borderSide: const BorderSide(color: navyGold, width: 2),
      ),
      hintStyle: const TextStyle(
        color: Color(0xFF64748B),
        fontFamily: 'Cairo',
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontFamily: 'Cairo', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      headlineMedium: TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      titleLarge: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
      bodyLarge: TextStyle(fontFamily: 'Cairo', fontSize: 16, color: Colors.white),
      bodyMedium: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: Color(0xFFCBD5E1)),
      labelSmall: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Color(0xFF64748B)),
    ),
    
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return navyGold;
        return Colors.grey;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return navyGold.withOpacity(0.5);
        return Colors.grey.withOpacity(0.3);
      }),
    ),
    
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: navyGold),
    tabBarTheme: const TabBarTheme(labelColor: navyGold, unselectedLabelColor: Color(0xFF64748B), indicatorColor: navyGold),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: navyGold, foregroundColor: navyPrimary),
  );

  // ============ دوال مساعدة ============
  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? Colors.white 
        : const Color(0xFF1E293B);
  }

  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? const Color(0xFFCBD5E1) 
        : const Color(0xFF475569);
  }

  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? navyLight 
        : lightCard;
  }

  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? navyPrimary 
        : lightBackground;
  }
  
  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? navyDark 
        : lightSurface;
  }
}

// ============ تحسينات إضافية للثيم ============

// إضافة تأثيرات حركية للكروت
class AnimatedCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double elevation;
  final Color? color;
  
  const AnimatedCard({
    super.key,
    required this.child,
    this.onTap,
    this.elevation = 4,
    this.color,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isPressed ? 0.98 : (_isHovered ? 1.02 : 1.0),
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: widget.color ?? AppTheme.getCardColor(context),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(_isHovered ? 0.2 : 0.1),
                  blurRadius: _isHovered ? 12 : 8,
                  offset: Offset(0, _isHovered ? 6 : 4),
                ),
              ],
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

// ============ متغيرات للتوافق مع الكود القديم ============
static const Color darkBackground = navyPrimary;
static const Color lightBackground = Color(0xFFF8FAFC);
static const Color goldLight = Color(0xFFE5C158);
static const Color goldDark = Color(0xFFB8860B);
static const Color darkBlueGrayAccent = navyAccent;

static const LinearGradient goldGradient = LinearGradient(
  colors: [goldColor, goldLight],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
