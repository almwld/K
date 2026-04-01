import 'package:flutter/material.dart';
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
  
  final List<String> _categories = ['الكل', 'إلكترونيات', 'سيارات', 'عقارات', 'أزياء', 'أثاث'];
  
  @override
  void initState() {
    super.initState();
    _loadProducts();
  }
  
  void _loadProducts() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _products = sampleProducts;
        _filterProducts();
        _isLoading = false;
      });
    });
  }
  
  void _filterProducts() {
    var filtered = List<ProductModel>.from(_products);
    
    if (_selectedCategory != 'الكل') {
      filtered = filtered.where((p) => p.category == _selectedCategory).toList();
    }
    
    if (_searchController.text.isNotEmpty) {
      filtered = filtered.where((p) => p.title.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
    }
    
    if (_sortBy == 'newest') {
      filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else if (_sortBy == 'price_low') {
      filtered.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortBy == 'price_high') {
      filtered.sort((a, b) => b.price.compareTo(a.price));
    } else if (_sortBy == 'rating') {
      filtered.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
    }
    
    setState(() => _filteredProducts = filtered);
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'جميع الإعلانات'),
      body: Column(
        children: [
          // شريط البحث
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => _filterProducts(),
              decoration: InputDecoration(
                hintText: 'بحث...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppTheme.getCardColor(context),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),
          
          // الفلتر والترتيب
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildFilterDropdown('الفئة', _selectedCategory, _categories, (v) {
                    setState(() => _selectedCategory = v);
                    _filterProducts();
                  }),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildFilterDropdown('ترتيب', _sortBy, ['newest', 'price_low', 'price_high', 'rating'],
                    (v) { setState(() => _sortBy = v); _filterProducts(); },
                    getLabel: (v) {
                      switch(v) {
                        case 'newest': return 'الأحدث';
                        case 'price_low': return 'الأقل سعراً';
                        case 'price_high': return 'الأعلى سعراً';
                        case 'rating': return 'الأعلى تقييماً';
                        default: return 'الأحدث';
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          
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
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppTheme.goldColor.withOpacity(0.1),
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                      ),
                                      child: const Center(child: Icon(Icons.image, color: AppTheme.goldColor, size: 40)),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(product.title, maxLines: 1, style: const TextStyle(fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 4),
                                          Text('${product.price.toStringAsFixed(0)} ر.ي', style: const TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on, size: 12, color: AppTheme.getSecondaryTextColor(context)),
                                              const SizedBox(width: 2),
                                              Expanded(child: Text(product.city, style: TextStyle(fontSize: 10, color: AppTheme.getSecondaryTextColor(context)))),
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
  
  Widget _buildFilterDropdown(String label, String value, List<String> items, Function(String) onChanged, {String Function(String)? getLabel}) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppTheme.getCardColor(context),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(getLabel != null ? getLabel(item) : item))).toList(),
      onChanged: (v) => onChanged(v!),
    );
  }
}
