import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  List<ProductModel> _filteredProducts = [];
  bool _isLoading = true;
  String _sortBy = 'newest';
  final TextEditingController _searchController = TextEditingController();

  final List<ProductModel> _allProducts = [
    ProductModel(id: '1', title: 'آيفون 15 برو ماكس', description: '', price: 450000, images: ['https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400'], category: 'electronics', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.9, createdAt: DateTime.now()),
    ProductModel(id: '2', title: 'سامسونج S24 الترا', description: '', price: 380000, images: ['https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400'], category: 'electronics', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.8, createdAt: DateTime.now()),
    ProductModel(id: '3', title: 'ماك بوك برو M3', description: '', price: 1800000, images: ['https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400'], category: 'electronics', city: 'عدن', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.9, createdAt: DateTime.now()),
    ProductModel(id: '4', title: 'تويوتا كامري 2024', description: '', price: 8500000, images: ['https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400'], category: 'cars', city: 'صنعاء', sellerId: '2', sellerName: 'معرض السيارات', rating: 4.7, createdAt: DateTime.now()),
  ];

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _searchController.addListener(_filterProducts);
  }

  void _loadProducts() {
    setState(() {
      _products = _allProducts.where((p) => p.category == widget.category).toList();
      _filteredProducts = List.from(_products);
      _isLoading = false;
    });
  }

  void _filterProducts() {
    setState(() {
      _filteredProducts = _products.where((p) => p.title.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
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
      appBar: SimpleAppBar(title: widget.categoryName),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(16), child: TextField(controller: _searchController, decoration: InputDecoration(hintText: 'بحث...', prefixIcon: const Icon(Icons.search), filled: true, fillColor: AppTheme.getCardColor(context), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)))),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
            _buildSortChip('الأحدث', 'newest'), const SizedBox(width: 8),
            _buildSortChip('الأقل سعراً', 'price_low'), const SizedBox(width: 8),
            _buildSortChip('الأعلى سعراً', 'price_high'), const SizedBox(width: 8),
            _buildSortChip('الأعلى تقييماً', 'rating'),
          ]))),
          const SizedBox(height: 12),
          Expanded(child: _isLoading ? const Center(child: CircularProgressIndicator()) : _filteredProducts.isEmpty ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.inbox, size: 80, color: AppTheme.goldColor.withOpacity(0.5)), const SizedBox(height: 16), const Text('لا توجد منتجات')])) : GridView.builder(padding: const EdgeInsets.all(16), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.75, crossAxisSpacing: 12, mainAxisSpacing: 12), itemCount: _filteredProducts.length, itemBuilder: (context, index) {
            final product = _filteredProducts[index];
            return GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdDetailScreen(product: product))), child: Container(decoration: BoxDecoration(color: AppTheme.getCardColor(context), borderRadius: BorderRadius.circular(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(16)), child: CachedNetworkImage(imageUrl: product.images.first, height: 120, width: double.infinity, fit: BoxFit.cover, placeholder: (_, __) => Container(height: 120, color: AppTheme.goldColor.withOpacity(0.1)), errorWidget: (_, __, ___) => Container(height: 120, color: AppTheme.goldColor.withOpacity(0.1), child: const Icon(Icons.image)))),
              Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(product.title, maxLines: 1, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text('${product.price.toStringAsFixed(0)} ر.ي', style: const TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold)), Row(children: [const Icon(Icons.star, size: 12, color: Colors.amber), const SizedBox(width: 2), Text('${product.rating}')])])),
            ])));
          }))),
        ],
      ),
    );
  }

  Widget _buildSortChip(String label, String value) {
    final isSelected = _sortBy == value;
    return FilterChip(label: Text(label), selected: isSelected, onSelected: (selected) { setState(() { _sortBy = value; _sortProducts(); }); }, selectedColor: AppTheme.goldColor, backgroundColor: AppTheme.getCardColor(context), checkmarkColor: Colors.black, labelStyle: TextStyle(color: isSelected ? Colors.black : AppTheme.getTextColor(context)));
  }
}
