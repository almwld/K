import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // انتظار 2.5 ثانية للشاشة الترحيبية
    await Future.delayed(const Duration(milliseconds: 2500));

    if (!mounted) return;

    // الانتقال إلى الصفحة الرئيسية مباشرة
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
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

            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.goldColor),
            ).animate().fadeIn(
              delay: 800.ms,
              duration: 400.ms,
            ),

            const SizedBox(height: 40),

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
