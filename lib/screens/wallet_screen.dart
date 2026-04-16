import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  final List<Map<String, dynamic>> _services = const [
    {'icon': Icons.swap_horiz, 'label': 'تحويل', 'color': 0xFF4CAF50},
    {'icon': Icons.receipt, 'label': 'فواتير', 'color': 0xFF2196F3},
    {'icon': Icons.phone_android, 'label': 'شحن', 'color': 0xFFFF9800},
    {'icon': Icons.card_giftcard, 'label': 'هدايا', 'color': 0xFF9C27B0},
    {'icon': Icons.qr_code, 'label': 'QR', 'color': 0xFF607D8B},
    {'icon': Icons.history, 'label': 'سجل', 'color': 0xFF795548},
  ];

  final List<Map<String, dynamic>> _transactions = const [
    {'title': 'شحن رصيد', 'amount': '+100 ريال', 'date': 'اليوم', 'icon': Icons.add_card, 'color': 0xFF4CAF50},
    {'title': 'شراء منتج', 'amount': '-250 ريال', 'date': 'أمس', 'icon': Icons.shopping_bag, 'color': 0xFFE91E63},
    {'title': 'استلام حوالة', 'amount': '+500 ريال', 'date': 'قبل يومين', 'icon': Icons.account_balance_wallet, 'color': 0xFF4CAF50},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.navyPrimary : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المحفظة'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppTheme.goldColor, AppTheme.goldDark]),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: AppTheme.goldColor.withOpacity(0.3), blurRadius: 20)],
              ),
              child: Column(
                children: [
                  const Text('الرصيد الحالي', style: TextStyle(color: Colors.white, fontSize: 16)),
                  const SizedBox(height: 8),
                  const Text('12,450 ريال', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add), label: const Text('إيداع'), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppTheme.goldColor))),
                      const SizedBox(width: 12),
                      Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.remove), label: const Text('سحب'), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppTheme.goldColor))),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3, crossAxisSpacing: 12, mainAxisSpacing: 12,
                children: _services.map((service) => Container(
                  decoration: BoxDecoration(color: AppTheme.getCardColor(context), borderRadius: BorderRadius.circular(16)),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(service['icon'], size: 32, color: Color(service['color'])), const SizedBox(height: 8), Text(service['label'], style: const TextStyle(fontSize: 12))],
                  ),
                )).toList(),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('آخر المعاملات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: const Text('عرض الكل')),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final tx = _transactions[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppTheme.getCardColor(context), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Container(width: 45, height: 45, decoration: BoxDecoration(color: Color(tx['color']).withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(tx['icon'], color: Color(tx['color']))),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(tx['title'], style: const TextStyle(fontWeight: FontWeight.bold)), Text(tx['date'], style: const TextStyle(fontSize: 11, color: Colors.grey))])),
                      Text(tx['amount'], style: TextStyle(fontWeight: FontWeight.bold, color: tx['amount'].contains('+') ? Colors.green : Colors.red)),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
