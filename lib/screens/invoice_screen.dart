import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الفاتورة'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt, size: 80, color: AppTheme.gold.withOpacity(0.5)),
            const SizedBox(height: 16),
            const Text('الفاتورة', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('سيتم إضافة هذه الميزة قريباً', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
          ],
        ),
      ),
    );
  }
}

