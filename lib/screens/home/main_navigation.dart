import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/theme_manager.dart';
import '../home_screen.dart';
import '../stores/stores_screen.dart';
import '../chat/chat_screen.dart';
import '../map/interactive_map_screen.dart';
import '../wallet/wallet_screen.dart';
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
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  // الترتيب: الرئيسية(0) | المتجر(1) | الدردشة(2) | الذهبي(3) | الخريطة(4) | المحفظة(5) | حسابي(6)
  final List<Widget> _screens = const [
    HomeScreen(),           // 0 - الرئيسية
    StoresScreen(),         // 1 - المتجر (تم ربطه بصفحة المتاجر)
    ChatScreen(),           // 2 - الدردشة
    SizedBox(),             // 3 - الزر الذهبي
    InteractiveMapScreen(), // 4 - الخريطة
    WalletScreen(),         // 5 - المحفظة
    ProfileScreen(),        // 6 - حسابي
  ];

  final List<Map<String, dynamic>> _quickActions = const [
    {'icon': Icons.campaign_outlined, 'label': 'إضافة إعلان', 'color': 0xFF4CAF50, 'screen': AddAdScreen()},
    {'icon': Icons.handyman_outlined, 'label': 'طلب خدمة', 'color': 0xFFFF9800, 'screen': RequestServiceScreen()},
  ];

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _rotationAnimation = Tween<double>(begin: 0, end: 0.125).animate(CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _rotationController.dispose();
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
      _isExpanded ? _rotationController.forward() : _rotationController.reverse();
    });
  }

  void _executeAction(Map<String, dynamic> action) {
    _toggleExpand();
    Navigator.push(context, MaterialPageRoute(builder: (_) => action['screen'] as Widget));
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
            Positioned.fill(
              child: GestureDetector(
                onTap: _toggleExpand,
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('اختر الإجراء', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: _quickActions.map((action) => _buildActionButton(action, themeManager.primaryColor)).toList(),
                          ),
                        ],
                      ),
                    ),
                  ).animate().scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1), duration: 200.ms, curve: Curves.elasticOut),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(isDark, themeManager.primaryColor),
    );
  }

  Widget _buildBottomNavBar(bool isDark, Color primaryColor) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -2))],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_outlined, Icons.home, 'الرئيسية', 0, primaryColor),
              _buildNavItem(Icons.store_outlined, Icons.store, 'المتجر', 1, primaryColor),
              _buildNavItem(Icons.chat_bubble_outline, Icons.chat_bubble, 'الدردشة', 2, primaryColor),
              _buildGoldenButton(primaryColor),
              _buildNavItem(Icons.map_outlined, Icons.map, 'الخريطة', 4, primaryColor),
              _buildNavItem(Icons.account_balance_wallet_outlined, Icons.account_balance_wallet, 'المحفظة', 5, primaryColor),
              _buildNavItem(Icons.person_outline, Icons.person, 'حسابي', 6, primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, IconData activeIcon, String label, int index, Color primaryColor) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? primaryColor : Colors.grey;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onItemTapped(index),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(isSelected ? activeIcon : icon, color: color, size: 24),
                const SizedBox(height: 2),
                Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
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
          margin: const EdgeInsets.only(bottom: 15),
          child: AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value * 3.14159 * 2,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [primaryColor, primaryColor.withOpacity(0.7)]),
                    boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.4), blurRadius: 15, spreadRadius: 2)],
                  ),
                  child: Icon(_isExpanded ? Icons.close : Icons.add, color: Colors.white, size: 30),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(Map<String, dynamic> action, Color primaryColor) {
    final color = Color(action['color'] as int);
    return GestureDetector(
      onTap: () => _executeAction(action),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(16), border: Border.all(color: color, width: 1.5)),
        child: Column(
          children: [
            Icon(action['icon'] as IconData, color: color, size: 40),
            const SizedBox(height: 8),
            Text(action['label'] as String, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
