import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../services/admin_service.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});
  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  final AdminService _adminService = AdminService();
  List<Map<String, dynamic>> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final users = await _adminService.getUsers();
    setState(() { _users = users; _isLoading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إدارة المستخدمين'), backgroundColor: AppTheme.gold),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : ListView.builder(itemCount: _users.length, itemBuilder: (context, index) => ListTile(leading: const CircleAvatar(child: Icon(Icons.person)), title: Text(_users[index]['name'] ?? ''), subtitle: Text(_users[index]['phone'] ?? ''))),
    );
  }
}

