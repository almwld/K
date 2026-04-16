import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;
  final String? productName;
  
  const ProductDetailScreen({
    super.key, 
    required this.productId,
    this.productName,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.navyPrimary : AppTheme.lightBackground,
      appBar: SimpleAppBar(title: productName ?? 'تفاصيل المنتج'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag, size: 80, color: AppTheme.goldColor),
            const SizedBox(height: 16),
            Text('المنتج: $productId', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            const Text('سيتم إضافة تفاصيل المنتج قريباً'),
          ],
        ),
      ),
    );
  }
}
