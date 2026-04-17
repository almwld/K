import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class TraditionalFoodScreen extends StatelessWidget {
  const TraditionalFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المأكولات الشعبية'),
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
              'المأكولات الشعبية',
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
