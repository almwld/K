import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_drawer.dart';
import 'home_screen.dart';
import '../stores/stores_screen.dart';
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
  bool _isFabMenuOpen = false;

  final List<Widget> _screens = [
    const HomeScreen(),
    const StoresScreen(),
    const CartScreen(),
    const AuctionsScreen(),
    const ProfileScreen(),
  ];

  final List<Map<String, dynamic>> _fabMenuItems = [
    {'icon': Icons.add_circle_outline, 'label': 'إضافة إعلان', 'color': const Color(0xFF2196F3)},
    {'icon': Icons.shopping_bag_outlined, 'label': 'إضافة منتج', 'color': const Color(0xFF4CAF50)},
    {'icon': Icons.handyman_outlined, 'label': 'طلب خدمة', 'color': const Color(0xFFFF9800)},
  ];

  void _toggleFabMenu() {
    setState(() {
      _isFabMenuOpen = !_isFabMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
          if (_isFabMenuOpen)
            GestureDetector(
              onTap: _toggleFabMenu,
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0B0E11),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
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
                _buildNavItem(1, Icons.store_outlined, 'المتاجر'),
                const SizedBox(width: 70),
                _buildNavItem(2, Icons.shopping_cart_outlined, 'السلة'),
                _buildNavItem(3, Icons.gavel_outlined, 'المزادات'),
                _buildNavItem(4, Icons.person_outline, 'حسابي'),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildGoldenFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (_isFabMenuOpen) _toggleFabMenu();
          setState(() => _currentIndex = index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFD4AF37).withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? const Color(0xFFD4AF37) : const Color(0xFF5E6673),
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? const Color(0xFFD4AF37) : const Color(0xFF5E6673),
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
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
          Positioned(
            bottom: 80,
            right: -20,
            child: _buildFabMenuItem(_fabMenuItems[0]),
          ),
          Positioned(
            bottom: 80,
            left: -20,
            child: _buildFabMenuItem(_fabMenuItems[1]),
          ),
          Positioned(
            bottom: 150,
            child: _buildFabMenuItem(_fabMenuItems[2]),
          ),
        ],
        GestureDetector(
          onTap: _toggleFabMenu,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFD4AF37), Color(0xFFAA8C2C)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD4AF37).withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _isFabMenuOpen
                  ? const Icon(Icons.close, color: Colors.black, size: 30, key: ValueKey('close'))
                  : const Icon(Icons.add, color: Colors.black, size: 30, key: ValueKey('add')),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('جاري ${item['label']}...'),
            backgroundColor: item['color'],
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2329),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: item['color'], width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item['icon'], color: item['color'], size: 20),
            const SizedBox(width: 8),
            Text(
              item['label'],
              style: TextStyle(color: item['color'], fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
