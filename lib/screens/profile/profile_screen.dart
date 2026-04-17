import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import '../../widgets/social_media_widget.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_manager.dart';
import '../settings/settings_screen.dart';
import '../my_orders_screen.dart';
import '../favorites_screen.dart';
import '../my_ads_screen.dart';
import '../addresses_screen.dart';
import '../wallet/wallet_screen.dart';
import '../login_screen.dart';
import '../auctions_screen.dart';
import '../advanced_search_screen.dart';
import '../seller/seller_reports_screen.dart';
import '../admin/admin_main_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authProvider = context.watch<AuthProvider>();
    final themeManager = context.watch<ThemeManager>();
    final isAdmin = authProvider.user?.email?.contains('admin') ?? false;
    final isMerchant = authProvider.user?.userMetadata?['role'] == 'merchant';

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'حسابي'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildProfileHeader(authProvider, themeManager),
            const SizedBox(height: 24),
            _buildStatsSection(),
            const SizedBox(height: 24),
            _buildMenuSection(context, isMerchant, isAdmin),
            const SizedBox(height: 20),
            const SocialMediaWidget(),
            const SizedBox(height: 20),
            _buildLogoutButton(context, authProvider),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(AuthProvider authProvider, ThemeManager themeManager) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: themeManager.primaryColor, width: 3),
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  authProvider.user?.userMetadata?['avatar'] ?? 
                  'https://ui-avatars.com/api/?name=${authProvider.user?.email ?? 'User'}&background=3B82F6&color=fff&size=100',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          authProvider.user?.userMetadata?['full_name'] ?? 'مستخدم فلكس يمن',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          authProvider.user?.email ?? '',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: themeManager.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            authProvider.user?.userMetadata?['role'] == 'merchant' ? 'تاجر' : 'عميل',
            style: TextStyle(color: themeManager.primaryColor, fontSize: 12),
          ),
        ),
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
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildMenuSection(BuildContext context, bool isMerchant, bool isAdmin) {
    // القائمة الأساسية لجميع المستخدمين
    final List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.shopping_bag_outlined, 'title': 'طلباتي', 'screen': const MyOrdersScreen()},
      {'icon': Icons.favorite_border, 'title': 'المفضلة', 'screen': const FavoritesScreen()},
      {'icon': Icons.campaign_outlined, 'title': 'إعلاناتي', 'screen': const MyAdsScreen()},
      {'icon': Icons.location_on_outlined, 'title': 'العناوين', 'screen': const AddressesScreen()},
      {'icon': Icons.account_balance_wallet_outlined, 'title': 'المحفظة', 'screen': const WalletScreen()},
      
      // الميزات الإضافية
      {'icon': Icons.gavel, 'title': 'المزادات', 'screen': const AuctionsScreen()},
      {'icon': Icons.search, 'title': 'البحث المتقدم', 'screen': const AdvancedSearchScreen()},
    ];

    // إضافة تقارير البائع للتجار
    if (isMerchant) {
      menuItems.insert(6, {'icon': Icons.analytics, 'title': 'تقارير المبيعات', 'screen': const SellerReportsScreen()});
    }

    // إضافة لوحة المشرف للمشرفين
    if (isAdmin) {
      menuItems.add({'icon': Icons.admin_panel_settings, 'title': 'لوحة التحكم', 'screen': const AdminMainScreen()});
    }

    // الإعدادات دائماً في النهاية
    menuItems.add({'icon': Icons.settings_outlined, 'title': 'الإعدادات', 'screen': const SettingsScreen()});

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: menuItems.length,
        separatorBuilder: (_, __) => const Divider(height: 1, indent: 60),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return ListTile(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => item['screen'] as Widget)),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item['icon'] as IconData, color: AppTheme.primaryBlue),
            ),
            title: Text(item['title'] as String),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          );
        },
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, AuthProvider authProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () async {
            await authProvider.signOut();
            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            }
          },
          icon: const Icon(Icons.logout, color: Colors.red),
          label: const Text('تسجيل الخروج', style: TextStyle(color: Colors.red)),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            side: const BorderSide(color: Colors.red),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
