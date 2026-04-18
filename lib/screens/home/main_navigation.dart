import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../theme/app_theme.dart';
import 'home_screen.dart';
import '../all_ads_screen.dart';
import '../wallet/wallet_screen.dart';
import '../chat/chat_screen.dart';
import '../profile/profile_screen.dart';
import '../login_screen.dart';

/// الشريط السفلي الرئيسي للتنقل
class MainNavigation extends StatefulWidget {
  final bool isGuest;
  
  const MainNavigation({super.key, this.isGuest = false});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),
      const AllAdsScreen(),
      const Placeholder(), // مكان للزر العائم
      WalletScreen(isGuest: widget.isGuest),
      ChatScreen(isGuest: widget.isGuest),
      ProfileScreen(isGuest: widget.isGuest),
    ];
  }

  void _onItemTapped(int index) {
    // الزر العائم - إضافة إعلان
    if (index == 2) {
      _handleAddAdAction();
      return;
    }
    
    setState(() {
      _currentIndex = index;
    });
  }

  void _handleAddAdAction() {
    // ✅ إذا كان ضيف، نطلب تسجيل الدخول
    if (widget.isGuest) {
      _showLoginRequiredDialog();
      return;
    }
    
    // إذا كان مسجل دخول، ننتقل لصفحة إضافة إعلان
    Navigator.pushNamed(context, '/add_ad');
  }

  void _handleWalletAction() {
    // ✅ إذا كان ضيف، نطلب تسجيل الدخول
    if (widget.isGuest) {
      _showLoginRequiredDialog();
      return;
    }
    
    setState(() {
      _currentIndex = 1; // المحفظة هي الفهرس 1 بعد إزالة الزر العائم
    });
  }

  void _handleChatAction() {
    // ✅ إذا كان ضيف، نطلب تسجيل الدخول
    if (widget.isGuest) {
      _showLoginRequiredDialog();
      return;
    }
    
    setState(() {
      _currentIndex = 2; // الدردشة هي الفهرس 2
    });
  }

  void _showLoginRequiredDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(Icons.lock_outline, color: AppTheme.goldPrimary),
            SizedBox(width: 12),
            Text(
              'تسجيل الدخول مطلوب',
              style: TextStyle(
                fontFamily: 'Changa',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: const Text(
          'هذه الميزة تتطلب تسجيل الدخول.\nهل تريد تسجيل الدخول أو إنشاء حساب جديد؟',
          style: TextStyle(fontFamily: 'Changa'),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'لاحقاً',
              style: TextStyle(fontFamily: 'Changa'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // الانتقال لصفحة تسجيل الدخول
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.goldPrimary,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'تسجيل الدخول',
              style: TextStyle(
                fontFamily: 'Changa',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const HomeScreen(),
          const AllAdsScreen(),
          WalletScreen(isGuest: widget.isGuest),
          ChatScreen(isGuest: widget.isGuest),
          ProfileScreen(isGuest: widget.isGuest),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_outlined, 'الرئيسية'),
                _buildNavItem(1, Icons.storefront_outlined, 'المتجر'),
                _buildAddButton(),
                _buildNavItem(2, Icons.account_balance_wallet_outlined, 'المحفظة'),
                _buildNavItem(3, Icons.chat_bubble_outline, 'الدردشة'),
                _buildNavItem(4, Icons.person_outline, 'حسابي'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.goldPrimary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.goldPrimary : AppTheme.getSecondaryTextColor(context),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 11,
                color: isSelected ? AppTheme.goldPrimary : AppTheme.getSecondaryTextColor(context),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: () => _onItemTapped(2),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: AppTheme.goldGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppTheme.goldPrimary.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.add,
          color: AppTheme.darkText,
          size: 32,
        ),
      ),
    );
  }
}
