import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
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
    await Future.delayed(const Duration(milliseconds: 3000));
    if (!mounted) return;
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
            // شعار Lottie متحرك
            Lottie.asset(
              'assets/animations/loading_logo.json',
              width: 150,
              height: 150,
              repeat: true,
            ),
            const SizedBox(height: 30),

            Text(
              'FLEX YEMEN',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: isDark ? AppTheme.goldColor : AppTheme.goldDark,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 16),

            Text(
              'منصة التجارة الإلكترونية اليمنية',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 16,
                color: AppTheme.getSecondaryTextColor(context),
              ),
            ),
            const SizedBox(height: 50),

            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.goldColor),
            ),
          ],
        ),
      ),
    );
  }
}
