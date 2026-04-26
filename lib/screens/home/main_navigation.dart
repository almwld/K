import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';
import 'home_screen.dart';
import '../all_ads_screen.dart';
import '../map/interactive_map_screen.dart';
import '../auctions/auctions_screen.dart';
import '../chat/chat_screen.dart';
import '../profile/profile_screen.dart';
import '../wallet/wallet_screen.dart';
import '../add_ad_screen.dart';
import '../add_product_screen.dart';
import '../request_service_screen.dart';
import '../receive_transfer_request_screen.dart';

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
  
  final TextEditingController _searchController = TextEditingController();

  final List<Widget> _screens = const [
    HomeScreen(),
    AllAdsScreen(),
    InteractiveMapScreen(),
    SizedBox(),
    AuctionsScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  final List<Map<String, dynamic>> _navItems = [
    {'icon': 'assets/icons/svg/home.svg', 'label': 'الرئيسية', 'index': 0},
    {'icon': 'assets/icons/svg/merchant.svg', 'label': 'متاجر', 'index': 1},
    {'icon': 'assets/icons/svg/location.svg', 'label': 'بجانبك', 'index': 2},
    {'icon': null, 'label': '', 'index': 3, 'isFAB': true},
    {'icon': 'assets/icons/svg/auction.svg', 'label': 'مزاد', 'index': 4},
    {'icon': 'assets/icons/svg/chat.svg', 'label': 'مساعد', 'index': 5},
    {'icon': 'assets/icons/svg/profile.svg', 'label': 'حسابي', 'index': 6},
  ];

  final List<Map<String, dynamic>> _quickActions = [
    {'icon': Icons.add_circle_outline, 'title': 'إضافة إعلان', 'color': AppTheme.serviceBlue, 'screen': const AddAdScreen()},
    {'icon': Icons.shopping_bag_outlined, 'title': 'إضافة منتج', 'color': AppTheme.serviceOrange, 'screen': const AddProductScreen()},
    {'icon': Icons.handyman_outlined, 'title': 'طلب خدمة', 'color': AppTheme.binanceGreen, 'screen': const RequestServiceScreen()},
    {'icon': Icons.account_balance_wallet_outlined, 'title': 'استلام حوالة', 'color': Colors.purple, 'screen': const ReceiveTransferRequestScreen()},
  ];

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      _toggleMenu();
      return;
    }
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

  void _executeAction(Widget screen) {
    _toggleMenu();
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  void _showVoiceSearch() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('البحث الصوتي قريباً...'), backgroundColor: AppTheme.binanceGold),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: null, // إزالة اسم المنصة من الشريط
        centerTitle: false,
        elevation: 0,
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
        // الجهة اليسرى: زر القائمة (ثلاث شرطات) + زر المحفظة
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: AppTheme.binanceGold),
              onPressed: () => Scaffold.of(context).openDrawer(),
              tooltip: 'القائمة',
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/icons/svg/wallet.svg',
                width: 22,
                height: 22,
                colorFilter: const ColorFilter.mode(AppTheme.binanceGold, BlendMode.srcIn),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WalletScreen()),
              ),
              tooltip: 'المحفظة',
            ),
          ],
        ),
        // الجهة اليمنى: شريط البحث + زر البحث الصوتي
        actions: [
          Container(
            width: 200,
            height: 40,
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.binanceCard : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppTheme.binanceGold.withOpacity(0.3)),
            ),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 13),
              decoration: InputDecoration(
                hintText: 'ابحث...',
                hintStyle: TextStyle(color: isDark ? Colors.grey.shade500 : Colors.grey.shade600, fontSize: 12),
                prefixIcon: Icon(Icons.search, color: AppTheme.binanceGold, size: 18),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              ),
              onSubmitted: (value) {
                // تنفيذ البحث
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('البحث عن: $value'), backgroundColor: AppTheme.binanceGold),
                );
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.mic, color: AppTheme.binanceGold),
            onPressed: _showVoiceSearch,
            tooltip: 'بحث صوتي',
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _navItems.map((item) {
                final index = item['index'] as int;
                final isSelected = _currentIndex == index;
                final color = isSelected ? AppTheme.binanceGold : const Color(0xFF5E6673);

                if (item['isFAB'] == true) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => _onItemTapped(index),
                      child: AnimatedBuilder(
                        animation: _rotationAnimation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _rotationAnimation.value * 3.14159 * 2,
                            child: Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                gradient: AppTheme.goldGradient,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.binanceGold.withOpacity(0.4),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/svg/add.svg',
                                width: 28,
                                height: 28,
                                colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: GestureDetector(
                    onTap: () => _onItemTapped(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.binanceGold.withOpacity(0.1) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            item['icon'] as String,
                            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['label'] as String,
                            style: TextStyle(
                              fontSize: 10,
                              color: color,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
