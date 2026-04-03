import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'product_detail_screen.dart';

// منتجات تجريبية لكل فئة مع صور حقيقية
final Map<String, List<Map<String, dynamic>>> productsByCategory = {
  'electronics': [
    {'id': '1', 'name': 'iPhone 15 Pro', 'price': 350000, 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=300', 'description': 'أحدث إصدار من آيفون'},
    {'id': '2', 'name': 'Samsung S24 Ultra', 'price': 320000, 'image': 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=300', 'description': 'كاميرا 200 ميجابكسل'},
    {'id': '3', 'name': 'MacBook Pro', 'price': 850000, 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=300', 'description': 'M3 Max chip'},
  ],
  'cars': [
    {'id': '1', 'name': 'تويوتا كامري 2024', 'price': 8500000, 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=300', 'description': 'فل كامل'},
    {'id': '2', 'name': 'هونداي النترا', 'price': 5500000, 'image': 'https://images.unsplash.com/photo-1568605117036-5fe5e7fa0ac7?w=300', 'description': 'مواصفات عالية'},
  ],
  'fashion': [
    {'id': '1', 'name': 'ثوب يمني', 'price': 25000, 'image': 'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=300', 'description': 'قماش فاخر'},
    {'id': '2', 'name': 'معطف رجالي', 'price': 35000, 'image': 'https://images.unsplash.com/photo-1539533113208-f6df8cc8b543?w=300', 'description': 'شتوي'},
  ],
  'perfumes': [
    {'id': '1', 'name': 'عود ملكي', 'price': 45000, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=300', 'description': 'عطر شرقي فاخر'},
  ],
};

class CategoryProductsScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  const CategoryProductsScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  List<Map<String, dynamic>> get _products {
    return productsByCategory[categoryId] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final products = _products;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(title: categoryName),
      body: products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.category, size: 80, color: AppTheme.goldColor.withOpacity(0.5)),
                  const SizedBox(height: 16),
                  Text(categoryName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('سيتم إضافة منتجات هذا القسم قريباً'),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(
                          productId: product['id'],
                          productName: product['name'],
                          productPrice: product['price'],
                          productImage: product['image'],
                          productDescription: product['description'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.getCardColor(context),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.network(
                            product['image'],
                            height: 130,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              height: 130,
                              color: Colors.grey[300],
                              child: const Icon(Icons.image_not_supported),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${product['price']} ر.ي',
                                style: TextStyle(
                                  color: AppTheme.goldColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
