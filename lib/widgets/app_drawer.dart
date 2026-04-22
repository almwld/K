import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/notifications_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0B0E11),
      child: SafeArea(
        child: Column(
          children: [
            // رأس القائمة
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A2A44), Color(0xFF0F172A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border(bottom: BorderSide(color: const Color(0xFFD4AF37).withOpacity(0.3))),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFD4AF37), width: 2),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFD4AF37), Color(0xFFAA8C2C)],
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.person, color: Colors.white, size: 35),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'أحمد محمد',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'ahmed@flexyemen.com',
                          style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // قائمة الخيارات
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _buildDrawerItem(
                    icon: 'assets/icons/svg/home.svg',
                    title: 'الرئيسية',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                  _buildDrawerItem(
                    icon: 'assets/icons/svg/profile.svg',
                    title: 'حسابي',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
                    },
                  ),
                  _buildDrawerItem(
                    icon: 'assets/icons/svg/orders.svg',
                    title: 'طلباتي',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildDrawerItem(
                    icon: 'assets/icons/svg/cart.svg',
                    title: 'السلة',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
                    },
                  ),
                  _buildDrawerItem(
                    icon: 'assets/icons/svg/favorite.svg',
                    title: 'المفضلة',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesScreen()));
                    },
                  ),
                  const Divider(color: Color(0xFF2B3139)),
                  _buildDrawerItem(
                    icon: 'assets/icons/svg/store.svg',
                    title: 'المتاجر',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/stores');
                    },
                  ),
                  _buildDrawerItem(
                    icon: 'assets/icons/svg/auction.svg',
                    title: 'المزادات',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/auctions');
                    },
                  ),
                  _buildDrawerItem(
                    icon: 'assets/icons/svg/discount.svg',
                    title: 'العروض',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(color: Color(0xFF2B3139)),
                  _buildDrawerItem(
                    icon: 'assets/icons/svg/wallet.svg',
                    title: 'المحفظة',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/wallet');
                    },
                  ),
                  _buildDrawerItem(
                    icon: 'assets/icons/svg/notification.svg',
                    title: 'الإشعارات',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
                    },
                  ),
                  _buildDrawerItem(
                    icon: 'assets/icons/svg/settings.svg',
                    title: 'الإعدادات',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildDrawerItem(
                    icon: 'assets/icons/svg/help.svg',
                    title: 'المساعدة والدعم',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(color: Color(0xFF2B3139)),
                  _buildDrawerItem(
                    icon: 'assets/icons/svg/logout.svg',
                    title: 'تسجيل الخروج',
                    color: const Color(0xFFF6465D),
                    onTap: () {
                      Navigator.pop(context);
                      _showLogoutDialog(context);
                    },
                  ),
                ],
              ),
            ),
            
            // تذييل القائمة
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: const Color(0xFF2B3139))),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/svg/info.svg',
                    width: 16,
                    height: 16,
                    colorFilter: const ColorFilter.mode(Color(0xFF5E6673), BlendMode.srcIn),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Flex Yemen - الإصدار 1.0.0',
                    style: TextStyle(color: Color(0xFF5E6673), fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: SvgPicture.asset(
        icon,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(color ?? const Color(0xFFD4AF37), BlendMode.srcIn),
      ),
      title: Text(
        title,
        style: TextStyle(color: color ?? Colors.white, fontSize: 15),
      ),
      onTap: onTap,
      trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 14),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E2329),
        title: const Text('تسجيل الخروج', style: TextStyle(color: Colors.white)),
        content: const Text('هل أنت متأكد من تسجيل الخروج؟', style: TextStyle(color: Color(0xFF9CA3AF))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(color: Color(0xFF9CA3AF))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF6465D),
            ),
            child: const Text('تسجيل الخروج'),
          ),
        ],
      ),
    );
  }
}
