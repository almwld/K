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
  bool _isFabOpen = false;

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

  final List<Map<String, dynamic>> _fabItems = [
    {'icon': Icons.campaign_outlined, 'label': 'إعلان', 'color': const Color(0xFF2196F3), 'screen': const AddAdScreen()},
    {'icon': Icons.shopping_bag_outlined, 'label': 'منتج', 'color': const Color(0xFF4CAF50), 'screen': const AddProductScreen()},
    {'icon': Icons.handyman_outlined, 'label': 'خدمة', 'color': const Color(0xFFFF9800), 'screen': const RequestServiceScreen()},
  ];

  void _toggleFab() => setState(() => _isFabOpen = !_isFabOpen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          IndexedStack(index: _currentIndex, children: _screens),
          if (_isFabOpen) GestureDetector(onTap: _toggleFab, child: Container(color: Colors.black.withOpacity(0.5))),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFF0B0E11),
          border: Border(top: BorderSide(color: const Color(0xFF2B3139).withOpacity(0.3))),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0), // الرئيسية
                _buildNavItem(1), // المتاجر
                _buildNavItem(2), // الدردشة
                const SizedBox(width: 56), // مساحة للزر الذهبي في المنتصف
                _buildNavItem(3), // المزادات
                _buildNavItem(4), // السلة
                _buildNavItem(5), // حسابي
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
        onTap: () { if (_isFabOpen) _toggleFab(); setState(() => _currentIndex = index); },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          decoration: BoxDecoration(color: isSelected ? const Color(0xFFD4AF37).withOpacity(0.1) : Colors.transparent, borderRadius: BorderRadius.circular(8)),
          child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(item['icon'] as String, width: 20, height: 20, colorFilter: ColorFilter.mode(isSelected ? const Color(0xFFD4AF37) : const Color(0xFF5E6673), BlendMode.srcIn)),
            const SizedBox(height: 2),
            Text(item['label'] as String, style: TextStyle(color: isSelected ? const Color(0xFFD4AF37) : const Color(0xFF5E6673), fontSize: 9, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
          ]),
        ),
      ),
    );
  }

  Widget _buildGoldenFAB() {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // القائمة المنبثقة
        if (_isFabOpen) ...[
          Positioned(bottom: 75, right: -5, child: _buildFabItem(_fabItems[0])),
          Positioned(bottom: 75, left: -5, child: _buildFabItem(_fabItems[1])),
          Positioned(bottom: 140, child: _buildFabItem(_fabItems[2])),
        ],
        // الزر الذهبي
        GestureDetector(
          onTap: _toggleFab,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 48, height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFAA8C2C)]),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: const Color(0xFFD4AF37).withOpacity(0.4), blurRadius: 15, spreadRadius: 2)],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _isFabOpen
                  ? const Icon(Icons.close, color: Colors.black, size: 24, key: ValueKey('close'))
                  : const Icon(Icons.add, color: Colors.black, size: 28, key: ValueKey('add')),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFabItem(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () { _toggleFab(); Navigator.push(context, MaterialPageRoute(builder: (_) => item['screen'] as Widget)); },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(20), border: Border.all(color: item['color'] as Color, width: 1.5), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8)]),
        child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(item['icon'], size: 16, color: item['color']), const SizedBox(width: 6), Text(item['label'] as String, style: TextStyle(color: item['color'] as Color, fontWeight: FontWeight.w600, fontSize: 12))]),
      ),
    );
  }
}
