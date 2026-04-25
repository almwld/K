import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../cart/cart_screen.dart';
import '../stores/stores_screen.dart';
import '../profile/profile_screen.dart';
import '../auctions/auctions_screen.dart';
import 'home_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    StoresScreen(),
    AuctionsScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  final List<String> _titles = ['الرئيسية', 'المتاجر', 'المزادات', 'السلة', 'حسابي'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.binanceDark,
          border: Border(top: BorderSide(color: AppTheme.binanceBorder)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppTheme.binanceDark,
          selectedItemColor: AppTheme.binanceGold,
          unselectedItemColor: const Color(0xFF5E6673),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'الرئيسية'),
            BottomNavigationBarItem(icon: Icon(Icons.store_outlined), label: 'المتاجر'),
            BottomNavigationBarItem(icon: Icon(Icons.gavel_outlined), label: 'المزادات'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'السلة'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'حسابي'),
          ],
        ),
      ),
    );
  }
}
