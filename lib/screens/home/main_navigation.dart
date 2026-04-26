import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';
import '../stores/stores_screen.dart';
import '../auctions/auctions_screen.dart';
import '../cart/cart_screen.dart';
import '../profile/profile_screen.dart';
import '../nearby_screen.dart';
import '../../widgets/golden_floating_button.dart';
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
    NearbyScreen(),
    AuctionsScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButton: const GoldenFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/svg/home.svg', width: 24, height: 24, colorFilter: const ColorFilter.mode(AppTheme.binanceGold, BlendMode.srcIn)),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/svg/store.svg', width: 24, height: 24, colorFilter: const ColorFilter.mode(AppTheme.binanceGold, BlendMode.srcIn)),
              label: 'متاجر',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/svg/location.svg', width: 24, height: 24, colorFilter: const ColorFilter.mode(AppTheme.binanceGold, BlendMode.srcIn)),
              label: 'بالجوار',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/svg/auction.svg', width: 24, height: 24, colorFilter: const ColorFilter.mode(AppTheme.binanceGold, BlendMode.srcIn)),
              label: 'مزادات',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/svg/cart.svg', width: 24, height: 24, colorFilter: const ColorFilter.mode(AppTheme.binanceGold, BlendMode.srcIn)),
              label: 'سلة',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/svg/profile.svg', width: 24, height: 24, colorFilter: const ColorFilter.mode(AppTheme.binanceGold, BlendMode.srcIn)),
              label: 'حسابي',
            ),
          ],
        ),
      ),
    );
  }
}
