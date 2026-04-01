import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_manager.dart';
import 'home_screen.dart';
import 'all_ads_screen.dart';
import 'map/interactive_map_screen.dart';
import 'wallet/wallet_screen.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';
import 'add_ad_screen.dart';
import 'notifications_screen.dart';
import 'cart_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _appBarAnimation;
  late Animation<double> _bottomBarAnimation;
  
  double _lastScrollOffset = 0;
  bool _isAppBarVisible = true;
  bool _isBottomBarVisible = true;
  
  final ScrollController _scrollController = ScrollController();

  final List<Widget> _screens = [
    const HomeScreen(),
    const AllAdsScreen(),
    const InteractiveMapScreen(),
    const WalletScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  final List<Map<String, dynamic>> _navItems = [
    {'icon': 'home', 'label': 'الرئيسية', 'index': 0},
    {'icon': 'customer', 'label': 'المتجر', 'index': 1},
    {'icon': 'location', 'label': 'الخريطة', 'index': 2},
    {'icon': 'add', 'label': '', 'index': 3, 'isCenter': true},
    {'icon': 'wallet', 'label': 'المحفظة', 'index': 4},
    {'icon': 'chat', 'label': 'الدردشة', 'index': 5},
    {'icon': 'profile', 'label': 'حسابي', 'index': 6},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _appBarAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    _bottomBarAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final double currentOffset = _scrollController.offset;
    final double delta = currentOffset - _lastScrollOffset;
    
    if (currentOffset <= 0) {
      // في قمة الصفحة، أظهر الشريطين
      if (!_isAppBarVisible || !_isBottomBarVisible) {
        setState(() {
          _isAppBarVisible = true;
          _isBottomBarVisible = true;
        });
        _animationController.forward();
      }
    } else if (delta > 10 && _isAppBarVisible) {
      // تمرير للأسفل، اخفِ الشريطين
      setState(() {
        _isAppBarVisible = false;
        _isBottomBarVisible = false;
      });
      _animationController.reverse();
    } else if (delta < -10 && !_isAppBarVisible) {
      // تمرير للأعلى، أظهر الشريطين
      setState(() {
        _isAppBarVisible = true;
        _isBottomBarVisible = true;
      });
      _animationController.forward();
    }
    
    _lastScrollOffset = currentOffset;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      _showQuickActionsSheet();
      return;
    }
    int actualIndex = index > 3 ? index - 1 : index;
    setState(() => _currentIndex = actualIndex);
  }

  void _showQuickActionsSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      backgroundColor: AppTheme.getSurfaceColor(context),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Text('إجراءات سريعة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildActionItem(Icons.add_circle_outline, 'إضافة إعلان', 'انشر إعلاناً جديداً', AppTheme.goldColor, () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/add_ad');
            }),
            _buildActionItem(Icons.shopping_bag_outlined, 'إضافة منتج', 'أضف منتجاً جديداً للبيع', Colors.green, () {
              Navigator.pop(context);
            }),
            _buildActionItem(Icons.build_outlined, 'طلب خدمة', 'اطلب خدمة معينة', Colors.blue, () {
              Navigator.pop(context);
            }),
            _buildActionItem(Icons.download_outlined, 'استلام حوالة', 'استلم حوالة مالية', Colors.purple, () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/receive_transfer');
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String title, String subtitle, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            _onScroll();
          }
          return false;
        },
        child: Stack(
          children: [
            // المحتوى الرئيسي
            IndexedStack(
              index: _currentIndex,
              children: _screens.map((screen) {
                return NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollUpdateNotification) {
                      _onScroll();
                    }
                    return false;
                  },
                  child: screen,
                );
              }).toList(),
            ),
            
            // الشريط العلوي المتحرك
            AnimatedBuilder(
              animation: _appBarAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -kToolbarHeight * (1 - _appBarAnimation.value)),
                  child: Opacity(
                    opacity: _appBarAnimation.value,
                    child: child,
                  ),
                );
              },
              child: AppBar(
                title: const Text(
                  'FLEX YEMEN',
                  style: TextStyle(
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,
                    color: AppTheme.goldColor,
                  ),
                ),
                centerTitle: true,
                elevation: 0,
                backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings_outlined, color: AppTheme.goldColor),
                    onPressed: () => Navigator.pushNamed(context, '/settings'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined, color: AppTheme.goldColor),
                    onPressed: () => Navigator.pushNamed(context, '/notifications'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined, color: AppTheme.goldColor),
                    onPressed: () => Navigator.pushNamed(context, '/cart'),
                  ),
                ],
              ),
            ),
            
            // الشريط السفلي المتحرك
            AnimatedBuilder(
              animation: _bottomBarAnimation,
              builder: (context, child) {
                return Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Transform.translate(
                    offset: Offset(0, (1 - _bottomBarAnimation.value) * 80),
                    child: Opacity(
                      opacity: _bottomBarAnimation.value,
                      child: child,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
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
                        _buildNavItem('home', 'الرئيسية', 0),
                        _buildNavItem('customer', 'المتجر', 1),
                        _buildNavItem('location', 'الخريطة', 2),
                        _buildCenterButton(),
                        _buildNavItem('wallet', 'المحفظة', 4),
                        _buildNavItem('chat', 'الدردشة', 5),
                        _buildNavItem('profile', 'حسابي', 6),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String iconName, String label, int index) {
    final bool isSelected = _currentIndex == (index > 3 ? index - 1 : index);
    final String iconPath = 'assets/icons/svg/$iconName.svg';
    
    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  isSelected ? AppTheme.goldColor : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 11,
                  color: isSelected ? AppTheme.goldColor : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCenterButton() {
    return GestureDetector(
      onTap: () => _onItemTapped(3),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: AppTheme.goldGradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppTheme.goldColor.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.black, size: 32),
      ),
    );
  }
}
