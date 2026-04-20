import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';

extension ProductNavigation on BuildContext {
  void navigateToProduct(Map<String, dynamic> product) {
    Navigator.push(
      this,
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(
          id: product['id']?.toString() ?? '',
          title: product['title'] ?? product['name'] ?? '',
          image: product['image'] ?? product['imageUrl'] ?? '',
          price: (product['price'] ?? 0).toDouble(),
          description: product['description'] ?? '',
          sellerName: product['sellerName'] ?? product['seller'] ?? 'غير معروف',
          rating: (product['rating'] ?? 0).toDouble(),
          reviewCount: product['reviewCount'] ?? 0,
          images: product['images'] ?? [],
          inStock: product['inStock'] ?? true,
        ),
      ),
    );
  }
}
