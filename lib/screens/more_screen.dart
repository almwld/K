import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';
import 'profile/profile_screen.dart';
import 'settings/settings_screen.dart';
import 'wallet/wallet_screen.dart';
import 'following_screen.dart';
import 'favorites_screen.dart';
import 'orders/orders_screen.dart';
import 'addresses_screen.dart';
import 'help_support_screen.dart';
import 'about_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  final List<Map<String, dynamic>> _menuItems = const [
    {'icon': Icons.person_outline, 'title': 'الملف الشخصي', 'route': '/profile', 'color': 0xFF2196F3},
    {'icon': Icons.favorite_border, 'title': 'المفضلة', 'route': '/favorites', 'color': 0xFFE91E63},
    {'icon': Icons.people_outline, 'title': 'المتابعات', 'route': '/following', 'color': 0xFF4CAF50},
    {'icon': Icons.shopping_bag_outlined, 'title': 'طلباتي', 'route': '/orders', 'color': 0xFFFF9800},
    {'icon': Icons.location_on_outlined, 'title': 'العناوين', 'route': '/addresses', 'color': 0xFF9C27B0},
    {'icon': Icons.account_balance_wallet_outlined, 'title': 'المحفظة', 'route': '/wallet', 'color': 0xFFD4AF37},
    {'icon': Icons.help_outline, 'title': 'مركز المساعدة', 'route': '/help', 'color': 0xFF00BCD4},
    {'icon': Icons.settings_outlined, 'title': 'الإعدادات', 'route': '/settings', 'color': 0xFF607D8B},
    {'icon': Icons.info_outline, 'title': 'عن التطبيق', 'route': '/about', 'color': 0xFF795548},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('المزيد', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _menuItems.length,
        itemBuilder: (context, index) {
          final item = _menuItems[index];
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, item['route']),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.binanceCard : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.binanceBorder),
              ),
              child: Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color(item['color'] as int).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(item['icon'], color: Color(item['color'] as int)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item['title'],
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
