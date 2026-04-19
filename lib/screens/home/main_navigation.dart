import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';
import 'home_screen.dart';
import '../all_ads_screen.dart';
import '../wallet/wallet_screen.dart';
import '../chat/chat_screen.dart';
import '../profile/profile_screen.dart';
import '../cart/cart_screen.dart';
import '../add_ad_screen.dart';
import '../request_service_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  bool _isMenuOpen = false;

  final List<Widget> _screens = [
    const HomeScreen(),
    const AllAdsScreen(),
    const CartScreen(),
    const WalletScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  static const List<String> _icons = [
    'assets/icons/svg/home.svg',
    'assets/icons/svg/shop.svg',
    'assets/icons/svg/cart.svg',
    'assets/icons/svg/wallet.svg',
    'assets/icons/svg/chat.svg',
    'assets/icons/svg/profile.svg',
  ];

  static const List<String> _labels = [
    'الرئيسية',
    'المتجر',
    'السلة',
    'المحفظة',
    'الدردشة',
    'حسابي',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.nightSurface : AppTheme.lightSurface,
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
                _buildNavItem(0),
                _buildNavItem(1),
                const SizedBox(width: 70),
                _buildNavItem(2),
                _buildNavItem(3),
                _buildNavItem(4),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildGoldenFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem(int index) {
    final isSelected = _currentIndex == index;
    final iconPath = _icons[index];
    final label = _labels[index];
    
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.gold.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isSelected ? AppTheme.gold : AppTheme.getSecondaryTextColor(context),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 11,
                color: isSelected ? AppTheme.gold : AppTheme.getSecondaryTextColor(context),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoldenFAB() {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedRotation(
          duration: const Duration(milliseconds: 300),
          turns: _isMenuOpen ? 0.125 : 0,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isMenuOpen = !_isMenuOpen;
              });
            },
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                gradient: AppTheme.goldGradient,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.gold.withOpacity(0.5),
                    blurRadius: 25,
                    spreadRadius: 3,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _isMenuOpen
                    ? const Icon(Icons.close, color: Colors.black, size: 35, key: ValueKey('close'))
                    : const Icon(Icons.add, color: Colors.black, size: 35, key: ValueKey('add')),
              ),
            ),
          ),
        ),
        
        if (_isMenuOpen) ...[
          Positioned(
            bottom: 85,
            child: _buildMenuItem(
              icon: Icons.campaign,
              label: 'إضافة إعلان',
              color: Colors.blue,
              onTap: () {
                setState(() => _isMenuOpen = false);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddAdScreen()),
                );
              },
            ),
          ),
          
          Positioned(
            top: 85,
            child: _buildMenuItem(
              icon: Icons.handyman,
              label: 'طلب خدمة',
              color: Colors.green,
              onTap: () {
                setState(() => _isMenuOpen = false);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RequestServiceScreen()),
                );
              },
            ),
          ),
          
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() => _isMenuOpen = false);
              },
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.nightCard
              : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Changa',
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
