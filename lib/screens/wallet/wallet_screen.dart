import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../login_screen.dart';

class WalletScreen extends StatefulWidget {
  final bool isGuest;
  
  const WalletScreen({super.key, this.isGuest = false});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    // ✅ إذا كان ضيف، نعرض شاشة تطلب تسجيل الدخول
    if (widget.isGuest) {
      return _buildGuestView();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('المحفظة'),
      ),
      body: const Center(
        child: Text('محفظتك'),
      ),
    );
  }

  Widget _buildGuestView() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('المحفظة'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppTheme.goldPrimary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 60,
                  color: AppTheme.goldPrimary,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'سجل دخول للوصول إلى محفظتك',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'قم بتسجيل الدخول أو إنشاء حساب جديد للاستمتاع بجميع ميزات المحفظة',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 14,
                  color: AppTheme.getSecondaryTextColor(context),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.goldPrimary,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  'إنشاء حساب جديد',
                  style: TextStyle(
                    fontFamily: 'Changa',
                    color: AppTheme.goldPrimary,
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
