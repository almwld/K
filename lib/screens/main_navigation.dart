import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_manager.dart';
import 'home_screen.dart';
import 'all_ads_screen.dart';
import 'wallet/wallet_screen.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';
import 'map/enhanced_map_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const AllAdsScreen(),
    const EnhancedMapScreen(),
    const WalletScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FLEX YEMEN',
          style: TextStyle(
            fontFamily: 'Changa',
            fontWeight: FontWeight.bold,
            color: AppTheme.goldColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppTheme.goldColor),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppTheme.goldColor),
            onPressed: () => Navigator.pushNamed(context, '/notifications'),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: AppTheme.goldColor),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
        selectedItemColor: AppTheme.goldColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.storefront_outlined), label: 'المتجر'),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'الخريطة'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'المحفظة'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'الدردشة'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'حسابي'),
        ],
      ),
    );
  }
}
