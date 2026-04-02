import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../services/cache/local_storage_service.dart';

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
    // الانتظار 2 ثانية فقط للعرض - بدون انتظار Supabase
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // التحقق من حالة تسجيل الدخول من التخزين المحلي
    final isLoggedIn = LocalStorageService.isLoggedIn();

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
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
            // Logo
            Container(
              width: 150,
              height: 150,
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
                size: 80,
                color: Colors.black,
              ),
            )
                .animate()
                .scale(duration: 800.ms, curve: Curves.easeOutBack)
                .fadeIn(duration: 600.ms),

            const SizedBox(height: 40),

            // App Name
            Text(
              'FLEX YEMEN',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: isDark ? AppTheme.goldColor : AppTheme.goldDark,
                letterSpacing: 2,
              ),
            )
                .animate()
                .fadeIn(delay: 400.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0, delay: 400.ms, duration: 600.ms),

            const SizedBox(height: 16),

            // Tagline
            Text(
              'منصة التجارة الإلكترونية اليمنية',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 16,
                color: AppTheme.getSecondaryTextColor(context),
              ),
            )
                .animate()
                .fadeIn(delay: 600.ms, duration: 600.ms),

            const SizedBox(height: 60),

            // Loading Indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(AppTheme.goldColor),
            )
                .animate()
                .fadeIn(delay: 800.ms, duration: 400.ms),
          ],
        ),
      ),
    );
  }
}

import '../services/offline_storage_service.dart';
import '../services/supabase_service.dart';

// إضافة دالة لتحميل البيانات
Future<void> _loadInitialData() async {
  // محاولة جلب البيانات من Supabase
  if (await SupabaseService.checkConnection()) {
    final products = await SupabaseService.getProducts();
    if (products.isNotEmpty) {
      await OfflineStorageService.saveProducts(
        products.map((p) => ProductModel.fromJson(p)).toList()
      );
    }
  }
}
