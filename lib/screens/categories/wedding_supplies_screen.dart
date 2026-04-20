import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class WeddingSuppliesScreen extends StatelessWidget {
  const WeddingSuppliesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'تجهيزات الأعراس'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.category,
              size: 80,
              color: AppTheme.gold.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'تجهيزات الأعراس',
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
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

