import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class SlidersScreen extends StatelessWidget {
  const SlidersScreen({super.key});

  final List<Map<String, String>> sliders = const [
    {'title': 'عرض مميز 1', 'subtitle': 'تخفيضات حتى 50%'},
    {'title': 'عرض مميز 2', 'subtitle': 'وصل حديثا'},
    {'title': 'عرض مميز 3', 'subtitle': 'أفضل الأسعار'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'السلايدر'),
      body: PageView.builder(
        itemCount: sliders.length,
        itemBuilder: (context, i) {
          final s = sliders[i];
          return Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: ListTile(
                title: Text(s['title']!, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                subtitle: Text(s['subtitle']!, style: const TextStyle(fontSize: 16)),
              ),
            ),
          );
        },
      ),
    );
  }
}
