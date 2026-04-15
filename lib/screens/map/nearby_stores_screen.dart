import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class NearbyStoresScreen extends StatelessWidget {
  const NearbyStoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المتاجر القريبة'),
      body: const Center(child: Text('المتاجر القريبة - قيد التطوير')),
    );
  }
}
