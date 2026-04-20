import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  final String productName;
  final String? storeName;

  const ProductDetailScreen({super.key, required this.productId, required this.productName, this.storeName});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.productName), backgroundColor: AppTheme.gold),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 250, color: Colors.grey[200], child: const Icon(Icons.image, size: 100)),
                  const SizedBox(height: 16),
                  Text(widget.productName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('السعر: 450.00 ريال', style: TextStyle(fontSize: 20, color: AppTheme.gold)),
                  const SizedBox(height: 16),
                  const Text('الوصف', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('منتج عالي الجودة مع ضمان سنة كاملة.'),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Theme.of(context).cardColor, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)]),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      IconButton(onPressed: () => setState(() { if (_quantity > 1) _quantity--; }), icon: const Icon(Icons.remove)),
                      Text('$_quantity', style: const TextStyle(fontSize: 18)),
                      IconButton(onPressed: () => setState(() => _quantity++), icon: const Icon(Icons.add)),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold, padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: const Text('أضف إلى السلة', style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

