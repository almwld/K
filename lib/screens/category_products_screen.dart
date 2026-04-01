import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../models/product_model.dart';
import 'ad_detail_screen.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String category;
  final String categoryName;
  const CategoryProductsScreen({super.key, required this.category, required this.categoryName});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  List<ProductModel> _products = [];
  bool _isLoading = true;
  String _sortBy = 'newest';

  final List<ProductModel> _allProducts = [
    ProductModel(id: '1', title: 'آيفون 15 برو ماكس', description: '', price: 450000, images: ['assets/images/products/iphone.jpg'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.9, reviewCount: 128, createdAt: DateTime.now()),
    ProductModel(id: '2', title: 'سامسونج S24 الترا', description: '', price: 380000, images: ['assets/images/products/samsung.jpg'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.8, reviewCount: 95, createdAt: DateTime.now()),
    ProductModel(id: '3', title: 'ماك بوك برو M3', description: '', price: 1800000, images: ['assets/images/products/macbook.jpg'], category: 'إلكترونيات', city: 'عدن', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.9, reviewCount: 67, createdAt: DateTime.now()),
    ProductModel(id: '4', title: 'تويوتا كامري 2024', description: '', price: 8500000, images: ['assets/images/products/camry.jpg'], category: 'سيارات', city: 'صنعاء', sellerId: '2', sellerName: 'معرض السيارات', rating: 4.7, reviewCount: 45, createdAt: DateTime.now()),
    ProductModel(id: '5', title: 'هيونداي النترا 2024', description: '', price: 6500000, images: ['assets/images/products/elantra.jpg'], category: 'سيارات', city: 'عدن', sellerId: '2', sellerName: 'معرض السيارات', rating: 4.6, reviewCount: 32, createdAt: DateTime.now()),
    ProductModel(id: '6', title: 'شقة فاخرة في حدة', description: '', price: 35000000, images: ['assets/images/products/apartment.jpg'], category: 'عقارات', city: 'صنعاء', sellerId: '3', sellerName: 'عقارات فلكس', rating: 4.8, reviewCount: 56, createdAt: DateTime.now()),
    ProductModel(id: '7', title: 'فيلا فاخرة', description: '', price: 150000000, images: ['assets/images/products/villa.jpg'], category: 'عقارات', city: 'صنعاء', sellerId: '3', sellerName: 'عقارات فلكس', rating: 4.9, reviewCount: 89, createdAt: DateTime.now()),
    ProductModel(id: '8', title: 'كنب زاوية فاخر', description: '', price: 650000, images: ['assets/images/products/majlis.jpg'], category: 'أثاث', city: 'صنعاء', sellerId: '4', sellerName: 'متجر الأثاث', rating: 4.5, reviewCount: 34, createdAt: DateTime.now()),
  ];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _products = _allProducts.where((p) => p.category == widget.category).toList();
        _sortProducts();
        _isLoading = false;
      });
    });
  }

  void _sortProducts() {
    if (_sortBy == 'newest') {
      _products.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else if (_sortBy == 'price_low') {
      _products.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortBy == 'price_high') {
      _products.sort((a, b) => b.price.compareTo(a.price));
    } else if (_sortBy == 'rating') {
      _products.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(title: widget.categoryName),
      body: Column(
        children: [
          // خيارات الترتيب
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text('ترتيب:'),
                const SizedBox(width: 8),
                _buildSortChip('الأحدث', 'newest'),
                const SizedBox(width: 8),
                _buildSortChip('الأقل سعراً', 'price_low'),
                const SizedBox(width: 8),
                _buildSortChip('الأعلى سعراً', 'price_high'),
                const SizedBox(width: 8),
                _buildSortChip('الأعلى تقييماً', 'rating'),
              ],
            ),
          ),

          // عرض المنتجات
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _products.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inbox, size: 80, color: AppTheme.goldColor.withOpacity(0.5)),
                            const SizedBox(height: 16),
                            const Text('لا توجد منتجات في هذه الفئة'),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          final product = _products[index];
                          return GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdDetailScreen(product: product))),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.getCardColor(context),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                      child: Image.asset(
                                        product.images.first,
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Container(
                                          color: AppTheme.goldColor.withOpacity(0.1),
                                          child: const Icon(Icons.image, size: 40, color: AppTheme.goldColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.title,
                                            maxLines: 1,
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${product.price.toStringAsFixed(0)} ر.ي',
                                            style: const TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 2),
                                          Row(
                                            children: [
                                              const Icon(Icons.star, size: 12, color: Colors.amber),
                                              const SizedBox(width: 2),
                                              Text('${product.rating}', style: const TextStyle(fontSize: 12)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on, size: 10, color: AppTheme.getSecondaryTextColor(context)),
                                              const SizedBox(width: 2),
                                              Expanded(
                                                child: Text(
                                                  product.city,
                                                  style: TextStyle(fontSize: 10, color: AppTheme.getSecondaryTextColor(context)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortChip(String label, String value) {
    final isSelected = _sortBy == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _sortBy = value;
          _sortProducts();
        });
      },
      selectedColor: AppTheme.goldColor,
      backgroundColor: AppTheme.getCardColor(context),
      checkmarkColor: Colors.black,
      labelStyle: TextStyle(
        color: isSelected ? Colors.black : AppTheme.getTextColor(context),
      ),
    );
  }
}
