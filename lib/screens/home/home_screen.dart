import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home, size: 80, color: AppTheme.goldColor),
            const SizedBox(height: 16),
            const Text('الصفحة الرئيسية', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('مرحباً بك في فلكس يمن', style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}
