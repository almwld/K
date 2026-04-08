import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';
import 'main_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    // انتظار 3 ثواني
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // التحقق من حالة تسجيل الدخول
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

    if (isLoggedIn) {
      // مستخدم مسجل دخول → الرئيسية
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigation()),
      );
    } else {
      // مستخدم جديد → شاشة تسجيل الدخول
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // الشعار
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.goldColor, AppTheme.goldLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.goldColor.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.shopping_bag,
                  size: 60,
                  color: Colors.black,
                ),
              ),
            ).animate().scale(
              duration: 800.ms,
              curve: Curves.easeOutBack,
            ).fadeIn(duration: 600.ms),

            const SizedBox(height: 40),

            // اسم التطبيق
            Text(
              'FLEX YEMEN',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: isDark ? AppTheme.goldColor : AppTheme.goldDark,
                letterSpacing: 2,
              ),
            ).animate().fadeIn(
              delay: 400.ms,
              duration: 600.ms,
            ).slideY(
              begin: 0.3,
              end: 0,
              delay: 400.ms,
              duration: 600.ms,
            ),

            const SizedBox(height: 16),

            // الوصف
            Text(
              'منصة التجارة الإلكترونية اليمنية',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 16,
                color: AppTheme.getSecondaryTextColor(context),
              ),
            ).animate().fadeIn(
              delay: 600.ms,
              duration: 600.ms,
            ),

            const SizedBox(height: 60),

            // مؤشر التحميل
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.goldColor),
            ).animate().fadeIn(
              delay: 800.ms,
              duration: 400.ms,
            ),

            const SizedBox(height: 40),

            // حقوق النشر
            Text(
              '© 2024 Flex Yemen. All rights reserved.',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.getSecondaryTextColor(context).withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
