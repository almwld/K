import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import 'onboarding_screen.dart';
import 'home/main_navigation.dart';
import 'admin/admin_main_screen.dart';
import '../services/admin_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _ballController;
  late AnimationController _gateController;
  late AnimationController _fadeController;
  late Animation<double> _ballVerticalMove;
  late Animation<double> _gateSlide;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  
  bool _navigationTriggered = false;

  @override
  void initState() {
    super.initState();
    
    // 1. حركة النقطة (سقوط عمودي مع ارتداد)
    _ballController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _ballVerticalMove = Tween<double>(begin: -100, end: 120).animate(
      CurvedAnimation(parent: _ballController, curve: Curves.bounceOut),
    );

    // 2. حركة البوابات (إغلاق أفقياً)
    _gateController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _gateSlide = Tween<double>(begin: 60, end: 0).animate(
      CurvedAnimation(parent: _gateController, curve: Curves.easeInOut),
    );

    // 3. حركة ظهور النص
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.elasticOut),
    );

    // بدء الحركة المتسلسلة
    _startAnimation();
  }

  Future<void> _startAnimation() async {
    // المرحلة 1: النقطة تسقط
    await _ballController.forward();
    
    // المرحلة 2: البوابة تغلق
    await _gateController.forward();
    
    // المرحلة 3: ظهور النص
    await _fadeController.forward();
    
    // انتظار قليل
    await Future.delayed(const Duration(milliseconds: 500));
    
    // التنقل للشاشة التالية
    if (!_navigationTriggered) {
      _navigationTriggered = true;
      _navigateToNextScreen();
    }
  }

  Future<void> _navigateToNextScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final onboardingSeen = prefs.getBool('onboarding_seen') ?? false;
    
    final adminService = AdminService();
    final canAccessAdmin = await adminService.canAccessAdminPanel();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          if (!onboardingSeen) {
            return const OnboardingScreen();
          } else if (canAccessAdmin) {
            return const AdminMainScreen();
          } else {
            return const MainNavigation();
          }
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? AppTheme.navyPrimary : Colors.white;
    final goldColor = isDark ? AppTheme.navyGold : AppTheme.goldColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // الشعار المتحرك
            SizedBox(
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // البوابات الذهبية
                  AnimatedBuilder(
                    animation: _gateSlide,
                    builder: (context, child) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildGatePart(
                            isLeft: true,
                            offset: _gateSlide.value,
                            color: goldColor,
                          ),
                          const SizedBox(width: 8),
                          _buildGatePart(
                            isLeft: false,
                            offset: _gateSlide.value,
                            color: goldColor,
                          ),
                        ],
                      );
                    },
                  ),
                  
                  // النقطة المتحركة
                  AnimatedBuilder(
                    animation: _ballVerticalMove,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _ballVerticalMove.value),
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: goldColor,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: goldColor.withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // النص الظاهر بعد الحركة
            AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Column(
                      children": [
                        Text(
                          'Flex Yemen',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: goldColor,
                            letterSpacing: 3,
                            shadows: [
                              Shadow(
                                color: goldColor.withOpacity(0.5),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'منصة التجارة الإلكترونية اليمنية',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGatePart({
    required bool isLeft,
    required double offset,
    required Color color,
  }) {
    return Transform.translate(
      offset: Offset(isLeft ? -offset : offset, 0),
      child: Container(
        width: 55,
        height: 90,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
          border: Border.all(
            color: color.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Center(
          child: Container(
            width: 20,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ballController.dispose();
    _gateController.dispose();
    _fadeController.dispose();
    super.dispose();
  }
}
