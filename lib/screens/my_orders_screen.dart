import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> orders = [
    {
      'id': '#1234',
      'status': 'pending',
      'statusText': 'قيد الانتظار',
      'date': '2024-03-29',
      'total': 350000,
      'items': 2,
      'seller': 'متجر التقنية',
    },
    {
      'id': '#1233',
      'status': 'shipped',
      'statusText': 'تم الشحن',
      'date': '2024-03-28',
      'total': 120000,
      'items': 1,
      'seller': 'متجر الأزياء',
    },
    {
      'id': '#1232',
      'status': 'delivered',
      'statusText': 'تم التوصيل',
      'date': '2024-03-25',
      'total': 50000,
      'items': 3,
      'seller': 'متجر المنزل',
    },
    {
      'id': '#1231',
      'status': 'cancelled',
      'statusText': 'ملغي',
      'date': '2024-03-20',
      'total': 75000,
      'items': 1,
      'seller': 'متجر متنوع',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'shipped':
        return Colors.blue;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'طلباتي'),
      body: Column(
        children: [
          Container(
            color: AppTheme.getCardColor(context),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: AppTheme.goldColor,
              labelColor: AppTheme.goldColor,
              unselectedLabelColor: AppTheme.getSecondaryTextColor(context),
              tabs: const [
                Tab(text: 'الكل'),
                Tab(text: 'قيد الانتظار'),
                Tab(text: 'تم الشحن'),
                Tab(text: 'تم التوصيل'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrdersList(orders),
                _buildOrdersList(orders.where((o) => o['status'] == 'pending').toList()),
                _buildOrdersList(orders.where((o) => o['status'] == 'shipped').toList()),
                _buildOrdersList(orders.where((o) => o['status'] == 'delivered').toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined, size: 80, color: AppTheme.goldColor.withOpacity(0.5)),
            const SizedBox(height: 16),
            const Text('لا توجد طلبات'),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildOrderCard(items[index]);
      },
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'طلب ${order['id']}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order['status']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    order['statusText'],
                    style: TextStyle(
                      color: _getStatusColor(order['status']),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Divider(color: AppTheme.getDividerColor(context)),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
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
                      Text('البائع: ${order['seller']}'),
                      const SizedBox(height: 4),
                      Text('${order['items']} منتجات'),
                      Text(
                        '${order['date']}',
                        style: TextStyle(
                          color: AppTheme.getSecondaryTextColor(context),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${order['total']} ر.ي',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.goldColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (order['status'] == 'shipped')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/track_order'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.goldColor,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('تتبع الطلب'),
                ),
              ),
          ],
        ),
      ),
    ).animate().fadeIn();
  }
}
