import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات'), backgroundColor: AppTheme.gold),
      body: ListView(children: [ListTile(leading: const Icon(Icons.palette), title: const Text('المظهر'), onTap: () {}), ListTile(leading: const Icon(Icons.notifications), title: const Text('الإشعارات'), onTap: () {})]),
    );
  }
}

