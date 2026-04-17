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

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _ballPosition;
  late Animation<double> _gateGap;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool _inverted = false;
  bool _navigationTriggered = false;
  bool _showSuccess = false;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );

    // حركة الكرة - تسقط من الأعلى
    _ballPosition = Tween<double>(begin: -120, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.45, curve: Curves.easeIn)),
    );

    // حركة إغلاق البوابة
    _gateGap = Tween<double>(begin: 60, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.35, 0.65, curve: Curves.elasticOut)),
    );

    // ظهور النص
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.6, 0.9, curve: Curves.easeOut)),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.6, 0.9, curve: Curves.elasticOut)),
    );

    // الاستماع لتغيير حالة العكس
    _controller.addListener(() {
      // عند منتصف الحركة - عكس الألوان
      if (_controller.value > 0.4 && !_inverted) {
        setState(() => _inverted = true);
      }
      if (_controller.value < 0.4 && _inverted) {
        setState(() => _inverted = false);
      }
    });

    // بدء الحركة والتنقل
    _controller.forward().then((_) {
      setState(() => _showSuccess = true);
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!_navigationTriggered) {
          _navigationTriggered = true;
          _navigateToNextScreen();
        }
      });
    });
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
        transitionDuration: const Duration(milliseconds": 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ColorFiltered(
          // منطق عكس الألوان برمجياً - ماتريكس احترافي
          colorFilter: _inverted 
              ? const ColorFilter.matrix([
                  -1, 0, 0, 0, 255,  // Red inverted
                  0, -1, 0, 0, 255,  // Green inverted
                  0, 0, -1, 0, 255,  // Blue inverted
                  0, 0, 0, 1, 0,     // Alpha unchanged
                ])
              : const ColorFilter.mode(Colors.transparent, BlendMode.dst),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // البوابة الذكية
              SizedBox(
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // البوابات (فكي الخزنة)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildGate(isLeft: true),
                        SizedBox(width: _gateGap.value),
                        _buildGate(isLeft: false),
                      ],
                    ),
                    
                    // الكرة المتحركة
                    Transform.translate(
                      offset: Offset(0, _ballPosition.value),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: _inverted ? AppTheme.goldPrimary : Colors.black,
                          shape: BoxShape.circle,
                          boxShadow: _inverted ? [
                            BoxShadow(
                              color: AppTheme.goldPrimary.withOpacity(0.5),
                              blurRadius: 20,
                              spreadRadius": 5,
                            ),
                          ] : null,
                        ),
                      ),
                    ),
                    
                    // إشارة النجاح (Ripple Effect)
                    if (_showSuccess)
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 3),
                        ),
                        child: const Icon(Icons.check, color: Colors.green, size: 30),
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
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                            ).createShader(bounds),
                            child: const Text(
                              'FLEX YEMEN',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                                letterSpacing: 6,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'منصة التجارة الإلكترونية اليمنية',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[400],
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w300,
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
      ),
    );
  }

  Widget _buildGate({required bool isLeft}) {
    return Container(
      width: 55,
      height: 110,
      decoration: BoxDecoration(
        color: _inverted ? Colors.black : AppTheme.goldPrimary,
        borderRadius: isLeft 
            ? const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))
            : const BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        border: Border.all(
          color: _inverted ? AppTheme.goldPrimary : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: _inverted ? [
          BoxShadow(
            color: AppTheme.goldPrimary.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius": 2,
          ),
        ] : null,
      ),
      child: Center(
        child: Container(
          width: 15,
          height: 3,
          decoration: BoxDecoration(
            color: _inverted ? AppTheme.goldPrimary : Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
