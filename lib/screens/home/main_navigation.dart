import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_drawer.dart';
import 'home_screen.dart';
import '../stores/stores_screen.dart';
import '../chat/chat_screen.dart';
import '../auctions/auctions_screen.dart';
import '../cart/cart_screen.dart';
import '../profile/profile_screen.dart';

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
    ChatScreen(),
    AuctionsScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  final List<Map<String, dynamic>> _navItems = [
    {'icon': 'assets/icons/svg/home.svg', 'label': 'الرئيسية'},
    {'icon': 'assets/icons/svg/store.svg', 'label': 'المتاجر'},
    {'icon': 'assets/icons/svg/chat.svg', 'label': 'الدردشة'},
    {'icon': 'assets/icons/svg/auction.svg', 'label': 'المزادات'},
    {'icon': 'assets/icons/svg/cart.svg', 'label': 'السلة'},
    {'icon': 'assets/icons/svg/profile.svg', 'label': 'حسابي'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      drawer: const AppDrawer(),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        height: 60, // 👈 نفس ارتفاع AppBar تقريباً
        decoration: BoxDecoration(
          color: const Color(0xFF0B0E11),
          border: Border(top: BorderSide(color: const Color(0xFF2B3139).withOpacity(0.3))),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), // 👈 padding أقل
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_navItems.length, (index) => _buildNavItem(index)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final isSelected = _currentIndex == index;
    final item = _navItems[index];
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentIndex = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2), // 👈 padding أصغر
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFD4AF37).withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                item['icon'] as String,
                width: 20, // 👈 أيقونة أصغر
                height: 20,
                colorFilter: ColorFilter.mode(
                  isSelected ? const Color(0xFFD4AF37) : const Color(0xFF5E6673),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 2), // 👈 مسافة أقل
              Text(
                item['label'] as String,
                style: TextStyle(
                  color: isSelected ? const Color(0xFFD4AF37) : const Color(0xFF5E6673),
                  fontSize: 9, // 👈 خط أصغر
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
