import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});

  final List<Map<String, String>> reels = const [
    {'title': 'ريل: أفضل الصفقات اليوم', 'duration': '00:15'},
    {'title': 'ريل: مراجعة المنتج', 'duration': '00:30'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الرييلز'),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: reels.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final r = reels[i];
          return Container(
            height: 220,
            decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
            child: Stack(
              children: [
                const Center(child: Icon(Icons.play_circle_outline, size: 80, color: AppTheme.gold)),
                Positioned(
                  left: 12,
                  bottom: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r['title']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text(r['duration']!, style: const TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
