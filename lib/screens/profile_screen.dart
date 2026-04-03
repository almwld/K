import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
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
import 'statistics_screen.dart';
import 'smart_support_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // إحصائيات المستخدم
  final Map<String, dynamic> _stats = {
    'totalSales': 1250000,
    'totalOrders': 48,
    'totalProducts': 12,
    'totalFollowers': 156,
    'totalReviews': 89,
    'averageRating': 4.8,
    'monthlyOrders': [5, 8, 12, 15, 10, 8],
    'monthlySales': [50000, 80000, 120000, 150000, 100000, 80000],
  };
  
  final List<Map<String, dynamic>> _profileMenu = [
    {'title': 'إعلاناتي', 'icon': Icons.post_add, 'color': 0xFF4CAF50, 'route': '/my_ads'},
    {'title': 'المفضلة', 'icon': Icons.favorite_border, 'color': 0xFFE91E63, 'route': '/favorites'},
    {'title': 'طلباتي', 'icon': Icons.shopping_bag_outlined, 'color': 0xFFFF9800, 'route': '/my_orders'},
    {'title': 'المتابعون', 'icon': Icons.people_outline, 'color': 0xFF2196F3, 'route': '/followers'},
    {'title': 'المراجعات', 'icon': Icons.rate_review, 'color': 0xFF9C27B0, 'route': '/reviews'},
    {'title': 'نقاطي', 'icon': Icons.stars, 'color': 0xFFD4AF37, 'route': '/garden'},
    {'title': 'الإحصائيات', 'icon': Icons.analytics, 'color': 0xFF00BCD4, 'route': '/statistics'},
    {'title': 'الإعدادات', 'icon': Icons.settings_outlined, 'color': 0xFF607D8B, 'route': '/settings'},
    {'title': 'عناويني', 'icon': Icons.location_on, 'color': 0xFF4CAF50, 'route': '/addresses'},
    {'title': 'طرق الدفع', 'icon': Icons.credit_card, 'color': 0xFF2196F3, 'route': '/saved_payment_methods'},
    {'title': 'المساعدة', 'icon': Icons.help_outline, 'color': 0xFF00BCD4, 'route': '/help_support'},
    {'title': 'الدعم الذكي', 'icon': Icons.smart_toy, 'color': 0xFF9C27B0, 'route': '/smart_support'},
    {'title': 'دعوة الأصدقاء', 'icon': Icons.share, 'color': 0xFF4CAF50, 'route': '/invite_friends'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authProvider = Provider.of<AuthProvider>(context);
    final userType = authProvider.userType ?? 'customer';
    final isMerchant = userType == 'merchant';

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Text('حسابي', style: TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold)),
              centerTitle: true,
              expandedHeight: 280,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppTheme.goldColor, AppTheme.goldLight],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            backgroundImage: authProvider.userAvatar != null
                                ? NetworkImage(authProvider.userAvatar!)
                                : null,
                            child: authProvider.userAvatar == null
                                ? const Icon(Icons.person, size: 45, color: AppTheme.goldColor)
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
                      const SizedBox(height: 12),
                      Text(
                        authProvider.userName ?? 'أحمد محمد',
                        style: const TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        authProvider.userEmail ?? 'ahmed@example.com',
                        style: const TextStyle(
                          fontFamily: 'Changa',
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // الإحصائيات السريعة
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildQuickStat('نقاطي', '1,250'),
                            _buildQuickStat('تقييم', '4.8'),
                            _buildQuickStat('متابع', '156'),
                            _buildQuickStat('إعلان', '12'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: Container(
                  color: AppTheme.getCardColor(context),
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: AppTheme.goldColor,
                    labelColor: AppTheme.goldColor,
                    unselectedLabelColor: AppTheme.getSecondaryTextColor(context),
                    tabs: const [
                      Tab(text: 'عام', icon: Icon(Icons.person)),
                      Tab(text: 'إحصائيات', icon: Icon(Icons.analytics)),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // تبويب عام - القائمة
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // بطاقة العضوية
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppTheme.goldColor, AppTheme.goldLight],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(isMerchant ? Icons.store : Icons.person, color: Colors.white),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isMerchant ? 'حساب تاجر' : 'حساب عميل',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                isMerchant ? 'يمكنك بيع المنتجات والخدمات' : 'يمكنك شراء المنتجات والخدمات',
                                style: TextStyle(color: Colors.white70, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text('موثق', style: TextStyle(color: Colors.white, fontSize: 10)),
                        ),
                      ],
                    ),
                  ),
                  // قائمة الإعدادات
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
                        onPressed: () => _showLogoutDialog(context),
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
            // تبويب الإحصائيات
            _buildStatisticsTab(context, isMerchant),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsTab(BuildContext context, bool isMerchant) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // بطاقات الإحصائيات الرئيسية
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              _buildStatCard('إجمالي المبيعات', '${(_stats['totalSales'] / 1000).toStringAsFixed(0)}K ر.ي', Icons.trending_up, Colors.green),
              _buildStatCard('إجمالي الطلبات', '${_stats['totalOrders']}', Icons.shopping_bag, Colors.blue),
              _buildStatCard('المنتجات', '${_stats['totalProducts']}', Icons.inventory, Colors.orange),
              _buildStatCard('المتابعين', '${_stats['totalFollowers']}', Icons.people, Colors.purple),
              _buildStatCard('المراجعات', '${_stats['totalReviews']}', Icons.rate_review, Colors.teal),
              _buildStatCard('متوسط التقييم', '${_stats['averageRating']}', Icons.star, Colors.amber),
            ],
          ),
          const SizedBox(height: 24),
          
          // الرسم البياني للطلبات الشهرية
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.getCardColor(context),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('الطلبات الشهرية', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 20,
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const months = ['أكت', 'نوف', 'ديس', 'ينا', 'فبر', 'مار'];
                              if (value.toInt() >= 0 && value.toInt() < months.length) {
                                return Text(months[value.toInt()], style: const TextStyle(fontSize: 10));
                              }
                              return const Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true, reservedSize: 30),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: _stats['monthlyOrders'].asMap().entries.map((entry) {
                        return BarChartGroupData(
                          x: entry.key,
                          barRods: [
                            BarChartRodData(
                              toY: entry.value.toDouble(),
                              color: AppTheme.goldColor,
                              width: 20,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // الرسم البياني للمبيعات الشهرية
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.getCardColor(context),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('المبيعات الشهرية', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const months = ['أكت', 'نوف', 'ديس', 'ينا', 'فبر', 'مار'];
                              if (value.toInt() >= 0 && value.toInt() < months.length) {
                                return Text(months[value.toInt()], style: const TextStyle(fontSize: 10));
                              }
                              return const Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                        ),
                      ),
                      borderData: FlBorderData(show: true),
                      lineBarsData: [
                        LineChartBarData(
                          spots: _stats['monthlySales'].asMap().entries.map((entry) {
                            return FlSpot(entry.key.toDouble(), entry.value.toDouble());
                          }).toList(),
                          isCurved: true,
                          color: AppTheme.goldColor,
                          barWidth: 3,
                          dotData: FlDotData(show: true),
                          belowBarData: BarAreaData(
                            show: true,
                            color: AppTheme.goldColor.withOpacity(0.1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // زر عرض الإحصائيات التفصيلية
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/statistics'),
              icon: const Icon(Icons.analytics),
              label: const Text('عرض الإحصائيات التفصيلية'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.goldColor,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Changa',
            fontSize: 18,
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.getSecondaryTextColor(context),
            ),
          ),
        ],
      ),
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
