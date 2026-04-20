import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'طرق الدفع'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.credit_card, size: 80, color: AppTheme.gold.withOpacity(0.5)),
            const SizedBox(height: 16),
            const Text('طرق الدفع', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('سيتم إضافة هذه الميزة قريباً', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
          ],
        ),
      ),
    );
  }
}

