import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class OrderDetailScreen extends StatelessWidget {
  final String? orderId;
  const OrderDetailScreen({super.key, this.orderId});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'تفاصيل الطلب'),
      body: Center(child: Text(orderId != null ? 'تفاصيل الطلب: $orderId' : 'تفاصيل الطلب')),
    );
  }
}
