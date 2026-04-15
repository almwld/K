import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'settings/settings_screen.dart';
import 'my_orders_screen.dart';
import 'favorites_screen.dart';
import 'my_ads_screen.dart';
import 'addresses_screen.dart';
import 'wallet_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'حسابي'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildStatsSection(),
            const SizedBox(height: 24),
            _buildMenuSection(context),
            const SizedBox(height: 16),
            _buildLogoutButton(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppTheme.goldColor, width: 3)),
              child: const CircleAvatar(radius: 50, backgroundImage: NetworkImage('https://ui-avatars.com/api/?name=Flex+Yemen&background=D4AF37&color=fff&size=100')),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: AppTheme.goldColor, shape: BoxShape.circle), child: const Icon(Icons.edit, size: 16, color: Colors.white)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text('مستخدم فلكس يمن', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text('user@flexyemen.com', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        const SizedBox(height: 8),
        Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)), child: const Text('عضو ذهبي', style: TextStyle(color: AppTheme.goldColor, fontSize: 12))),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('12', 'طلبات'),
          Container(width: 1, height: 30, color: Colors.grey[300]),
          _buildStatItem('5', 'إعلانات'),
          Container(width: 1, height: 30, color: Colors.grey[300]),
          _buildStatItem('24', 'مفضلة'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600]))],
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    final menuItems = [
      {'icon': Icons.shopping_bag_outlined, 'title': 'طلباتي', 'screen': const MyOrdersScreen()},
      {'icon': Icons.favorite_border, 'title': 'المفضلة', 'screen': const FavoritesScreen()},
      {'icon': Icons.campaign_outlined, 'title': 'إعلاناتي', 'screen': const MyAdsScreen()},
      {'icon': Icons.location_on_outlined, 'title': 'العناوين', 'screen': const AddressesScreen()},
      {'icon': Icons.account_balance_wallet_outlined, 'title': 'المحفظة', 'screen': const WalletScreen()},
      {'icon': Icons.settings_outlined, 'title': 'الإعدادات', 'screen': const SettingsScreen()},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16)),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: menuItems.length,
        separatorBuilder: (_, __) => const Divider(height: 1, indent: 60),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return ListTile(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => item['screen'] as Widget)),
            leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(item['icon'] as IconData, color: AppTheme.goldColor)),
            title: Text(item['title'] as String),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          );
        },
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false),
          icon: const Icon(Icons.logout, color: Colors.red),
          label: const Text('تسجيل الخروج', style: TextStyle(color: Colors.red)),
          style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), side: const BorderSide(color: Colors.red), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        ),
      ),
    );
  }
}
