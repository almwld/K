import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/theme_manager.dart';
import '../home_screen.dart';
import '../stores/stores_screen.dart';
import '../chat/chat_screen.dart';
import '../map/interactive_map_screen.dart';
import '../wallet/wallet_screen.dart';
import '../cart/cart_screen.dart';
import '../profile_screen.dart';
import '../add_ad_screen.dart';
import '../request_service_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  // الترتيب: الرئيسية(0) | المتجر(1) | الدردشة(2) | الذهبي(3) | الخريطة(4) | المحفظة(5) | حسابي(6)
  final List<Widget> _screens = const [
    HomeScreen(),
    StoresScreen(),
    ChatScreen(),
    SizedBox(),
    InteractiveMapScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];

  // بيانات الأيقونات مع مسارات SVG
  final List<Map<String, String>> _navItems = const [
    {'label': 'الرئيسية', 'icon': 'home.svg'},
    {'label': 'المتجر', 'icon': 'merchant.svg'},
    {'label': 'الدردشة', 'icon': 'chat.svg'},
    {'label': '', 'icon': ''}, // الزر الذهبي
    {'label': 'الخريطة', 'icon': 'location.svg'},
    {'label': 'المحفظة', 'icon': 'wallet.svg'},
    {'label': 'حسابي', 'icon': 'profile.svg'},
  ];

  final List<Map<String, dynamic>> _quickActions = const [
    {'icon': Icons.campaign_outlined, 'label': 'إضافة إعلان', 'color': 0xFF4CAF50, 'screen': AddAdScreen()},
    {'icon': Icons.handyman_outlined, 'label': 'طلب خدمة', 'color': 0xFFFF9800, 'screen': RequestServiceScreen()},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      _toggleExpand();
      return;
    }
    if (_isExpanded) _toggleExpand();
    setState(() => _currentIndex = index);
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _executeAction(Widget screen) {
    _toggleExpand();
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeManager = context.watch<ThemeManager>();

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: _currentIndex, children: _screens),
          
          if (_isExpanded)
            GestureDetector(
              onTap: _toggleExpand,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                color: Colors.black.withOpacity(_isExpanded ? 0.5 : 0.0),
              ),
            ),
          
          if (_isExpanded)
            Positioned(
              bottom: 90,
              left: 20,
              right: 20,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.darkSurface : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: themeManager.primaryColor.withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: 5,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'اختر الإجراء',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: _quickActions.map((action) {
                            return _buildActionButton(action, themeManager.primaryColor);
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkSurface : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, themeManager.primaryColor),
                _buildNavItem(1, themeManager.primaryColor),
                _buildNavItem(2, themeManager.primaryColor),
                _buildGoldenButton(themeManager.primaryColor),
                _buildNavItem(4, themeManager.primaryColor),
                _buildNavItem(5, themeManager.primaryColor),
                _buildNavItem(6, themeManager.primaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, Color primaryColor) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? primaryColor : Colors.grey;
    final item = _navItems[index];

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onItemTapped(index),
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            decoration: BoxDecoration(
              color: isSelected ? primaryColor.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/icons/svg/${item['icon']}',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
                const SizedBox(height: 4),
                Text(
                  item['label']!,
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoldenButton(Color primaryColor) {
    return Expanded(
      child: GestureDetector(
        onTap: _toggleExpand,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                _isExpanded ? Icons.close : Icons.add,
                key: ValueKey(_isExpanded),
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(Map<String, dynamic> action, Color primaryColor) {
    final color = Color(action['color'] as int);
    return GestureDetector(
      onTap: () => _executeAction(action['screen'] as Widget),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 110,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(action['icon'] as IconData, color: color, size: 28),
            ),
            const SizedBox(height: 10),
            Text(
              action['label'] as String,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
