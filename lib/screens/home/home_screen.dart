import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../../widgets/stories_widget.dart';
import '../categories/all_categories_screen.dart';
import '../stores/stores_screen.dart';
import '../auctions/auctions_screen.dart';
import '../offers_screen.dart';
import '../cart/cart_screen.dart';
import '../wallet/wallet_screen.dart';
import '../stats/sales_stats_screen.dart';
import '../stats/loyalty_points_screen.dart';
import '../stats/orders_stats_screen.dart';
import '../all_stores_screen.dart';
import '../markets_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _carouselIndex = 0;

  // السلايدرات
  final List<Map<String, dynamic>> _carouselItems = [
    {'title': 'عروض الإلكترونيات', 'subtitle': 'خصم يصل إلى 50%', 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=600', 'gradient': [AppTheme.serviceBlue, AppTheme.serviceBlue.withOpacity(0.7)], 'buttonText': 'تسوق الآن', 'badge': 'عرض محدود', 'discount': '50%'},
    {'title': 'مزادات حية', 'subtitle': 'شارك في المزادات', 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=600', 'gradient': [AppTheme.binanceGreen, AppTheme.binanceGreen.withOpacity(0.7)], 'buttonText': 'اشترك الآن', 'badge': 'مزاد حي', 'discount': '75%'},
    {'title': 'عروض VIP', 'subtitle': 'خصم 25% للأعضاء', 'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=600', 'gradient': [AppTheme.binanceGold, AppTheme.binanceGold.withOpacity(0.7)], 'buttonText': 'انضم الآن', 'badge': 'VIP فقط', 'discount': '25%'},
    {'title': 'توصيل مجاني', 'subtitle': 'لطلبات +200,000', 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=600', 'gradient': [AppTheme.serviceOrange, AppTheme.serviceOrange.withOpacity(0.7)], 'buttonText': 'اطلب الآن', 'badge': 'شحن مجاني', 'discount': '100%'},
    {'title': 'عروض العيد', 'subtitle': 'خصومات تصل إلى 60%', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600', 'gradient': [AppTheme.binanceRed, AppTheme.binanceRed.withOpacity(0.7)], 'buttonText': 'استفد الآن', 'badge': 'عرض خاص', 'discount': '60%'},
  ];

  // بيانات الحالات (Stories)
  final List<StoryModel> _stories = [
    StoryModel(id: 'user', name: 'إضافة حالة', imageUrl: '', time: '', isUser: true),
    StoryModel(id: '1', name: 'أحمد محمد', imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg', time: 'منذ 5 دقائق', isViewed: false),
    StoryModel(id: '2', name: 'متجر التقنية', imageUrl: 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200', time: 'منذ ساعة', isViewed: false),
    StoryModel(id: '3', name: 'سارة علي', imageUrl: 'https://randomuser.me/api/portraits/women/1.jpg', time: 'منذ 3 ساعات', isViewed: true),
  ];

  // 10 فئات مع صور حقيقية
  final List<Map<String, dynamic>> _categories = [
    {'name': 'إلكترونيات', 'icon': Icons.devices, 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200', 'color': const Color(0xFF2196F3)},
    {'name': 'أزياء', 'icon': Icons.checkroom, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200', 'color': const Color(0xFFE91E63)},
    {'name': 'سيارات', 'icon': Icons.directions_car, 'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=200', 'color': const Color(0xFFF6465D)},
    {'name': 'عقارات', 'icon': Icons.home, 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=200', 'color': const Color(0xFF4CAF50)},
    {'name': 'أثاث', 'icon': Icons.chair, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200', 'color': const Color(0xFFFF9800)},
    {'name': 'مطاعم', 'icon': Icons.restaurant, 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200', 'color': const Color(0xFF9C27B0)},
    {'name': 'مقاهي', 'icon': Icons.coffee, 'image': 'https://images.unsplash.com/photo-1507133750040-4a8f57021571?w=200', 'color': const Color(0xFF795548)},
    {'name': 'مستحضرات تجميل', 'icon': Icons.face, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=200', 'color': const Color(0xFFE91E63)},
    {'name': 'رياضة', 'icon': Icons.sports_soccer, 'image': 'https://images.unsplash.com/photo-1461896836934-ffe807baa261?w=200', 'color': const Color(0xFF4CAF50)},
    {'name': 'كتب', 'icon': Icons.menu_book, 'image': 'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=200', 'color': const Color(0xFF795548)},
  ];

  // المتابعات (التجار)
  final List<Map<String, dynamic>> _followings = [
    {'name': 'متجر التقنية', 'update': 'منتج جديد', 'time': 'قبل ساعة', 'avatar': 'https://randomuser.me/api/portraits/men/1.jpg', 'storeId': '1'},
    {'name': 'مطعم مندي الملكي', 'update': 'عرض خاص', 'time': 'اليوم', 'avatar': 'https://randomuser.me/api/portraits/men/2.jpg', 'storeId': '2'},
    {'name': 'الأزياء العصرية', 'update': 'تخفيضات', 'time': 'أمس', 'avatar': 'https://randomuser.me/api/portraits/women/1.jpg', 'storeId': '3'},
    {'name': 'عطور الشرق', 'update': 'وصل حديثاً', 'time': 'منذ ساعتين', 'avatar': 'https://randomuser.me/api/portraits/men/3.jpg', 'storeId': '4'},
  ];

  // العروض الرائجة
  final List<Map<String, dynamic>> _trendingOffers = [
    {'name': 'iPhone 15 Pro', 'price': '350,000', 'old': '450,000', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400', 'discount': 22, 'productId': '1'},
    {'name': 'ساعة أبل الترا', 'price': '45,000', 'old': '60,000', 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400', 'discount': 25, 'productId': '2'},
    {'name': 'ماك بوك برو', 'price': '1,800,000', 'old': '2,100,000', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400', 'discount': 14, 'productId': '3'},
    {'name': 'سامسونج S24', 'price': '380,000', 'old': '450,000', 'image': 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=400', 'discount': 15, 'productId': '4'},
  ];

  // الأسواق اليمنية
  final List<Map<String, dynamic>> _markets = [
    {'name': 'السوق اليمني', 'change': '+2.5%', 'volume': '1.2M', 'items': 1250, 'isUp': true, 'description': 'أكبر سوق في اليمن'},
    {'name': 'المولات', 'change': '+1.8%', 'volume': '890K', 'items': 450, 'isUp': true, 'description': 'أحدث المولات'},
    {'name': 'المقاهي', 'change': '+3.2%', 'volume': '567K', 'items': 320, 'isUp': true, 'description': 'أشهر المقاهي'},
    {'name': 'الفنادق', 'change': '-0.5%', 'volume': '456K', 'items': 95, 'isUp': false, 'description': 'فنادق فاخرة'},
  ];

  // منتجات مميزة
  final List<Map<String, dynamic>> _featuredProducts = [
    {'name': 'آيباد برو', 'price': '280,000', 'oldPrice': null, 'image': 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400', 'discount': 0, 'rating': 4.9, 'tag': 'موصى به'},
    {'name': 'سماعات سوني', 'price': '45,000', 'oldPrice': '60,000', 'image': 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=400', 'discount': 25, 'rating': 4.8, 'tag': 'مفضلات'},
    {'name': 'ساعة رياضية', 'price': '25,000', 'oldPrice': '40,000', 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400', 'discount': 37, 'rating': 4.7, 'tag': 'أقل سعر'},
    {'name': 'لابتوب ديل', 'price': '350,000', 'oldPrice': '450,000', 'image': 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=400', 'discount': 22, 'rating': 4.8, 'tag': 'اشتر الآن'},
  ];

  void _navigateTo(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  void _navigateToStats(String type) {
    switch (type) {
      case 'purchases':
        Navigator.push(context, MaterialPageRoute(builder: (_) => SalesStatsScreen(title: 'إجمالي المشتريات', totalValue: '1,234,567 ريال', details: const [])));
        break;
      case 'points':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const LoyaltyPointsScreen()));
        break;
      case 'orders':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const OrdersStatsScreen()));
        break;
    }
  }

  void _addToCartWithAnimation(String productName) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم إضافة $productName إلى السلة'), backgroundColor: AppTheme.binanceGreen));
  }

  void _addStory() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('إضافة حالة - قريباً'), backgroundColor: AppTheme.binanceGold));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: _buildAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Text('الحالات', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500))),
            StoriesWidget(stories: _stories, onAddStory: _addStory),
          ])),
          SliverToBoxAdapter(child: const SizedBox(height: 8)),
          SliverToBoxAdapter(child: _buildStatsCard()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildCarousel()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildQuickActions()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('متابعاتك', 'مشاهدة الكل', onTap: () => _navigateTo(const AllStoresScreen()))),
          SliverToBoxAdapter(child: _buildFollowingsList()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('العروض الرائجة', 'تسوق الآن', onTap: () => _navigateTo(const OffersScreen()))),
          SliverToBoxAdapter(child: _buildTrendingOffers()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('الأسواق الرائجة', 'استكشف الان', onTap: () => _navigateTo(const MarketsScreen()))),
          SliverToBoxAdapter(child: _buildMarkets()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('الفئات', 'عرض الكل', onTap: () => _navigateTo(const AllCategoriesScreen()))),
          SliverToBoxAdapter(child: _buildCategoriesGrid()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('موصى به', 'تسوق الآن', onTap: () {})),
          SliverToBoxAdapter(child: _buildFeaturedProducts()),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.binanceDark,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('FLEX', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.binanceGold)),
        const SizedBox(width: 6),
        Text('YEMEN', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppTheme.binanceGold.withOpacity(0.8))),
      ]),
      centerTitle: true,
      actions: [
        IconButton(icon: const Icon(Icons.search, color: AppTheme.binanceGold), onPressed: () {}),
        IconButton(icon: const Icon(Icons.notifications_none, color: AppTheme.binanceGold), onPressed: () {}),
        IconButton(icon: const Icon(Icons.shopping_cart_outlined, color: AppTheme.binanceGold), onPressed: () => _navigateTo(const CartScreen())),
      ],
    );
  }

  Widget _buildStatsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF1E2329), Color(0xFF16213E)]), borderRadius: BorderRadius.circular(16)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        GestureDetector(onTap: () => _navigateToStats('purchases'), child: _buildStatItem('إجمالي المشتريات', '1,234,567', AppTheme.binanceGold)),
        Container(width: 1, height: 30, color: AppTheme.binanceBorder),
        GestureDetector(onTap: () => _navigateToStats('points'), child: _buildStatItem('نقاط الولاء', '1,250', AppTheme.binanceGreen)),
        Container(width: 1, height: 30, color: AppTheme.binanceBorder),
        GestureDetector(onTap: () => _navigateToStats('orders'), child: _buildStatItem('الطلبات', '24', AppTheme.serviceBlue)),
      ]),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(children: [Text(value, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(label, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10))]);
  }

  Widget _buildCarousel() {
    return Column(children: [
      CarouselSlider.builder(
        itemCount: _carouselItems.length,
        options: CarouselOptions(height: 180, autoPlay: true, viewportFraction: 0.9, enlargeCenterPage: true, onPageChanged: (i, _) => setState(() => _carouselIndex = i)),
        itemBuilder: (context, index, realIndex) {
          final item = _carouselItems[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(gradient: LinearGradient(colors: item['gradient'] as List<Color>, begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(20)),
              child: Stack(children: [
                ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.network(item['image'], height: 180, width: double.infinity, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: Colors.grey[800]))),
                Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: LinearGradient(colors: [Colors.black.withOpacity(0.5), Colors.transparent], begin: Alignment.centerRight, end: Alignment.centerLeft))),
                Positioned(top: 12, left: 12, child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: AppTheme.binanceRed, borderRadius: BorderRadius.circular(20)), child: Row(children: [const Icon(Icons.local_offer, color: Colors.white, size: 12), const SizedBox(width: 4), Text(item['badge'], style: const TextStyle(color: Colors.white, fontSize: 10))]))),
                Positioned(top: 12, right: 12, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), borderRadius: BorderRadius.circular(12)), child: Text('خصم ${item['discount']}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)))),
                Positioned(right: 20, top: 50, child: Text(item['title'], style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold))),
                Positioned(right: 20, top: 85, child: SizedBox(width: 200, child: Text(item['subtitle'], style: const TextStyle(color: Colors.white70, fontSize: 12)))),
                Positioned(right: 20, bottom: 20, child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)), child: Text(item['buttonText'], style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)))),
              ]),
            ),
          );
        },
      ),
      const SizedBox(height: 12),
      AnimatedSmoothIndicator(activeIndex: _carouselIndex, count: _carouselItems.length, effect: ExpandingDotsEffect(activeDotColor: AppTheme.binanceGold, dotColor: AppTheme.binanceBorder)),
    ]);
  }

  Widget _buildQuickActions() {
    final actions = [
      {'icon': Icons.category, 'label': 'فئات', 'screen': const AllCategoriesScreen()},
      {'icon': Icons.store, 'label': 'متاجر', 'screen': const StoresScreen()},
      {'icon': Icons.gavel, 'label': 'مزادات', 'screen': const AuctionsScreen()},
      {'icon': Icons.local_offer, 'label': 'عروض', 'screen': const OffersScreen()},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: actions.map((a) => GestureDetector(
        onTap: () => _navigateTo(a['screen'] as Widget),
        child: Column(children: [Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppTheme.binanceCard, shape: BoxShape.circle), child: Icon(a['icon'] as IconData, color: AppTheme.binanceGold, size: 28)), const SizedBox(height: 8), Text(a['label'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12))]),
      )).toList()),
    );
  }

  Widget _buildSectionHeader(String title, String action, {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        GestureDetector(onTap: onTap, child: Row(children: [Text(action, style: TextStyle(color: AppTheme.binanceGold, fontSize: 12)), const SizedBox(width: 4), Icon(Icons.arrow_forward_ios, color: AppTheme.binanceGold, size: 10)])),
      ]),
    );
  }

  Widget _buildFollowingsList() {
    return SizedBox(
      height: 100,
      child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: _followings.length, itemBuilder: (_, i) => GestureDetector(
        onTap: () => _navigateTo(const AllStoresScreen()),
        child: Container(width: 150, margin: const EdgeInsets.only(right: 12), padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12)), child: Row(children: [
          CircleAvatar(radius: 20, backgroundColor: AppTheme.binanceGold.withOpacity(0.2), child: Icon(Icons.store, color: AppTheme.binanceGold, size: 20)),
          const SizedBox(width: 8),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(_followings[i]['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), maxLines: 1),
            Text(_followings[i]['update'] as String, style: TextStyle(color: AppTheme.binanceGold, fontSize: 10)),
            Text(_followings[i]['time'] as String, style: const TextStyle(color: Color(0xFF5E6673), fontSize: 9)),
          ])),
        ])),
      )),
    );
  }

  Widget _buildTrendingOffers() {
    return SizedBox(
      height: 200,
      child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: _trendingOffers.length, itemBuilder: (_, i) {
        final product = _trendingOffers[i];
        return Container(
          width: 160, margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.binanceBorder)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(children: [
              ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(12)), child: Image.network(product['image']!, height: 120, width: double.infinity, fit: BoxFit.cover)),
              Positioned(top: 8, left: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppTheme.binanceRed, borderRadius: BorderRadius.circular(4)), child: Text('-${product['discount']}%', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
              Positioned(bottom: 8, right: 8, child: GestureDetector(
                onTap: () => _addToCartWithAnimation(product['name'] as String),
                child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: AppTheme.binanceGold, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: AppTheme.binanceGold.withOpacity(0.4), blurRadius: 4)]), child: const Icon(Icons.add_shopping_cart, color: Colors.black, size: 18)),
              )),
            ]),
            Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(product['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), maxLines: 1),
              Row(children: [Text(product['price'] as String, style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold, fontSize: 12)), const SizedBox(width: 4), Text(product['old'] as String, style: const TextStyle(color: Color(0xFF5E6673), decoration: TextDecoration.lineThrough, fontSize: 10))]),
            ])),
          ]),
        );
      }),
    );
  }

  Widget _buildMarkets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: _markets.map((m) => GestureDetector(
          onTap: () => _navigateTo(const MarketsScreen()),
          child: Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(10)), child: Row(children: [
            Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(m['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)), Text(m['description'] as String, style: const TextStyle(color: Color(0xFF5E6673), fontSize: 10))])),
            Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: (m['isUp'] as bool) ? AppTheme.binanceGreen.withOpacity(0.1) : AppTheme.binanceRed.withOpacity(0.1), borderRadius: BorderRadius.circular(4)), child: Row(children: [
              Icon((m['isUp'] as bool) ? Icons.trending_up : Icons.trending_down, color: (m['isUp'] as bool) ? AppTheme.binanceGreen : AppTheme.binanceRed, size: 10),
              const SizedBox(width: 2), Text(m['change'] as String, style: TextStyle(color: (m['isUp'] as bool) ? AppTheme.binanceGreen : AppTheme.binanceRed, fontSize: 10)),
            ])),
            const SizedBox(width: 12), Text(m['volume'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
            const SizedBox(width: 8), Text('${m['items']}', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 11)),
            const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 14),
          ])),
        )).toList(),
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 5, childAspectRatio: 0.9, children: _categories.map((cat) => GestureDetector(
        onTap: () => _navigateTo(const AllCategoriesScreen()),
        child: Column(children: [
          ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(cat['image'] as String, height: 50, width: 50, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(height: 50, width: 50, color: (cat['color'] as Color).withOpacity(0.2), child: Icon(cat['icon'] as IconData, color: cat['color'] as Color, size: 24)))),
          const SizedBox(height: 4), Text(cat['name'] as String, style: const TextStyle(color: Colors.white, fontSize: 10), textAlign: TextAlign.center, maxLines: 2),
        ]),
      )).toList()),
    );
  }

  Widget _buildFeaturedProducts() {
    return SizedBox(
      height: 220,
      child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: _featuredProducts.length, itemBuilder: (_, i) {
        final product = _featuredProducts[i];
        return Container(
          width: 170, margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.binanceBorder)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(children: [
              ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(12)), child: Image.network(product['image'] as String, height: 120, width: double.infinity, fit: BoxFit.cover)),
              if (product['discount'] > 0) Positioned(top: 8, left: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppTheme.binanceRed, borderRadius: BorderRadius.circular(4)), child: Text('-${product['discount']}%', style: const TextStyle(color: Colors.white, fontSize: 10)))),
              Positioned(top: 8, right: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppTheme.binanceGold.withOpacity(0.9), borderRadius: BorderRadius.circular(4)), child: Text(product['tag'] as String, style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)))),
              Positioned(bottom: 8, right: 8, child: GestureDetector(
                onTap: () => _addToCartWithAnimation(product['name'] as String),
                child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: AppTheme.binanceGold, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: AppTheme.binanceGold.withOpacity(0.4), blurRadius: 4)]), child: const Icon(Icons.add_shopping_cart, color: Colors.black, size: 18)),
              )),
            ]),
            Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(product['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), maxLines: 2),
              const SizedBox(height: 4),
              Row(children: [
                Text(product['price'] as String, style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold, fontSize: 12)),
                if (product['oldPrice'] != null) ...[const SizedBox(width: 4), Text(product['oldPrice'] as String, style: const TextStyle(color: Color(0xFF5E6673), decoration: TextDecoration.lineThrough, fontSize: 10))],
              ]),
              const SizedBox(height: 2),
              Row(children: [const Icon(Icons.star, size: 12, color: Colors.amber), const SizedBox(width: 2), Text('${product['rating']}', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10))]),
            ])),
          ]),
        );
      }),
    );
  }
}

class StoryModel {
  final String id, name, imageUrl, time;
  final bool isViewed;
  final bool isUser;

  StoryModel({required this.id, required this.name, required this.imageUrl, required this.time, this.isViewed = false, this.isUser = false});
}
