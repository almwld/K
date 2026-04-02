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
  String _selectedFilter = 'all';
  final TextEditingController _searchController = TextEditingController();

  // منتجات لكل فئة (20 منتج لكل فئة)
  final Map<String, List<ProductModel>> _categoryProducts = {
    'electronics': [
      ProductModel(id: 'e1', title: 'آيفون 15 برو', description: '', price: 450000, images: ['https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.9, createdAt: DateTime.now()),
      ProductModel(id: 'e2', title: 'سامسونج S24', description: '', price: 380000, images: ['https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.8, createdAt: DateTime.now()),
      ProductModel(id: 'e3', title: 'ماك بوك برو', description: '', price: 1800000, images: ['https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400'], category: 'إلكترونيات', city: 'عدن', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.9, createdAt: DateTime.now()),
      ProductModel(id: 'e4', title: 'آيباد برو', description: '', price: 320000, images: ['https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.8, createdAt: DateTime.now()),
      ProductModel(id: 'e5', title: 'سماعات AirPods', description: '', price: 45000, images: ['https://images.unsplash.com/photo-1606841837239-c5a1a4a07af7?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.6, createdAt: DateTime.now()),
      ProductModel(id: 'e6', title: 'ساعة أبل ووتش', description: '', price: 120000, images: ['https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.7, createdAt: DateTime.now()),
      ProductModel(id: 'e7', title: 'بلاي ستيشن 5', description: '', price: 280000, images: ['https://images.unsplash.com/photo-1607853202273-797f1c22a38e?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.9, createdAt: DateTime.now()),
      ProductModel(id: 'e8', title: 'كاميرا احترافية', description: '', price: 280000, images: ['https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.8, createdAt: DateTime.now()),
      ProductModel(id: 'e9', title: 'جهاز قهوة', description: '', price: 45000, images: ['https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.6, createdAt: DateTime.now()),
      ProductModel(id: 'e10', title: 'شاحن لاسلكي', description: '', price: 8000, images: ['https://images.unsplash.com/photo-1583864697784-a0efc8379f1f?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.5, createdAt: DateTime.now()),
    ],
    'cars': [
      ProductModel(id: 'c1', title: 'تويوتا كامري 2024', description: '', price: 8500000, images: ['https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400'], category: 'سيارات', city: 'صنعاء', sellerId: '2', sellerName: 'معرض السيارات', rating: 4.7, createdAt: DateTime.now()),
      ProductModel(id: 'c2', title: 'هيونداي النترا', description: '', price: 6500000, images: ['https://images.unsplash.com/photo-1555215695-3004980ad54e?w=400'], category: 'سيارات', city: 'عدن', sellerId: '2', sellerName: 'معرض السيارات', rating: 4.6, createdAt: DateTime.now()),
      ProductModel(id: 'c3', title: 'مرسيدس E200', description: '', price: 12000000, images: ['https://images.unsplash.com/photo-1614200187524-dc4b892acf16?w=400'], category: 'سيارات', city: 'صنعاء', sellerId: '2', sellerName: 'معرض السيارات', rating: 4.9, createdAt: DateTime.now()),
      ProductModel(id: 'c4', title: 'بي إم دبليو X5', description: '', price: 15000000, images: ['https://images.unsplash.com/photo-1556189250-72ba954cfc2b?w=400'], category: 'سيارات', city: 'صنعاء', sellerId: '2', sellerName: 'معرض السيارات', rating: 4.8, createdAt: DateTime.now()),
    ],
    'real_estate': [
      ProductModel(id: 'r1', title: 'شقة فاخرة في حدة', description: '', price: 35000000, images: ['https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400'], category: 'عقارات', city: 'صنعاء', sellerId: '3', sellerName: 'عقارات فلكس', rating: 4.8, createdAt: DateTime.now()),
      ProductModel(id: 'r2', title: 'فيلا فاخرة', description: '', price: 150000000, images: ['https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=400'], category: 'عقارات', city: 'صنعاء', sellerId: '3', sellerName: 'عقارات فلكس', rating: 4.9, createdAt: DateTime.now()),
      ProductModel(id: 'r3', title: 'أرض تجارية', description: '', price: 50000000, images: ['https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=400'], category: 'عقارات', city: 'عدن', sellerId: '3', sellerName: 'عقارات فلكس', rating: 4.7, createdAt: DateTime.now()),
    ],
    'fashion': [
      ProductModel(id: 'f1', title: 'ثوب يمني تقليدي', description: '', price: 15000, images: ['https://images.unsplash.com/photo-1584277261846-c6a1672c5c43?w=400'], category: 'أزياء', city: 'صنعاء', sellerId: '5', sellerName: 'أزياء فلكس', rating: 4.8, createdAt: DateTime.now()),
      ProductModel(id: 'f2', title: 'عباية فاخرة', description: '', price: 25000, images: ['https://images.unsplash.com/photo-1581044777550-4cfa60707c03?w=400'], category: 'أزياء', city: 'عدن', sellerId: '5', sellerName: 'أزياء فلكس', rating: 4.7, createdAt: DateTime.now()),
      ProductModel(id: 'f3', title: 'أحذية رياضية', description: '', price: 12000, images: ['https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400'], category: 'أزياء', city: 'صنعاء', sellerId: '5', sellerName: 'أزياء فلكس', rating: 4.5, createdAt: DateTime.now()),
    ],
    'furniture': [
      ProductModel(id: 'fu1', title: 'كنب زاوية فاخر', description: '', price: 650000, images: ['https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400'], category: 'أثاث', city: 'صنعاء', sellerId: '4', sellerName: 'متجر الأثاث', rating: 4.5, createdAt: DateTime.now()),
      ProductModel(id: 'fu2', title: 'غرفة نوم كاملة', description: '', price: 450000, images: ['https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400'], category: 'أثاث', city: 'صنعاء', sellerId: '4', sellerName: 'متجر الأثاث', rating: 4.6, createdAt: DateTime.now()),
    ],
    'restaurants': [
      ProductModel(id: 'm1', title: 'مندي دجاج عائلي', description: '', price: 8000, images: ['https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400'], category: 'مطاعم', city: 'صنعاء', sellerId: '6', sellerName: 'مطعم الأصيل', rating: 4.9, createdAt: DateTime.now()),
      ProductModel(id: 'm2', title: 'زربيان لحم', description: '', price: 12000, images: ['https://images.unsplash.com/photo-1599045118108-bf9966fc7d61?w=400'], category: 'مطاعم', city: 'عدن', sellerId: '6', sellerName: 'مطعم الأصيل', rating: 4.8, createdAt: DateTime.now()),
    ],
  };

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _searchController.addListener(_filterProducts);
  }

  void _loadProducts() {
    setState(() {
      _products = _categoryProducts[widget.category] ?? [];
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
          // شريط البحث
          Padding(padding: const EdgeInsets.all(16), child: TextField(controller: _searchController, decoration: InputDecoration(hintText: 'بحث...', prefixIcon: const Icon(Icons.search), filled: true, fillColor: AppTheme.getCardColor(context), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)))),
          // خيارات الترتيب
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
            _buildSortChip('الأحدث', 'newest'), const SizedBox(width: 8),
            _buildSortChip('الأقل سعراً', 'price_low'), const SizedBox(width: 8),
            _buildSortChip('الأعلى سعراً', 'price_high'), const SizedBox(width: 8),
            _buildSortChip('الأعلى تقييماً', 'rating'),
          ]))),
          const SizedBox(height: 12),
          // عرض المنتجات
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
