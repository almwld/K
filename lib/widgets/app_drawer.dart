import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/offers_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/orders/orders_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/wallet/wallet_screen.dart';
import '../screens/stores/stores_screen.dart';
import '../screens/auctions/auctions_screen.dart';
import '../screens/chat/chat_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0B0E11),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF1A2A44), Color(0xFF0F172A)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                border: Border(bottom: BorderSide(color: const Color(0xFFD4AF37).withOpacity(0.3))),
              ),
              child: Row(
                children: [
                  Container(width: 60, height: 60, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFD4AF37), width: 2), gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFAA8C2C)])), child: const Center(child: Icon(Icons.person, color: Colors.white, size: 35))),
                  const SizedBox(width: 12),
                  const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('أحمد محمد', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), SizedBox(height: 4), Text('ahmed@flexyemen.com', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12))])),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _buildItem(context, 'home', 'الرئيسية', '/home'),
                  _buildItem(context, 'profile', 'حسابي', screen: const ProfileScreen()),
                  _buildItem(context, 'orders', 'طلباتي', screen: const OrdersScreen()),
                  _buildItem(context, 'cart', 'السلة', screen: const CartScreen()),
                  _buildItem(context, 'favorite', 'المفضلة', screen: const FavoritesScreen()),
                  const Divider(color: Color(0xFF2B3139)),
                  _buildItem(context, 'store', 'المتاجر', screen: const StoresScreen()),
                  _buildItem(context, 'auction', 'المزادات', screen: const AuctionsScreen()),
                  _buildItem(context, 'discount', 'العروض', screen: const OffersScreen()),
                  _buildItem(context, 'chat', 'الدردشة', screen: const ChatScreen()),
                  const Divider(color: Color(0xFF2B3139)),
                  _buildItem(context, 'wallet', 'المحفظة', screen: const WalletScreen()),
                  _buildItem(context, 'deposit', 'إيداع', '/deposit'),
                  _buildItem(context, 'withdraw', 'سحب', '/withdraw'),
                  _buildItem(context, 'transfer', 'تحويل', '/transfer'),
                  _buildItem(context, 'notification', 'الإشعارات', screen: const NotificationsScreen()),
                  _buildItem(context, 'settings', 'الإعدادات', screen: const SettingsScreen()),
                  const Divider(color: Color(0xFF2B3139)),
                  _buildItem(context, 'admin', 'لوحة الإدارة', '/admin'),
                  _buildItem(context, 'help', 'المساعدة', '/help'),
                  _buildItem(context, 'logout', 'تسجيل الخروج', color: const Color(0xFFF6465D), onTap: () => _logout(context)),
                ],
              ),
            ),
            Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(border: Border(top: BorderSide(color: const Color(0xFF2B3139)))), child: Row(children: [SvgPicture.asset('assets/icons/svg/info.svg', width: 16, colorFilter: const ColorFilter.mode(Color(0xFF5E6673), BlendMode.srcIn)), const SizedBox(width: 8), const Text('Flex Yemen - v1.0.0', style: TextStyle(color: Color(0xFF5E6673), fontSize: 12))])),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, String icon, String title, [String? route, Widget? screen, Color? color, VoidCallback? onTap]) {
    return ListTile(
      leading: SvgPicture.asset('assets/icons/svg/$icon.svg', width: 24, colorFilter: ColorFilter.mode(color ?? const Color(0xFFD4AF37), BlendMode.srcIn)),
      title: Text(title, style: TextStyle(color: color ?? Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 14),
      onTap: onTap ?? () { Navigator.pop(context); if (route != null) Navigator.pushNamed(context, route); else if (screen != null) Navigator.push(context, MaterialPageRoute(builder: (_) => screen)); },
    );
  }

  void _logout(BuildContext context) {
    showDialog(context: context, builder: (c) => AlertDialog(backgroundColor: const Color(0xFF1E2329), title: const Text('تسجيل الخروج', style: TextStyle(color: Colors.white)), content: const Text('هل أنت متأكد؟', style: TextStyle(color: Color(0xFF9CA3AF))), actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text('إلغاء')), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF6465D)), onPressed: () { Navigator.pop(c); Navigator.pushReplacementNamed(context, '/login'); }, child: const Text('خروج'))]));
  }
}
