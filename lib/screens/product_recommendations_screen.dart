import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class ProductRecommendationsScreen extends StatelessWidget {
  const ProductRecommendationsScreen({super.key});

  final List<Map<String, dynamic>> recs = const [
    {'title': 'سماعات بلوتوث', 'price': 120, 'rating': 4.5},
    {'title': 'كاميرا أكشن', 'price': 650, 'rating': 4.2},
    {'title': 'سوار ذكي', 'price': 79, 'rating': 4.0},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'منتجات مقترحة لك'),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.75, crossAxisSpacing: 12, mainAxisSpacing: 12),
        itemCount: recs.length,
        itemBuilder: (context, i) {
          final r = recs[i];
          return Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Center(child: Icon(Icons.image, size: 48, color: AppTheme.gold))),
                const SizedBox(height: 8),
                Text(r['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('${r['price']} ر.ي', style: const TextStyle(color: AppTheme.gold)),
                const SizedBox(height: 6),
                Row(children: [Icon(Icons.star, size: 14, color: Colors.amber), const SizedBox(width: 4), Text('${r['rating']}')]),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/ad_detail'),
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold, foregroundColor: Colors.black),
                  child: const Text('��رض'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
