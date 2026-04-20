import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
 Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الطلبات'),
      body: const Center(child: Text('قائمة الطلبات')),
    );
  }
}

