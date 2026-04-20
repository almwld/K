import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../screens/product_detail_screen.dart';

extension ProductNavigation on BuildContext {
  void navigateToProduct(dynamic product) {
    String id, title, image, description, sellerName;
    double price, rating;
    int reviewCount;
    List<String> images;
    bool inStock;

    if (product is ProductModel) {
      id = product.id;
      title = product.title;
      image = product.images.isNotEmpty ? product.images[0] : '';
      price = product.price;
      description = product.description;
      sellerName = product.sellerName ?? 'غير معروف';
      rating = product.rating ?? 0.0;
      reviewCount = product.reviewCount ?? 0;
      images = product.images;
      inStock = product.stock > 0;
    } else if (product is Map<String, dynamic>) {
      id = product['id']?.toString() ?? '';
      title = product['title'] ?? product['name'] ?? '';
      image = product['image'] ?? product['imageUrl'] ?? '';
      price = (product['price'] ?? 0).toDouble();
      description = product['description'] ?? '';
      sellerName = product['sellerName'] ?? product['seller'] ?? 'غير معروف';
      rating = (product['rating'] ?? 0).toDouble();
      reviewCount = product['reviewCount'] ?? 0;
      images = product['images'] != null ? List<String>.from(product['images']) : [];
      inStock = product['inStock'] ?? true;
    } else {
      return;
    }

    Navigator.push(
      this,
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(
          id: id,
          title: title,
          image: image,
          price: price,
          description: description,
          sellerName: sellerName,
          rating: rating,
          reviewCount: reviewCount,
          images: images,
          inStock: inStock,
        ),
      ),
    );
  }
}
