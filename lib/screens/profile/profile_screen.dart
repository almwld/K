import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final Map<String, dynamic> _user = {
    'name': 'أحمد محمد',
    'email': 'ahmed@flexyemen.com',
    'phone': '+967 777 123 456',
    'avatar': 'https://randomuser.me/api/portraits/men/1.jpg',
    'cover': 'https://images.unsplash.com/photo-1557682250-33bd709cbe85?w=600',
    'joinDate': '2024-01-15',
    'level': 'ذهبي',
    'points': 1250,
  };

  final List<Map<String, dynamic>> _stats = [
    {'value': '24', 'label': 'طلبات', 'icon': Icons.shopping_bag_outlined, 'color': AppTheme.binanceGold},
    {'value': '12', 'label': 'متابِع', 'icon': Icons.people_outline, 'color': AppTheme.binanceGreen},
    {'value': '156', 'label': 'متابَع', 'icon': Icons.person_add_alt_outlined, 'color': AppTheme.serviceBlue},
    {'value': '4.8', 'label': 'تقييم', 'icon': Icons.star_outline, 'color': Colors.amber},
  ];

  final List<Map<String, dynamic>> _menuItems = [
    {'icon': Icons.shopping_bag_outlined, 'title': 'طلباتي', 'subtitle': 'عرض جميع طلباتك', 'route': '/orders', 'badge': 3},
    {'icon': Icons.favorite_border, 'title': 'المفضلة', 'subtitle': 'منتجاتك المفضلة', 'route': '/favorites', 'badge': null},
    {'icon': Icons.account_balance_wallet_outlined, 'title': 'المحفظة', 'subtitle': 'رصيدك الحالي: 2,500 ريال', 'route': '/wallet', 'badge': null},
    {'icon': Icons.location_on_outlined, 'title': 'العناوين', 'subtitle': 'إدارة عناوين الشحن', 'route': '/addresses', 'badge': null},
    {'icon': Icons.notifications_none, 'title': 'الإشعارات', 'subtitle': 'آخر الإشعارات', 'route': '/notifications', 'badge': 5},
    {'icon': Icons.chat_bubble_outline, 'title': 'الدردشة', 'subtitle': 'تواصل مع البائعين', 'route': '/chat', 'badge': 2},
    {'icon': Icons.settings_outlined, 'title': 'الإعدادات', 'subtitle': 'اللغة، المظهر، الخصوصية', 'route': '/settings', 'badge': null},
    {'icon': Icons.help_outline, 'title': 'مركز المساعدة', 'subtitle': 'الأسئلة الشائعة والدعم', 'route': '/help', 'badge': null},
    {'icon': Icons.logout, 'title': 'تسجيل الخروج', 'subtitle': '', 'route': '/logout', 'badge': null, 'isLogout': true},
  ];

  final List<Map<String, dynamic>> _achievements = [
    {'icon': Icons.emoji_events, 'title': 'أول عملية شراء', 'points': 100, 'completed': true, 'color': AppTheme.binanceGold},
    {'icon': Icons.store, 'title': 'بائع محترف', 'points': 250, 'completed': false, 'color': AppTheme.serviceBlue, 'progress': 0.7},
    {'icon': Icons.star, 'title': 'نجم التقييمات', 'points': 500, 'completed': false, 'color': Colors.amber, 'progress': 0.4},
    {'icon': Icons.people, 'title': 'الوصول إلى 1000 متابع', 'points': 1000, 'completed': false, 'color': AppTheme.binanceGreen, 'progress': 0.25},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
          SliverToBoxAdapter(child: _buildAchievements()),
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
            Image.network(
              _user['cover'] as String,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: AppTheme.binanceCard),
            ),
            Container(color: Colors.black.withOpacity(0.3)),
            Positioned(
              bottom: -40,
              left: 16,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.binanceGold, width: 3),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10)],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(45),
                    child: Image.network(
                      _user['avatar'] as String,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(color: AppTheme.binanceGold.withOpacity(0.2), child: const Icon(Icons.person, color: AppTheme.binanceGold, size: 45)),
                    ),
                  ),
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
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppTheme.binanceGold.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      const Icon(Icons.workspace_premium, color: AppTheme.binanceGold, size: 14),
                      const SizedBox(width: 4),
                      Text('عضو ${_user['level']}', style: const TextStyle(color: AppTheme.binanceGold, fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppTheme.binanceGreen.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      const Icon(Icons.stars, color: AppTheme.binanceGreen, size: 14),
                      const SizedBox(width: 4),
                      Text('${_user['points']} نقطة', style: const TextStyle(color: AppTheme.binanceGreen, fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStats() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF1E2329), Color(0xFF16213E)]),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.binanceBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _stats.map((stat) => Column(
            children: [
              Icon(stat['icon'] as IconData, color: stat['color'] as Color, size: 24),
              const SizedBox(height: 8),
              Text(stat['value'] as String, style: TextStyle(color: stat['color'] as Color, fontSize: 20, fontWeight: FontWeight.bold)),
              Text(stat['label'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
            ],
          )).toList(),
        ),
      ),
    );
  }

  Widget _buildVipCard() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFB8962E), Color(0xFFF4E4A6)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), shape: BoxShape.circle),
                    child: const Icon(Icons.workspace_premium, color: Colors.white, size: 32),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('عرض VIP حصري', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('خصم 25% إضافي للأعضاء + شحن مجاني', style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 12)),
                        const SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: 0.65,
                          backgroundColor: Colors.black.withOpacity(0.2),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        const SizedBox(height: 2),
                        Text('نقطة واحدة تفصلك عن الـ VIP', style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 10)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                    child: const Text('ترقية', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAchievements() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('🏆 الإنجازات', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _achievements.length,
              itemBuilder: (_, i) => Container(
                width: 140,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.binanceCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _achievements[i]['completed'] == true ? AppTheme.binanceGold : AppTheme.binanceBorder),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(color: (_achievements[i]['color'] as Color).withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                      child: Icon(_achievements[i]['icon'] as IconData, color: _achievements[i]['color'] as Color),
                    ),
                    const SizedBox(height: 8),
                    Text(_achievements[i]['title'] as String, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold), maxLines: 2, textAlign: TextAlign.center),
                    const SizedBox(height: 4),
                    if (_achievements[i]['completed'] == true)
                      const Icon(Icons.check_circle, color: AppTheme.binanceGreen, size: 16)
                    else if (_achievements[i]['progress'] != null)
                      LinearProgressIndicator(value: _achievements[i]['progress'] as double, backgroundColor: AppTheme.binanceBorder, color: AppTheme.binanceGold, borderRadius: BorderRadius.circular(4)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: List.generate(_menuItems.length, (i) {
          final item = _menuItems[i];
          final isLogout = item['isLogout'] == true;
          return ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12)),
              child: Icon(item['icon'] as IconData, color: isLogout ? AppTheme.binanceRed : AppTheme.binanceGold),
            ),
            title: Text(item['title'] as String, style: TextStyle(color: isLogout ? AppTheme.binanceRed : Colors.white, fontWeight: FontWeight.w500)),
            subtitle: item['subtitle'].toString().isNotEmpty ? Text(item['subtitle'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)) : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item['badge'] != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: AppTheme.binanceRed, borderRadius: BorderRadius.circular(10)),
                    child: Text('${item['badge']}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                const SizedBox(width: 8),
                Icon(isLogout ? Icons.logout : Icons.arrow_forward_ios, color: const Color(0xFF5E6673), size: 16),
              ],
            ),
            onTap: () {
              if (isLogout) {
                _showLogoutDialog();
              } else {
                // Navigator.pushNamed(context, item['route'] as String);
              }
            },
          );
        }),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppTheme.binanceCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تسجيل الخروج', style: TextStyle(color: Colors.white)),
        content: const Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟', style: TextStyle(color: Color(0xFF9CA3AF))),
        actions: [
          TextButton(onPressed: () => Navigator.pop(_), child: const Text('إلغاء', style: TextStyle(color: Color(0xFF9CA3AF)))),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(_);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم تسجيل الخروج بنجاح'), backgroundColor: AppTheme.binanceGreen));
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceRed),
            child: const Text('تسجيل خروج', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
