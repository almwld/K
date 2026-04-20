import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';

class ProductDetailScreen extends StatefulWidget {
  final String id;
  final String title;
  final String image;
  final double price;
  final String description;
  final String sellerName;
  final double rating;
  final int reviewCount;
  final List<String> images;
  final bool inStock;

  const ProductDetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
    required this.sellerName,
    required this.rating,
    required this.reviewCount,
    required this.images,
    required this.inStock,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: widget.image,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(widget.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('${widget.price.toStringAsFixed(0)} ر.ي',
                style: const TextStyle(fontSize: 22, color: AppTheme.gold, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('الوصف', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(widget.description),
            const SizedBox(height: 16),
            Text('البائع: ${widget.sellerName}'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.inStock ? () {} : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.gold,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(widget.inStock ? 'أضف للسلة' : 'غير متوفر',
                    style: const TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
