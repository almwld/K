import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/auth_provider.dart';
import '../models/product_model.dart';
import '../models/auction_model.dart';
import 'ad_detail_screen.dart';
import 'auction_detail_screen.dart';
import 'category_products_screen.dart';
import 'all_ads_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentCarouselIndex = 0;

  // سلايدرات العروض (10 عروض)
  final List<Map<String, dynamic>> _carouselItems = [
    {'title': 'عرض العيد', 'subtitle': 'خصومات تصل إلى 50%', 'image': 'https://images.unsplash.com/photo-1606293926075-21a6300f46d7?w=800', 'tag': 'عرض خاص'},
    {'title': 'مزاد الجنابي', 'subtitle': 'أكبر مزاد للأسلحة التراثية', 'image': 'https://images.unsplash.com/photo-1595078475328-1ab05d0a6a0e?w=800', 'tag': 'مزاد'},
    {'title': 'توصيل مجاني', 'subtitle': 'لجميع طلبات اليوم', 'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800', 'tag': 'عرض سريع'},
    {'title': 'عقارات مميزة', 'subtitle': 'أفضل العروض العقارية', 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=800', 'tag': 'استثمار'},
    {'title': 'إلكترونيات', 'subtitle': 'أحدث الأجهزة بأفضل الأسعار', 'image': 'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=800', 'tag': 'تكنولوجيا'},
    {'title': 'أزياء', 'subtitle': 'تشكيلة رائعة من الملابس', 'image': 'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?w=800', 'tag': 'موضة'},
    {'title': 'سيارات', 'subtitle': 'أحدث الموديلات', 'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=800', 'tag': 'سيارات'},
    {'title': 'أثاث', 'subtitle': 'تصاميم عصرية', 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800', 'tag': 'أثاث'},
    {'title': 'مطاعم', 'subtitle': 'أشهى المأكولات', 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800', 'tag': 'طعام'},
    {'title': 'خدمات', 'subtitle': 'جميع الخدمات المنزلية', 'image': 'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=800', 'tag': 'خدمات'},
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

  // المنتجات المميزة (30 منتج)
  final List<ProductModel> _featuredProducts = [
    ProductModel(id: '1', title: 'آيفون 15 برو ماكس', description: 'هاتف آيفون 15 برو ماكس', price: 450000, images: ['https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.9, createdAt: DateTime.now()),
    ProductModel(id: '2', title: 'سامسونج S24 الترا', description: 'سامسونج جالاكسي S24', price: 380000, images: ['https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.8, createdAt: DateTime.now()),
    ProductModel(id: '3', title: 'ماك بوك برو M3', description: 'لابتوب ماك بوك', price: 1800000, images: ['https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400'], category: 'إلكترونيات', city: 'عدن', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.9, createdAt: DateTime.now()),
    ProductModel(id: '4', title: 'تويوتا كامري 2024', description: 'سيارة كامري', price: 8500000, images: ['https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400'], category: 'سيارات', city: 'صنعاء', sellerId: '2', sellerName: 'معرض السيارات', rating: 4.7, createdAt: DateTime.now()),
    ProductModel(id: '5', title: 'شقة فاخرة في حدة', description: 'شقة 3 غرف', price: 35000000, images: ['https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400'], category: 'عقارات', city: 'صنعاء', sellerId: '3', sellerName: 'عقارات فلكس', rating: 4.8, createdAt: DateTime.now()),
    ProductModel(id: '6', title: 'كنب زاوية فاخر', description: 'كنب جلد', price: 650000, images: ['https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400'], category: 'أثاث', city: 'صنعاء', sellerId: '4', sellerName: 'متجر الأثاث', rating: 4.5, createdAt: DateTime.now()),
    ProductModel(id: '7', title: 'ثوب يمني تقليدي', description: 'ثوب يمني', price: 15000, images: ['https://images.unsplash.com/photo-1584277261846-c6a1672c5c43?w=400'], category: 'أزياء', city: 'صنعاء', sellerId: '5', sellerName: 'أزياء فلكس', rating: 4.8, createdAt: DateTime.now()),
    ProductModel(id: '8', title: 'مندي دجاج عائلي', description: 'مندي', price: 8000, images: ['https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400'], category: 'مطاعم', city: 'صنعاء', sellerId: '6', sellerName: 'مطعم الأصيل', rating: 4.9, createdAt: DateTime.now()),
    ProductModel(id: '9', title: 'ساعة أبل ووتش', description: 'ساعة ذكية', price: 120000, images: ['https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.7, createdAt: DateTime.now()),
    ProductModel(id: '10', title: 'آيباد برو', description: 'جهاز لوحي', price: 320000, images: ['https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.8, createdAt: DateTime.now()),
    ProductModel(id: '11', title: 'سماعات AirPods Pro', description: 'سماعات لاسلكية', price: 45000, images: ['https://images.unsplash.com/photo-1606841837239-c5a1a4a07af7?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.6, createdAt: DateTime.now()),
    ProductModel(id: '12', title: 'بلاي ستيشن 5', description: 'جهاز ألعاب', price: 280000, images: ['https://images.unsplash.com/photo-1607853202273-797f1c22a38e?w=400'], category: 'ألعاب', city: 'صنعاء', sellerId: '7', sellerName: 'متجر الألعاب', rating: 4.9, createdAt: DateTime.now()),
    ProductModel(id: '13', title: 'هيونداي النترا', description: 'سيارة', price: 6500000, images: ['https://images.unsplash.com/photo-1555215695-3004980ad54e?w=400'], category: 'سيارات', city: 'عدن', sellerId: '2', sellerName: 'معرض السيارات', rating: 4.6, createdAt: DateTime.now()),
    ProductModel(id: '14', title: 'فيلا فاخرة', description: 'فيلا 5 غرف', price: 150000000, images: ['https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=400'], category: 'عقارات', city: 'صنعاء', sellerId: '3', sellerName: 'عقارات فلكس', rating: 4.9, createdAt: DateTime.now()),
    ProductModel(id: '15', title: 'غرفة نوم كاملة', description: 'غرفة نوم', price: 450000, images: ['https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400'], category: 'أثاث', city: 'صنعاء', sellerId: '4', sellerName: 'متجر الأثاث', rating: 4.6, createdAt: DateTime.now()),
    ProductModel(id: '16', title: 'عباية فاخرة', description: 'عباية', price: 25000, images: ['https://images.unsplash.com/photo-1581044777550-4cfa60707c03?w=400'], category: 'أزياء', city: 'عدن', sellerId: '5', sellerName: 'أزياء فلكس', rating: 4.7, createdAt: DateTime.now()),
    ProductModel(id: '17', title: 'زربيان لحم', description: 'زربيان', price: 12000, images: ['https://images.unsplash.com/photo-1599045118108-bf9966fc7d61?w=400'], category: 'مطاعم', city: 'عدن', sellerId: '6', sellerName: 'مطعم الأصيل', rating: 4.8, createdAt: DateTime.now()),
    ProductModel(id: '18', title: 'شاهي بالحليب', description: 'شاهي', price: 1500, images: ['https://images.unsplash.com/photo-1598300042247-d088f8ab3a91?w=400'], category: 'مطاعم', city: 'تعز', sellerId: '6', sellerName: 'مطعم الأصيل', rating: 4.7, createdAt: DateTime.now()),
    ProductModel(id: '19', title: 'خدمة تنظيف منزل', description: 'تنظيف', price: 25000, images: ['https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=400'], category: 'خدمات منزلية', city: 'صنعاء', sellerId: '8', sellerName: 'خدمات فلكس', rating: 4.5, createdAt: DateTime.now()),
    ProductModel(id: '20', title: 'صيانة أجهزة', description: 'صيانة', price: 15000, images: ['https://images.unsplash.com/photo-1621905251918-48416bd8575a?w=400'], category: 'خدمات', city: 'صنعاء', sellerId: '8', sellerName: 'خدمات فلكس', rating: 4.6, createdAt: DateTime.now()),
    ProductModel(id: '21', title: 'دراجة هوائية', description: 'دراجة', price: 35000, images: ['https://images.unsplash.com/photo-1485965120184-e220f721d03e?w=400'], category: 'رياضة', city: 'صنعاء', sellerId: '9', sellerName: 'متجر الرياضة', rating: 4.4, createdAt: DateTime.now()),
    ProductModel(id: '22', title: 'أحذية رياضية', description: 'حذاء', price: 12000, images: ['https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400'], category: 'أزياء', city: 'صنعاء', sellerId: '5', sellerName: 'أزياء فلكس', rating: 4.5, createdAt: DateTime.now()),
    ProductModel(id: '23', title: 'سجادة صلاة', description: 'سجادة', price: 5000, images: ['https://images.unsplash.com/photo-1585135497273-6db3f3a2f8a9?w=400'], category: 'هدايا', city: 'صنعاء', sellerId: '10', sellerName: 'هدايا فلكس', rating: 4.8, createdAt: DateTime.now()),
    ProductModel(id: '24', title: 'مجموعة كتب', description: 'كتب', price: 8000, images: ['https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=400'], category: 'كتب', city: 'صنعاء', sellerId: '11', sellerName: 'مكتبة العلم', rating: 4.7, createdAt: DateTime.now()),
    ProductModel(id: '25', title: 'جهاز قهوة', description: 'ماكينة قهوة', price: 45000, images: ['https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.6, createdAt: DateTime.now()),
    ProductModel(id: '26', title: 'طقم أواني', description: 'أواني طبخ', price: 25000, images: ['https://images.unsplash.com/photo-1584345604325-1a4f31e9c0f9?w=400'], category: 'أثاث', city: 'صنعاء', sellerId: '4', sellerName: 'متجر الأثاث', rating: 4.5, createdAt: DateTime.now()),
    ProductModel(id: '27', title: 'عطر فاخر', description: 'عطر', price: 18000, images: ['https://images.unsplash.com/photo-1541643600914-78b084683601?w=400'], category: 'صحة وجمال', city: 'صنعاء', sellerId: '12', sellerName: 'عطور فلكس', rating: 4.9, createdAt: DateTime.now()),
    ProductModel(id: '28', title: 'حقيبة سفر', description: 'حقيبة', price: 35000, images: ['https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400'], category: 'سفر', city: 'صنعاء', sellerId: '13', sellerName: 'متجر السفر', rating: 4.4, createdAt: DateTime.now()),
    ProductModel(id: '29', title: 'ساعة يد', description: 'ساعة', price: 55000, images: ['https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.7, createdAt: DateTime.now()),
    ProductModel(id: '30', title: 'كاميرا احترافية', description: 'كاميرا', price: 280000, images: ['https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=400'], category: 'إلكترونيات', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', rating: 4.8, createdAt: DateTime.now()),
  ];

  // المزادات النشطة (10 مزادات)
  final List<AuctionModel> _activeAuctions = [
    AuctionModel(id: 'a1', title: 'ساعة رولكس أصلية', description: 'ساعة رولكس', images: ['https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=400'], startingPrice: 500000, currentPrice: 620000, sellerId: '1', sellerName: 'أحمد علي', startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(days: 2)), status: 'active', bidCount: 12, createdAt: DateTime.now(), category: 'ساعات'),
    AuctionModel(id: 'a2', title: 'لوحة فنية نادرة', description: 'لوحة زيتية', images: ['https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?w=400'], startingPrice: 200000, currentPrice: 280000, sellerId: '2', sellerName: 'فاطمة محمد', startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(days: 3)), status: 'active', bidCount: 18, createdAt: DateTime.now(), category: 'فنون'),
    AuctionModel(id: 'a3', title: 'عملة قديمة نادرة', description: 'عملة فضية', images: ['https://images.unsplash.com/photo-1605106702734-205df224ecce?w=400'], startingPrice: 5000, currentPrice: 8500, sellerId: '3', sellerName: 'خالد محمود', startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(days: 1)), status: 'active', bidCount: 32, createdAt: DateTime.now(), category: 'عملات'),
    AuctionModel(id: 'a4', title: 'جنبية يمنية أصلية', description: 'جنبية فضة', images: ['https://images.unsplash.com/photo-1595078475328-1ab05d0a6a0e?w=400'], startingPrice: 100000, currentPrice: 145000, sellerId: '4', sellerName: 'خالد محمود', startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(hours: 36)), status: 'active', bidCount: 25, createdAt: DateTime.now(), category: 'تحف'),
    AuctionModel(id: 'a5', title: 'سيارة كلاسيكية', description: 'مرسيدس 280SE', images: ['https://images.unsplash.com/photo-1614200187524-dc4b892acf16?w=400'], startingPrice: 5000000, currentPrice: 6200000, sellerId: '5', sellerName: 'عمر حسن', startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(days: 5)), status: 'active', bidCount: 7, createdAt: DateTime.now(), category: 'سيارات'),
    AuctionModel(id: 'a6', title: 'مجموعة طوابع نادرة', description: 'طوابع قديمة', images: ['https://images.unsplash.com/photo-1618354691373-d851c5c3a990?w=400'], startingPrice: 15000, currentPrice: 22000, sellerId: '6', sellerName: 'نادر علي', startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(days: 4)), status: 'active', bidCount: 15, createdAt: DateTime.now(), category: 'طوابع'),
    AuctionModel(id: 'a7', title: 'ألماسة نادرة', description: 'ألماسة 2 قيراط', images: ['https://images.unsplash.com/photo-1605106702734-205df224ecce?w=400'], startingPrice: 2000000, currentPrice: 2350000, sellerId: '7', sellerName: 'مجوهرات فلكس', startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(days: 7)), status: 'active', bidCount: 9, createdAt: DateTime.now(), category: 'مجوهرات'),
    AuctionModel(id: 'a8', title: 'سيف أثري', description: 'سيف قديم', images: ['https://images.unsplash.com/photo-1595078475328-1ab05d0a6a0e?w=400'], startingPrice: 80000, currentPrice: 95000, sellerId: '8', sellerName: 'تحف قديمة', startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(days: 3)), status: 'active', bidCount: 22, createdAt: DateTime.now(), category: 'تحف'),
    AuctionModel(id: 'a9', title: 'ساعة أوميغا', description: 'ساعة فاخرة', images: ['https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=400'], startingPrice: 300000, currentPrice: 380000, sellerId: '1', sellerName: 'أحمد علي', startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(days: 2)), status: 'active', bidCount: 14, createdAt: DateTime.now(), category: 'ساعات'),
    AuctionModel(id: 'a10', title: 'مخطوطة قديمة', description: 'مخطوطة نادرة', images: ['https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=400'], startingPrice: 50000, currentPrice: 67000, sellerId: '9', sellerName: 'مكتبة التراث', startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(days: 6)), status: 'active', bidCount: 19, createdAt: DateTime.now(), category: 'مخطوطات'),
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
              const SizedBox(height: 24),
              _buildPopularCategories(),
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
                  CachedNetworkImage(imageUrl: item['image'], width: double.infinity, height: 200, fit: BoxFit.cover, placeholder: (_, __) => Container(color: Colors.grey[300]), errorWidget: (_, __, ___) => Container(color: Colors.grey[300], child: const Icon(Icons.error))),
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
        return GestureDetector(onTap: () => Navigator.pushNamed(context, '/category/${cat['route']}'), child: Container(width: 80, margin: const EdgeInsets.only(right: 12), child: Column(children: [Container(width: 60, height: 60, decoration: BoxDecoration(color: Color(cat['color']).withOpacity(0.1), borderRadius: BorderRadius.circular(16)), child: Icon(cat['icon'], color: Color(cat['color']), size: 28)), const SizedBox(height: 8), Text(cat['name'], style: const TextStyle(fontSize: 12), textAlign: TextAlign.center)])));
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
          ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(16)), child: CachedNetworkImage(imageUrl: product.images.first, height: 140, width: double.infinity, fit: BoxFit.cover, placeholder: (_, __) => Container(height: 140, color: AppTheme.goldColor.withOpacity(0.1), child: const Center(child: CircularProgressIndicator())), errorWidget: (_, __, ___) => Container(height: 140, color: AppTheme.goldColor.withOpacity(0.1), child: const Icon(Icons.image, size: 40)))),
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
          ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(16)), child: CachedNetworkImage(imageUrl: auction.images.first, height: 100, width: double.infinity, fit: BoxFit.cover, placeholder: (_, __) => Container(height: 100, color: AppTheme.goldColor.withOpacity(0.1), child: const Center(child: CircularProgressIndicator())), errorWidget: (_, __, ___) => Container(height: 100, color: AppTheme.goldColor.withOpacity(0.1), child: const Icon(Icons.gavel, size: 30)))),
          Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(auction.title, maxLines: 1, style: const TextStyle(fontWeight: FontWeight.bold)), Text('${auction.currentPrice.toStringAsFixed(0)} ر.ي', style: const TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold)), Row(children: [const Icon(Icons.timer, size: 12, color: Colors.red), const SizedBox(width: 4), Text(auction.timeLeft, style: const TextStyle(fontSize: 10, color: Colors.red))]), Text('${auction.bidCount} مزايد', style: TextStyle(fontSize: 10, color: AppTheme.getSecondaryTextColor(context)))])),
        ])));
      })),
    ]);
  }

  Widget _buildPopularCategories() {
    final popular = [
      {'name': 'عقارات', 'count': '1,245 إعلان', 'icon': Icons.home, 'color': 0xFF4CAF50},
      {'name': 'سيارات', 'count': '876 إعلان', 'icon': Icons.directions_car, 'color': 0xFF2196F3},
      {'name': 'إلكترونيات', 'count': '2,345 إعلان', 'icon': Icons.devices, 'color': 0xFFFF9800},
      {'name': 'أزياء', 'count': '1,567 إعلان', 'icon': Icons.checkroom, 'color': 0xFFE91E63},
      {'name': 'أثاث', 'count': '890 إعلان', 'icon': Icons.chair, 'color': 0xFF795548},
      {'name': 'مطاعم', 'count': '654 إعلان', 'icon': Icons.restaurant, 'color': 0xFF9C27B0},
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: const Text('أكثر الفئات مشاهدة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
      const SizedBox(height: 12),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.5, crossAxisSpacing: 12, mainAxisSpacing: 12), itemCount: popular.length, itemBuilder: (context, index) {
        final cat = popular[index];
        return Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppTheme.getCardColor(context), borderRadius: BorderRadius.circular(12)), child: Row(children: [Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Color(cat['color']).withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Icon(cat['icon'], color: Color(cat['color']))), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text(cat['name'], style: const TextStyle(fontWeight: FontWeight.bold)), Text(cat['count'], style: TextStyle(fontSize: 11, color: AppTheme.getSecondaryTextColor(context)))]))]));
      })),
    ]);
  }
}
