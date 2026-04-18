import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'home/main_navigation.dart';

/// شاشة الترحيب
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _controller.forward();
    _navigateToNextScreen();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // ✅ الانتقال مباشرة للواجهة الرئيسية كضيف
    // المستخدم يمكنه التصفح بحرية
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const MainNavigation(isGuest: true), // وضع الضيف
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
              isDark ? AppTheme.nightSurface : AppTheme.lightSurface,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // الشعار
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          gradient: AppTheme.goldGradient,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.gold.withOpacity(0.4),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.shopping_bag,
                          size: 80,
                          color: AppTheme.darkText,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              // اسم التطبيق
              FadeTransition(
                opacity: _fadeAnimation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'FLEX',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.gold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'YEMEN',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.goldLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // الشعار الفرعي
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'منصة التجارة الإلكترونية اليمنية',
                  style: TextStyle(
                    fontFamily: 'Changa',
                    fontSize: 16,
                    color: AppTheme.getSecondaryTextColor(context),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // رسالة ترحيبية
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.gold.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    '👋 أهلاً بك! تصفح المنصة بحرية',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 14,
                      color: AppTheme.gold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              // مؤشر التحميل
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.gold),
                strokeWidth: 3,
              ),
            ].animate(
              interval: const Duration(milliseconds: 100),
            ).fadeIn().slideY(
              begin: 0.3,
              end: 0,
              duration: const Duration(milliseconds: 600),
            ),
          ),
        ),
      ),
    );
  }
}
