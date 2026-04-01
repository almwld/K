import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import 'my_ads_screen.dart';
import 'favorites_screen.dart';
import 'my_orders_screen.dart';
import 'following_screen.dart';
import 'garden_screen.dart';
import 'settings/settings_screen.dart';
import 'help_support_screen.dart';
import 'invite_friends_screen.dart';
import 'reviews_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final List<Map<String, dynamic>> _profileMenu = const [
    {'title': 'إعلاناتي', 'icon': Icons.post_add, 'color': 0xFF4CAF50, 'screen': MyAdsScreen()},
    {'title': 'المفضلة', 'icon': Icons.favorite_border, 'color': 0xFFE91E63, 'screen': FavoritesScreen()},
    {'title': 'طلباتي', 'icon': Icons.shopping_bag_outlined, 'color': 0xFFFF9800, 'screen': MyOrdersScreen()},
    {'title': 'المتابعون', 'icon': Icons.people_outline, 'color': 0xFF2196F3, 'screen': FollowingScreen()},
    {'title': 'المراجعات', 'icon': Icons.rate_review, 'color': 0xFF9C27B0, 'screen': ReviewsScreen()},
    {'title': 'نقاطي', 'icon': Icons.stars, 'color': 0xFFD4AF37, 'screen': GardenScreen()},
    {'title': 'الإعدادات', 'icon': Icons.settings_outlined, 'color': 0xFF607D8B, 'screen': SettingsScreen()},
    {'title': 'المساعدة', 'icon': Icons.help_outline, 'color': 0xFF00BCD4, 'screen': HelpSupportScreen()},
    {'title': 'دعوة الأصدقاء', 'icon': Icons.share, 'color': 0xFF4CAF50, 'screen': InviteFriendsScreen()},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      // تم إزالة AppBar المخصص - سيتم استخدام AppBar من MainNavigation
      body: SingleChildScrollView(
        child: Column(
          children: [
            // معلومات المستخدم
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppTheme.goldGradient,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: authProvider.userAvatar != null
                              ? NetworkImage(authProvider.userAvatar!)
                              : null,
                          child: authProvider.userAvatar == null
                              ? const Icon(Icons.person, size: 50, color: AppTheme.goldColor)
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppTheme.goldColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.camera_alt, size: 16, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    authProvider.userName ?? 'ضيف',
                    style: const TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    authProvider.userEmail ?? 'guest@flexyemen.com',
                    style: const TextStyle(
                      fontFamily: 'Changa',
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStat('نقاطي', '1,250'),
                      _buildStat('تقييم', '4.8'),
                      _buildStat('متابع', '48'),
                      _buildStat('إعلان', '12'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // القائمة
            ..._profileMenu.map((item) => _buildMenuItem(
                  context,
                  item['title'],
                  item['icon'],
                  Color(item['color']),
                  item['screen'],
                )),

            const SizedBox(height: 24),

            // زر تسجيل الخروج
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomButton(
                text: 'تسجيل الخروج',
                onPressed: () => _showLogoutDialog(context),
                backgroundColor: AppTheme.error,
                textColor: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Changa',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Changa',
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon, Color color, Widget screen) {
    return ListTile(
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Changa',
          color: AppTheme.getTextColor(context),
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تسجيل الخروج'),
        content: const Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () async {
              await context.read<AuthProvider>().logout();
              if (context.mounted) Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error, foregroundColor: Colors.white),
            child: const Text('تسجيل الخروج'),
          ),
        ],
      ),
    );
  }
}
