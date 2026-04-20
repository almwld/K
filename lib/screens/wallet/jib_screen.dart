import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class JibScreen extends StatelessWidget {
  const JibScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'جيب'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 80, color: AppTheme.goldLight.withOpacity(0.5)),
            const SizedBox(height: 16),
            const Text('جيب', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('سيتم إضافة هذه الميزة قريباً', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
          ],
        ),
      ),
    );
  }
}

