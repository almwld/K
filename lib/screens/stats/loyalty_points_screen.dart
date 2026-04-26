import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class LoyaltyPointsScreen extends StatelessWidget {
  const LoyaltyPointsScreen({super.key});

  final List<Map<String, dynamic>> _transactions = const [
    {'date': '2024-04-20', 'points': 100, 'reason': 'شراء iPhone 15 Pro', 'type': 'earn'},
    {'date': '2024-04-18', 'points': 50, 'reason': 'تقييم منتج', 'type': 'earn'},
    {'date': '2024-04-15', 'points': 200, 'reason': 'دعوة صديق', 'type': 'earn'},
    {'date': '2024-04-10', 'points': 30, 'reason': 'مشاركة التطبيق', 'type': 'earn'},
    {'date': '2024-04-05', 'points': 75, 'reason': 'كتابة مراجعة', 'type': 'earn'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final totalPoints = _transactions.fold(0, (sum, t) => sum + t['points'] as int);

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('نقاط الولاء', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppTheme.goldGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text('رصيد النقاط', style: TextStyle(color: Colors.black87, fontSize: 14)),
                const SizedBox(height: 8),
                Text(
                  '$totalPoints',
                  style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text('≈ ${totalPoints * 10} ريال', style: const TextStyle(color: Colors.black87)),
              ],
            ),
          ),
          // المستوى
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.binanceCard : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.binanceBorder),
            ),
            child: Row(
              children: [
                Container(
                  width: 50, height: 50,
                  decoration: BoxDecoration(
                    gradient: AppTheme.goldGradient,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.workspace_premium, color: Colors.black, size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('مستوى العضوية', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('ذهبي', style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: totalPoints / 2000,
                        backgroundColor: AppTheme.binanceBorder,
                        color: AppTheme.binanceGold,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const SizedBox(height: 2),
                      Text('${2000 - totalPoints} نقطة للوصول إلى البلاتيني', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('سجل النقاط', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('المجموع: 455', style: TextStyle(color: AppTheme.binanceGold)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _transactions.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.binanceCard : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.binanceBorder),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.binanceGold.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _transactions[index]['type'] == 'earn' ? Icons.add : Icons.remove,
                        color: AppTheme.binanceGold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_transactions[index]['reason'], style: const TextStyle(fontWeight: FontWeight.w500)),
                          Text(_transactions[index]['date'], style: TextStyle(fontSize: 10, color: Colors.grey)),
                        ],
                      ),
                    ),
                    Text(
                      '+${_transactions[index]['points']}',
                      style: const TextStyle(color: AppTheme.binanceGreen, fontWeight: FontWeight.bold),
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
