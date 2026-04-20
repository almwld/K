import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/my_orders_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/wallet/wallet_screen.dart';
import '../screens/auctions_screen.dart';
import '../screens/offers_screen.dart';
import '../screens/nearby_stores_screen.dart';
import '../screens/seller_dashboard_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/help_support_screen.dart';
import '../screens/invite_friends_screen.dart';
import '../screens/sanaa_services_screen.dart';
import '../screens/ai_assistant_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/order_tracking_screen.dart';
import '../screens/reels_screen.dart';
import '../screens/categories_screen.dart';
import '../providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../screens/login_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authProvider = context.watch<AuthProvider>();
    final isLoggedIn = authProvider.isLoggedIn;
    final userName = authProvider.userName ?? 'زائر';

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // رأس القائمة
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppTheme.goldGradient,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 45,
                      color: AppTheme.gold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'مرحباً $userName!',
                    style: const TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  if (!isLoggedIn)
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text(
                        'تسجيل الدخول للاستفادة من جميع الميزات',
                        style: TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
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
                    icon: Icons.person_outline,
                    title: 'حسابي',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.shopping_bag_outlined,
                    title: 'طلباتي',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const MyOrdersScreen()));
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.local_shipping_outlined,
                    title: 'تتبع الطلب',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderTrackingScreen()));
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.favorite_border,
                    title: 'المفضلة',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesScreen()));
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.account_balance_wallet_outlined,
                    title: 'المحفظة',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletScreen()));
                    },
                  ),
                  const Divider(),
                  _buildDrawerItem(
                    icon: Icons.category_outlined,
                    title: 'جميع الفئات',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoriesScreen()));
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.gavel_outlined,
                    title: 'المزادات',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AuctionsScreen()));
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.local_offer_outlined,
                    title: 'العروض والتخفيضات',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const OffersScreen()));
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.video_library_outlined,
                    title: 'ريلز',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ReelsScreen()));
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.store_outlined,
                    title: 'متاجر قريبة',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const NearbyStoresScreen()));
                    },
                  ),
                  const Divider(),
                  _buildDrawerItem(
                    icon: Icons.smart_toy_outlined,
                    title: 'المساعد الذكي',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AIAssistantScreen()));
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.location_city_outlined,
                    title: 'خدمات صنعاء',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SanaaServicesScreen()));
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.notifications_outlined,
                    title: 'الإشعارات',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
                    },
                  ),
                  if (isLoggedIn) ...[
                    const Divider(),
                    _buildDrawerItem(
                      icon: Icons.storefront_outlined,
                      title: 'لوحة البائع',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (_) => SellerDashboard()));
                      },
                    ),
                  ],
                  const Divider(),
                  _buildDrawerItem(
                    icon: Icons.settings_outlined,
                    title: 'الإعدادات',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.help_outline,
                    title: 'المساعدة والدعم',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpSupportScreen()));
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.share_outlined,
                    title: 'دعوة الأصدقاء',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const InviteFriendsScreen()));
                    },
                  ),
                ],
              ),
            ),

            // تذييل القائمة
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: isDark ? Colors.white12 : Colors.black12,
                  ),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    'Flex Yemen - الإصدار 2.0.0',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
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
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.gold, size: 22),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Changa',
          fontSize: 14,
        ),
      ),
      onTap: onTap,
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}

