import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../services/cache/local_storage_service.dart';
import '../services/offline_storage_service.dart';
import '../services/supabase_service.dart';
import '../models/product_model.dart';
import 'main_navigation.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeAndNavigate();
  }

  Future<void> _initializeAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));
    
    // محاولة تحميل البيانات من Supabase
    if (await SupabaseService.checkConnection()) {
      final products = await SupabaseService.getProducts();
      if (products.isNotEmpty) {
        await OfflineStorageService.saveProducts(
          products.map((p) => ProductModel.fromJson(p)).toList()
        );
      }
    }
    
    if (!mounted) return;
    
    final isLoggedIn = LocalStorageService.isLoggedIn();
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.goldColor, AppTheme.goldLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'FLEX',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.goldColor),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('YEMEN', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 40),
              const CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
