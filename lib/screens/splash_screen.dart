import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import '../theme/app_theme.dart';
import 'home/main_navigation.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // تحكم في التلاشي فقط (بدون حركة)
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    
    _fadeController.forward();
    
    // الانتقال للشاشة التالية بعد 3 ثواني
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // كحلي داكن فاخر
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: [
              const Color(0xFF1A2A44),
              const Color(0xFF0F172A),
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // الشعار الذهبي - أكبر حجماً وبدون ظل وبدون حركة
                Container(
                  width: 220,  // تكبير الحجم من 180 إلى 220
                  height: 220, // تكبير الحجم من 180 إلى 220
                  child: SvgPicture.asset(
                    'assets/icons/svg/logo_static.svg',
                    width: 220,
                    height: 220,
                    fit: BoxFit.contain,
                    // إيقاف الحركة - نستخدم نسخة ثابتة أو نتجاهل animation
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // نص FLEX YEMEN
                Column(
                  children: [
                    const Text(
                      'FLEX',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 52,  // تكبير الخط
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD4AF37),
                        letterSpacing: 6,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'YEMEN',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 36,  // تكبير الخط
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFD4AF37).withOpacity(0.9),
                        letterSpacing: 8,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFD4AF37), Color(0xFFAA8C2C)],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        'منصة التجارة الإلكترونية اليمنية',
                        style: TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 60),
                
                // شريط تحميل ذهبي
                Container(
                  width: 250,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: LinearProgressIndicator(
                    backgroundColor: const Color(0xFFD4AF37).withOpacity(0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD4AF37)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
