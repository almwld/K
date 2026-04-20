import '../utils/navigation_extensions.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/countdown_timer.dart';
import '../widgets/stock_badge.dart';

class FlashSaleScreen extends StatelessWidget {
  const FlashSaleScreen({super.key});

  List<Map<String, dynamic>> get _flashProducts {
    return [
      {'product': sampleProducts[0], 'discount': 35, 'sold': 78, 'total': 100, 'endTime': DateTime.now().add(const Duration(hours: 6))},
      {'product': sampleProducts[1], 'discount': 50, 'sold': 45, 'total': 80, 'endTime': DateTime.now().add(const Duration(hours: 4))},
      {'product': sampleProducts[2], 'discount': 25, 'sold': 120, 'total': 150, 'endTime': DateTime.now().add(const Duration(hours: 8))},
      {'product': sampleProducts[4], 'discount': 40, 'sold': 200, 'total': 250, 'endTime': DateTime.now().add(const Duration(hours: 2))},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const SimpleAppBar(title: 'عروض البرق'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _flashProducts.length,
        itemBuilder: (context, index) {
          final item = _flashProducts[index];
          final product = item['product'] as ProductModel;
          return InkWell(
            onTap: () => Navigator.push(context, product.navigateToDetail(context)),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(product.images.isNotEmpty ? product.images[0] : '', width: 80, height: 80, fit: BoxFit.cover)),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(product.formattedPrice, style: const TextStyle(color: Color(0xFFF0B90B), fontWeight: FontWeight.bold))])),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
