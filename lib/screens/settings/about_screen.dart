import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'حول التطبيق'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.goldColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.goldColor.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(Icons.store, size: 60, color: Colors.black),
            ),
            const SizedBox(height: 24),
            const Text(
              'Flex Yemen',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.goldColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'الإصدار 1.0.0',
                style: TextStyle(color: AppTheme.goldColor),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'السوق الإلكتروني اليمني الأول',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 48),
            _buildInfoTile(Icons.email, 'البريد الإلكتروني', 'support@flexyemen.com'),
            _buildInfoTile(Icons.language, 'الموقع الإلكتروني', 'www.flexyemen.com'),
            _buildInfoTile(Icons.phone, 'الدعم الفني', '777 123 456'),
            
            const Spacer(),
            
            const Text(
              '© 2024 Flex Yemen. جميع الحقوق محفوظة',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.goldColor),
      title: Text(title),
      subtitle: Text(value),
      onTap: () {},
    );
  }
}
