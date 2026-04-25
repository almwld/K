import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../../widgets/product_card.dart';
import '../../widgets/store_card.dart';
import '../../widgets/category_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _carouselIndex = 0;

  final List<Map<String, String>> _carouselItems = [
    {'title': 'عرض خاص', 'subtitle': 'خصم 50% على الإلكترونيات', 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=600'},
    {'title': 'عروض البرق', 'subtitle': 'لفترة محدودة', 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=600'},
    {'title': 'عرض VIP', 'subtitle': 'خصم 25% للأعضاء', 'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=600'},
  ];

  final List<Map<String, dynamic>> _categories = [
    {'name': 'إلكترونيات', 'icon': Icons.devices, 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200', 'color': const Color(0xFF2196F3)},
    {'name': 'أزياء', 'icon': Icons.checkroom, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200', 'color': const Color(0xFFE91E63)},
    {'name': 'سيارات', 'icon': Icons.directions_car, 'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=200', 'color': const Color(0xFFF6465D)},
    {'name': 'عقارات', 'icon': Icons.home, 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=200', 'color': const Color(0xFF4CAF50)},
    {'name': 'أثاث', 'icon': Icons.chair, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200', 'color': const Color(0xFFFF9800)},
    {'name': 'مطاعم', 'icon': Icons.restaurant, 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200', 'color': const Color(0xFF9C27B0)},
  ];

  final List<Map<String, dynamic>> _products = [
    {'name': 'ساعة أبل الترا', 'price': '45,000', 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400', 'rating': 4.8, 'discount': 15},
    {'name': 'سماعات ايربودز', 'price': '35,000', 'image': 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=400', 'rating': 4.7, 'discount': 22},
    {'name': 'آيباد برو', 'price': '280,000', 'image': 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400', 'rating': 4.9, 'discount': null},
    {'name': 'كاميرا كانون', 'price': '120,000', 'image': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=400', 'rating': 4.6, 'discount': 10},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(child: _buildCarousel()),
          SliverToBoxAdapter(child: const SizedBox(height: 20)),
          SliverToBoxAdapter(child: _buildSectionHeader('الفئات', 'عرض الكل')),
          SliverToBoxAdapter(child: const SizedBox(height: 12)),
          SliverToBoxAdapter(child: _buildCategoriesGrid()),
          SliverToBoxAdapter(child: const SizedBox(height: 20)),
          SliverToBoxAdapter(child: _buildSectionHeader('منتجات مميزة', 'عرض الكل')),
          SliverToBoxAdapter(child: const SizedBox(height: 12)),
          SliverToBoxAdapter(child: _buildProductsGrid()),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: AppTheme.binanceDark,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('FLEX', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.binanceGold)),
          const SizedBox(width: 6),
          Text('YEMEN', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppTheme.binanceGold.withOpacity(0.8))),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(icon: const Icon(Icons.search, color: AppTheme.binanceGold), onPressed: () {}),
        IconButton(icon: const Icon(Icons.notifications_none, color: AppTheme.binanceGold), onPressed: () {}),
      ],
    );
  }

  Widget _buildCarousel() {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _carouselItems.length,
          options: CarouselOptions(
            height: 160,
            autoPlay: true,
            viewportFraction: 0.9,
            onPageChanged: (i, _) => setState(() => _carouselIndex = i),
          ),
          itemBuilder: (_, i, __) {
            final item = _carouselItems[i];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(imageUrl: item['image']!, height: 160, width: double.infinity, fit: BoxFit.cover),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(colors: [Colors.black.withOpacity(0.6), Colors.transparent], begin: Alignment.centerRight, end: Alignment.centerLeft),
                    ),
                  ),
                  Positioned(right: 20, top: 30, child: Text(item['title']!, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
                  Positioned(right: 20, top: 65, child: Text(item['subtitle']!, style: const TextStyle(color: Colors.white70, fontSize: 14))),
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(color: AppTheme.binanceGold, borderRadius: BorderRadius.circular(20)),
                      child: const Text('تسوق الآن', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        AnimatedSmoothIndicator(
          activeIndex: _carouselIndex,
          count: _carouselItems.length,
          effect: ExpandingDotsEffect(activeDotColor: AppTheme.binanceGold, dotColor: AppTheme.binanceBorder),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, String action) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          Text(action, style: TextStyle(color: AppTheme.binanceGold)),
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        childAspectRatio: 0.85,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: _categories.map((cat) => CategoryCard(category: cat, onTap: () {})).toList(),
      ),
    );
  }

  Widget _buildProductsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: _products[index],
            onTap: () {},
            onAddToCart: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('تمت إضافة ${_products[index]['name']} إلى السلة'), backgroundColor: AppTheme.binanceGreen),
              );
            },
          );
        },
      ),
    );
  }
}
