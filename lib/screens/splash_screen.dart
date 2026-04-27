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
  late AnimationController _logoController;
  late Animation<double> _logoScale;
  late Animation<double> _logoFade;
  late AnimationController _textController;
  late Animation<double> _textSlide;
  
  @override
  void initState() {
    super.initState();

    // تأثير تكبير الشعار
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );

    // تأثير انزلاق النص
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _textSlide = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );

    _logoController.forward();
    _textController.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      body: Stack(
        children: [
          // خلفية متدرجة
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.binanceDark,
                  AppTheme.binanceCard,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // تأثير نبضات ذهبية في الخلفية
          ...List.generate(3, (index) {
            return Positioned(
              top: MediaQuery.of(context).size.height * (0.2 + index * 0.3),
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(seconds: 2 + index),
                builder: (context, value, child) {
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.binanceGold.withOpacity(0.05 * value),
                          blurRadius: 100,
                          spreadRadius: 50,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // الشعار بتأثير تكبير
                AnimatedBuilder(
                  animation: _logoController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _logoScale.value,
                      child: Opacity(
                        opacity: _logoFade.value,
                        child: SvgPicture.asset(
                          'assets/icons/svg/logo_clear.svg',
                          width: 180,
                          height: 180,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                // نص FLEX YEMEN بتأثير انزلاق
                AnimatedBuilder(
                  animation: _textController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _textSlide.value),
                      child: Column(
                        children: [
                          ShaderMask(
                            shaderCallback: (rect) => const LinearGradient(
                              colors: [AppTheme.binanceGold, AppTheme.goldLight],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(rect),
                            child: const Text(
                              'FLEX',
                              style: TextStyle(
                                fontFamily: 'Changa',
                                fontSize: 52,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 6,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'YEMEN',
                            style: TextStyle(
                              fontFamily: 'Changa',
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.binanceGold.withOpacity(0.9),
                              letterSpacing: 8,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                // شارة التحميل
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(seconds: 2),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          gradient: AppTheme.goldGradient,
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.binanceGold.withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Text(
                          'Flex Yemen',
                          style: TextStyle(
                            fontFamily: 'Changa',
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
                // شريط التحميل
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(seconds: 3),
                  builder: (context, value, child) {
                    return SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        value: value,
                        backgroundColor: AppTheme.binanceBorder,
                        color: AppTheme.binanceGold,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
