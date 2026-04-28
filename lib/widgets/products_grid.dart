import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'product_card.dart';
import '../screens/product/product_detail_screen.dart';

class ProductsGrid extends StatelessWidget {
  final List<dynamic> products;
  final bool isDark;

  const ProductsGrid({
    super.key,
    required this.products,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'لا توجد منتجات',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(12),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final product = products[index];
            return ProductCard(
              id: product.id,
              title: product.name,
              image: product.imageUrl,
              price: product.price,
              isAvailable: product.inStock,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(
                      productId: product.id,
                    ),
                  ),
                );
              },
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
