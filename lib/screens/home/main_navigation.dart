import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  bool _isExpanded = false;

  // الشاشات: الرئيسية | المتجر | الدردشة | (زر+) | الخريطة | المحفظة | حسابي
  final List<Widget> _screens = const [
    HomeScreen(),           // 0
    StoresScreen(),         // 1
    ChatScreen(),           // 2 - الدردشة
    SizedBox(),             // 3 - الزر الأزرق
    InteractiveMapScreen(), // 4
    WalletScreen(),         // 5
    ProfileScreen(),        // 6
  ];

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: _currentIndex, children: _screens),
          if (_isExpanded)
            GestureDetector(
              onTap: () => setState(() => _isExpanded = false),
              child: Container(color: Colors.black.withOpacity(0.5)),
            ),
          if (_isExpanded)
            Positioned(
              bottom: 100,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(Icons.campaign_outlined, 'إضافة إعلان', () { setState(() => _isExpanded = false); Navigator.push(context, MaterialPageRoute(builder: (_) => const AddAdScreen())); }),
                    _buildActionButton(Icons.handyman_outlined, 'طلب خدمة', () { setState(() => _isExpanded = false); Navigator.push(context, MaterialPageRoute(builder: (_) => const RequestServiceScreen())); }),
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
                _buildGoldenButton(),
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
          onTap: () => setState(() => _currentIndex = index),
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

  Widget _buildGoldenButton() {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _isExpanded = !_isExpanded),
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
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
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), shape: BoxShape.circle), child: Icon(icon, color: AppTheme.primaryBlue, size: 28)),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 12)),
        ],
      ),
    );
  }
}
