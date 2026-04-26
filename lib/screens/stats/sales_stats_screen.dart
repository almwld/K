import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';

class SalesStatsScreen extends StatelessWidget {
  final String title;
  final String totalValue;
  final List<Map<String, dynamic>> details;

  const SalesStatsScreen({
    super.key,
    required this.title,
    required this.totalValue,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      ),
      body: Column(
        children: [
          // بطاقة الإجمالي
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppTheme.goldGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text('الإجمالي', style: TextStyle(color: Colors.black87, fontSize: 14)),
                const SizedBox(height: 8),
                Text(
                  totalValue,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
          // قائمة التفاصيل
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: details.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.binanceCard : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.binanceBorder),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 45, height: 45,
                      decoration: BoxDecoration(
                        color: (details[index]['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(details[index]['icon'], color: details[index]['color']),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            details[index]['label'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            details[index]['date'],
                            style: TextStyle(color: isDark ? Colors.grey.shade500 : Colors.grey.shade600, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      details[index]['value'],
                      style: TextStyle(
                        color: details[index]['color'] as Color,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
