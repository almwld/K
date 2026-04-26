import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class OrdersStatsScreen extends StatelessWidget {
  const OrdersStatsScreen({super.key});

  final List<Map<String, dynamic>> _orders = const [
    {'id': 'ORD-001', 'date': '2024-04-20', 'total': 350000, 'status': 'delivered', 'statusText': 'تم التوصيل', 'items': 2},
    {'id': 'ORD-002', 'date': '2024-04-18', 'total': 45000, 'status': 'shipped', 'statusText': 'تم الشحن', 'items': 1},
    {'id': 'ORD-003', 'date': '2024-04-15', 'total': 150000, 'status': 'pending', 'statusText': 'قيد المعالجة', 'items': 3},
    {'id': 'ORD-004', 'date': '2024-04-10', 'total': 250000, 'status': 'delivered', 'statusText': 'تم التوصيل', 'items': 4},
    {'id': 'ORD-005', 'date': '2024-04-05', 'total': 80000, 'status': 'cancelled', 'statusText': 'ملغي', 'items': 2},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final totalOrders = _orders.length;
    final totalSpent = _orders.fold(0, (sum, o) => sum + o['total'] as int);
    final deliveredCount = _orders.where((o) => o['status'] == 'delivered').length;
    final pendingCount = _orders.where((o) => o['status'] == 'pending').length;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('طلباتي', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      ),
      body: Column(
        children: [
          // إحصائيات سريعة
          Container(
            margin: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildStatCard('إجمالي الطلبات', '$totalOrders', Icons.shopping_bag, AppTheme.binanceGold),
                const SizedBox(width: 12),
                _buildStatCard('إجمالي المشتريات', '$totalSpent ريال', Icons.money, AppTheme.binanceGreen),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildStatCard('تم التوصيل', '$deliveredCount', Icons.check_circle, Colors.green),
                const SizedBox(width: 12),
                _buildStatCard('قيد المعالجة', '$pendingCount', Icons.hourglass_empty, Colors.orange),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('جميع الطلبات', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('آخر 30 يوم', style: TextStyle(color: AppTheme.binanceGold)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _orders.length,
              itemBuilder: (context, index) => _buildOrderCard(_orders[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark ? AppTheme.binanceCard : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.binanceBorder),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    Color statusColor;
    switch (order['status'] as String) {
      case 'delivered': statusColor = AppTheme.binanceGreen; break;
      case 'shipped': statusColor = AppTheme.serviceBlue; break;
      case 'pending': statusColor = AppTheme.serviceOrange; break;
      default: statusColor = AppTheme.binanceRed;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? AppTheme.binanceCard : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.binanceBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order['id'], style: const TextStyle(fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(order['statusText'], style: TextStyle(color: statusColor, fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${order['items']} منتجات', style: const TextStyle(color: Colors.grey)),
              Text('${order['total']} ريال', style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Text(order['date'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }
}
