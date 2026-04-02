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
  final ScrollController _scrollController = ScrollController();
  
  String _selectedCategory = 'الكل';
  String _selectedCity = 'الكل';
  String _sortBy = 'newest';
  RangeValues _priceRange = const RangeValues(0, 10000000);
  double _minRating = 0;
  bool _showFilter = false;
  bool _isLoading = true;
  bool _hasMore = true;
  int _currentPage = 1;
  final int _itemsPerPage = 10;
  
  List<ProductModel> _allProducts = [];
  List<ProductModel> _displayedProducts = [];

  final List<String> _categories = ['الكل', 'عقارات', 'سيارات', 'إلكترونيات', 'أزياء', 'أثاث', 'مطاعم', 'خدمات'];
  final List<String> _cities = ['الكل', 'صنعاء', 'عدن', 'تعز', 'الحديدة', 'المكلا', 'إب', 'ذمار'];

  // قائمة المنتجات الكاملة (50 منتج)
  final List<ProductModel> _fullProductsList = List.generate(50, (index) {
    final categories = ['عقارات', 'سيارات', 'إلكترونيات', 'أزياء', 'أثاث', 'مطاعم'];
    final cities = ['صنعاء', 'عدن', 'تعز', 'الحديدة', 'المكلا'];
    final titles = [
      'منتج مميز ${index + 1}', 'سلعة رائعة ${index + 1}', 'عرض خاص ${index + 1}',
      'جودة عالية ${index + 1}', 'سعر منافس ${index + 1}', 'تخفيضات ${index + 1}'
    ];
    final images = [
      'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400',
      'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400',
      'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400',
      'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400',
    ];
    
    return ProductModel(
      id: (index + 1).toString(),
      title: titles[index % titles.length],
      description: '',
      price: 10000 * (index + 1) * (index % 5 + 1),
      images: [images[index % images.length]],
      category: categories[index % categories.length],
      city: cities[index % cities.length],
      sellerId: '1',
      sellerName: 'بائع ${index + 1}',
      rating: 3 + (index % 20) / 10,
      reviewCount: (index + 1) * 5,
      createdAt: DateTime.now().subtract(Duration(days: index)),
      isFeatured: index < 10,
    );
  });

  @override
  void initState() {
    super.initState();
    _allProducts = List.from(_fullProductsList);
    _filterAndLoadMore();
    _searchController.addListener(_filterAndReset);
    _scrollController.addListener(_onScroll);
  }

  void _filterAndReset() {
    setState(() {
      _currentPage = 1;
      _displayedProducts.clear();
      _hasMore = true;
      _filterAndLoadMore();
    });
  }

  void _filterAndLoadMore() {
    final filtered = _allProducts.where((p) {
      final matchesSearch = _searchController.text.isEmpty || p.title.toLowerCase().contains(_searchController.text.toLowerCase());
      final matchesCategory = _selectedCategory == 'الكل' || p.category == _selectedCategory;
      final matchesCity = _selectedCity == 'الكل' || p.city == _selectedCity;
      final matchesPrice = p.price >= _priceRange.start && p.price <= _priceRange.end;
      final matchesRating = (p.rating ?? 0) >= _minRating;
      return matchesSearch && matchesCategory && matchesCity && matchesPrice && matchesRating;
    }).toList();

    final start = (_currentPage - 1) * _itemsPerPage;
    final end = start + _itemsPerPage;
    final newItems = filtered.skip(start).take(_itemsPerPage).toList();

    setState(() {
      _displayedProducts.addAll(newItems);
      _hasMore = end < filtered.length;
      _isLoading = false;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && _hasMore && !_isLoading) {
      setState(() {
        _isLoading = true;
        _currentPage++;
        _filterAndLoadMore();
      });
    }
  }

  void _applyFilters() {
    setState(() {
      _currentPage = 1;
      _displayedProducts.clear();
      _hasMore = true;
      _isLoading = true;
      _filterAndLoadMore();
      _showFilter = false;
    });
  }

  void _resetFilters() {
    setState(() {
      _selectedCategory = 'الكل';
      _selectedCity = 'الكل';
      _priceRange = const RangeValues(0, 10000000);
      _minRating = 0;
      _sortBy = 'newest';
      _searchController.clear();
      _currentPage = 1;
      _displayedProducts.clear();
      _hasMore = true;
      _sortProducts();
      _applyFilters();
    });
  }

  void _sortProducts() {
    if (_sortBy == 'newest') {
      _allProducts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else if (_sortBy == 'price_low') {
      _allProducts.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortBy == 'price_high') {
      _allProducts.sort((a, b) => b.price.compareTo(a.price));
    } else if (_sortBy == 'rating') {
      _allProducts.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
    }
    _applyFilters();
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
                          _filterAndReset();
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
            height: _showFilter ? 320 : 0,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildFilterDropdown('الفئة', _selectedCategory, _categories, (v) {
                    setState(() => _selectedCategory = v);
                  }),
                  const SizedBox(height: 12),
                  _buildFilterDropdown('المدينة', _selectedCity, _cities, (v) {
                    setState(() => _selectedCity = v);
                  }),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text('السعر: ${_priceRange.start.toStringAsFixed(0)} - ${_priceRange.end.toStringAsFixed(0)} ر.ي', style: const TextStyle(fontSize: 12)),
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
                    onChanged: (values) => setState(() => _priceRange = values),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text('الحد الأدنى للتقييم: ', style: TextStyle(fontSize: 12)),
                      Row(
                        children: List.generate(5, (index) {
                          return IconButton(
                            icon: Icon(index < _minRating ? Icons.star : Icons.star_border, color: Colors.amber, size: 20),
                            onPressed: () => setState(() => _minRating = index + 1.0),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _resetFilters,
                          icon: const Icon(Icons.refresh),
                          label: const Text('إعادة تعيين'),
                          style: OutlinedButton.styleFrom(side: const BorderSide(color: AppTheme.goldColor)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _applyFilters,
                          icon: const Icon(Icons.check),
                          label: const Text('تطبيق'),
                          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // خيارات الترتيب وعدد النتائج
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
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
                Text(
                  '${_displayedProducts.length}',
                  style: const TextStyle(fontSize: 12, color: AppTheme.goldColor),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // عرض النتائج مع تحميل المزيد
          Expanded(
            child: _displayedProducts.isEmpty && _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _displayedProducts.isEmpty
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
                        controller: _scrollController,
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: _displayedProducts.length + (_hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == _displayedProducts.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: SizedBox(
                                  width: 30, height: 30,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                              ),
                            );
                          }
                          final product = _displayedProducts[index];
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
