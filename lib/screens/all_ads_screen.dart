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
  
  List<ProductModel> _filteredProducts = [];
  bool _isLoading = true;

  final List<String> _categories = ['الكل', 'عقارات', 'سيارات', 'إلكترونيات', 'أزياء', 'أثاث', 'مطاعم'];
  final List<String> _cities = ['الكل', 'صنعاء', 'عدن', 'تعز', 'الحديدة', 'المكلا', 'إب', 'ذمار'];

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadProducts() {
    setState(() {
      _filteredProducts = List.from(sampleProducts);
      _isLoading = false;
    });
  }

  void _filterProducts() {
    setState(() {
      _filteredProducts = sampleProducts.where((p) {
        final matchesSearch = _searchController.text.isEmpty ||
            p.title.toLowerCase().contains(_searchController.text.toLowerCase());
        final matchesCategory = _selectedCategory == 'الكل' || p.category == _selectedCategory;
        final matchesCity = _selectedCity == 'الكل' || p.city == _selectedCity;
        final matchesPrice = p.price >= _priceRange.start && p.price <= _priceRange.end;
        final matchesRating = p.rating >= _minRating;
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
      _filteredProducts.sort((a, b) => b.rating.compareTo(a.rating));
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
      _showFilter = false;
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
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
                  DropdownButtonFormField<String>(
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
                  const SizedBox(height: 12),
                  
                  // المدينة
                  DropdownButtonFormField<String>(
                    value: _selectedCity,
                    decoration: InputDecoration(
                      labelText: 'المدينة',
                      filled: true,
                      fillColor: AppTheme.getCardColor(context),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: _cities.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (v) {
                      setState(() => _selectedCity = v!);
                      _filterProducts();
                    },
                  ),
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
                        child: const Text('إعادة'),
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
                  
                  // زر إعادة تعيين
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
                            Text('حاول تغيير معايير البحث', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
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
                                  Expanded(
                                    flex: 3,
                                    child: ClipRRect(
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
                                          Row(
                                            children: [
                                              const Icon(Icons.star, size: 10, color: Colors.amber),
                                              const SizedBox(width: 2),
                                              Text(
                                                '${product.rating}',
                                                style: const TextStyle(fontSize: 10),
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
