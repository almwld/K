import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../theme/app_theme.dart';
import '../../widgets/vip_banner.dart';
import '../../widgets/upgrade_card.dart';
import '../login_screen.dart';
import 'account_info_screen.dart';
import '../my_ads_screen.dart';
import '../favorites_screen.dart';
import '../help_support_screen.dart';
import '../user_dashboard.dart';
import '../seller_dashboard.dart';
import '../vip_subscription_screen.dart';
import '../language_settings_screen.dart';
import '../security_settings_screen.dart';
import '../privacy_settings_screen.dart';
import '../notifications_settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.gold.withOpacity(0.4),
                      isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Avatar
                      Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: AppTheme.goldGradient,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppTheme.gold, width: 3),
                            ),
                            child: const Icon(Icons.person, size: 50, color: Colors.black),
                          ),
                          // Gold Badge
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xFFFFD700), Color(0xFFF0B90B)],
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.emoji_events,
                                size: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        user?.email ?? 'مستخدم ضيف',
                        style: const TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Level Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFD700), Color(0xFFF0B90B)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'عضو ذهبي',
                          style: TextStyle(
                            fontFamily: 'Changa',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Quick Stats
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? AppTheme.nightCard : AppTheme.lightCard,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _statItem('الطلبات', '24', Icons.shopping_bag),
                      _verticalDivider(),
                      _statItem('المفضلة', '42', Icons.favorite),
                      _verticalDivider(),
                      _statItem('النقاط', '3.5K', Icons.stars),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // VIP Upgrade Banner
                UpgradeCard(
                  title: 'ترقية إلى VIP',
                  subtitle: 'وفر 25% على كل عملية شراء',
                  savings: 'حتى 500K ر.ي/شهر',
                  onUpgrade: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const VipSubscriptionScreen()),
                  ),
                ),
                const SizedBox(height: 20),

                // Section: Account
                _sectionTitle('الحساب'),
                _buildMenuItem(context, {
                  'title': 'لوحة التحكم',
                  'icon': Icons.dashboard,
                  'color': const Color(0xFFF0B90B),
                  'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UserDashboard())),
                }, isDark),
                _buildMenuItem(context, {
                  'title': 'إعلاناتي',
                  'icon': Icons.campaign,
                  'color': const Color(0xFF2196F3),
                  'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyAdsScreen())),
                }, isDark),
                _buildMenuItem(context, {
                  'title': 'المفضلة',
                  'icon': Icons.favorite,
                  'color': const Color(0xFFF6465D),
                  'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesScreen())),
                }, isDark),
                _buildMenuItem(context, {
                  'title': 'معلومات الحساب',
                  'icon': Icons.person,
                  'color': const Color(0xFF0ECB81),
                  'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountInfoScreen())),
                }, isDark),
                const SizedBox(height: 16),

                // Section: Seller
                _sectionTitle('لوحة البائع'),
                _buildMenuItem(context, {
                  'title': 'لوحة تحكم البائع',
                  'icon': Icons.store,
                  'color': const Color(0xFF0ECB81),
                  'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerDashboard())),
                }, isDark),
                const SizedBox(height: 16),

                // Section: Settings
                _sectionTitle('الإعدادات'),
                _buildMenuItem(context, {
                  'title': 'اللغة',
                  'icon': Icons.language,
                  'color': const Color(0xFF9C27B0),
                  'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LanguageSettingsScreen())),
                }, isDark),
                _buildMenuItem(context, {
                  'title': 'الأمان',
                  'icon': Icons.security,
                  'color': const Color(0xFFF44336),
                  'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SecuritySettingsScreen())),
                }, isDark),
                _buildMenuItem(context, {
                  'title': 'الخصوصية',
                  'icon': Icons.privacy_tip,
                  'color': const Color(0xFF607D8B),
                  'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacySettingsScreen())),
                }, isDark),
                _buildMenuItem(context, {
                  'title': 'الإشعارات',
                  'icon': Icons.notifications,
                  'color': const Color(0xFFFF9800),
                  'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsSettingsScreen())),
                }, isDark),
                const SizedBox(height: 16),

                // Section: Support
                _sectionTitle('المساعدة'),
                _buildMenuItem(context, {
                  'title': 'المساعدة والدعم',
                  'icon': Icons.help_outline,
                  'color': const Color(0xFF2196F3),
                  'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpSupportScreen())),
                }, isDark),
                const SizedBox(height: 24),

                // Logout
                ElevatedButton.icon(
                  onPressed: () => _logout(context),
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
                    'تسجيل الخروج',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.error,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    minimumSize: const Size(double.infinity, 55),
                  ),
                ),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, right: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Changa',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppTheme.gold,
        ),
      ),
    );
  }

  Widget _statItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.gold, size: 22),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Changa',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey[800],
    );
  }

  Widget _buildMenuItem(BuildContext context, Map<String, dynamic> item, bool isDark) {
    return GestureDetector(
      onTap: item['onTap'] as VoidCallback?,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.nightCard : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (item['color'] as Color).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item['icon'] as IconData, color: item['color'] as Color, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                item['title'] as String,
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: isDark ? Colors.grey[600] : Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }
}
