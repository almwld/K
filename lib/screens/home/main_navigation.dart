import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';
import 'home_screen.dart';
import '../all_ads_screen.dart';
import '../wallet/wallet_screen.dart';
import '../chat/chat_screen.dart';
import '../profile/profile_screen.dart';
import '../cart/cart_screen.dart';
import '../map/interactive_map_screen.dart';
import '../add_ad_screen.dart';
import '../request_service_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isMenuOpen = false;
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  final List<Widget> _screens = const [
    HomeScreen(),
    AllAdsScreen(),
    InteractiveMapScreen(),
    WalletScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  static const List<String> _icons = [
    'assets/icons/svg/home.svg',
    'assets/icons/svg/shop.svg',
    'assets/icons/svg/location.svg',
    'assets/icons/svg/wallet.svg',
    'assets/icons/svg/chat.svg',
    'assets/icons/svg/profile.svg',
  ];

  static const List<String> _labels = [
    'الرئيسية',
    'المتاجر',
    'الخريطة',
    'المحفظة',
    'الدردشة',
    'حسابي',
  ];

  // ✅ أزرار الخدمات الجانبية (دائرية)
  final List<Map<String, dynamic>> _quickActions = [
    {'icon': Icons.add_circle_outline, 'label': 'إعلان', 'color': AppTheme.serviceBlue, 'route': AddAdScreen},
    {'icon': Icons.shopping_bag_outlined, 'label': 'منتج', 'color': AppTheme.serviceOrange, 'route': AddAdScreen},
    {'icon': Icons.handyman_outlined, 'label': 'خدمة', 'color': AppTheme.serviceGreen, 'route': RequestServiceScreen},
    {'icon': Icons.account_balance_wallet_outlined, 'label': 'حوالة', 'color': Colors.purple, 'route': AddAdScreen},
  ];

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0.125).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_isMenuOpen) _toggleMenu();
    setState(() {
      _currentIndex = index;
    });
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _rotationController.forward();
      } else {
        _rotationController.reverse();
      }
    });
  }

  void _executeAction(Map<String, dynamic> action) {
    _toggleMenu();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => action['route']()),
    );
  }

  PreferredSizeWidget _buildAppBar(bool isDark) {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: AppTheme.goldGradient,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'FLX',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'FLEX YEMEN',
            style: TextStyle(
              fontFamily: 'Changa',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: isDark ? AppTheme.nightSurface : AppTheme.lightSurface,
      elevation: 0,
      actions: [
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined, color: AppTheme.gold),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                );
              },
              tooltip: 'السلة',
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: const Text(
                  '0',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: AppTheme.gold),
          onPressed: () {},
          tooltip: 'الإشعارات',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: _buildAppBar(isDark),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNavBar(isDark),
      floatingActionButton: _buildGoldenFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNavBar(bool isDark) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.nightSurface : AppTheme.lightSurface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0),
              _buildNavItem(1),
              _buildNavItem(2),
              const SizedBox(width: 70),
              _buildNavItem(3),
              _buildNavItem(4),
              _buildNavItem(5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final isSelected = _currentIndex == index;
    final iconPath = _icons[index];
    final label = _labels[index];

    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.gold.withOpacity(0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: SvgPicture.asset(
                  iconPath,
                  key: ValueKey(isSelected),
                  width: 22,
                  height: 22,
                  colorFilter: ColorFilter.mode(
                    isSelected ? AppTheme.gold : AppTheme.getSecondaryTextColor(context),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 10,
                  color: isSelected ? AppTheme.gold : AppTheme.getSecondaryTextColor(context),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                child: Text(label, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
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
        // ✅ القائمة الجانبية الدائرية
        if (_isMenuOpen) ...[
          // أعلى اليمين
          Positioned(
            bottom: 70,
            right: -30,
            child: _buildCircularMenuItem(_quickActions[0], 0),
          ),
          // أعلى اليسار
          Positioned(
            bottom: 70,
            left: -30,
            child: _buildCircularMenuItem(_quickActions[1], 1),
          ),
          // أسفل اليمين
          Positioned(
            top: 70,
            right: -30,
            child: _buildCircularMenuItem(_quickActions[2], 2),
          ),
          // أسفل اليسار
          Positioned(
            top: 70,
            left: -30,
            child: _buildCircularMenuItem(_quickActions[3], 3),
          ),
        ],

        // خلفية شفافة للإغلاق
        if (_isMenuOpen)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleMenu,
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),

        // الزر الذهبي الرئيسي
        AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value * 3.14159 * 2,
              child: GestureDetector(
                onTap: _toggleMenu,
                child: Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    gradient: AppTheme.goldGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.gold.withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: _isMenuOpen
                        ? const Icon(Icons.close, color: Colors.black, size: 32, key: ValueKey('close'))
                        : const Icon(Icons.add, color: Colors.black, size: 32, key: ValueKey('add')),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // ✅ أيقونة دائرية للخدمات الجانبية
  Widget _buildCircularMenuItem(Map<String, dynamic> action, int index) {
    final color = action['color'] as Color;
    final icon = action['icon'] as IconData;
    final label = action['label'] as String;

    return GestureDetector(
      onTap: () => _executeAction(action),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300 + (index * 50)),
        curve: Curves.elasticOut,
        transform: Matrix4.identity()..scale(_isMenuOpen ? 1.0 : 0.0),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.nightCard
                : AppTheme.lightCard,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: color.withOpacity(0.5),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
