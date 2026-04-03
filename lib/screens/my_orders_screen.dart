import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'order_detail_screen.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> _orders = [];
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadOrders();
  }
  
  void _loadOrders() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _orders = [
          {'id': '#1234', 'status': 'pending', 'statusText': 'قيد المراجعة', 'date': '2026-04-03', 'total': 450000, 'items': 2, 'seller': 'متجر التقنية'},
          {'id': '#1233', 'status': 'shipped', 'statusText': 'تم الشحن', 'date': '2026-04-02', 'total': 380000, 'items': 1, 'seller': 'متجر التقنية'},
          {'id': '#1232', 'status': 'delivered', 'statusText': 'تم التوصيل', 'date': '2026-04-01', 'total': 120000, 'items': 3, 'seller': 'متجر الأزياء'},
          {'id': '#1231', 'status': 'cancelled', 'statusText': 'ملغي', 'date': '2026-03-31', 'total': 25000, 'items': 1, 'seller': 'مطعم الأصيل'},
        ];
        _isLoading = false;
      });
    });
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending': return Colors.orange;
      case 'shipped': return Colors.blue;
      case 'delivered': return Colors.green;
      case 'cancelled': return Colors.red;
      default: return Colors.grey;
    }
  }
  
  List<Map<String, dynamic>> _getFilteredOrders(String status) {
    if (status == 'all') return _orders;
    return _orders.where((o) => o['status'] == status).toList();
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'طلباتي'),
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
                      Tab(text: 'الكل'),
                      Tab(text: 'قيد المراجعة'),
                      Tab(text: 'تم الشحن'),
                      Tab(text: 'تم التوصيل'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildOrdersList(_getFilteredOrders('all')),
                      _buildOrdersList(_getFilteredOrders('pending')),
                      _buildOrdersList(_getFilteredOrders('shipped')),
                      _buildOrdersList(_getFilteredOrders('delivered')),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
  
  Widget _buildOrdersList(List<Map<String, dynamic>> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined, size: 80, color: AppTheme.goldColor.withOpacity(0.5)),
            const SizedBox(height: 16),
            const Text('لا توجد طلبات', style: TextStyle(fontSize: 18)),
          ],
        ),
      );
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
            color: AppTheme.getCardColor(context),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(order['id'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order['status']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(order['statusText'], style: TextStyle(color: _getStatusColor(order['status']), fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 60, height: 60,
                    decoration: BoxDecoration(
                      color: AppTheme.goldColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.image, color: AppTheme.goldColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('البائع: ${order['seller']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('${order['items']} منتجات'),
                        Text(order['date'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('${order['total']} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.goldColor)),
                      const SizedBox(height: 4),
                      if (order['status'] == 'shipped')
                        TextButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderDetailScreen())),
                          child: const Text('تتبع'),
                        ),
                    ],
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
