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
  String _selectedCity = 'الكل';
  String _sortBy = 'newest';
  RangeValues _priceRange = const RangeValues(0, 10000000);
  double _minRating = 0;
  bool _showFilter = false;
  
  List<ProductModel> _products = [];
  List<ProductModel> _filteredProducts = [];
  bool _isLoading = true;

  final List<String> _categories = ['الكل', 'عقارات', 'سيارات', 'إلكترونيات', 'أزياء', 'أثاث', 'مطاعم', 'خدمات'];
  final List<String> _cities = ['الكل', 'صنعاء', 'عدن', 'تعز', 'الحديدة', 'المكلا', 'إب', 'ذمار'];

  final List<ProductModel> _allProducts = [
    ProductModel(id: '1', title: 'شقة فاخرة في حدة', description: '', price: 35000000, images: ['https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400'], category: 'عقارات', city: 'صنعاء', sellerId: '1', sellerName: 'عقارات فلكس', rating: 4.8, createdAt: DateTime.now()),
    ProductModel(id: '2', title: 'تويوتا كامري 2024', description: '', price: 8500000, images: ['https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400'], category: 'سيارات', city: 'صنعاء', sellerId: '2', sellerName: 'معرض السيارات', rating: 4.7, createdAt: DateTime.now()),
    ProductModel(id: '3', title: 'ماك بوك برو M3', description: '', price: 1800000, images: ['https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400'], category: 'إلكترونيات', city: 'عدن', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.9, createdAt: DateTime.now()),
    ProductModel(id: '4', title: 'سامسونج S24 الترا', description: '', price: 380000, images: ['https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.8, createdAt: DateTime.now()),
    ProductModel(id: '5', title: 'فيلا فاخرة', description: '', price: 150000000, images: ['https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=400'], category: 'عقارات', city: 'صنعاء', sellerId: '3', sellerName: 'عقارات فلكس', rating: 4.9, createdAt: DateTime.now()),
    ProductModel(id: '6', title: 'هيونداي النترا', description: '', price: 6500000, images: ['https://images.unsplash.com/photo-1555215695-3004980ad54e?w=400'], category: 'سيارات', city: 'عدن', sellerId: '2', sellerName: 'معرض السيارات', rating: 4.6, createdAt: DateTime.now()),
    ProductModel(id: '7', title: 'آيباد برو', description: '', price: 320000, images: ['https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.8, createdAt: DateTime.now()),
    ProductModel(id: '8', title: 'مندي دجاج عائلي', description: '', price: 8000, images: ['https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400'], category: 'مطاعم', city: 'صنعاء', sellerId: '6', sellerName: 'مطعم الأصيل', rating: 4.9, createdAt: DateTime.now()),
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
        final matchesSearch = _searchController.text.isEmpty || p.title.toLowerCase().contains(_searchController.text.toLowerCase());
        final matchesCategory = _selectedCategory == 'الكل' || p.category == _selectedCategory;
        final matchesCity = _selectedCity == 'الكل' || p.city == _selectedCity;
        final matchesPrice = p.price >= _priceRange.start && p.price <= _priceRange.end;
        final matchesRating = (p.rating ?? 0) >= _minRating;
        return matchesSearch && matchesCategory && matchesCity && matchesPrice && matchesRating;
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

  void _resetFilters() {
    setState(() {
      _selectedCategory = 'الكل';
      _selectedCity = 'الكل';
      _priceRange = const RangeValues(0, 10000000);
      _minRating = 0;
      _sortBy = 'newest';
      _searchController.clear();
      _filterProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(
        title: 'جميع الإعلانات',
        actions: [
          IconButton(
            icon: Icon(_showFilter ? Icons.filter_alt : Icons.filter_alt_outlined, color: AppTheme.goldColor),
            onPressed: () => setState(() => _showFilter = !_showFilter),
          ),
        ],
      ),
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
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _filterProducts();
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppTheme.getCardColor(context),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),

          // لوحة الفلتر المتقدم
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _showFilter ? 280 : 0,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // الفئة
                  _buildFilterDropdown('الفئة', _selectedCategory, _categories, (v) {
                    setState(() => _selectedCategory = v);
                    _filterProducts();
                  }),
                  const SizedBox(height: 12),

                  // المدينة
                  _buildFilterDropdown('المدينة', _selectedCity, _cities, (v) {
                    setState(() => _selectedCity = v);
                    _filterProducts();
                  }),
                  const SizedBox(height: 12),

                  // نطاق السعر
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'السعر: ${_priceRange.start.toStringAsFixed(0)} - ${_priceRange.end.toStringAsFixed(0)} ر.ي',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      TextButton(
                        onPressed: () => setState(() => _priceRange = const RangeValues(0, 10000000)),
                        child: const Text('إعادة تعيين'),
                      ),
                    ],
                  ),
                  RangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: 10000000,
                    divisions: 100,
                    activeColor: AppTheme.goldColor,
                    onChanged: (values) {
                      setState(() => _priceRange = values);
                      _filterProducts();
                    },
                  ),
                  const SizedBox(height: 12),

                  // الحد الأدنى للتقييم
                  Row(
                    children: [
                      const Text('الحد الأدنى للتقييم: ', style: TextStyle(fontSize: 12)),
                      Row(
                        children: List.generate(5, (index) {
                          return IconButton(
                            icon: Icon(index < _minRating ? Icons.star : Icons.star_border, color: Colors.amber, size: 20),
                            onPressed: () {
                              setState(() => _minRating = index + 1.0);
                              _filterProducts();
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // زر إعادة تعيين الفلتر
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _resetFilters,
                      icon: const Icon(Icons.refresh),
                      label: const Text('إعادة تعيين جميع الفلاتر'),
                      style: OutlinedButton.styleFrom(side: const BorderSide(color: AppTheme.goldColor)),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // خيارات الترتيب
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
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
          ),

          const SizedBox(height: 12),

          // عرض النتائج
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
                            const SizedBox(height: 8),
                            Text(
                              'حاول تغيير معايير البحث',
                              style: TextStyle(color: AppTheme.getSecondaryTextColor(context)),
                            ),
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
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdDetailScreen(product: product))),
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
                                      placeholder: (_, __) => Container(height: 120, color: AppTheme.goldColor.withOpacity(0.1)),
                                      errorWidget: (_, __, ___) => Container(height: 120, color: AppTheme.goldColor.withOpacity(0.1), child: const Icon(Icons.image)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(product.title, maxLines: 1, style: const TextStyle(fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 4),
                                        Text('${product.price.toStringAsFixed(0)} ر.ي', style: const TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 2),
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on, size: 10, color: Colors.grey),
                                            const SizedBox(width: 2),
                                            Expanded(child: Text(product.city, style: const TextStyle(fontSize: 10, color: Colors.grey))),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.star, size: 10, color: Colors.amber),
                                            const SizedBox(width: 2),
                                            Text('${product.rating}', style: const TextStyle(fontSize: 10)),
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

  Widget _buildFilterDropdown(String label, String value, List<String> items, Function(String) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppTheme.getCardColor(context),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      onChanged: (v) => onChanged(v!),
    );
  }

  Widget _buildSortChip(String label, String value) {
    final isSelected = _sortBy == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() => _sortBy = value);
        _sortProducts();
      },
      selectedColor: AppTheme.goldColor,
      backgroundColor: AppTheme.getCardColor(context),
      checkmarkColor: Colors.black,
      labelStyle: TextStyle(color: isSelected ? Colors.black : AppTheme.getTextColor(context)),
    );
  }
}
