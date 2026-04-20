import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../services/admin_service.dart';
import '../../models/admin_model.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final AdminService _adminService = AdminService();
  AdminStatsModel? _stats;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final stats = await _adminService.getStats();
    setState(() { _stats = stats; _isLoading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة التحكم'), backgroundColor: AppTheme.gold),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : Padding(padding: const EdgeInsets.all(16), child: GridView.count(crossAxisCount: 2, children: [_buildStatCard('المستخدمين', '${_stats?.totalUsers ?? 0}', Icons.people), _buildStatCard('المتاجر', '${_stats?.totalStores ?? 0}', Icons.store), _buildStatCard('الطلبات', '${_stats?.totalOrders ?? 0}', Icons.shopping_bag), _buildStatCard('المبيعات', '${_stats?.totalSales.toInt() ?? 0} ريال', Icons.monetization_on)])),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 40, color: AppTheme.gold), const SizedBox(height: 8), Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), Text(title, style: TextStyle(color: Colors.grey[600]))]));
  }
}

