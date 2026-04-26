import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  final List<Map<String, dynamic>> _news = const [
    {'title': 'عروض العيد الكبرى', 'date': '2024-04-27', 'views': '1.2K', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200'},
    {'title': 'إطلاق تطبيق فلكس يمن الجديد', 'date': '2024-04-25', 'views': '890', 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200'},
    {'title': 'خصم 50% على جميع المنتجات', 'date': '2024-04-23', 'views': '2.3K', 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('الأخبار', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _news.length,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? AppTheme.binanceCard : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.binanceBorder),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(_news[index]['image'], width: 80, height: 80, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_news[index]['title'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 12, color: AppTheme.binanceGold),
                        const SizedBox(width: 4),
                        Text(_news[index]['date'], style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
                        const SizedBox(width: 12),
                        const Icon(Icons.remove_red_eye, size: 12, color: AppTheme.binanceGold),
                        const SizedBox(width: 4),
                        Text(_news[index]['views'], style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
