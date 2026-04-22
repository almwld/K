import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import '../theme/app_theme.dart';
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
    
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    
    _fadeController.forward();
    
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
      backgroundColor: const Color(0xFF0F172A), // كحلي داكن
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // الشعار الذهبي الشفاف
              SvgPicture.asset(
                'assets/icons/svg/logo_clear.svg',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 40),
              // نص FLEX YEMEN
              const Text(
                'FLEX',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 48,
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
                  fontSize: 32,
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
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
