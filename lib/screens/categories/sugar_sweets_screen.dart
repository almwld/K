import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class SugarSweetsScreen extends StatelessWidget {
  const SugarSweetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'السكر والحلويات'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.category,
              size: 80,
              color: AppTheme.goldPrimary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'السكر والحلويات',
              style: const TextStyle(
                fontFamily: 'Changa',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'سيتم إضافة منتجات هذا القسم قريباً',
              style: TextStyle(
                color: AppTheme.getSecondaryTextColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
