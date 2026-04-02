import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/auth_provider.dart';
import '../models/product_model.dart';
import '../models/auction_model.dart';
import '../widgets/cached_image_with_fallback.dart';
import 'ad_detail_screen.dart';
import 'auction_detail_screen.dart';
import 'category_products_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentCarouselIndex = 0;

  // سلايدرات العروض
  final List<Map<String, dynamic>> _carouselItems = [
    {'title': 'عرض العيد', 'subtitle': 'خصومات تصل إلى 50%', 'image': 'https://images.unsplash.com/photo-1606293926075-21a6300f46d7?w=800', 'tag': 'عرض خاص'},
    {'title': 'مزاد الجنابي', 'subtitle': 'أكبر مزاد للأسلحة التراثية', 'image': 'https://images.unsplash.com/photo-1595078475328-1ab05d0a6a0e?w=800', 'tag': 'مزاد'},
    {'title': 'توصيل مجاني', 'subtitle': 'لجميع طلبات اليوم', 'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800', 'tag': 'عرض سريع'},
    {'title': 'عقارات مميزة', 'subtitle': 'أفضل العروض العقارية', 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=800', 'tag': 'استثمار'},
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
  ];

  // المنتجات المميزة
  final List<ProductModel> _featuredProducts = [
    ProductModel(id: '1', title: 'آيفون 15 برو ماكس', description: '', price: 450000, images: ['https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.9, createdAt: DateTime.now()),
    ProductModel(id: '2', title: 'سامسونج S24 الترا', description: '', price: 380000, images: ['https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.8, createdAt: DateTime.now()),
    ProductModel(id: '3', title: 'ماك بوك برو M3', description: '', price: 1800000, images: ['https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400'], category: 'إلكترونيات', city: 'عدن', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.9, createdAt: DateTime.now()),
    ProductModel(id: '4', title: 'تويوتا كامري 2024', description: '', price: 8500000, images: ['https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400'], category: 'سيارات', city: 'صنعاء', sellerId: '2', sellerName: 'معرض السيارات', rating: 4.7, createdAt: DateTime.now()),
  ];

  // المزادات النشطة
  final List<AuctionModel> _activeAuctions = [
    AuctionModel(id: 'a1', title: 'ساعة رولكس أصلية', description: '', images: ['https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=400'], startingPrice: 500000, currentPrice: 620000, sellerId: '1', sellerName: 'أحمد علي', startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(days: 2)), status: 'active', bidCount: 12, createdAt: DateTime.now(), category: 'ساعات'),
    AuctionModel(id: 'a2', title: 'لوحة فنية نادرة', description: '', images: ['https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?w=400'], startingPrice: 200000, currentPrice: 280000, sellerId: '2', sellerName: 'فاطمة محمد', startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(days: 3)), status: 'active', bidCount: 18, createdAt: DateTime.now(), category: 'فنون'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(authProvider),
              _buildCarousel(),
              const SizedBox(height: 20),
              _buildMainCategories(),
              const SizedBox(height: 24),
              _buildFeaturedProducts(),
              const SizedBox(height: 24),
              _buildAuctionsSection(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AuthProvider authProvider) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: AppTheme.goldColor.withOpacity(0.2),
            child: const Icon(Icons.person, color: AppTheme.goldColor),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('مرحباً', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
              Text(authProvider.userName ?? 'ضيف', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(height: 200, autoPlay: true, viewportFraction: 0.9, onPageChanged: (index, _) => setState(() => _currentCarouselIndex = index)),
          items: _carouselItems.map((item) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  CachedImageWithFallback(
                    imageUrl: item['image'],
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.6)]))),
                  Positioned(bottom: 20, left: 20, right: 20, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: AppTheme.goldColor, borderRadius: BorderRadius.circular(20)), child: Text(item['tag'], style: const TextStyle(color: Colors.black, fontSize: 10))),
                    const SizedBox(height: 8), Text(item['title'], style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(item['subtitle'], style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
                  ])),
                ],
              ),
            ),
          )).toList(),
        ),
        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: _carouselItems.asMap().entries.map((e) => Container(width: _currentCarouselIndex == e.key ? 24 : 8, height: 8, margin: const EdgeInsets.symmetric(horizontal: 4), decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: _currentCarouselIndex == e.key ? AppTheme.goldColor : Colors.grey.withOpacity(0.5)))).toList()),
      ],
    );
  }

  Widget _buildMainCategories() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('الأقسام الرئيسية', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), TextButton(onPressed: () => Navigator.pushNamed(context, '/all_categories'), child: const Text('عرض الكل', style: TextStyle(color: AppTheme.goldColor)))])),
      const SizedBox(height: 12),
      SizedBox(height: 100, child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: _mainCategories.length, itemBuilder: (context, index) {
        final cat = _mainCategories[index];
        return GestureDetector(onTap: () => Navigator.pushNamed(context, '/category/${cat['route']}'), child: Container(width: 80, margin: const EdgeInsets.only(right: 12), child: Column(children: [Container(width: 60, height: 60, decoration: BoxDecoration(color: Color(cat['color'] as int).withOpacity(0.1), borderRadius: BorderRadius.circular(16)), child: Icon(cat['icon'] as IconData, color: Color(cat['color'] as int), size: 28)), const SizedBox(height: 8), Text(cat['name'] as String, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center)])));
      })),
    ]);
  }

  Widget _buildFeaturedProducts() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('منتجات مميزة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), TextButton(onPressed: () => Navigator.pushNamed(context, '/all_ads'), child: const Text('عرض الكل', style: TextStyle(color: AppTheme.goldColor)))])),
      const SizedBox(height: 12),
      SizedBox(height: 280, child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: _featuredProducts.length, itemBuilder: (context, index) {
        final product = _featuredProducts[index];
        return Container(width: 160, margin: const EdgeInsets.only(right: 12), decoration: BoxDecoration(color: AppTheme.getCardColor(context), borderRadius: BorderRadius.circular(16)), child: GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdDetailScreen(product: product))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(16)), child: CachedImageWithFallback(
            imageUrl: product.images.first,
            width: double.infinity,
            height: 140,
            fit: BoxFit.cover,
          )),
          Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(product.title, maxLines: 1, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text('${product.price.toStringAsFixed(0)} ر.ي', style: const TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold)), Row(children: [const Icon(Icons.star, size: 10, color: Colors.amber), const SizedBox(width: 2), Text('${product.rating}', style: const TextStyle(fontSize: 10))])])),
        ])));
      })),
    ]);
  }

  Widget _buildAuctionsSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('مزادات نشطة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), TextButton(onPressed: () => Navigator.pushNamed(context, '/auctions'), child: const Text('عرض الكل', style: TextStyle(color: AppTheme.goldColor)))])),
      const SizedBox(height: 12),
      SizedBox(height: 220, child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: _activeAuctions.length, itemBuilder: (context, index) {
        final auction = _activeAuctions[index];
        return Container(width: 180, margin: const EdgeInsets.only(right: 12), decoration: BoxDecoration(color: AppTheme.getCardColor(context), borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.goldColor.withOpacity(0.3))), child: GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AuctionDetailScreen(auction: auction))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(16)), child: CachedImageWithFallback(
            imageUrl: auction.images.first,
            width: double.infinity,
            height: 100,
            fit: BoxFit.cover,
          )),
          Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(auction.title, maxLines: 1, style: const TextStyle(fontWeight: FontWeight.bold)), Text('${auction.currentPrice.toStringAsFixed(0)} ر.ي', style: const TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold)), Row(children: [const Icon(Icons.timer, size: 12, color: Colors.red), const SizedBox(width: 4), Text(auction.timeLeft, style: const TextStyle(fontSize: 10, color: Colors.red))]), Text('${auction.bidCount} مزايد', style: TextStyle(fontSize: 10, color: AppTheme.getSecondaryTextColor(context)))])),
        ])));
      })),
    ]);
  }
}

// إضافة import لقاعدة البيانات المحلية
import '../services/local_database_service.dart';

// إضافة دالة لجلب المنتجات من قاعدة البيانات المحلية
Future<void> _loadProductsFromLocal() async {
  try {
    final localDb = LocalDatabaseService();
    final products = await localDb.getProducts(featured: true);
    if (products.isNotEmpty) {
      setState(() {
        _featuredProducts = products;
      });
    }
  } catch (e) {
    debugPrint('Error loading from local DB: $e');
  }
}
