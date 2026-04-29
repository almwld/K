import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/theme_manager.dart';
import '../../services/theme_service.dart';
import 'home_screen.dart';
import '../all_ads_screen.dart';
import '../map/interactive_map_screen.dart';
import '../wallet/wallet_screen.dart';
import '../chat/chat_screen.dart';
import '../profile/profile_screen.dart';
import '../orders/orders_screen.dart';
import '../stores/stores_screen.dart';
import '../ai_assistant_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  Color _themeColor = AppTheme.goldColor;

  final List<Widget> _screens = const [
    ProfileScreen(),        // 0 - حسابي
    OrdersScreen(),         // 1 - طلباتي
    ChatScreen(),           // 2 - دردشه
    SizedBox(),             // 3 - زر ذهبي (إجراءات سريعة)
    WalletScreen(),         // 4 - مزاد
    StoresScreen(),         // 5 - متاجر
    HomeScreen(),           // 6 - الرئيسية
  ];

  @override
  void initState() {
    super.initState();
    _loadThemeColor();
  }

  Future<void> _loadThemeColor() async {
    final color = await ThemeService.getThemeColor();
    setState(() => _themeColor = color);
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      _showQuickActionsSheet();
      return;
    }
    setState(() => _currentIndex = index);
  }

  void _showQuickActionsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppTheme.getSurfaceColor(context),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.getDividerColor(context),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'إجراءات سريعة',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.getTextColor(context),
              ),
            ),
            const SizedBox(height: 24),
            _buildQuickActionItem(
              icon: Icons.add_circle_outline,
              title: 'إضافة إعلان',
              subtitle: 'أضف إعلاناً جديداً للبيع',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/add_ad');
              },
            ),
            _buildQuickActionItem(
              icon: Icons.shopping_bag_outlined,
              title: 'إضافة منتج',
              subtitle: 'أضف منتجاً جديداً للمتجر',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/seller_products');
              },
            ),
            _buildQuickActionItem(
              icon: Icons.handyman_outlined,
              title: 'طلب خدمة',
              subtitle: 'اطلب خدمة من مزودي الخدمات',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _buildQuickActionItem(
              icon: Icons.account_balance_wallet_outlined,
              title: 'استلام حوالة',
              subtitle: 'استلم حوالة مالية',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/receive_transfer');
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_themeColor, Color.lerp(_themeColor, Colors.white, 0.3) ?? _themeColor],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.black),
      ),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: AppTheme.getSecondaryTextColor(context),
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
        elevation: 0,
        title: const Text(
          'Flex Yemen',
          style: TextStyle(
            fontFamily: 'Changa',
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: AppTheme.goldColor,
          ),
        ),
        centerTitle: true,
        actions: [
          // زر الدعم
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/svg/support.svg',
              width: 22,
              height: 22,
              colorFilter: ColorFilter.mode(
                isDark ? Colors.white : Colors.black87,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () => Navigator.pushNamed(context, '/help'),
            tooltip: 'الدعم',
          ),
          // زر السلة
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/svg/cart.svg',
              width: 22,
              height: 22,
              colorFilter: ColorFilter.mode(
                isDark ? Colors.white : Colors.black87,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
            tooltip: 'السلة',
          ),
          // زر المساعد الذكي AI
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/svg/ai_assistant.svg',
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                AppTheme.goldColor,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AIAssistantScreen()),
            ),
            tooltip: 'المساعد الذكي',
          ),
          // زر الإشعارات
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/svg/notification_bell.svg',
              width: 22,
              height: 22,
              colorFilter: ColorFilter.mode(
                isDark ? Colors.white : Colors.black87,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () => Navigator.pushNamed(context, '/notifications'),
            tooltip: 'الإشعارات',
          ),
          // ثلاث نقاط فوق بعض
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: isDark ? Colors.white : Colors.black87,
            ),
            onSelected: (value) {
              switch (value) {
                case 'settings':
                  Navigator.pushNamed(context, '/settings');
                  break;
                case 'theme':
                  _showColorPicker();
                  break;
                case 'quick_settings':
                  _showQuickSettings();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'settings', child: Text('الإعدادات')),
              const PopupMenuItem(value: 'theme', child: Text('تغيير الثيم')),
              const PopupMenuItem(value: 'quick_settings', child: Text('إعدادات سريعة')),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
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
                _buildNavItem('assets/icons/svg/profile.svg', 'حسابي', 0),
                _buildNavItem('assets/icons/svg/orders.svg', 'طلباتي', 1),
                _buildNavItem('assets/icons/svg/chat.svg', 'دردشه', 2),
                _buildFAB(),
                _buildNavItem('assets/icons/svg/auction.svg', 'مزاد', 4),
                _buildNavItem('assets/icons/svg/market.svg', 'متاجر', 5),
                _buildNavItem('assets/icons/svg/home.svg', 'الرئيسية', 6),
              ],
            ),
          ),
        ),
      ),
    );
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
              crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16,
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
            Container(width: 40, height: 4, decoration: BoxDecoration(color: AppTheme.getDividerColor(context), borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 20),
            const Text('الإعدادات السريعة', style: TextStyle(fontFamily: 'Changa', fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.brightness_6),
              title: const Text('الوضع الليلي'),
              trailing: Switch(value: themeManager.isDarkMode, onChanged: (v) => themeManager.toggleTheme(), activeColor: _themeColor),
            ),
            ListTile(leading: const Icon(Icons.language), title: const Text('اللغة'), trailing: const Text('العربية')),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('الإشعارات'),
              trailing: Switch(value: true, onChanged: (v) {}, activeColor: _themeColor),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('جميع الإعدادات'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _showQuickActionsSheet,
        customBorder: const CircleBorder(),
        child: Container(
          width: 56, height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_themeColor, Color.lerp(_themeColor, Colors.white, 0.3) ?? _themeColor],
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [BoxShadow(color: _themeColor.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: const Icon(Icons.add, color: Colors.black, size: 32),
        ),
      ),
    ).animate(onPlay: (controller) => controller.repeat(reverse: true)).scale(
      begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 1.seconds, curve: Curves.easeInOut,
    );
  }

  Widget _buildNavItem(String svgPath, String label, int index) {
    final isSelected = _currentIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isSelected ? _themeColor : (isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary);

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
