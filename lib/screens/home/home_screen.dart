import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../categories/all_categories_screen.dart';
import '../stores/stores_screen.dart';
import '../auctions/auctions_screen.dart';
import '../offers_screen.dart';
import '../profile/following_screen.dart';
import '../markets_screen.dart';
import '../nearby_screen.dart';
import '../cart/cart_screen.dart';
import '../notifications_screen.dart';
import '../search_screen.dart';
import '../product/product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _carouselIndex = 0;

  final List<Map<String, String>> _carouselItems = [
    {'title': 'عرض خاص', 'subtitle': 'خصم 50% على الإلكترونيات', 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=600', 'route': '/offers'},
    {'title': 'عروض البرق', 'subtitle': 'لفترة محدودة', 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=600', 'route': '/flash_sale'},
    {'title': 'عرض VIP', 'subtitle': 'خصم 25% للأعضاء', 'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=600', 'route': '/vip'},
    {'title': 'توصيل مجاني', 'subtitle': 'للطلبات فوق 200,000 ريال', 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=600', 'route': '/delivery'},
  ];

  final List<Map<String, dynamic>> _categories = [
    {'name': 'إلكترونيات', 'icon': Icons.devices, 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200', 'color': const Color(0xFF2196F3), 'route': '/category/electronics'},
    {'name': 'أزياء', 'icon': Icons.checkroom, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200', 'color': const Color(0xFFE91E63), 'route': '/category/fashion'},
    {'name': 'سيارات', 'icon': Icons.directions_car, 'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=200', 'color': const Color(0xFFF6465D), 'route': '/category/cars'},
    {'name': 'عقارات', 'icon': Icons.home, 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=200', 'color': const Color(0xFF4CAF50), 'route': '/category/realestate'},
    {'name': 'أثاث', 'icon': Icons.chair, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200', 'color': const Color(0xFFFF9800), 'route': '/category/furniture'},
    {'name': 'مطاعم', 'icon': Icons.restaurant, 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200', 'color': const Color(0xFF9C27B0), 'route': '/category/restaurants'},
  ];

  final List<Map<String, dynamic>> _followings = [
    {'name': 'متجر التقنية', 'update': 'منتج جديد', 'time': 'قبل ساعة', 'storeId': '1'},
    {'name': 'مطعم مندي الملكي', 'update': 'عرض خاص', 'time': 'اليوم', 'storeId': '2'},
    {'name': 'الأزياء العصرية', 'update': 'تخفيضات', 'time': 'أمس', 'storeId': '3'},
  ];

  final List<Map<String, dynamic>> _trendingOffers = [
    {'name': 'iPhone 15 Pro', 'price': '350,000', 'old': '450,000', 'productId': '1', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400'},
    {'name': 'ساعة أبل الترا', 'price': '45,000', 'old': '60,000', 'productId': '2', 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400'},
    {'name': 'ماك بوك برو', 'price': '1,800,000', 'old': '2,100,000', 'productId': '3', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400'},
  ];

  final List<Map<String, dynamic>> _markets = [
    {'name': 'السوق اليمني', 'change': '+2.5%', 'volume': '1.2M', 'items': 1250, 'isUp': true},
    {'name': 'المولات', 'change': '+1.8%', 'volume': '890K', 'items': 450, 'isUp': true},
    {'name': 'المقاهي', 'change': '+3.2%', 'volume': '567K', 'items': 320, 'isUp': true},
    {'name': 'الفنادق', 'change': '-0.5%', 'volume': '456K', 'items': 95, 'isUp': false},
  ];

  final List<Map<String, dynamic>> _nearby = [
    {'name': 'سوبر ماركت السعادة', 'distance': '0.3 كم', 'rating': 4.5, 'storeId': '5'},
    {'name': 'مطعم البيت اليمني', 'distance': '0.8 كم', 'rating': 4.8, 'storeId': '6'},
  ];

  final List<Map<String, dynamic>> _products = [
    {'name': 'سامسونج S24', 'price': '380,000', 'productId': '4', 'image': 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=400'},
    {'name': 'آيباد برو', 'price': '280,000', 'productId': '5', 'image': 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400'},
    {'name': 'كاميرا كانون', 'price': '120,000', 'productId': '6', 'image': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=400'},
  ];

  void _navigateTo(String route, {dynamic arguments}) {
    Navigator.pushNamed(context, route, arguments: arguments);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppTheme.binanceGreen, duration: const Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(child: const SizedBox(height: 8)),
          SliverToBoxAdapter(child: _buildStatsCard()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildCarousel()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildQuickActions()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('📌 متابعاتك', 'عرض الكل', onTap: () => _navigateTo('/following'))),
          SliverToBoxAdapter(child: _buildFollowingsList()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('🔥 العروض الرائجة', 'عرض الكل', onTap: () => _navigateTo('/offers'))),
          SliverToBoxAdapter(child: _buildTrendingOffers()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('📊 الأسواق الرائجة', 'عرض الكل', onTap: () => _navigateTo('/markets'))),
          SliverToBoxAdapter(child: _buildMarkets()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('📍 بالقرب منك', 'عرض الكل', onTap: () => _navigateTo('/nearby'))),
          SliverToBoxAdapter(child: _buildNearbyGrid()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('⭐ الفئات', 'عرض الكل', onTap: () => _navigateTo('/categories'))),
          SliverToBoxAdapter(child: _buildCategoriesGrid()),
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
        IconButton(icon: const Icon(Icons.search, color: AppTheme.binanceGold), onPressed: () => _navigateTo('/search')),
        IconButton(icon: const Icon(Icons.notifications_none, color: AppTheme.binanceGold), onPressed: () => _navigateTo('/notifications')),
        IconButton(icon: const Icon(Icons.shopping_cart_outlined, color: AppTheme.binanceGold), onPressed: () => _navigateTo('/cart')),
      ],
    );
  }

  Widget _buildStatsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF1E2329), Color(0xFF16213E)]), borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('إجمالي المشتريات', '1,234,567', AppTheme.binanceGold),
          Container(width: 1, height: 30, color: AppTheme.binanceBorder),
          _buildStatItem('نقاط الولاء', '1,250', AppTheme.binanceGreen),
          Container(width: 1, height: 30, color: AppTheme.binanceBorder),
          _buildStatItem('الطلبات', '24', AppTheme.serviceBlue),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(children: [Text(value, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(label, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10))]);
  }

  Widget _buildCarousel() {
    return Column(children: [
      CarouselSlider.builder(
        itemCount: _carouselItems.length,
        options: CarouselOptions(height: 160, autoPlay: true, viewportFraction: 0.9, onPageChanged: (i, _) => setState(() => _carouselIndex = i)),
        itemBuilder: (_, i, __) => GestureDetector(
          onTap: () => _navigateTo(_carouselItems[i]['route']!),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Stack(children: [
              ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.network(_carouselItems[i]['image']!, height: 160, width: double.infinity, fit: BoxFit.cover)),
              Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: LinearGradient(colors: [Colors.black.withOpacity(0.6), Colors.transparent], begin: Alignment.centerRight, end: Alignment.centerLeft))),
              Positioned(right: 20, top: 30, child: Text(_carouselItems[i]['title']!, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
              Positioned(right: 20, top: 65, child: Text(_carouselItems[i]['subtitle']!, style: const TextStyle(color: Colors.white70, fontSize: 14))),
              Positioned(right: 20, bottom: 20, child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: AppTheme.binanceGold, borderRadius: BorderRadius.circular(20)), child: const Text('تسوق الآن', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
            ]),
          ),
        ),
      ),
      const SizedBox(height: 12),
      AnimatedSmoothIndicator(activeIndex: _carouselIndex, count: _carouselItems.length, effect: ExpandingDotsEffect(activeDotColor: AppTheme.binanceGold, dotColor: AppTheme.binanceBorder)),
    ]);
  }

  Widget _buildQuickActions() {
    final actions = [
      {'icon': Icons.category, 'label': 'فئات', 'route': '/categories'},
      {'icon': Icons.store, 'label': 'متاجر', 'route': '/stores'},
      {'icon': Icons.gavel, 'label': 'مزادات', 'route': '/auctions'},
      {'icon': Icons.local_offer, 'label': 'عروض', 'route': '/offers'},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: actions.map((a) => GestureDetector(
          onTap: () => _navigateTo(a['route'] as String),
          child: Column(children: [
            Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppTheme.binanceCard, shape: BoxShape.circle), child: Icon(a['icon'] as IconData, color: AppTheme.binanceGold, size: 28)),
            const SizedBox(height: 8),
            Text(a['label'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
          ]),
        )).toList(),
      ),
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
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _followings.length,
        itemBuilder: (_, i) => GestureDetector(
          onTap: () => _navigateTo('/store/${_followings[i]['storeId']}'),
          child: Container(
            width: 150, margin: const EdgeInsets.only(right: 12), padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              CircleAvatar(radius: 20, backgroundColor: AppTheme.binanceGold.withOpacity(0.2), child: Icon(Icons.store, color: AppTheme.binanceGold, size: 20)),
              const SizedBox(width: 8),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(_followings[i]['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), maxLines: 1),
                Text(_followings[i]['update'] as String, style: TextStyle(color: AppTheme.binanceGold, fontSize: 10)),
                Text(_followings[i]['time'] as String, style: const TextStyle(color: Color(0xFF5E6673), fontSize: 9)),
              ])),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingOffers() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _trendingOffers.length,
        itemBuilder: (_, i) => GestureDetector(
          onTap: () => _navigateTo('/product/${_trendingOffers[i]['productId']}'),
          child: Container(
            width: 150, margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.binanceBorder)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(12)), child: Image.network(_trendingOffers[i]['image']!, height: 100, width: double.infinity, fit: BoxFit.cover)),
              Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(_trendingOffers[i]['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), maxLines: 1),
                Row(children: [Text(_trendingOffers[i]['price'] as String, style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold, fontSize: 12)), const SizedBox(width: 4), Text(_trendingOffers[i]['old'] as String, style: const TextStyle(color: Color(0xFF5E6673), decoration: TextDecoration.lineThrough, fontSize: 10))]),
              ])),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildMarkets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: _markets.map((m) => GestureDetector(
          onTap: () => _navigateTo('/market/${m['name']}'),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              Expanded(flex: 3, child: Text(m['name'] as String, style: const TextStyle(color: Colors.white))),
              Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: (m['isUp'] as bool) ? AppTheme.binanceGreen.withOpacity(0.1) : AppTheme.binanceRed.withOpacity(0.1), borderRadius: BorderRadius.circular(4)), child: Row(children: [
                Icon((m['isUp'] as bool) ? Icons.trending_up : Icons.trending_down, color: (m['isUp'] as bool) ? AppTheme.binanceGreen : AppTheme.binanceRed, size: 10),
                const SizedBox(width: 2), Text(m['change'] as String, style: TextStyle(color: (m['isUp'] as bool) ? AppTheme.binanceGreen : AppTheme.binanceRed, fontSize: 10)),
              ])),
              const SizedBox(width: 12), Text(m['volume'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
              const SizedBox(width: 8), Text('${m['items']}', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 11)),
            ]),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildNearbyGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2, childAspectRatio: 2.5, crossAxisSpacing: 12, mainAxisSpacing: 12,
        children: _nearby.map((n) => GestureDetector(
          onTap: () => _navigateTo('/store/${n['storeId']}'),
          child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              Container(width: 40, height: 40, decoration: BoxDecoration(color: AppTheme.binanceGold.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.store, color: AppTheme.binanceGold)),
              const SizedBox(width: 10),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(n['name'] as String, style: const TextStyle(color: Colors.white, fontSize: 12)),
                Row(children: [Text(n['distance'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10)), const SizedBox(width: 8), const Icon(Icons.star, size: 10, color: Colors.amber), Text('${n['rating']}', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10))]),
              ])),
            ]),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4, childAspectRatio: 0.85,
        children: _categories.map((cat) => GestureDetector(
          onTap: () => _navigateTo(cat['route'] as String),
          child: Column(children: [
            ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(cat['image'] as String, height: 55, width: 55, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(height: 55, width: 55, color: (cat['color'] as Color).withOpacity(0.2), child: Icon(cat['icon'] as IconData, color: cat['color'] as Color, size: 24)))),
            const SizedBox(height: 4), Text(cat['name'] as String, style: const TextStyle(color: Colors.white, fontSize: 10), textAlign: TextAlign.center),
          ]),
        )).toList(),
      ),
    );
  }
}
