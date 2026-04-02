import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../models/product_model.dart';
import 'ad_detail_screen.dart';

class AllAdsScreen extends StatefulWidget {
  const AllAdsScreen({super.key});

  @override
  State<AllAdsScreen> createState() => _AllAdsScreenState();
}

class _AllAdsScreenState extends State<AllAdsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'الكل';
  String _sortBy = 'newest';
  List<ProductModel> _products = [];
  List<ProductModel> _filteredProducts = [];
  bool _isLoading = true;

  final List<String> _categories = ['الكل', 'عقارات', 'سيارات', 'إلكترونيات', 'أزياء', 'أثاث'];

  final List<ProductModel> _allProducts = [
    ProductModel(id: '1', title: 'شقة فاخرة في حدة', description: 'شقة 3 غرف', price: 35000000, images: ['https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400'], category: 'عقارات', city: 'صنعاء', sellerId: '1', sellerName: 'عقارات فلكس', rating: 4.8, createdAt: DateTime.now()),
    ProductModel(id: '2', title: 'تويوتا كامري 2024', description: 'سيارة كامري', price: 8500000, images: ['https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400'], category: 'سيارات', city: 'صنعاء', sellerId: '2', sellerName: 'معرض السيارات', rating: 4.7, createdAt: DateTime.now()),
    ProductModel(id: '3', title: 'ماك بوك برو M3', description: 'لابتوب', price: 1800000, images: ['https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400'], category: 'إلكترونيات', city: 'عدن', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.9, createdAt: DateTime.now()),
    ProductModel(id: '4', title: 'سامسونج S24 الترا', description: 'هاتف', price: 380000, images: ['https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.8, createdAt: DateTime.now()),
  ];

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _searchController.addListener(_filterProducts);
  }

  void _loadProducts() {
    setState(() {
      _products = _allProducts;
      _filterProducts();
      _isLoading = false;
    });
  }

  void _filterProducts() {
    setState(() {
      _filteredProducts = _products.where((p) {
        final matchesCategory = _selectedCategory == 'الكل' || p.category == _selectedCategory;
        final matchesSearch = _searchController.text.isEmpty || p.title.toLowerCase().contains(_searchController.text.toLowerCase());
        return matchesCategory && matchesSearch;
      }).toList();
      _sortProducts();
    });
  }

  void _sortProducts() {
    if (_sortBy == 'newest') {
      _filteredProducts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else if (_sortBy == 'price_low') {
      _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortBy == 'price_high') {
      _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
    } else if (_sortBy == 'rating') {
      _filteredProducts.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(title: 'جميع الإعلانات'),
      body: Column(
        children: [
          // شريط البحث
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'بحث...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppTheme.getCardColor(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // الفلتر والترتيب
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'الفئة',
                      filled: true,
                      fillColor: AppTheme.getCardColor(context),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (v) {
                      setState(() => _selectedCategory = v!);
                      _filterProducts();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _sortBy,
                    decoration: InputDecoration(
                      labelText: 'ترتيب',
                      filled: true,
                      fillColor: AppTheme.getCardColor(context),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'newest', child: Text('الأحدث')),
                      DropdownMenuItem(value: 'price_low', child: Text('الأقل سعراً')),
                      DropdownMenuItem(value: 'price_high', child: Text('الأعلى سعراً')),
                      DropdownMenuItem(value: 'rating', child: Text('الأعلى تقييماً')),
                    ],
                    onChanged: (v) {
                      setState(() => _sortBy = v!);
                      _filterProducts();
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // عرض المنتجات
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredProducts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inbox, size: 80, color: AppTheme.goldColor.withOpacity(0.5)),
                            const SizedBox(height: 16),
                            const Text('لا توجد إعلانات'),
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
                        itemCount: _filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = _filteredProducts[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AdDetailScreen(product: product),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.getCardColor(context),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                    child: CachedNetworkImage(
                                      imageUrl: product.images.first,
                                      height: 120,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      placeholder: (_, __) => Container(
                                        height: 120,
                                        color: AppTheme.goldColor.withOpacity(0.1),
                                      ),
                                      errorWidget: (_, __, ___) => Container(
                                        height: 120,
                                        color: AppTheme.goldColor.withOpacity(0.1),
                                        child: const Icon(Icons.image),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.title,
                                          maxLines: 1,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${product.price.toStringAsFixed(0)} ر.ي',
                                          style: const TextStyle(
                                            color: AppTheme.goldColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on, size: 10, color: Colors.grey),
                                            const SizedBox(width: 2),
                                            Expanded(
                                              child: Text(
                                                product.city,
                                                style: const TextStyle(fontSize: 10, color: Colors.grey),
                                                maxLines: 1,
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
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
