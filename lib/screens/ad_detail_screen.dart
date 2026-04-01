import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../models/product_model.dart';
import '../widgets/simple_app_bar.dart';
import 'checkout_screen.dart';
import 'chat_screen.dart';

class AdDetailScreen extends StatefulWidget {
  final ProductModel? product;
  const AdDetailScreen({super.key, this.product});

  @override
  State<AdDetailScreen> createState() => _AdDetailScreenState();
}

class _AdDetailScreenState extends State<AdDetailScreen> {
  int _currentImageIndex = 0;
  bool _isFavorite = false;
  int _selectedQuantity = 1;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final product = widget.product;

    if (product == null) {
      return Scaffold(
        appBar: const SimpleAppBar(title: 'تفاصيل الإعلان'),
        body: const Center(child: Text('لا توجد بيانات')),
      );
    }

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(
        title: product.title,
        actions: [
          IconButton(
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : AppTheme.goldColor),
            onPressed: () => setState(() => _isFavorite = !_isFavorite),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المنتج (Carousel)
            _buildImageCarousel(product),

            // معلومات المنتج
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان والسعر
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.goldColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${product.price.toStringAsFixed(0)} ر.ي',
                          style: const TextStyle(
                            color: AppTheme.goldColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // التقييم والموقع
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text('${product.rating ?? 4.5}'),
                          const SizedBox(width: 4),
                          Text('(${product.reviewCount ?? 12})',
                              style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 16,
                              color: AppTheme.getSecondaryTextColor(context)),
                          const SizedBox(width: 4),
                          Text(product.city),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // الكمية
                  Row(
                    children: [
                      const Text('الكمية:'),
                      const SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.goldColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 18),
                              onPressed: () {
                                if (_selectedQuantity > 1) {
                                  setState(() => _selectedQuantity--);
                                }
                              },
                            ),
                            SizedBox(
                              width: 40,
                              child: Center(
                                child: Text(
                                  '$_selectedQuantity',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, size: 18),
                              onPressed: () {
                                setState(() => _selectedQuantity++);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // الوصف
                  const Text(
                    'الوصف',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description.isNotEmpty
                        ? product.description
                        : 'منتج مميز وجودة عالية. مناسب للاستخدام اليومي. متوفر بأسعار منافسة.',
                    style: TextStyle(
                      height: 1.5,
                      color: AppTheme.getSecondaryTextColor(context),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // معلومات البائع
                  const Text(
                    'معلومات البائع',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                          child: Text(
                            product.sellerName.isNotEmpty ? product.sellerName[0] : 'ب',
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.sellerName.isNotEmpty ? product.sellerName : 'بائع موثوق',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star, size: 14, color: Colors.amber),
                                  const SizedBox(width: 4),
                                  Text('${product.rating ?? 4.8}'),
                                  const SizedBox(width: 12),
                                  const Icon(Icons.shopping_bag, size: 14),
                                  const SizedBox(width: 4),
                                  const Text('12 إعلان'),
                                  const SizedBox(width: 12),
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Text('متصل الآن'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // أزرار الإجراءات
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CheckoutScreen(product: product),
                              ),
                            );
                          },
                          icon: const Icon(Icons.shopping_cart),
                          label: const Text('شراء الآن'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.goldColor,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ChatScreen()),
                            );
                          },
                          icon: const Icon(Icons.chat),
                          label: const Text('محادثة'),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppTheme.goldColor),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel(ProductModel product) {
    final images = product.images.isNotEmpty
        ? product.images
        : ['https://picsum.photos/id/1/400/300'];

    return Stack(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            onPageChanged: (index) => setState(() => _currentImageIndex = index),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: images[index],
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (_, __) => Container(
                  color: AppTheme.goldColor.withOpacity(0.1),
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: AppTheme.goldColor.withOpacity(0.1),
                  child: const Icon(Icons.image_not_supported, size: 50),
                ),
              );
            },
          ),
        ),
        if (images.length > 1)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentImageIndex == index
                        ? AppTheme.goldColor
                        : Colors.white.withOpacity(0.5),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }
}
