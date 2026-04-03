import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../theme/app_theme.dart';
import '../models/product_model.dart';
import 'ad_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _carouselIndex = 0;

  final List<Map<String, dynamic>> _carouselItems = [
    {'title': 'عروض خاصة', 'description': 'خصومات تصل إلى 50%', 'gradient': [const Color(0xFF667eea), const Color(0xFF764ba2)]},
    {'title': 'مزادات حية', 'description': 'شارك في المزادات', 'gradient': [const Color(0xFFf093fb), const Color(0xFFf5576c)]},
    {'title': 'عقارات مميزة', 'description': 'أفضل العروض العقارية', 'gradient': [const Color(0xFF4facfe), const Color(0xFF00f2fe)]},
  ];

  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.home_outlined, 'name': 'عقارات', 'color': Colors.blue},
    {'icon': Icons.directions_car_outlined, 'name': 'سيارات', 'color': Colors.red},
    {'icon': Icons.phone_android_outlined, 'name': 'إلكترونيات', 'color': Colors.green},
    {'icon': Icons.checkroom_outlined, 'name': 'أزياء', 'color': Colors.purple},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              _buildCarousel(),
              const SizedBox(height: 16),
              _buildGardenPromo(),
              const SizedBox(height: 24),
              _buildCategories(),
              const SizedBox(height: 24),
              _buildSuggestedProducts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(height: 180, autoPlay: true, viewportFraction: 0.9, onPageChanged: (index, _) => setState(() => _carouselIndex = index)),
          items: _carouselItems.map((item) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(gradient: LinearGradient(colors: item['gradient']), borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(item['title'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)), const SizedBox(height: 8), Text(item['description'], style: const TextStyle(fontSize: 14, color: Colors.white70))],
              ),
            ),
          )).toList(),
        ),
        const SizedBox(height: 12),
        AnimatedSmoothIndicator(activeIndex: _carouselIndex, count: _carouselItems.length, effect: ExpandingDotsEffect(activeDotColor: AppTheme.goldColor, dotColor: AppTheme.getDividerColor(context))),
      ],
    );
  }

  Widget _buildGardenPromo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF11998e), Color(0xFF38ef7d)]), borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.local_florist, color: Colors.white, size: 32)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('حديقة فلكس (Flex Garden)', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('أزرع نقاطك واحصد خصومات مذهلة!', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 8),
                  ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/garden'), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF11998e)), child: const Text('استكشف الآن')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text('الأقسام الرئيسية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.getTextColor(context)))),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final cat = _categories[index];
              return Container(
                width: 80, margin: const EdgeInsets.only(right: 12),
                child: Column(
                  children: [
                    Container(width: 60, height: 60, decoration: BoxDecoration(color: (cat['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(16)), child: Icon(cat['icon'] as IconData, color: cat['color'] as Color, size: 28)),
                    const SizedBox(height: 8),
                    Text(cat['name'] as String, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestedProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('منتجات مقترحة لك', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(onPressed: () => Navigator.pushNamed(context, '/all_ads'), child: const Text('المزيد', style: TextStyle(color: AppTheme.goldColor))),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: sampleProducts.length,
            itemBuilder: (context, index) {
              final product = sampleProducts[index];
              return Container(
                width: 160, margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(color: AppTheme.getCardColor(context), borderRadius: BorderRadius.circular(16)),
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdDetailScreen(product: product))),
                  child: Column(
                    children: [
                      Container(height: 140, decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.1), borderRadius: const BorderRadius.vertical(top: Radius.circular(16))), child: const Center(child: Icon(Icons.image, color: AppTheme.goldColor, size: 40))),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.title, maxLines: 1, style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text('${product.price.toStringAsFixed(0)} ر.ي', style: const TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold)),
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
    );
  }
}
