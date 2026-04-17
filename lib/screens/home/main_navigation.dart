import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/theme_manager.dart';
import 'home/home_screen.dart';
import '../stores/stores_screen.dart';
import '../chat/chat_screen.dart';
import '../map/interactive_map_screen.dart';
import '../wallet/wallet_screen.dart';
import 'profile/profile_screen.dart';
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

  final List<Widget> _screens = const [
    HomeScreen(),
    StoresScreen(),
    ChatScreen(),
    SizedBox(),
    InteractiveMapScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 2.5).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _rotationController.forward(from: 0);
      } else {
        _rotationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: _currentIndex, children: _screens),
          if (_isExpanded)
            GestureDetector(
              onTap: _toggleExpand,
              child: Container(color: Colors.black.withOpacity(0.5)),
            ),
          if (_isExpanded)
            Positioned(
              bottom: 120,
              left: 30,
              right: 30,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, spreadRadius: 5)],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(Icons.campaign_outlined, 'إضافة إعلان', () { _toggleExpand(); Navigator.push(context, MaterialPageRoute(builder: (_) => const AddAdScreen())); }),
                    _buildActionButton(Icons.handyman_outlined, 'طلب خدمة', () { _toggleExpand(); Navigator.push(context, MaterialPageRoute(builder: (_) => const RequestServiceScreen())); }),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: AppTheme.bottomBar, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, 'assets/icons/svg/home.svg', 'الرئيسية'),
                _buildNavItem(1, 'assets/icons/svg/merchant.svg', 'المتجر'),
                _buildNavItem(2, 'assets/icons/svg/chat.svg', 'الدردشة'),
                _buildRotatingButton(),
                _buildNavItem(4, 'assets/icons/svg/location.svg', 'الخريطة'),
                _buildNavItem(5, 'assets/icons/svg/wallet.svg', 'المحفظة'),
                _buildNavItem(6, 'assets/icons/svg/profile.svg', 'حسابي'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath, String label) {
    final isSelected = _currentIndex == index;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (_isExpanded) _toggleExpand();
            setState(() => _currentIndex = index);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(iconPath, width: 24, height: 24, colorFilter: ColorFilter.mode(isSelected ? AppTheme.primaryBlue : AppTheme.textMuted, BlendMode.srcIn)),
              const SizedBox(height: 4),
              Text(label, style: TextStyle(fontSize: 10, color: isSelected ? AppTheme.primaryBlue : AppTheme.textMuted)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRotatingButton() {
    return Expanded(
      child: GestureDetector(
        onTap: _toggleExpand,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value * 3.14159 * 2,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: AppTheme.primaryBlue.withOpacity(0.4), blurRadius: 15, spreadRadius: 2)],
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

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), shape: BoxShape.circle), child: Icon(icon, color: AppTheme.primaryBlue, size: 32)),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
