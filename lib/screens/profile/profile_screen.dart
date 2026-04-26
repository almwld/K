import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../following_screen.dart';
import '../orders/orders_screen.dart';
import '../favorites_screen.dart';
import '../wallet/wallet_screen.dart';
import '../addresses_screen.dart';
import '../notifications_screen.dart';
import '../chat/chat_screen.dart';
import '../help_support_screen.dart';
import '../settings/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<String, dynamic> _user = {
    'name': 'أحمد محمد',
    'email': 'ahmed@flexyemen.com',
    'phone': '+967 777 123 456',
    'avatar': 'https://randomuser.me/api/portraits/men/1.jpg',
    'cover': 'https://images.unsplash.com/photo-1557682250-33bd709cbe85?w=600',
    'level': 'ذهبي',
    'points': 1250,
  };

  final List<Map<String, dynamic>> _stats = [
    {'value': '24', 'label': 'طلبات', 'icon': Icons.shopping_bag_outlined, 'color': AppTheme.binanceGold, 'route': '/orders'},
    {'value': '12', 'label': 'متابِع', 'icon': Icons.people_outline, 'color': AppTheme.binanceGreen, 'route': '/followers'},
    {'value': '156', 'label': 'متابَع', 'icon': Icons.person_add_alt_rounded, 'color': AppTheme.serviceBlue, 'route': '/following'},
    {'value': '4.8', 'label': 'تقييم', 'icon': Icons.star_outline, 'color': Colors.amber, 'route': '/reviews'},
  ];

  final List<Map<String, dynamic>> _menuItems = [
    {'icon': Icons.shopping_bag_outlined, 'title': 'طلباتي', 'subtitle': 'عرض جميع طلباتك', 'screen': const OrdersScreen(), 'badge': 3},
    {'icon': Icons.favorite_border, 'title': 'المفضلة', 'subtitle': 'منتجاتك المفضلة', 'screen': const FavoritesScreen(), 'badge': null},
    {'icon': Icons.people_outline, 'title': 'المتابعات', 'subtitle': 'المتاجر التي تتابعها', 'screen': const FollowingScreen(), 'badge': null},
    {'icon': Icons.account_balance_wallet_outlined, 'title': 'المحفظة', 'subtitle': 'رصيدك الحالي: 2,500 ريال', 'screen': const WalletScreen(), 'badge': null},
    {'icon': Icons.location_on_outlined, 'title': 'العناوين', 'subtitle': 'إدارة عناوين الشحن', 'screen': const AddressesScreen(), 'badge': null},
    {'icon': Icons.notifications_none, 'title': 'الإشعارات', 'subtitle': 'آخر الإشعارات', 'screen': const NotificationsScreen(), 'badge': 5},
    {'icon': Icons.chat_bubble_outline, 'title': 'الدردشة', 'subtitle': 'تواصل مع البائعين', 'screen': const ChatScreen(), 'badge': 2},
    {'icon': Icons.help_outline, 'title': 'مركز المساعدة', 'subtitle': 'الأسئلة الشائعة والدعم', 'screen': const HelpSupportScreen(), 'badge': null},
    {'icon': Icons.settings_outlined, 'title': 'الإعدادات', 'subtitle': 'اللغة، المظهر، الخصوصية', 'screen': const SettingsScreen(), 'badge': null},
    {'icon': Icons.logout, 'title': 'تسجيل الخروج', 'subtitle': '', 'screen': null, 'badge': null, 'isLogout': true},
  ];

  void _navigateTo(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.binanceCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تسجيل الخروج', style: TextStyle(color: Colors.white)),
        content: const Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟', style: TextStyle(color: Color(0xFF9CA3AF))),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء', style: TextStyle(color: Color(0xFF9CA3AF)))),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم تسجيل الخروج بنجاح'), backgroundColor: AppTheme.binanceGreen),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceRed),
            child: const Text('تسجيل خروج', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      body: CustomScrollView(
        slivers: [
          _buildCoverAndAvatar(),
          SliverToBoxAdapter(child: _buildUserInfo()),
          SliverToBoxAdapter(child: _buildStats()),
          SliverToBoxAdapter(child: _buildVipCard()),
          SliverToBoxAdapter(child: _buildMenuItems()),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildCoverAndAvatar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: AppTheme.binanceDark,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(_user['cover'] as String, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: AppTheme.binanceCard)),
            Container(color: Colors.black.withOpacity(0.3)),
            Positioned(
              bottom: -40,
              left: 16,
              child: Container(
                width: 90, height: 90,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppTheme.binanceGold, width: 3)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(45),
                  child: Image.network(_user['avatar'] as String, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: AppTheme.binanceGold.withOpacity(0.2), child: const Icon(Icons.person, color: AppTheme.binanceGold, size: 45))),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(icon: const Icon(Icons.edit, color: Colors.white), onPressed: () {}),
        IconButton(icon: const Icon(Icons.qr_code_scanner, color: Colors.white), onPressed: () {}),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 56, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_user['name'] as String, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(_user['email'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13)),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: AppTheme.binanceGold.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                child: Row(children: [const Icon(Icons.workspace_premium, color: AppTheme.binanceGold, size: 14), const SizedBox(width: 4), Text('عضو ${_user['level']}', style: const TextStyle(color: AppTheme.binanceGold, fontSize: 11))])),
              const SizedBox(width: 8),
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: AppTheme.binanceGreen.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                child: Row(children: [const Icon(Icons.stars, color: AppTheme.binanceGreen, size: 14), const SizedBox(width: 4), Text('${_user['points']} نقطة', style: const TextStyle(color: AppTheme.binanceGreen, fontSize: 11))])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF1E2329), Color(0xFF16213E)]), borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _stats.map((stat) => GestureDetector(
          onTap: () {
            if (stat['route'] != null && stat['label'] == 'متابَع') {
              _navigateTo(const FollowingScreen());
            }
          },
          child: Column(children: [
            Icon(stat['icon'] as IconData, color: stat['color'] as Color, size: 24),
            const SizedBox(height: 8),
            Text(stat['value'] as String, style: TextStyle(color: stat['color'] as Color, fontSize: 20, fontWeight: FontWeight.bold)),
            Text(stat['label'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
          ]),
        )).toList(),
      ),
    );
  }

  Widget _buildVipCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(gradient: AppTheme.goldGradient, borderRadius: BorderRadius.circular(20)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), shape: BoxShape.circle), child: const Icon(Icons.workspace_premium, color: Colors.white, size: 32)),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('عرض VIP حصري', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                Text('خصم 25% إضافي للأعضاء + شحن مجاني', style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 12)),
              ])),
              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(20)), child: const Text('ترقية', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItems() {
    return Column(
      children: List.generate(_menuItems.length, (i) {
        final item = _menuItems[i];
        final isLogout = item['isLogout'] == true;
        return ListTile(
          leading: Container(width: 40, height: 40, decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12)), child: Icon(item['icon'] as IconData, color: isLogout ? AppTheme.binanceRed : AppTheme.binanceGold)),
          title: Text(item['title'] as String, style: TextStyle(color: isLogout ? AppTheme.binanceRed : Colors.white, fontWeight: FontWeight.w500)),
          subtitle: item['subtitle'].toString().isNotEmpty ? Text(item['subtitle'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)) : null,
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            if (item['badge'] != null) Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppTheme.binanceRed, borderRadius: BorderRadius.circular(10)), child: Text('${item['badge']}', style: const TextStyle(color: Colors.white, fontSize: 10))),
            const SizedBox(width: 8),
            Icon(isLogout ? Icons.logout : Icons.arrow_forward_ios, color: const Color(0xFF5E6673), size: 16),
          ]),
          onTap: () {
            if (isLogout) {
              _showLogoutDialog();
            } else if (item['screen'] != null) {
              _navigateTo(item['screen'] as Widget);
            }
          },
        );
      }),
    );
  }
}
