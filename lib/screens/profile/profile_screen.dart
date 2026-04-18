import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final bool isGuest;
  
  const ProfileScreen({super.key, this.isGuest = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.isGuest) {
      return _buildGuestView();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('حسابي'),
      ),
      body: const Center(
        child: Text('الملف الشخصي'),
      ),
    );
  }

  Widget _buildGuestView() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حسابي'),
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
                  Icons.person_outline,
                  size: 60,
                  color: AppTheme.goldPrimary,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'سجل دخول للوصول إلى حسابك',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'قم بتسجيل الدخول أو إنشاء حساب جديد للاستمتاع بجميع الميزات',
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
            ],
          ),
        ),
      ),
    );
  }
}
