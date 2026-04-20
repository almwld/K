import 'package:flutter/material.dart';
import '../utils/navigation_extensions.dart';
import '../models/product_model.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class FlashSaleScreen extends StatelessWidget {
  const FlashSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const SimpleAppBar(title: 'عروض البرق'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sampleProducts.take(4).length,
        itemBuilder: (context, index) {
          final product = sampleProducts[index];
          return InkWell(
            onTap: () => product.navigateToDetail(context),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2329),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.images.isNotEmpty ? product.images[0] : '',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.title,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(product.formattedPrice,
                            style: const TextStyle(color: Color(0xFFF0B90B), fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
