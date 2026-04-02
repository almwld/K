import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/auth_provider.dart';
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
    {'title': 'إعلاناتي', 'icon': Icons.post_add, 'color': 0xFF4CAF50, 'route': '/my_ads'},
    {'title': 'المفضلة', 'icon': Icons.favorite_border, 'color': 0xFFE91E63, 'route': '/favorites'},
    {'title': 'طلباتي', 'icon': Icons.shopping_bag_outlined, 'color': 0xFFFF9800, 'route': '/my_orders'},
    {'title': 'المتابعون', 'icon': Icons.people_outline, 'color': 0xFF2196F3, 'route': '/followers'},
    {'title': 'المراجعات', 'icon': Icons.rate_review, 'color': 0xFF9C27B0, 'route': '/reviews'},
    {'title': 'نقاطي', 'icon': Icons.stars, 'color': 0xFFD4AF37, 'route': '/garden'},
    {'title': 'الإعدادات', 'icon': Icons.settings_outlined, 'color': 0xFF607D8B, 'route': '/settings'},
    {'title': 'المساعدة', 'icon': Icons.help_outline, 'color': 0xFF00BCD4, 'route': '/help_support'},
    {'title': 'دعوة الأصدقاء', 'icon': Icons.share, 'color': 0xFF4CAF50, 'route': '/invite_friends'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authProvider = Provider.of<AuthProvider>(context);

    // إحصائيات وهمية
    final stats = [
      {'value': '12', 'label': 'إعلان'},
      {'value': '48', 'label': 'متابع'},
      {'value': '4.8', 'label': 'تقييم'},
      {'value': '1,250', 'label': 'نقطة'},
    ];

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // الهيدر مع معلومات المستخدم
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppTheme.goldGradient,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  // صورة المستخدم
                  Stack(
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
                  const SizedBox(height: 16),
                  // اسم المستخدم
                  Text(
                    authProvider.userName ?? 'أحمد محمد',
                    style: const TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // البريد الإلكتروني
                  Text(
                    authProvider.userEmail ?? 'ahmed@example.com',
                    style: const TextStyle(
                      fontFamily: 'Changa',
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // الإحصائيات
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: stats.map((stat) {
                      return Column(
                        children: [
                          Text(
                            stat['value'],
                            style: const TextStyle(
                              fontFamily: 'Changa',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            stat['label'],
                            style: const TextStyle(
                              fontFamily: 'Changa',
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // القائمة
            ..._profileMenu.map((item) => ListTile(
              leading: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Color(item['color']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item['icon'] as IconData, color: Color(item['color']), size: 22),
              ),
              title: Text(
                item['title'],
                style: TextStyle(
                  fontFamily: 'Changa',
                  color: AppTheme.getTextColor(context),
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.pushNamed(context, item['route']),
            )),
            const SizedBox(height: 24),
            // زر تسجيل الخروج
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await authProvider.logout();
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('تسجيل الخروج'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.error,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
