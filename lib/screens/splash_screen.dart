import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import 'main_navigation.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;
  String _loadingMessage = 'جاري التحميل...';
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  Future<void> _startLoading() async {
    // محاكاة تحميل البيانات
    final messages = [
      'جاري تجهيز المتجر...',
      'تحميل المنتجات...',
      'تهيئة حسابك...',
      'مرحباً بك في فلكس اليمن!',
    ];
    
    for (int i = 0; i < messages.length; i++) {
      await Future.delayed(const Duration(milliseconds: 800));
      if (mounted) {
        setState(() {
          _loadingMessage = messages[i];
          _progress = (i + 1) / messages.length;
        });
      }
    }
    
    // انتظار ثانيتين إضافيتين (إجمالي ~10 ثوانٍ)
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() => _isLoading = false);
      _navigateToNext();
    }
  }

  Future<void> _navigateToNext() async {
    final authService = context.read<AuthService>();
    final isLoggedIn = authService.isLoggedIn;
    
    // انتظار ثانية إضافية للانتقال السلس
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (!mounted) return;
    
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/main');
    } else {
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
            // شعار متحرك
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
              child: const Icon(
                Icons.shopping_bag,
                size: 60,
                color: Colors.black,
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

            // شريط التقدم
            if (_isLoading) ...[
              Container(
                width: 200,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: Colors.transparent,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.goldColor),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _loadingMessage,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.getSecondaryTextColor(context),
                ),
              ),
            ],

            const SizedBox(height: 40),

            // نص حقوق النشر
            Text(
              '© 2024 Flex Yemen. All rights reserved.',
              style: TextStyle(
                fontSize: 10,
                color: AppTheme.getSecondaryTextColor(context).withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
