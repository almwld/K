import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/countdown_timer.dart';
import '../widgets/stock_badge.dart';
import 'product_detail_screen.dart';

class FlashSaleScreen extends StatelessWidget {
  const FlashSaleScreen({super.key});

  // منتجات عروض البرق
  List<Map<String, dynamic>> get _flashProducts {
    return [
      {
        'product': sampleProducts[0], // تويوتا كامري
        'discount': 35,
        'sold': 78,
        'total': 100,
        'endTime': DateTime.now().add(const Duration(hours: 6)),
      },
      {
        'product': sampleProducts[1], // ماك بوك
        'discount': 50,
        'sold': 45,
        'total': 80,
        'endTime': DateTime.now().add(const Duration(hours: 4)),
      },
      {
        'product': sampleProducts[2], // آيفون
        'discount': 25,
        'sold': 120,
        'total': 150,
        'endTime': DateTime.now().add(const Duration(hours: 8)),
      },
      {
        'product': sampleProducts[4], // مندي
        'discount': 40,
        'sold': 200,
        'total': 250,
        'endTime': DateTime.now().add(const Duration(hours: 2)),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const SimpleAppBar(title: 'عروض البرق'),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Header Banner
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFF6465D),
                          Color(0xFFFF6B6B),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.flash_on,
                              color: Colors.white,
                              size: 32,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'عروض البرق',
                              style: TextStyle(
                                fontFamily: 'Changa',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'خصومات تصل إلى 50% - لفترة محدودة!',
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.timer, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'ينتهي خلال:',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(width: 8),
                              CountdownTimer(
                                duration: Duration(hours: 6),
                                showLabel: false,
                                fontSize: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Products List
                  ..._flashProducts.map((item) => _buildFlashProduct(context, item)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashProduct(
      BuildContext context, Map<String, dynamic> item) {
    final product = item['product'] as ProductModel;
    final discount = item['discount'] as int;
    final sold = item['sold'] as int;
    final total = item['total'] as int;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2329),
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: product),
          ),
        ),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    product.images.isNotEmpty
                        ? product.images[0]
                        : 'https://via.placeholder.com/400',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6465D),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '-$discount%',
                      style: const TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        product.formattedPrice,
                        style: const TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF0B90B),
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (product.oldPrice != null)
                        Text(
                          '${product.oldPrice!.toStringAsFixed(0)} ر.ي',
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: sold / total,
                      backgroundColor: Colors.grey[800],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFFF6465D),
                      ),
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'تم بيع $sold من $total',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                      StockBadge(stock: total - sold),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
