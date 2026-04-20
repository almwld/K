import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/shimmer_image.dart';
import 'product/product_detail_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _products = [];
  String _sortBy = 'الأحدث';
  final List<String> _sortOptions = ['الأحدث', 'الأقدم', 'الأقل سعراً', 'الأعلى سعراً'];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _products = List.generate(20, (index) => {
        'id': '$index',
        'name': 'منتج ${index + 1}',
        'price': '${(index + 1) * 50000}',
        'image': 'https://picsum.photos/400/400?random=$index',
        'tag': index % 3 == 0 ? 'جديد' : 'مميز',
      });
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(
        title: 'المنتجات',
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => setState(() => _sortBy = value),
            itemBuilder: (context) => _sortOptions.map((option) => PopupMenuItem(value: option, child: Text(option))).toList(),
            child: Container(padding: const EdgeInsets.symmetric(horizontal: 12), child: Row(children: [Text(_sortBy, style: const TextStyle(color: Colors.black)), const Icon(Icons.arrow_drop_down, color: Colors.black)])),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadProducts,
        color: AppTheme.gold,
        child: _isLoading
            ? const ProductGridShimmer(itemCount: 8)
            : GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 12, mainAxisSpacing: 12),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return _buildProductCard(product);
                },
              ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(productId: product['id'], productName: product['name']))),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: ShimmerImage(imageUrl: product['image'], height: 130, width: double.infinity),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product['name'], maxLines: 2, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 4),
                  Text('${product['price']} ريال', style: TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 4),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppTheme.gold.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Text(product['tag'], style: TextStyle(color: AppTheme.gold, fontSize: 10))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

