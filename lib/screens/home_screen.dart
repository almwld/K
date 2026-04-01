import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../theme/app_theme.dart';
import '../models/product_model.dart';
import '../models/auction_model.dart';
import 'ad_detail_screen.dart';
import 'auction_detail_screen.dart';
import 'category_products_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _carouselIndex = 0;

  // سلايدرات العروض - روابط صور حقيقية
  final List<Map<String, dynamic>> _carouselItems = [
    {
      'title': 'عرض العيد',
      'subtitle': 'خصومات تصل إلى 50%',
      'image': 'https://images.unsplash.com/photo-1606293926075-21a6300f46d7?w=800',
      'gradient': [const Color(0xFFD4AF37), const Color(0xFFF3E5AB)],
      'tag': 'عرض خاص',
    },
    {
      'title': 'مزاد الجنابي',
      'subtitle': 'أكبر مزاد للأسلحة التراثية',
      'image': 'https://images.unsplash.com/photo-1595078475328-1ab05d0a6a0e?w=800',
      'gradient': [const Color(0xFFE74C3C), const Color(0xFFC0392B)],
      'tag': 'مزاد',
    },
    {
      'title': 'توصيل مجاني',
      'subtitle': 'لجميع طلبات اليوم',
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800',
      'gradient': [const Color(0xFF2ECC71), const Color(0xFF27AE60)],
      'tag': 'عرض سريع',
    },
    {
      'title': 'عقارات مميزة',
      'subtitle': 'أفضل العروض العقارية',
      'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=800',
      'gradient': [const Color(0xFF3498DB), const Color(0xFF2980B9)],
      'tag': 'استثمار',
    },
  ];

  // الأقسام الرئيسية
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

  // منتجات مميزة - روابط صور حقيقية
  final List<ProductModel> _featuredProducts = [
    ProductModel(
      id: '1', title: 'آيفون 15 برو ماكس', description: 'هاتف آيفون 15 برو ماكس 256GB', price: 450000,
      images: ['https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400'], category: 'إلكترونيات', city: 'صنعاء',
      sellerId: '1', sellerName: 'متجر التقنية', rating: 4.9, reviewCount: 128, createdAt: DateTime.now(), isFeatured: true,
    ),
    ProductModel(
      id: '2', title: 'سامسونج S24 الترا', description: 'سامسونج جالاكسي S24 الترا 512GB', price: 380000,
      images: ['https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400'], category: 'إلكترونيات', city: 'صنعاء',
      sellerId: '1', sellerName: 'متجر التقنية', rating: 4.8, reviewCount: 95, createdAt: DateTime.now(), isFeatured: true,
    ),
    ProductModel(
      id: '3', title: 'ماك بوك برو M3', description: 'ماك بوك برو M3 14 بوصة', price: 1800000,
      images: ['https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400'], category: 'إلكترونيات', city: 'عدن',
      sellerId: '1', sellerName: 'متجر التقنية', rating: 4.9, reviewCount: 67, createdAt: DateTime.now(), isFeatured: true,
    ),
    ProductModel(
      id: '4', title: 'تويوتا كامري 2024', description: 'تويوتا كامري 2024 فول اوبشن', price: 8500000,
      images: ['https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400'], category: 'سيارات', city: 'صنعاء',
      sellerId: '2', sellerName: 'معرض السيارات', rating: 4.7, reviewCount: 45, createdAt: DateTime.now(), isFeatured: true,
    ),
    ProductModel(
      id: '5', title: 'هيونداي النترا 2024', description: 'هيونداي النترا 2024', price: 6500000,
      images: ['https://images.unsplash.com/photo-1555215695-3004980ad54e?w=400'], category: 'سيارات', city: 'عدن',
      sellerId: '2', sellerName: 'معرض السيارات', rating: 4.6, reviewCount: 32, createdAt: DateTime.now(), isFeatured: true,
    ),
    ProductModel(
      id: '6', title: 'شقة فاخرة في حدة', description: 'شقة 3 غرف في حدة', price: 35000000,
      images: ['https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400'], category: 'عقارات', city: 'صنعاء',
      sellerId: '3', sellerName: 'عقارات فلكس', rating: 4.8, reviewCount: 56, createdAt: DateTime.now(), isFeatured: true,
    ),
    ProductModel(
      id: '7', title: 'فيلا فاخرة', description: 'فيلا 5 غرف مع حديقة', price: 150000000,
      images: ['https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=400'], category: 'عقارات', city: 'صنعاء',
      sellerId: '3', sellerName: 'عقارات فلكس', rating: 4.9, reviewCount: 89, createdAt: DateTime.now(), isFeatured: true,
    ),
    ProductModel(
      id: '8', title: 'كنب زاوية فاخر', description: 'كنب زاوية جلد طبيعي', price: 650000,
      images: ['https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400'], category: 'أثاث', city: 'صنعاء',
      sellerId: '4', sellerName: 'متجر الأثاث', rating: 4.5, reviewCount: 34, createdAt: DateTime.now(), isFeatured: true,
    ),
    ProductModel(
      id: '9', title: 'غرفة نوم كاملة', description: 'غرفة نوم مودرن 5 قطع', price: 450000,
      images: ['https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400'], category: 'أثاث', city: 'صنعاء',
      sellerId: '4', sellerName: 'متجر الأثاث', rating: 4.6, reviewCount: 28, createdAt: DateTime.now(), isFeatured: true,
    ),
    ProductModel(
      id: '10', title: 'ثوب يمني تقليدي', description: 'ثوب يمني فاخر', price: 15000,
      images: ['https://images.unsplash.com/photo-1584277261846-c6a1672c5c43?w=400'], category: 'أزياء', city: 'صنعاء',
      sellerId: '5', sellerName: 'أزياء فلكس', rating: 4.8, reviewCount: 112, createdAt: DateTime.now(), isFeatured: true,
    ),
    ProductModel(
      id: '11', title: 'مندي دجاج عائلي', description: 'مندي دجاج عائلي 4 أشخاص', price: 8000,
      images: ['https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400'], category: 'مطاعم', city: 'صنعاء',
      sellerId: '6', sellerName: 'مطعم الأصيل', rating: 4.9, reviewCount: 234, createdAt: DateTime.now(), isFeatured: true,
    ),
    ProductModel(
      id: '12', title: 'ساعة أبل ووتش', description: 'Apple Watch Series 9', price: 120000,
      images: ['https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=400'], category: 'إلكترونيات', city: 'صنعاء',
      sellerId: '1', sellerName: 'متجر التقنية', rating: 4.7, reviewCount: 45, createdAt: DateTime.now(), isFeatured: true,
    ),
    ProductModel(
      id: '13', title: 'آيباد برو', description: 'iPad Pro M2 11 بوصة', price: 320000,
      images: ['https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400'], category: 'إلكترونيات', city: 'صنعاء',
      sellerId: '1', sellerName: 'متجر التقنية', rating: 4.8, reviewCount: 67, createdAt: DateTime.now(), isFeatured: true,
    ),
    ProductModel(
      id: '14', title: 'سماعات AirPods Pro', description: 'AirPods Pro الجيل الثاني', price: 45000,
      images: ['https://images.unsplash.com/photo-1606841837239-c5a1a4a07af7?w=400'], category: 'إلكترونيات', city: 'صنعاء',
      sellerId: '1', sellerName: 'متجر التقنية', rating: 4.6, reviewCount: 89, createdAt: DateTime.now(), isFeatured: true,
    ),
    ProductModel(
      id: '15', title: 'بلاي ستيشن 5', description: 'PS5 Digital Edition', price: 280000,
      images: ['https://images.unsplash.com/photo-1607853202273-797f1c22a38e?w=400'], category: 'ألعاب', city: 'صنعاء',
      sellerId: '7', sellerName: 'متجر الألعاب', rating: 4.9, reviewCount: 123, createdAt: DateTime.now(), isFeatured: true,
    ),
  ];

  // مزادات نشطة
  final List<AuctionModel> _activeAuctions = [
    AuctionModel(
      id: 'a1', title: 'ساعة رولكس أصلية', description: 'ساعة رولكس أصلية بحالة ممتازة', 
      images: ['https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=400'],
      startingPrice: 500000, currentPrice: 620000, sellerId: '1', sellerName: 'أحمد علي',
      startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(days: 2)),
      status: 'active', bidCount: 12, createdAt: DateTime.now(), category: 'ساعات',
    ),
    AuctionModel(
      id: 'a2', title: 'لوحة فنية نادرة', description: 'لوحة زيتية لفنان مشهور', 
      images: ['https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?w=400'],
      startingPrice: 200000, currentPrice: 280000, sellerId: '2', sellerName: 'فاطمة محمد',
      startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(days: 3)),
      status: 'active', bidCount: 18, createdAt: DateTime.now(), category: 'فنون',
    ),
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
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.3,
                      child: CachedNetworkImage(
                        imageUrl: item['image'] as String,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(),
                        errorWidget: (_, __, ___) => Container(),
                      ),
                    ),
                  ),
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
                        child: CachedNetworkImage(
                          imageUrl: product.images.first,
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(
                            height: 140,
                            color: AppTheme.goldColor.withOpacity(0.1),
                            child: const Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (_, __, ___) => Container(
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
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AuctionDetailScreen(auction: auction))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: CachedNetworkImage(
                          imageUrl: auction.images.first,
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(
                            height: 100,
                            color: AppTheme.goldColor.withOpacity(0.1),
                            child: const Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (_, __, ___) => Container(
                            height: 100,
                            color: AppTheme.goldColor.withOpacity(0.1),
                            child: const Icon(Icons.gavel, size: 30, color: AppTheme.goldColor),
                          ),
                        ),
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
                            Text(
                              '${auction.bidCount} مزايد',
                              style: TextStyle(fontSize: 10, color: AppTheme.getSecondaryTextColor(context)),
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
}

// إضافة extension لتحويل int إلى Color
extension ColorExtension on int {
  Color toColor() {
    return Color(this);
  }
}
