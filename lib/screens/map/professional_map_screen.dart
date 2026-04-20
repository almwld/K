import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class ProfessionalMapScreen extends StatelessWidget {
  const ProfessionalMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'خريطة احترافية'),
      body: const Center(child: Text('الخريطة الاحترافية - قيد التطوير')),
    );
  }
}

