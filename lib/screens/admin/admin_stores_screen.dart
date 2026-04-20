import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../services/admin_service.dart';

class AdminStoresScreen extends StatefulWidget {
  const AdminStoresScreen({super.key});
  @override
  State<AdminStoresScreen> createState() => _AdminStoresScreenState();
}

class _AdminStoresScreenState extends State<AdminStoresScreen> {
  final AdminService _adminService = AdminService();
  List<Map<String, dynamic>> _stores = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final stores = await _adminService.getStores();
    setState(() { _stores = stores; _isLoading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إدارة المتاجر'), backgroundColor: AppTheme.gold),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : ListView.builder(itemCount: _stores.length, itemBuilder: (context, index) => ListTile(leading: const CircleAvatar(child: Icon(Icons.store)), title: Text(_stores[index]['name'] ?? ''))),
    );
  }
}

