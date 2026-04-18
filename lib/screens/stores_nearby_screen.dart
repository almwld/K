import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class StoresNearbyScreen extends StatelessWidget {
  const StoresNearbyScreen({super.key});

  final List<Map<String, String>> stores = const [
    {'name': 'متجر الأناقة', 'distance': '350 م'},
    {'name': 'هايبر ��اركت', 'distance': '900 م'},
    {'name': 'متجر الأجهزة', 'distance': '1.1 كم'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المتاجر القريبة'),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: stores.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final s = stores[i];
          return ListTile(
            tileColor: Theme.of(context).cardColor,
            leading: const Icon(Icons.store),
            title: Text(s['name']!),
            subtitle: Text(s['distance']!),
            trailing: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldPrimary, foregroundColor: Colors.black),
              child: const Text('عرض'),
            ),
          );
        },
      ),
    );
  }
}
