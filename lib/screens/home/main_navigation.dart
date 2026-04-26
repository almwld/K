import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';
import 'home_screen.dart';
import '../all_ads_screen.dart';
import '../map/interactive_map_screen.dart';
import '../wallet/wallet_screen.dart';
import '../chat/chat_screen.dart';
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
    AllAdsScreen(),
    InteractiveMapScreen(),
    SizedBox(),
    WalletScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 3) {
      _showQuickActionsSheet();
      return;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  void _showQuickActionsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.binanceCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.binanceBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'إجراءات سريعة',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              _buildActionItem(
                icon: Icons.add_circle_outline,
                title: 'إضافة إعلان',
                color: AppTheme.serviceBlue,
              ),
              _buildActionItem(
                icon: Icons.shopping_bag_outlined,
                title: 'إضافة منتج',
                color: AppTheme.serviceOrange,
              ),
              _buildActionItem(
                icon: Icons.handyman_outlined,
                title: 'طلب خدمة',
                color: AppTheme.binanceGreen,
              ),
              _buildActionItem(
                icon: Icons.account_balance_wallet_outlined,
                title: 'استلام حوالة',
                color: Colors.purple,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 16),
      onTap: () => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FLEX YEMEN',
          style: TextStyle(
            fontFamily: 'Changa',
            fontWeight: FontWeight.bold,
            color: AppTheme.binanceGold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: AppTheme.binanceGold),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppTheme.binanceGold),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
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
                _buildNavItem('assets/icons/svg/home.svg', 'الرئيسية', 0),
                _buildNavItem('assets/icons/svg/merchant.svg', 'متاجر', 1),
                _buildNavItem('assets/icons/svg/location.svg', 'مول بجوارك', 2),
                _buildFAB(),
                _buildNavItem('assets/icons/svg/auction.svg', 'مزاد', 4),
                _buildNavItem('assets/icons/svg/cart.svg', 'سلة', 5),
                _buildNavItem('assets/icons/svg/profile.svg', 'حسابي', 6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return GestureDetector(
      onTap: _showQuickActionsSheet,
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
        child: const Icon(Icons.add, color: Colors.black, size: 32),
      ),
    );
  }

  Widget _buildNavItem(String svgPath, String label, int index) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? AppTheme.binanceGold : const Color(0xFF5E6673);

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
                SvgPicture.asset(
                  svgPath,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  width: 24,
                  height: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
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
      ),
    );
  }
}
