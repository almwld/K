import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class TrackOrderScreen extends StatelessWidget {
  final dynamic order;
  const TrackOrderScreen({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'تتبع الطلب'),
      body: const Center(child: Text('تتبع الطلب - قيد التطوير')),
    );
  }
}
