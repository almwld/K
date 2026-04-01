import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../theme/app_theme.dart';
import '../models/product_model.dart';
import '../models/auction_model.dart';
import 'ad_detail_screen.dart';
import 'category_products_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _carouselIndex = 0;

  // سلايدرات العروض
  final List<Map<String, dynamic>> _carouselItems = [
    {
      'title': 'عرض العيد',
      'subtitle': 'خصومات تصل إلى 50%',
      'gradient': [const Color(0xFFD4AF37), const Color(0xFFF3E5AB)],
      'tag': 'عرض خاص',
    },
    {
      'title': 'مزاد الجنابي',
      'subtitle': 'أكبر مزاد للأسلحة التراثية',
      'gradient': [const Color(0xFFE74C3C), const Color(0xFFC0392B)],
      'tag': 'مزاد',
    },
    {
      'title': 'توصيل مجاني',
      'subtitle': 'لجميع طلبات اليوم',
      'gradient': [const Color(0xFF2ECC71), const Color(0xFF27AE60)],
      'tag': 'عرض سريع',
    },
    {
      'title': 'عقارات مميزة',
      'subtitle': 'أفضل العروض العقارية',
      'gradient': [const Color(0xFF3498DB), const Color(0xFF2980B9)],
      'tag': 'استثمار',
    },
  ];

  // الأقسام الرئيسية (20 قسم)
  final List<Map<String, dynamic>> _mainCategories = [
    {'name': 'عقارات', 'icon': Icons.home, 'color': 0xFF4CAF50, 'route': 'real_estate'},
    {'name': 'سيارات', 'icon': Icons.directions_car, 'color': 0xFF2196F3, 'route': 'cars'},
    {'name': 'إلكترونيات', 'icon': Icons.devices, 'color': 0xFFFF9800, 'route': 'electronics'},
    {'name': 'أزياء', 'icon': Icons.checkroom, 'color': 0xFFE91E63, 'route': 'fashion'},
    {'name': 'أثاث', 'icon': Icons.chair, 'color': 0xFF795548, 'route': 'furniture'},
    {'name': 'مطاعم', 'icon': Icons.restaurant, 'color': 0xFF9C27B0, 'route': 'restaurants'},
    {'name': 'خدمات', 'icon': Icons.build, 'color': 0xFF00BCD4, 'route': 'services'},
    {'name': 'ألعاب', 'icon': Icons.sports_esports, 'color': 0xFFE74C3C, 'route': 'games'},
    {'name': 'صحة وجمال', 'icon': Icons.favorite, 'color': 0xFFE91E63, 'route': 'health_beauty'},
    {'name': 'تعليم', 'icon': Icons.school, 'color': 0xFF3F51B5, 'route': 'education'},
    {'name': 'حيوانات', 'icon': Icons.pets, 'color': 0xFF8D6E63, 'route': 'pets'},
    {'name': 'رياضة', 'icon': Icons.sports_soccer, 'color': 0xFF4CAF50, 'route': 'sports'},
    {'name': 'كتب', 'icon': Icons.menu_book, 'color': 0xFF607D8B, 'route': 'books'},
    {'name': 'موسيقى', 'icon': Icons.music_note, 'color': 0xFF9C27B0, 'route': 'music'},
    {'name': 'أفلام', 'icon': Icons.movie, 'color': 0xFFE74C3C, 'route': 'movies'},
    {'name': 'سفر', 'icon': Icons.flight, 'color': 0xFF2196F3, 'route': 'travel'},
    {'name': 'وظائف', 'icon': Icons.work, 'color': 0xFF795548, 'route': 'jobs'},
    {'name': 'خدمات منزلية', 'icon': Icons.handyman, 'color': 0xFFFF9800, 'route': 'home_services'},
    {'name': 'معدات', 'icon': Icons.construction, 'color': 0xFF607D8B, 'route': 'equipment'},
    {'name': 'هدايا', 'icon': Icons.card_giftcard, 'color': 0xFFE91E63, 'route': 'gifts'},
  ];

  // منتجات مميزة (20 منتج)
  final List<ProductModel> _featuredProducts = [
    ProductModel(
      id: '1', title: 'آيفون 15 برو ماكس', description: 'هاتف آيفون 15 برو ماكس 256GB', price: 450000,
      images: ['assets/images/products/iphone.jpg'], category: 'إلكترونيات', city: 'صنعاء',
      sellerId: '1', sellerName: 'متجر التقنية', rating: 4.9, reviewCount: 128, createdAt: DateTime.now(), isFeatured: true,
    ),
    ProductModel(
      id: '2', title: 'سامسونج S24 الترا', description: 'سامسونج جالاكسي S24 الترا 512GB', price: 380000,
      images: ['assets/images/products/samsung.jpg'], category: 'إلكترونيات', city: 'صنعاء',
      sellerId: '1', sellerName: 'متجر التقنية', rating: 4.8, reviewCount: 95, createdAt: DateTime.now(), isFeatured: true,
    ),
    ProductModel(
      id: '3', title: 'ماك بوك برو M3', description: 'ماك بوك برو M3 14 بوصة', price: 1800000,
      images: ['assets/images/products/macbook.jpg'], category: 'إلكترونيات', city: 'عدن',
      sellerId: '1', sellerName: 'متجر التقنية', rating: 4.9, reviewCount: 67, createdAt: DateTime.now(), isFeatured: true,
    ),
    ProductModel(
      id: '4', title: 'تويوتا كامري 2024', description: 'تويوتا كامري 2024 فول اوبشن', price: 8500000,
      images: ['assets/images/products/camry.jpg'], category: 'سيارات', city: 'صنعاء',
      sellerId: '2', sellerName: 'معرض السيارات', rating: 4.7, reviewCount: 45, createdAt: DateTime.now(), isFeatured: true,
    ),
  ];

  // مزادات نشطة
  final List<AuctionModel> _activeAuctions = [
    AuctionModel(
      id: 'a1', title: 'ساعة رولكس أصلية', description: 'ساعة رولكس أصلية بحالة ممتازة', images: ['assets/images/products/watch.jpg'],
      startingPrice: 500000, currentPrice: 620000, sellerId: '1', sellerName: 'أحمد علي', 
      startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(days: 2)),
      status: 'active', bidCount: 12, createdAt: DateTime.now(), category: 'ساعات',
    ),
    AuctionModel(
      id: 'a2', title: 'جنبية يمنية أصلية', description: 'جنبية فضة يمنية أصلية', images: ['assets/images/products/shahs.jpg'],
      startingPrice: 100000, currentPrice: 145000, sellerId: '2', sellerName: 'خالد محمود',
      startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(hours: 36)),
      status: 'active', bidCount: 25, createdAt: DateTime.now(), category: 'تحف',
    ),
    AuctionModel(
      id: 'a3', title: 'لوحة فنية نادرة', description: 'لوحة زيتية لفنان مشهور', images: ['assets/images/products/art.jpg'],
      startingPrice: 200000, currentPrice: 280000, sellerId: '3', sellerName: 'فاطمة محمد',
      startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(days: 3)),
      status: 'active', bidCount: 18, createdAt: DateTime.now(), category: 'فنون',
    ),
    AuctionModel(
      id: 'a4', title: 'عملة قديمة نادرة', description: 'عملة فضية من العصر العثماني', images: ['assets/images/products/coin.jpg'],
      startingPrice: 5000, currentPrice: 8500, sellerId: '4', sellerName: 'خالد محمود',
      startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(days: 1)),
      status: 'active', bidCount: 32, createdAt: DateTime.now(), category: 'عملات',
    ),
  ];

  // الفئات الأكثر مشاهدة
  final List<Map<String, dynamic>> _popularCategories = [
    {'name': 'عقارات', 'icon': Icons.home, 'count': '1,245 إعلان', 'color': 0xFF4CAF50},
    {'name': 'سيارات', 'icon': Icons.directions_car, 'count': '876 إعلان', 'color': 0xFF2196F3},
    {'name': 'إلكترونيات', 'icon': Icons.devices, 'count': '2,345 إعلان', 'color': 0xFFFF9800},
    {'name': 'أزياء', 'icon': Icons.checkroom, 'count': '1,567 إعلان', 'color': 0xFFE91E63},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            _buildCarousel(),
            const SizedBox(height: 16),
            _buildGardenPromo(),
            const SizedBox(height: 24),
            _buildMainCategories(),
            const SizedBox(height: 24),
            _buildFeaturedProducts(),
            const SizedBox(height: 24),
            _buildAuctionsSection(),
            const SizedBox(height: 24),
            _buildPopularCategories(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) => setState(() => _carouselIndex = index),
          ),
          items: _carouselItems.map((item) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: (item['gradient'] as List<Color>),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        item['tag'] as String,
                        style: const TextStyle(color: Colors.black, fontSize: 10),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item['title'] as String,
                          style: const TextStyle(
                            fontFamily: 'Changa',
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item['subtitle'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        AnimatedSmoothIndicator(
          activeIndex: _carouselIndex,
          count: _carouselItems.length,
          effect: ExpandingDotsEffect(
            activeDotColor: AppTheme.goldColor,
            dotColor: AppTheme.getDividerColor(context),
            dotHeight: 8,
            dotWidth: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildGardenPromo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF11998e), Color(0xFF38ef7d)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.local_florist, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'حديقة فلكس (Flex Garden)',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'أزرع نقاطك واحصد خصومات مذهلة!',
                    style: TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/garden'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF11998e),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: const Text('استكشف الآن', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'الأقسام الرئيسية',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/all_categories'),
                child: const Text('عرض الكل', style: TextStyle(color: AppTheme.goldColor)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _mainCategories.length,
            itemBuilder: (context, index) {
              final cat = _mainCategories[index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/category/${cat['route']}'),
                child: Container(
                  width: 80,
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: (cat['color'] as int).toColor().withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(cat['icon'] as IconData, color: (cat['color'] as int).toColor(), size: 28),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        cat['name'] as String,
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
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

  Widget _buildFeaturedProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'منتجات مميزة',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/all_ads'),
                child: const Text('عرض الكل', style: TextStyle(color: AppTheme.goldColor)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _featuredProducts.length,
            itemBuilder: (context, index) {
              final product = _featuredProducts[index];
              return Container(
                width: 160,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdDetailScreen(product: product))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.asset(
                          product.images.first,
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 140,
                            color: AppTheme.goldColor.withOpacity(0.1),
                            child: const Icon(Icons.image, size: 40, color: AppTheme.goldColor),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              maxLines: 1,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${product.price.toStringAsFixed(0)} ر.ي',
                              style: const TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 2),
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
    );
  }

  Widget _buildAuctionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'مزادات نشطة',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/auctions'),
                child: const Text('عرض الكل', style: TextStyle(color: AppTheme.goldColor)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _activeAuctions.length,
            itemBuilder: (context, index) {
              final auction = _activeAuctions[index];
              return Container(
                width: 180,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Container(
                            height: 100,
                            color: AppTheme.goldColor.withOpacity(0.1),
                            child: const Center(
                              child: Icon(Icons.gavel, size: 40, color: AppTheme.goldColor),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'مباشر',
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            auction.title,
                            maxLines: 1,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${auction.currentPrice.toStringAsFixed(0)} ر.ي',
                            style: const TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.timer, size: 12, color: Colors.red),
                              const SizedBox(width: 4),
                              Text(
                                auction.timeLeft,
                                style: const TextStyle(fontSize: 10, color: Colors.red),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${auction.bidCount} مزايد',
                            style: TextStyle(fontSize: 10, color: AppTheme.getSecondaryTextColor(context)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopularCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: const Text(
            'أكثر الفئات مشاهدة',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: _popularCategories.length,
            itemBuilder: (context, index) {
              final cat = _popularCategories[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: (cat['color'] as int).toColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(cat['icon'] as IconData, color: (cat['color'] as int).toColor()),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cat['name'] as String,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            cat['count'] as String,
                            style: TextStyle(fontSize: 11, color: AppTheme.getSecondaryTextColor(context)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// إضافة extension لتحويل int إلى Color
extension ColorExtension on int {
  Color toColor() {
    return Color(this);
  }
}
