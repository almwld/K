import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class WheelsInvestmentsScreen extends StatefulWidget {
  const WheelsInvestmentsScreen({super.key});

  @override
  State<WheelsInvestmentsScreen> createState() => _WheelsInvestmentsScreenState();
}

class _WheelsInvestmentsScreenState extends State<WheelsInvestmentsScreen> {
  final List<Map<String, dynamic>> items = [
    {'title': 'عجلة الحظ 1', 'price': 100, 'chance': '10%'},
    {'title': 'استثمار مضمون', 'price': 1000, 'chance': '70%'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'العجلات والاستثمارات'),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final it = items[i];
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.casino, size: 36),
                const SizedBox(width: 12),
                Expanded(child: Text(it['title'], style: const TextStyle(fontWeight: FontWeight.bold))),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${it['price']} ر.ي', style: const TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold)),
                    Text(it['chance'], style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
                    const SizedBox(height: 6),
                    ElevatedButton(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم المشاركة'))),
                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold, foregroundColor: Colors.black),
                      child: const Text('شارك'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
