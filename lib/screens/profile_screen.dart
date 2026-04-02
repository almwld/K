import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final List<Map<String, dynamic>> _profileMenu = const [
    {'title': 'إعلاناتي', 'icon': Icons.post_add, 'color': 0xFF4CAF50, 'route': '/my_ads'},
    {'title': 'المفضلة', 'icon': Icons.favorite_border, 'color': 0xFFE91E63, 'route': '/favorites'},
    {'title': 'طلباتي', 'icon': Icons.shopping_bag_outlined, 'color': 0xFFFF9800, 'route': '/my_orders'},
    {'title': 'نقاطي', 'icon': Icons.stars, 'color': 0xFFD4AF37, 'route': '/garden'},
    {'title': 'الإعدادات', 'icon': Icons.settings_outlined, 'color': 0xFF607D8B, 'route': '/settings'},
    {'title': 'المساعدة', 'icon': Icons.help_outline, 'color': 0xFF00BCD4, 'route': '/help_support'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.goldColor, AppTheme.goldLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.person, size: 50, color: AppTheme.goldColor),
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
                ],
              ),
            ),
            const SizedBox(height: 16),
            ..._profileMenu.map((item) => ListTile(
              leading: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Color(item['color'] as int).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item['icon'] as IconData, color: Color(item['color'] as int), size: 22),
              ),
              title: Text(
                item['title'] as String,
                style: TextStyle(
                  fontFamily: 'Changa',
                  color: AppTheme.getTextColor(context),
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.pushNamed(context, item['route'] as String),
            )),
            const SizedBox(height: 24),
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
