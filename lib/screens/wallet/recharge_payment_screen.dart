import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class RechargePaymentScreen extends StatelessWidget {
  const RechargePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'شحن'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.phone_android, size: 80, color: AppTheme.goldAccent.withOpacity(0.5)),
            const SizedBox(height: 16),
            const Text('شحن', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('سيتم إضافة هذه الميزة قريباً', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
          ],
        ),
      ),
    );
  }
}
