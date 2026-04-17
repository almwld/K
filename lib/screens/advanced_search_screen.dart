import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../models/product_model.dart';
import '../widgets/shimmer_effect.dart';
import 'ad_detail_screen.dart';

class AdvancedSearchScreen extends StatefulWidget {
  const AdvancedSearchScreen({super.key});

  @override
  State<AdvancedSearchScreen> createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends State<AdvancedSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  String _selectedCategory = 'الكل';
  String _selectedCity = 'الكل';
  String _sortBy = 'newest';
  RangeValues _priceRange = const RangeValues(0, 10000000);
  double _minRating = 0;
  bool _isLoading = false;
  List<ProductModel> _results = [];
  bool _hasSearched = false;

  final List<String> _categories = ['الكل', 'عقارات', 'سيارات', 'إلكترونيات', 'أزياء', 'أثاث', 'مطاعم'];
  final List<String> _cities = ['الكل', 'صنعاء', 'عدن', 'تعز', 'الحديدة', 'المكلا', 'إب', 'ذمار'];

  void _performSearch() {
    setState(() {
      _isLoading = true;
      _hasSearched = true;
    });

    // محاكاة البحث
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _results = sampleProducts.where((p) {
          final matchesSearch = _searchController.text.isEmpty ||
              p.title.toLowerCase().contains(_searchController.text.toLowerCase());
          final matchesCategory = _selectedCategory == 'الكل' || p.category == _selectedCategory;
          final matchesCity = _selectedCity == 'الكل' || p.city == _selectedCity;
          final matchesPrice = p.price >= _priceRange.start && p.price <= _priceRange.end;
          final matchesRating = (p.rating ?? 0) >= _minRating;
          return matchesSearch && matchesCategory && matchesCity && matchesPrice && matchesRating;
        }).toList();
        _sortResults();
        _isLoading = false;
      });
    });
  }

  void _sortResults() {
    if (_sortBy == 'newest') {
      _results.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else if (_sortBy == 'price_low') {
      _results.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortBy == 'price_high') {
      _results.sort((a, b) => b.price.compareTo(a.price));
    } else if (_sortBy == 'rating') {
      _results.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
    }
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _selectedCategory = 'الكل';
      _selectedCity = 'الكل';
      _priceRange = const RangeValues(0, 10000000);
      _minRating = 0;
      _sortBy = 'newest';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'بحث متقدم'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // شريط البحث
            Container(
              padding: const EdgeInsets.all(16),
              color: AppTheme.getCardColor(context),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'ابحث عن منتج...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: isDark ? AppTheme.darkCard : Colors.grey[100],
                      ),
                      onSubmitted: (_) => _performSearch(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _performSearch,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.goldPrimary,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    ),
                    child: const Text('بحث'),
                  ),
                ],
              ),
            ),

            // فلتر متقدم
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('فلتر متقدم', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  // الفئة والمدينة
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          decoration: InputDecoration(labelText: 'الفئة', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                          items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                          onChanged: (v) => setState(() => _selectedCategory = v!),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedCity,
                          decoration: InputDecoration(labelText: 'المدينة', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                          items: _cities.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                          onChanged: (v) => setState(() => _selectedCity = v!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // نطاق السعر
                  Text('نطاق السعر: ${_priceRange.start.toStringAsFixed(0)} - ${_priceRange.end.toStringAsFixed(0)} ر.ي'),
                  RangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: 10000000,
                    divisions: 100,
                    activeColor: AppTheme.goldPrimary,
                    onChanged: (values) => setState(() => _priceRange = values),
                  ),
                  const SizedBox(height: 16),
                  // التقييم
                  Row(
                    children: [
                      const Text('الحد الأدنى للتقييم: '),
                      Row(
                        children: List.generate(5, (index) {
                          return IconButton(
                            icon: Icon(index < _minRating ? Icons.star : Icons.star_border, color: Colors.amber, size: 24),
                            onPressed: () => setState(() => _minRating = index + 1.0),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // الترتيب
                  Row(
                    children: [
                      const Text('ترتيب حسب: '),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SegmentedButton<String>(
                          segments: const [
                            ButtonSegment(value: 'newest', label: Text('الأحدث')),
                            ButtonSegment(value: 'price_low', label: Text('الأقل سعراً')),
                            ButtonSegment(value: 'price_high', label: Text('الأعلى سعراً')),
                            ButtonSegment(value: 'rating', label: Text('الأعلى تقييماً')),
                          ],
                          selected: {_sortBy},
                          onSelectionChanged: (Set<String> selection) => setState(() => _sortBy = selection.first),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _resetFilters,
                          icon: const Icon(Icons.refresh),
                          label: const Text('إعادة تعيين'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _performSearch,
                          icon: const Icon(Icons.search),
                          label: const Text('بحث'),
                          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldPrimary, foregroundColor: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // النتائج
            if (_hasSearched)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'نتائج البحث: ${_results.length} منتج',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

            _isLoading
                ? const ShimmerGrid(itemCount: 6)
                : _hasSearched && _results.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Icon(Icons.search_off, size: 80, color: AppTheme.goldPrimary.withOpacity(0.5)),
                            const SizedBox(height: 16),
                            const Text('لا توجد نتائج', style: TextStyle(fontSize: 18)),
                            const SizedBox(height: 8),
                            Text('حاول تغيير معايير البحث', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
                          ],
                        ),
                      )
                    : _hasSearched
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(16),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: _results.length,
                            itemBuilder: (context, index) {
                              final product = _results[index];
                              return GestureDetector(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(productId: product.name, productName: product.name, storeName: product.store))),
                                child: Container(
                                  decoration: BoxDecoration(color: AppTheme.getCardColor(context), borderRadius: BorderRadius.circular(16)),
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
                                          placeholder: (_, __) => Container(height: 120, color: AppTheme.goldPrimary.withOpacity(0.1)),
                                          errorWidget: (_, __, ___) => Container(height: 120, color: AppTheme.goldPrimary.withOpacity(0.1), child: const Icon(Icons.image)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(product.title, maxLines: 1, style: const TextStyle(fontWeight: FontWeight.bold)),
                                            const SizedBox(height: 4),
                                            Text('${product.price.toStringAsFixed(0)} ر.ي', style: const TextStyle(color: AppTheme.goldPrimary, fontWeight: FontWeight.bold)),
                                            Row(children: [const Icon(Icons.star, size: 10, color: Colors.amber), const SizedBox(width: 2), Text('${product.rating}', style: const TextStyle(fontSize: 10))]),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
