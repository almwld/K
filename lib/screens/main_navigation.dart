import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_manager.dart';
import '../services/theme_service.dart';
import 'home_screen.dart';
import 'all_ads_screen.dart';
import 'map/interactive_map_screen.dart';
import 'wallet/wallet_screen.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  Color _themeColor = AppTheme.goldColor;
  bool _isExpanded = false;
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  final List<Widget> _screens = const [
    HomeScreen(),
    AllAdsScreen(),
    InteractiveMapScreen(),
    SizedBox(),
    WalletScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  // خيارات الزر الذهبي الدوار
  final List<Map<String, dynamic>> _quickActions = [
    {'icon': Icons.add_circle_outline, 'label': 'إضافة إعلان', 'color': 0xFF4CAF50, 'route': '/add_ad'},
    {'icon': Icons.shopping_bag_outlined, 'label': 'إضافة منتج', 'color': 0xFF2196F3, 'route': '/seller_products'},
    {'icon': Icons.handyman_outlined, 'label': 'طلب خدمة', 'color': 0xFFFF9800, 'route': null},
    {'icon': Icons.account_balance_wallet_outlined, 'label': 'استلام حوالة', 'color': 0xFF9C27B0, 'route': '/receive_transfer'},
  ];

  @override
  void initState() {
    super.initState();
    _loadThemeColor();
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  Future<void> _loadThemeColor() async {
    final color = await ThemeService.getThemeColor();
    setState(() => _themeColor = color);
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      _toggleExpand();
      return;
    }
    if (_isExpanded) _toggleExpand();
    setState(() {
      _currentIndex = index;
    });
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _rotationController.forward();
      } else {
        _rotationController.reverse();
      }
    });
  }

  void _executeAction(Map<String, dynamic> action) {
    _toggleExpand();
    if (action['route'] != null) {
      Navigator.pushNamed(context, action['route']);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('سيتم إضافة ${action['label']} قريباً')),
      );
    }
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('اختر لون التطبيق', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Changa')),
        content: SizedBox(
          width: 300,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: ThemeService.availableColors.length,
            itemBuilder: (context, index) {
              final color = ThemeService.availableColors[index];
              final isSelected = _themeColor.value == color.value;
              return GestureDetector(
                onTap: () async {
                  await ThemeService.saveThemeColor(color);
                  setState(() => _themeColor = color);
                  Navigator.pop(context);
                },
                child: Column(
                  children: [
                    Container(
                      width: 60, height: 60,
                      decoration: BoxDecoration(
                        color: color, shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 5)],
                        border: isSelected ? Border.all(color: Colors.black, width: 3) : null,
                      ),
                      child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 30) : null,
                    ),
                    const SizedBox(height: 8),
                    Text(ThemeService.colorNames[index], style: const TextStyle(fontSize: 12)),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showQuickSettings() {
    final themeManager = context.read<ThemeManager>();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, margin: const EdgeInsets.only(bottom: 20), decoration: BoxDecoration(color: AppTheme.getDividerColor(context), borderRadius: BorderRadius.circular(2))),
            const Text('الإعدادات السريعة', style: TextStyle(fontFamily: 'Changa', fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ListTile(leading: const Icon(Icons.brightness_6), title: const Text('الوضع الليلي'), trailing: Switch(value: themeManager.isDarkMode, onChanged: (v) => themeManager.toggleTheme(), activeColor: _themeColor)),
            ListTile(leading: const Icon(Icons.language), title: const Text('اللغة'), trailing: const Text('العربية'), onTap: () {}),
            ListTile(leading: const Icon(Icons.notifications), title: const Text('الإشعارات'), trailing: Switch(value: true, onChanged: (v) {}, activeColor: _themeColor)),
            const Divider(),
            ListTile(leading: const Icon(Icons.settings), title: const Text('جميع الإعدادات'), trailing: const Icon(Icons.arrow_forward_ios, size: 16), onTap: () { Navigator.pop(context); Navigator.pushNamed(context, '/settings'); }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('FLEX YEMEN', style: TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold, color: AppTheme.goldColor)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
        actions: [
          IconButton(icon: const Icon(Icons.palette), onPressed: _showColorPicker, tooltip: 'تغيير الثيم'),
          IconButton(icon: const Icon(Icons.settings), onPressed: _showQuickSettings, tooltip: 'الإعدادات السريعة'),
          IconButton(icon: const Icon(Icons.shopping_cart_outlined), onPressed: () => Navigator.pushNamed(context, '/cart'), tooltip: 'السلة'),
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () => Navigator.pushNamed(context, '/notifications'), tooltip: 'الإشعارات'),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem('assets/icons/svg/home.svg', 'الرئيسية', 0),
                _buildNavItem('assets/icons/svg/merchant.svg', 'المتجر', 1),
                _buildNavItem('assets/icons/svg/location.svg', 'الخريطة', 2),
                _buildGoldenButton(),
                _buildNavItem('assets/icons/svg/wallet.svg', 'المحفظة', 4),
                _buildNavItem('assets/icons/svg/chat.svg', 'الدردشة', 5),
                _buildNavItem('assets/icons/svg/profile.svg', 'حسابي', 6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // الزر الذهبي الدوار مع الخيارات
  Widget _buildGoldenButton() {
    return Expanded(
      child: GestureDetector(
        onTap: _toggleExpand,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // الخيارات الأربعة (تظهر عند الضغط)
            if (_isExpanded)
              Positioned(
                bottom: 70,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.getCardColor(context).withOpacity(0.95),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.goldColor.withOpacity(0.5), width: 1),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _quickActions.asMap().entries.map((entry) {
                      final index = entry.key;
                      final action = entry.value;
                      return _buildQuickActionItem(action, index);
                    }).toList(),
                  ),
                ),
              ),

            // الزر الذهبي الدوار
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value * 3.14159 * 2,
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [_themeColor, _themeColor.withOpacity(0.7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [BoxShadow(color: _themeColor.withOpacity(0.5), blurRadius: 20, spreadRadius: 5)],
                    ),
                    child: Icon(_isExpanded ? Icons.close : Icons.add, color: Colors.white, size: 32),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionItem(Map<String, dynamic> action, int index) {
    final color = Color(action['color'] as int);
    return GestureDetector(
      onTap: () => _executeAction(action),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.2),
                border: Border.all(color: color, width: 2),
              ),
              child: Icon(action['icon'] as IconData, color: color, size: 22),
            ),
            const SizedBox(height: 4),
            Text(action['label'], style: TextStyle(color: AppTheme.getTextColor(context).withOpacity(0.8), fontSize: 10)),
          ],
        ),
      ).animate().fadeIn(delay: Duration(milliseconds: 50 * index), duration: 300.ms).scale(begin: const Offset(0, 0.5), end: const Offset(1, 1), curve: Curves.elasticOut),
    );
  }

  Widget _buildNavItem(String svgPath, String label, int index) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? _themeColor : (Theme.of(context).brightness == Brightness.dark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary);

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onItemTapped(index),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(svgPath, colorFilter: ColorFilter.mode(color, BlendMode.srcIn), width: 24, height: 24),
                const SizedBox(height: 4),
                Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
