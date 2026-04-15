import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import '../../widgets/shimmer_image.dart';
import '../product/product_detail_screen.dart';
import '../category_products_screen.dart';
import '../all_ads_screen.dart';
import '../auctions_screen.dart';
import '../login_screen.dart';
import '../register_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentCarouselIndex = 0;
  bool _isLoading = true;
  
  final List<Map<String, dynamic>> _carouselItems = [
    {'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800', 'title': 'مندي يمني', 'subtitle': 'لحم ضأن مع أرز', 'discount': 'خصم 20%'},
    {'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=800', 'title': 'عقارات فاخرة', 'subtitle': 'فلل وشقق', 'discount': 'خصم 30%'},
    {'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=800', 'title': 'سيارات جديدة', 'subtitle': 'أحدث الموديلات', 'discount': 'خصم 25%'},
    {'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800', 'title': 'إلكترونيات', 'subtitle': 'هواتف وكومبيوترات', 'discount': 'خصم 40%'},
  ];

  List<Map<String, dynamic>> _products = [];
  final List<Map<String, dynamic>> _categories = [
    {'id': 'electronics', 'name': 'إلكترونيات', 'icon': Icons.electrical_services, 'color': 0xFF9C27B0},
    {'id': 'fashion', 'name': 'أزياء', 'icon': Icons.checkroom, 'color': 0xFFE91E63},
    {'id': 'furniture', 'name': 'أثاث', 'icon': Icons.weekend, 'color': 0xFF795548},
    {'id': 'cars', 'name': 'سيارات', 'icon': Icons.directions_car, 'color': 0xFF4CAF50},
    {'id': 'real_estate', 'name': 'عقارات', 'icon': Icons.house, 'color': 0xFF2196F3},
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _products = [
        {'id': '1', 'name': 'آيفون 15 برو', 'price': '450,000', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400', 'tag': 'إلكتروني'},
        {'id': '2', 'name': 'سامسونج S24', 'price': '380,000', 'image': 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400', 'tag': 'إلكتروني'},
        {'id': '3', 'name': 'ماك بوك برو M3', 'price': '1,800,000', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400', 'tag': 'إلكتروني'},
        {'id': '4', 'name': 'فيلا فاخرة', 'price': '45,000,000', 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400', 'tag': 'عقار'},
        {'id': '5', 'name': 'تويوتا كامري', 'price': '8,500,000', 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400', 'tag': 'سيارة'},
        {'id': '6', 'name': 'مندي يمني', 'price': '3,500', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400', 'tag': 'مطعم'},
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('فلكس يمن', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.goldColor,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
            icon: const Icon(Icons.login, size: 18, color: Colors.black),
            label: const Text('دخول', style: TextStyle(color: Colors.black, fontSize: 14)),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppTheme.goldColor),
            child: const Text('إنشاء حساب', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        color: AppTheme.goldColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              _isLoading ? const CarouselShimmer() : _buildCarousel(),
              const SizedBox(height: 16),
              _buildMazadAlJanabi(),
              const SizedBox(height: 24),
              _buildSectionHeader('الأقسام الرئيسية'),
              _isLoading ? _buildCategoriesShimmer() : _buildCategories(),
              const SizedBox(height: 24),
              _buildSectionHeader('منتجات مميزة'),
              _isLoading ? const ProductGridShimmer() : _buildProductsGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesShimmer() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        itemBuilder: (context, index) => const CategoryShimmer(),
      ),
    );
  }

  Widget _buildCarousel() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(height: 180, autoPlay: true, enlargeCenterPage: true, viewportFraction: 0.9, onPageChanged: (index, reason) => setState(() => _currentCarouselIndex = index)),
          items: _carouselItems.map((item) => Builder(builder: (context) => Container(
            width: double.infinity, margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ShimmerImage(
              imageUrl: item['image'],
              borderRadius: BorderRadius.circular(20),
              height: 180,
              width: double.infinity,
              errorWidget: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey[300]),
                child: const Center(child: Icon(Icons.image_not_supported)),
              ),
            ),
          ))).toList(),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: _carouselItems.asMap().entries.map((entry) => Container(width: 8, height: 8, margin: const EdgeInsets.symmetric(horizontal: 4), decoration: BoxDecoration(shape: BoxShape.circle, color: _currentCarouselIndex == entry.key ? AppTheme.goldColor : Colors.grey.withOpacity(0.5)))).toList()),
      ],
    );
  }

  Widget _buildMazadAlJanabi() {
    return Container(margin: const EdgeInsets.symmetric(horizontal: 16), padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [AppTheme.goldColor, AppTheme.goldDark]), borderRadius: BorderRadius.circular(15)),
      child: Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('مزاد الجنابي', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), const Text('أكبر مزاد للسيوف التراثية', style: TextStyle(color: Colors.white70)), const SizedBox(height: 8), ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AuctionsScreen())), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppTheme.goldColor), child: const Text('شارك الآن'))])), const Icon(Icons.emoji_events, size: 60, color: Colors.white)]),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AllAdsScreen())), child: Text('عرض الكل', style: TextStyle(color: AppTheme.goldColor)))]) );
  }

  Widget _buildCategories() {
    return SizedBox(height: 100, child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: _categories.length, itemBuilder: (context, index) {
      final cat = _categories[index];
      return GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryProductsScreen(categoryId: cat['id'], categoryName: cat['name']))),
        child: Container(width: 80, margin: const EdgeInsets.symmetric(horizontal: 8), child: Column(children: [Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Color(cat['color']).withOpacity(0.1), shape: BoxShape.circle), child: Icon(cat['icon'], color: Color(cat['color']), size: 30)), const SizedBox(height: 8), Text(cat['name'], style: const TextStyle(fontSize: 12))])),
      );
    }));
  }

  Widget _buildProductsGrid() {
    return GridView.builder(
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), padding: const EdgeInsets.symmetric(horizontal: 12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 12, mainAxisSpacing: 12),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(productId: product['id'], productName: product['name']))),
          child: Container(
            decoration: BoxDecoration(color: AppTheme.getCardColor(context), borderRadius: BorderRadius.circular(12)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: ShimmerImage(
                    imageUrl: product['image'],
                    height: 130,
                    width: double.infinity,
                  ),
                ),
                Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(product['name'], maxLines: 2, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), const SizedBox(height: 4), Text('${product['price']} ريال', style: TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold, fontSize: 14)), const SizedBox(height: 4), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Text(product['tag'], style: TextStyle(color: AppTheme.goldColor, fontSize: 10)))])),
              ],
            ),
          ),
        );
      },
    );
  }
}
