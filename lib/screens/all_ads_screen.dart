import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../models/product_model.dart';
import '../widgets/shimmer_effect.dart';
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
  String _sortBy = 'newest';
  bool _showFilter = false;
  bool _isLoading = true;
  bool _hasMore = true;
  int _currentPage = 1;
  final int _itemsPerPage = 10;
  
  List<ProductModel> _allProducts = [];
  List<ProductModel> _displayedProducts = [];

  final List<String> _categories = ['الكل', 'عقارات', 'سيارات', 'إلكترونيات', 'أزياء', 'أثاث', 'مطاعم'];

  @override
  void initState() {
    super.initState();
    _allProducts = List.from(sampleProducts);
    _loadMore();
    _searchController.addListener(_filterAndReset);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _filterAndReset() {
    setState(() {
      _currentPage = 1;
      _displayedProducts.clear();
      _hasMore = true;
      _loadMore();
    });
  }

  void _loadMore() {
    if (!_hasMore) return;
    
    final filtered = _allProducts.where((p) {
      final matchesSearch = _searchController.text.isEmpty ||
          p.title.toLowerCase().contains(_searchController.text.toLowerCase());
      final matchesCategory = _selectedCategory == 'الكل' || p.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    final start = (_currentPage - 1) * _itemsPerPage;
    final end = start + _itemsPerPage;
    final newItems = filtered.skip(start).take(_itemsPerPage).toList();

    setState(() {
      _displayedProducts.addAll(newItems);
      _hasMore = end < filtered.length;
      _currentPage++;
      _isLoading = false;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && _hasMore && !_isLoading) {
      setState(() => _isLoading = true);
      _loadMore();
    }
  }

  void _sortProducts() {
    if (_sortBy == 'newest') {
      _displayedProducts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else if (_sortBy == 'price_low') {
      _displayedProducts.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortBy == 'price_high') {
      _displayedProducts.sort((a, b) => b.price.compareTo(a.price));
    } else if (_sortBy == 'rating') {
      _displayedProducts.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
    }
    setState(() {});
  }

  void _resetFilters() {
    setState(() {
      _selectedCategory = 'الكل';
      _searchController.clear();
      _currentPage = 1;
      _displayedProducts.clear();
      _hasMore = true;
      _loadMore();
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
                        onPressed: _filterAndReset,
                      )
                    : null,
                filled: true,
                fillColor: AppTheme.getCardColor(context),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),

          // لوحة الفلتر
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _showFilter ? 120 : 0,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'الفئة',
                      filled: true,
                      fillColor: AppTheme.getCardColor(context),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                    items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (v) {
                      setState(() => _selectedCategory = v!);
                      _filterAndReset();
                    },
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _resetFilters,
                      icon: const Icon(Icons.refresh),
                      label: const Text('إعادة تعيين'),
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
          
          // عرض المنتجات مع تحميل تدريجي
          Expanded(
            child: _displayedProducts.isEmpty && _isLoading
                ? const ShimmerGrid(itemCount: 6)
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
                                        Row(children: [const Icon(Icons.star, size: 10, color: Colors.amber), const SizedBox(width: 2), Text('${product.rating}', style: const TextStyle(fontSize: 10))]),
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
