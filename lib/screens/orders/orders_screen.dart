import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _orders = [
    {'id': '#12345', 'status': 'قيد التجهيز', 'date': '2024-01-15', 'total': '350 ريال', 'items': 2, 'color': const Color(0xFFFF9800)},
    {'id': '#12344', 'status': 'تم الشحن', 'date': '2024-01-14', 'total': '1,200 ريال', 'items': 1, 'color': const Color(0xFF2196F3)},
    {'id': '#12343', 'status': 'تم التوصيل', 'date': '2024-01-10', 'total': '500 ريال', 'items': 3, 'color': const Color(0xFF0ECB81)},
    {'id': '#12342', 'status': 'ملغي', 'date': '2024-01-05', 'total': '200 ريال', 'items': 1, 'color': const Color(0xFFF6465D)},
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
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        title: const Text('طلباتي', style: TextStyle(color: Colors.white)),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: const Color(0xFFD4AF37),
          unselectedLabelColor: const Color(0xFF9CA3AF),
          indicatorColor: const Color(0xFFD4AF37),
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
          _buildOrdersList(_orders.where((o) => o['status'] == 'قيد التجهيز').toList()),
          _buildOrdersList(_orders.where((o) => o['status'] == 'تم الشحن').toList()),
          _buildOrdersList(_orders.where((o) => o['status'] == 'تم التوصيل').toList()),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<Map<String, dynamic>> orders) {
    if (orders.isEmpty) {
      return const Center(child: Text('لا توجد طلبات', style: TextStyle(color: Color(0xFF9CA3AF))));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2329),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(order['id'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (order['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      order['status'],
                      style: TextStyle(color: order['color'], fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today, color: Color(0xFF9CA3AF), size: 14),
                  const SizedBox(width: 4),
                  Text(order['date'], style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                  const Spacer(),
                  Text('${order['items']} منتجات', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                ],
              ),
              const Divider(color: Color(0xFF2B3139)),
              Row(
                children: [
                  const Text('الإجمالي:', style: TextStyle(color: Color(0xFF9CA3AF))),
                  const SizedBox(width: 8),
                  Text(order['total'], style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text('تتبع الطلب', style: TextStyle(color: Color(0xFFD4AF37))),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
