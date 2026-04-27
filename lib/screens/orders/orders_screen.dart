import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../order_detail_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _orders = [
    {'id': 'ORD-001', 'date': '2024-04-20', 'total': 350000, 'status': 'delivered', 'statusText': 'تم التوصيل', 'items': 2, 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=100'},
    {'id': 'ORD-002', 'date': '2024-04-18', 'total': 45000, 'status': 'shipped', 'statusText': 'تم الشحن', 'items': 1, 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=100'},
    {'id': 'ORD-003', 'date': '2024-04-15', 'total': 150000, 'status': 'pending', 'statusText': 'قيد المعالجة', 'items': 3, 'image': 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=100'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('طلباتي', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.binanceGold,
          unselectedLabelColor: const Color(0xFF9CA3AF),
          indicatorColor: AppTheme.binanceGold,
          tabs: const [
            Tab(text: 'الكل'),
            Tab(text: 'قيد التجهيز'),
            Tab(text: 'تم الشحن'),
            Tab(text: 'تم التوصيل'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrdersList(_orders),
          _buildOrdersList(_orders.where((o) => o['status'] == 'pending').toList()),
          _buildOrdersList(_orders.where((o) => o['status'] == 'shipped').toList()),
          _buildOrdersList(_orders.where((o) => o['status'] == 'delivered').toList()),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<Map<String, dynamic>> orders) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox, size: 80, color: AppTheme.binanceGold.withOpacity(0.3)),
            const SizedBox(height: 16),
            const Text('لا توجد طلبات', style: TextStyle(color: Color(0xFF9CA3AF))),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) => _buildOrderCard(orders[index], isDark),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order, bool isDark) {
    Color statusColor;
    IconData statusIcon;
    switch (order['status'] as String) {
      case 'delivered':
        statusColor = AppTheme.binanceGreen;
        statusIcon = Icons.check_circle;
        break;
      case 'shipped':
        statusColor = AppTheme.serviceBlue;
        statusIcon = Icons.local_shipping;
        break;
      default:
        statusColor = AppTheme.serviceOrange;
        statusIcon = Icons.hourglass_empty;
    }

    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OrderDetailScreen(orderId: order['id']))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.binanceCard : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.binanceBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(order['image'], width: 50, height: 50, fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(order['id'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text(order['date'], style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Icon(statusIcon, color: statusColor, size: 12),
                      const SizedBox(width: 4),
                      Text(order['statusText'], style: TextStyle(color: statusColor, fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(color: AppTheme.binanceBorder),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${order['items']} منتجات', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                Text('${order['total']} ريال', style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(side: BorderSide(color: AppTheme.binanceGold), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    child: const Text('تتبع الطلب', style: TextStyle(color: AppTheme.binanceGold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceGold, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    child: const Text('تقييم', style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
