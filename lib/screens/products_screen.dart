import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'product_detail_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key, this.category});

  final String? category;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String _selectedCategory = 'الكل';
  bool _isLoading = true;
  List<Map<String, dynamic>> _products = [];

  final List<String> _categories = [
    'الكل', 'إلكترونيات', 'أزياء', 'أثاث', 'سيارات', 
    'عقارات', 'مطاعم', 'خدمات', 'مجوهرات', 'عطور'
  ];

  // منتجات افتراضية للعرض
  final List<Map<String, dynamic>> _mockProducts = [
    {'id': '1', 'name': 'آيفون 15 برو', 'price': 450000, 'category': 'إلكترونيات', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400', 'rating': 4.8},
    {'id': '2', 'name': 'سامسونج S24', 'price': 380000, 'category': 'إلكترونيات', 'image': 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400', 'rating': 4.7},
    {'id': '3', 'name': 'ماك بوك برو M3', 'price': 1800000, 'category': 'إلكترونيات', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400', 'rating': 4.9},
    {'id': '4', 'name': 'ثوب يمني فاخر', 'price': 35000, 'category': 'أزياء', 'image': 'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=400', 'rating': 4.6},
    {'id': '5', 'name': 'فيلا فاخرة صنعاء', 'price': 45000000, 'category': 'عقارات', 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400', 'rating': 4.9},
    {'id': '6', 'name': 'تويوتا كامري 2024', 'price': 8500000, 'category': 'سيارات', 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400', 'rating': 4.8},
    {'id': '7', 'name': 'مندي يمني', 'price': 3500, 'category': 'مطاعم', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400', 'rating': 4.9},
    {'id': '8', 'name': 'كنبة زاوية فاخرة', 'price': 150000, 'category': 'أثاث', 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400', 'rating': 4.7},
  ];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() => _isLoading = true);
    // محاكاة تحميل البيانات
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _products = _mockProducts;
      _isLoading = false;
    });
  }

  List<Map<String, dynamic>> get _filteredProducts {
    if (_selectedCategory == 'الكل') return _products;
    return _products.where((p) => p['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filteredProducts = _filteredProducts;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المنتجات'),
      body: Column(
        children: [
          // شريط الفئات
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = category),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [AppTheme.goldColor, AppTheme.goldDark],
                            )
                          : null,
                      color: isSelected ? null : (isDark ? Colors.grey[800] : Colors.grey[200]),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          // عدد النتائج
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  '${filteredProducts.length} منتج',
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                const Text('ترتيب حسب: الأحدث', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // شبكة المنتجات
          Expanded(
            child: _isLoading
                ? _buildShimmerGrid()
                : filteredProducts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inbox, size: 80, color: Colors.grey),
                            const SizedBox(height: 16),
                            const Text('لا توجد منتجات'),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return _buildProductCard(product);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => _buildShimmerCard(),
    );
  }

  Widget _buildShimmerCard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[700] : Colors.grey[300],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 14,
                  width: double.infinity,
                  color: isDark ? Colors.grey[700] : Colors.grey[300],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 80,
                  color: isDark ? Colors.grey[700] : Colors.grey[300],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 10,
                  width: 60,
                  color: isDark ? Colors.grey[700] : Colors.grey[300],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(productId: product['id']),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getCardColor(context),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المنتج
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: product['image'],
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 140,
                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 140,
                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),
            // معلومات المنتج
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 12, color: Colors.amber),
                      const SizedBox(width: 2),
                      Text(
                        product['rating'].toString(),
                        style: const TextStyle(fontSize: 11),
                      ),
                      const Spacer(),
                      Text(
                        '${product['price']} ر.ي',
                        style: TextStyle(
                          color: AppTheme.goldColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
