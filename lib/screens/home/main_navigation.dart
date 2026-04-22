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
import '../add_ad_screen.dart';
import '../add_product_screen.dart';
import '../request_service_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  bool _isFabMenuOpen = false;

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

  final List<Map<String, dynamic>> _fabMenuItems = [
    {'icon': Icons.campaign_outlined, 'label': 'إضافة إعلان', 'screen': const AddAdScreen()},
    {'icon': Icons.shopping_bag_outlined, 'label': 'إضافة منتج', 'screen': const AddProductScreen()},
    {'icon': Icons.handyman_outlined, 'label': 'طلب خدمة', 'screen': const RequestServiceScreen()},
  ];

  void _toggleFabMenu() => setState(() => _isFabMenuOpen = !_isFabMenuOpen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          IndexedStack(index: _currentIndex, children: _screens),
          if (_isFabMenuOpen) GestureDetector(onTap: _toggleFabMenu, child: Container(color: Colors.black.withOpacity(0.5))),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: const Color(0xFF0B0E11), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, -5))]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0), _buildNavItem(1), _buildNavItem(2),
                const SizedBox(width: 60),
                _buildNavItem(3), _buildNavItem(4), _buildNavItem(5),
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
    final item = _navItems[index];
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (_isFabMenuOpen) _toggleFabMenu();
          setState(() => _currentIndex = index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(color: isSelected ? const Color(0xFFD4AF37).withOpacity(0.1) : Colors.transparent, borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(item['icon'] as String, width: 24, height: 24, colorFilter: ColorFilter.mode(isSelected ? const Color(0xFFD4AF37) : const Color(0xFF5E6673), BlendMode.srcIn)),
              const SizedBox(height: 4),
              Text(item['label'] as String, style: TextStyle(color: isSelected ? const Color(0xFFD4AF37) : const Color(0xFF5E6673), fontSize: 11, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoldenFAB() {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        if (_isFabMenuOpen) ...[
          Positioned(bottom: 80, right: -10, child: _buildFabMenuItem(_fabMenuItems[0])),
          Positioned(bottom: 80, left: -10, child: _buildFabMenuItem(_fabMenuItems[1])),
          Positioned(bottom: 150, child: _buildFabMenuItem(_fabMenuItems[2])),
        ],
        GestureDetector(
          onTap: _toggleFabMenu,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 56, height: 56,
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFAA8C2C)]), shape: BoxShape.circle, boxShadow: [BoxShadow(color: const Color(0xFFD4AF37).withOpacity(0.4), blurRadius: 20, spreadRadius: 3)]),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _isFabMenuOpen
                  ? const Icon(Icons.close, color: Colors.black, size: 28, key: ValueKey('close'))
                  : SvgPicture.asset('assets/icons/svg/add.svg', width: 28, height: 28, colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn), key: const ValueKey('add')),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFabMenuItem(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        _toggleFabMenu();
        Navigator.push(context, MaterialPageRoute(builder: (_) => item['screen'] as Widget));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(25), border: Border.all(color: item['color'] ?? const Color(0xFFD4AF37), width: 1.5), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10)]),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item['icon'], color: item['color'], size: 18),
            const SizedBox(width: 6),
            Text(item['label'], style: TextStyle(color: item['color'], fontWeight: FontWeight.w600, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
