import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../screens/product_detail_screen.dart';

extension ProductNavigation on ProductModel {
  /// للاستخدام مع Navigator.push(context, product.toDetailScreen())
  Route<dynamic> toDetailScreen() {
    return MaterialPageRoute(
      builder: (_) => ProductDetailScreen(
        id: id,
        title: title,
        image: images.isNotEmpty ? images[0] : '',
        price: price,
        description: description,
        sellerName: sellerName ?? 'غير معروف',
        rating: rating ?? 0.0,
        reviewCount: reviewCount ?? 0,
        images: images,
        inStock: stock > 0,
      ),
    );
  }
  
  /// للاستخدام المباشر: product.navigateToDetail(context)
  void navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(
          id: id,
          title: title,
          image: images.isNotEmpty ? images[0] : '',
          price: price,
          description: description,
          sellerName: sellerName ?? 'غير معروف',
          rating: rating ?? 0.0,
          reviewCount: reviewCount ?? 0,
          images: images,
          inStock: stock > 0,
        ),
      ),
    );
  }
}
