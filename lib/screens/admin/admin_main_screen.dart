import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'admin_dashboard.dart';
import 'admin_users_screen.dart';
import 'admin_stores_screen.dart';
import 'admin_settings_screen.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [AdminDashboard(), AdminUsersScreen(), AdminStoresScreen(), AdminSettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(width: 80, color: AppTheme.goldPrimary, child: Column(children: [
            const SizedBox(height: 40), const Icon(Icons.admin_panel_settings, color: Colors.white, size: 40), const SizedBox(height: 30),
            _buildNavItem(Icons.dashboard, 'الرئيسية', 0), _buildNavItem(Icons.people, 'المستخدمين', 1), _buildNavItem(Icons.store, 'المتاجر', 2), _buildNavItem(Icons.settings, 'الإعدادات', 3),
            const Spacer(), IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.logout, color: Colors.white)), const SizedBox(height: 20),
          ])),
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 16), color: _selectedIndex == index ? Colors.white.withOpacity(0.2) : Colors.transparent, child: Column(children: [Icon(icon, color: Colors.white, size: 24), const SizedBox(height: 4), Text(label, style: const TextStyle(color: Colors.white, fontSize: 10))])),
    );
  }
}
