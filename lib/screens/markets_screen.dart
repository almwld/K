import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MarketsScreen extends StatelessWidget {
  const MarketsScreen({super.key});

  final List<Map<String, dynamic>> _markets = const [
    {'name': 'السوق اليمني', 'change': '+2.5%', 'volume': '1.2M', 'items': 1250, 'isUp': true},
    {'name': 'المولات', 'change': '+1.8%', 'volume': '890K', 'items': 450, 'isUp': true},
    {'name': 'المقاهي', 'change': '+3.2%', 'volume': '567K', 'items': 320, 'isUp': true},
    {'name': 'الفنادق', 'change': '-0.5%', 'volume': '456K', 'items': 95, 'isUp': false},
    {'name': 'المطاعم', 'change': '+4.2%', 'volume': '789K', 'items': 560, 'isUp': true},
    {'name': 'الصيدليات', 'change': '+1.2%', 'volume': '234K', 'items': 180, 'isUp': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        title: const Text('الأسواق', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.binanceDark,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // بطاقة إحصائيات
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF1E2329), Color(0xFF16213E)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('إجمالي الأسواق', '6', AppTheme.binanceGold),
                Container(width: 1, height: 30, color: AppTheme.binanceBorder),
                _buildStatItem('حجم التداول', '4.5M', AppTheme.binanceGreen),
                Container(width: 1, height: 30, color: AppTheme.binanceBorder),
                _buildStatItem('المنتجات', '2.8K', AppTheme.serviceBlue),
              ],
            ),
          ),
          // رأس الجدول
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppTheme.binanceCard,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: const [
                Expanded(flex: 3, child: Text('السوق', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12))),
                Expanded(flex: 1, child: Text('التغير', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12), textAlign: TextAlign.end)),
                Expanded(flex: 1, child: Text('الحجم', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12), textAlign: TextAlign.end)),
                Expanded(flex: 1, child: Text('المنتجات', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12), textAlign: TextAlign.end)),
              ],
            ),
          ),
          // قائمة الأسواق
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _markets.length,
              itemBuilder: (context, index) => _buildMarketRow(_markets[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
      ],
    );
  }

  Widget _buildMarketRow(Map<String, dynamic> market) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.binanceCard,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(market['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text('${market['items']} منتج', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 10)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: (market['isUp'] as bool) ? AppTheme.binanceGreen.withOpacity(0.1) : AppTheme.binanceRed.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    (market['isUp'] as bool) ? Icons.trending_up : Icons.trending_down,
                    color: (market['isUp'] as bool) ? AppTheme.binanceGreen : AppTheme.binanceRed,
                    size: 12,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    market['change'] as String,
                    style: TextStyle(
                      color: (market['isUp'] as bool) ? AppTheme.binanceGreen : AppTheme.binanceRed,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              market['volume'] as String,
              style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
              textAlign: TextAlign.end,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${market['items']}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
