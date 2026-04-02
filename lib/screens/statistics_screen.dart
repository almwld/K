import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../services/statistics_service.dart';
import '../providers/auth_provider.dart';
import '../models/statistics_model.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final StatisticsService _statsService = StatisticsService();
  StatisticsModel _stats = StatisticsModel.empty();
  Map<String, dynamic> _userStats = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    setState(() => _isLoading = true);
    final userId = context.read<AuthProvider>().userData?.id ?? 'guest';
    _stats = await _statsService.getGeneralStatistics(userId);
    _userStats = await _statsService.getUserStatistics(userId);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'التقارير والإحصائيات'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  color: AppTheme.getCardColor(context),
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: AppTheme.goldColor,
                    labelColor: AppTheme.goldColor,
                    unselectedLabelColor: AppTheme.getSecondaryTextColor(context),
                    tabs: const [
                      Tab(text: 'الإحصائيات العامة', icon: Icon(Icons.dashboard)),
                      Tab(text: 'إحصائياتي الشخصية', icon: Icon(Icons.person)),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildGeneralStats(),
                      _buildPersonalStats(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildGeneralStats() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildStatsCards(),
          const SizedBox(height: 24),
          _buildSalesChart(),
          const SizedBox(height: 24),
          _buildCategoryStats(),
          const SizedBox(height: 24),
          _buildCityStats(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildPersonalStats() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildUserCards(),
          const SizedBox(height: 24),
          _buildSpendingChart(),
          const SizedBox(height: 24),
          _buildRecentOrders(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    final cards = [
      {'title': 'إجمالي المنتجات', 'value': '${_stats.totalProducts}', 'icon': Icons.inventory, 'color': 0xFF4CAF50},
      {'title': 'إجمالي الطلبات', 'value': '${_stats.totalOrders}', 'icon': Icons.shopping_bag, 'color': 0xFF2196F3},
      {'title': 'إجمالي المبيعات', 'value': '${_stats.totalSales.toStringAsFixed(0)} ر.ي', 'icon': Icons.trending_up, 'color': 0xFFFF9800},
      {'title': 'المستخدمين', 'value': '${_stats.totalUsers}', 'icon': Icons.people, 'color': 0xFF9C27B0},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return Container(
          padding: const EdgeInsets.all(16),
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
                  color: Color(card['color']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(card['icon'], color: Color(card['color']), size: 24),
              ),
              const Spacer(),
              Text(card['value'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(card['title'], style: TextStyle(fontSize: 12, color: AppTheme.getSecondaryTextColor(context))),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserCards() {
    final cards = [
      {'title': 'إجمالي الطلبات', 'value': '${_userStats['totalOrders'] ?? 0}', 'icon': Icons.shopping_bag, 'color': 0xFF2196F3},
      {'title': 'إجمالي الإنفاق', 'value': '${(_userStats['totalSpent'] ?? 0).toStringAsFixed(0)} ر.ي', 'icon': Icons.money, 'color': 0xFFFF9800},
      {'title': 'المفضلة', 'value': '${_userStats['totalFavorites'] ?? 0}', 'icon': Icons.favorite, 'color': 0xFFE91E63},
      {'title': 'رصيد المحفظة', 'value': '${(_userStats['walletBalance'] ?? 0).toStringAsFixed(0)} ر.ي', 'icon': Icons.account_balance_wallet, 'color': 0xFF4CAF50},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return Container(
          padding: const EdgeInsets.all(16),
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
                  color: Color(card['color']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(card['icon'], color: Color(card['color']), size: 24),
              ),
              const Spacer(),
              Text(card['value'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(card['title'], style: TextStyle(fontSize: 12, color: AppTheme.getSecondaryTextColor(context))),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSalesChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('المبيعات', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Center(
            child: Text(
              '${_stats.totalSales.toStringAsFixed(0)} ر.ي',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.goldColor),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'إجمالي المبيعات',
              style: TextStyle(color: AppTheme.getSecondaryTextColor(context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpendingChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('إجمالي إنفاقي', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Center(
            child: Text(
              '${(_userStats['totalSpent'] ?? 0).toStringAsFixed(0)} ر.ي',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.goldColor),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'إجمالي المشتريات',
              style: TextStyle(color: AppTheme.getSecondaryTextColor(context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryStats() {
    if (_stats.categoryStats.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.getCardColor(context),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(child: Text('لا توجد بيانات كافية')),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('أفضل الفئات مبيعاً', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ..._stats.categoryStats.take(5).map((stat) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  SizedBox(width: 80, child: Text(stat.category, style: const TextStyle(fontSize: 12))),
                  const SizedBox(width: 8),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: stat.percentage / 100,
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      color: AppTheme.goldColor,
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('${stat.percentage.toStringAsFixed(1)}%', style: const TextStyle(fontSize: 12)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCityStats() {
    if (_stats.cityStats.isEmpty) {
      return const SizedBox();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('المدن الأكثر طلباً', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ..._stats.cityStats.take(5).map((stat) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  SizedBox(width: 80, child: Text(stat.city, style: const TextStyle(fontSize: 12))),
                  const Spacer(),
                  Text('${stat.orders} طلب', style: const TextStyle(fontSize: 12, color: AppTheme.goldColor)),
                  const SizedBox(width: 8),
                  Text('${stat.revenue.toStringAsFixed(0)} ر.ي', style: const TextStyle(fontSize: 12)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRecentOrders() {
    final orders = _userStats['recentOrders'] ?? [];
    if (orders.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.getCardColor(context),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(child: Text('لا توجد طلبات سابقة')),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('آخر الطلبات', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ...orders.map((order) {
            return ListTile(
              leading: const Icon(Icons.shopping_bag, color: AppTheme.goldColor),
              title: Text(order['product_title'] ?? 'منتج'),
              subtitle: Text(order['created_at']?.toString().substring(0, 10) ?? ''),
              trailing: Text('${order['total_price']} ر.ي', style: const TextStyle(color: AppTheme.goldColor)),
            );
          }),
        ],
      ),
    );
  }
}
