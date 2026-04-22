import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MarketsScreen extends StatelessWidget {
  const MarketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final markets = [{'name': 'السوق اليمني', 'change': '+2.5%', 'volume': '1.2M', 'items': 1250, 'isUp': true}, {'name': 'المولات', 'change': '+1.8%', 'volume': '890K', 'items': 450, 'isUp': true}, {'name': 'المقاهي', 'change': '+3.2%', 'volume': '567K', 'items': 320, 'isUp': true}, {'name': 'الفنادق', 'change': '-0.5%', 'volume': '456K', 'items': 95, 'isUp': false}, {'name': 'الإلكترونيات', 'change': '+5.2%', 'volume': '2.1M', 'items': 2100, 'isUp': true}, {'name': 'الأزياء', 'change': '+1.5%', 'volume': '1.5M', 'items': 1800, 'isUp': true}];
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(title: const Text('الأسواق', style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11)),
      body: ListView.builder(padding: const EdgeInsets.all(16), itemCount: markets.length, itemBuilder: (c, i) => Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: Row(children: [Expanded(flex: 3, child: Text(markets[i]['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: (markets[i]['isUp'] as bool) ? const Color(0xFF0ECB81).withOpacity(0.1) : const Color(0xFFF6465D).withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Row(children: [Icon((markets[i]['isUp'] as bool) ? Icons.trending_up : Icons.trending_down, color: (markets[i]['isUp'] as bool) ? const Color(0xFF0ECB81) : const Color(0xFFF6465D), size: 14), const SizedBox(width: 4), Text(markets[i]['change']!, style: TextStyle(color: (markets[i]['isUp'] as bool) ? const Color(0xFF0ECB81) : const Color(0xFFF6465D), fontWeight: FontWeight.bold))])), const SizedBox(width: 16), Text(markets[i]['volume']!, style: const TextStyle(color: Color(0xFF9CA3AF))), const SizedBox(width: 16), Text('${markets[i]['items']} منتج', style: const TextStyle(color: Color(0xFF5E6673)))])),
    );
  }
}
