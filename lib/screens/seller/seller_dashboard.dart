import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class SellerDashboard extends StatelessWidget {
  const SellerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'لوحة تحكم البائع'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Stats Cards
            _buildStatsCards(context),

            const SizedBox(height: 24),

            // Quick Actions
            _buildQuickActions(context),

            const SizedBox(height: 24),

            // Recent Orders
            _buildRecentOrders(context),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCards(BuildContext context) {
    final stats = [
      {'title': 'المبيعات', 'value': '1.2M', 'icon': Icons.trending_up, 'color': Colors.green},
      {'title': 'الطلبات', 'value': '156', 'icon': Icons.shopping_bag, 'color': Colors.blue},
      {'title': 'المنتجات', 'value': '48', 'icon': Icons.inventory, 'color': Colors.orange},
      {'title': 'التقييم', 'value': '4.8', 'icon': Icons.star, 'color': Colors.amber},
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: stats.length,
        itemBuilder: (context, index) {
          final stat = stats[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.getCardColor(context),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(stat['icon'] as IconData, color: stat['color'] as Color),
                const Spacer(),
                Text(
                  stat['value'] as String,
                  style: TextStyle(
                    fontFamily: 'Changa',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.getTextColor(context),
                  ),
                ),
                Text(
                  stat['title'] as String,
                  style: TextStyle(
                    color: AppTheme.getSecondaryTextColor(context),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      {'icon': Icons.add_box, 'title': 'إضافة منتج', 'route': '/seller_products'},
      {'icon': Icons.assignment, 'title': 'الطلبات', 'route': '/seller_orders'},
      {'icon': Icons.analytics, 'title': 'التحليلات', 'route': '/seller_analytics'},
      {'icon': Icons.account_balance_wallet, 'title': 'الأرباح', 'route': '/seller_payouts'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'إجراءات سريعة',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: actions.map((action) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, action['route'] as String),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.goldColor, AppTheme.goldLight],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(action['icon'] as IconData, color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    Text(action['title'] as String),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildRecentOrders(BuildContext context) {
    final orders = [
      {'id': '#1234', 'product': 'آيفون 14', 'status': 'مكتمل', 'amount': 350000},
      {'id': '#1235', 'product': 'سامسونج S23', 'status': 'قيد التجهيز', 'amount': 280000},
      {'id': '#1236', 'product': 'آيباد برو', 'status': 'معلق', 'amount': 420000},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'آخر الطلبات',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/seller_orders'),
                child: const Text('عرض الكل', style: TextStyle(color: AppTheme.goldColor)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...orders.map((order) {
            Color statusColor = Colors.grey;
            if (order['status'] == 'مكتمل') statusColor = Colors.green;
            if (order['status'] == 'قيد التجهيز') statusColor = Colors.orange;
            if (order['status'] == 'معلق') statusColor = Colors.red;

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.getCardColor(context),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.goldColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.shopping_bag, color: AppTheme.goldColor),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order['product'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.getTextColor(context),
                          ),
                        ),
                        Text(
                          order['id'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.getSecondaryTextColor(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${order['amount']} ر.ي',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.goldColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          order['status'] as String,
                          style: TextStyle(
                            fontSize: 10,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms);
  }
}
