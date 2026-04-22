import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_drawer.dart';
import '../search_screen.dart';
import '../notifications_screen.dart';
import '../categories_screen.dart';
import '../auctions/auctions_screen.dart';
import '../offers_screen.dart';
import '../stores/stores_screen.dart';
import '../stores/store_detail_screen.dart';
import '../product/product_detail_screen.dart';
import '../following_screen.dart';
import '../markets_screen.dart';
import '../nearby_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _carouselIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();
  bool _isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, String>> _carouselItems = [
    {'title': 'عرض خاص', 'subtitle': 'خصم 50% على الإلكترونيات', 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=600'},
    {'title': 'عروض البرق', 'subtitle': 'لفترة محدودة', 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=600'},
    {'title': 'عرض VIP', 'subtitle': 'خصم 25% للأعضاء', 'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=600'},
  ];

  final List<Map<String, dynamic>> _featuredStores = [
    {'name': 'متجر التقنية', 'category': 'إلكترونيات', 'rating': 4.8, 'isOpen': true, 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200'},
    {'name': 'عالم الجوالات', 'category': 'إلكترونيات', 'rating': 4.7, 'isOpen': true, 'image': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=200'},
    {'name': 'الأزياء العصرية', 'category': 'أزياء', 'rating': 4.6, 'isOpen': false, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200'},
  ];

  final List<Map<String, dynamic>> _trendingOffers = [
    {'name': 'iPhone 15 Pro', 'price': '350,000', 'old': '450,000', 'discount': '50', 'hero': 'iphone', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400'},
    {'name': 'MacBook Pro M3', 'price': '1,800,000', 'old': '2,100,000', 'discount': '30', 'hero': 'macbook', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400'},
    {'name': 'Samsung S24 Ultra', 'price': '380,000', 'old': '450,000', 'discount': '40', 'hero': 'samsung', 'image': 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=400'},
  ];

  final List<Map<String, dynamic>> _featuredProducts = [
    {'name': 'ساعة أبل الترا', 'price': '45,000', 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400', 'hero': 'watch'},
    {'name': 'سماعات ايربودز برو', 'price': '35,000', 'image': 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=400', 'hero': 'airpods'},
    {'name': 'آيباد برو M2', 'price': '280,000', 'image': 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400', 'hero': 'ipad'},
    {'name': 'كاميرا كانون R50', 'price': '120,000', 'image': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=400', 'hero': 'camera'},
  ];

  final List<Map<String, dynamic>> _markets = [
    {'name': 'السوق اليمني', 'change': '+2.5%', 'volume': '1.2M', 'isUp': true},
    {'name': 'المولات', 'change': '+1.8%', 'volume': '890K', 'isUp': true},
    {'name': 'المقاهي', 'change': '+3.2%', 'volume': '567K', 'isUp': true},
    {'name': 'الفنادق', 'change': '-0.5%', 'volume': '456K', 'isUp': false},
  ];

  final List<Map<String, dynamic>> _nearby = [
    {'name': 'متجر الذهبية', 'distance': '0.3 كم', 'rating': 4.5, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200'},
    {'name': 'متجر النخبة', 'distance': '0.8 كم', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1581539250439-c96689b516dd?w=200'},
    {'name': 'متجر السعادة', 'distance': '1.2 كم', 'rating': 4.3, 'image': 'https://images.unsplash.com/photo-1556909114-44e3ef1e0d71?w=200'},
    {'name': 'مطعم النور', 'distance': '0.5 كم', 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200'},
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  void _showEmptyState() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('لا توجد بيانات حالياً'), duration: Duration(seconds: 2)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF0B0E11),
      drawer: const AppDrawer(),
      appBar: _buildAppBar(context),
      body: _isLoading ? _buildShimmerLoading() : _buildContent(context),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView(padding: const EdgeInsets.all(16), children: [Shimmer.fromColors(baseColor: const Color(0xFF2A3A54), highlightColor: const Color(0xFF3A4A64), child: Column(children: [Container(height: 160, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))), const SizedBox(height: 20), Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: List.generate(4, (_) => Container(width: 55, height: 55, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)))), const SizedBox(height: 20), Container(height: 100, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12))), const SizedBox(height: 20), Container(height: 120, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12))), const SizedBox(height: 20), Container(height: 180, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)))]))]);
  }

  Widget _buildContent(BuildContext context) {
    if (_featuredStores.isEmpty) return _buildEmptyState();
    return RefreshIndicator(
      onRefresh: () async { setState(() => _isLoading = true); await Future.delayed(const Duration(seconds: 1)); setState(() => _isLoading = false); },
      color: const Color(0xFFD4AF37),
      backgroundColor: const Color(0xFF1E2329),
      child: ListView(padding: const EdgeInsets.all(16), children: [_buildStatsCard(), const SizedBox(height: 20), _buildCarousel(), const SizedBox(height: 20), _buildQuickActions(context), const SizedBox(height: 20), _buildSectionHeader('متابعاتك', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FollowingScreen()))), const SizedBox(height: 12), _buildFollowingsList(), const SizedBox(height: 20), _buildSectionHeader('متاجر مميزة', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StoresScreen()))), const SizedBox(height: 12), _buildFeaturedStores(), const SizedBox(height: 20), _buildSectionHeader('العروض الرائجة', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OffersScreen()))), const SizedBox(height: 12), _buildTrendingOffers(), const SizedBox(height: 20), _buildSectionHeader('الأسواق الرائجة', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MarketsScreen()))), const SizedBox(height: 12), _buildMarkets(), const SizedBox(height: 20), _buildSectionHeader('بالقرب منك', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NearbyScreen()))), const SizedBox(height: 12), _buildNearby(), const SizedBox(height: 20), _buildSectionHeader('منتجات مميزة', onTap: () {}), const SizedBox(height: 12), _buildProductsGrid(), const SizedBox(height: 20)]),
    );
  }

  Widget _buildEmptyState() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.inbox, size: 80, color: Colors.grey[600]), const SizedBox(height: 16), const Text('لا توجد بيانات', style: TextStyle(color: Colors.white, fontSize: 18)), const SizedBox(height: 8), const Text('اسحب للأسفل للتحديث', style: TextStyle(color: Color(0xFF9CA3AF)))]));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0B0E11),
      elevation: 0,
      leading: IconButton(icon: const Icon(Icons.menu, color: Color(0xFFD4AF37)), onPressed: () { HapticFeedback.lightImpact(); _scaffoldKey.currentState?.openDrawer(); }),
      title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Text('FLEX', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))), const SizedBox(width: 6), Text('YEMEN', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: const Color(0xFFD4AF37).withOpacity(0.8)))]),
      actions: [
        IconButton(icon: SvgPicture.asset('assets/icons/svg/search.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)), onPressed: () { HapticFeedback.lightImpact(); Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen())); }),
        IconButton(icon: SvgPicture.asset('assets/icons/svg/notification.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)), onPressed: () { HapticFeedback.lightImpact(); Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())); }),
      ],
    );
  }

  Widget _buildStatsCard() {
    return Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [const Color(0xFF1E2329), const Color(0xFF0B0E11)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.3))), child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [_buildStat('المبيعات', '1,234 ريال', Icons.trending_up, const Color(0xFF0ECB81)), _buildStat('المنتجات', '156', Icons.shopping_bag, const Color(0xFFD4AF37)), _buildStat('المتابعون', '8.9K', Icons.people, const Color(0xFF2196F3))]));
  }

  Widget _buildStat(String label, String value, IconData icon, Color color) {
    return Column(children: [Icon(icon, color: color, size: 20), const SizedBox(height: 4), Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), Text(label, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11))]);
  }

  Widget _buildCarousel() {
    return Column(children: [
      CarouselSlider.builder(carouselController: _carouselController, itemCount: _carouselItems.length, options: CarouselOptions(height: 160, autoPlay: true, autoPlayInterval: const Duration(seconds: 4), enlargeCenterPage: true, viewportFraction: 0.9, onPageChanged: (index, reason) => setState(() => _carouselIndex = index)), itemBuilder: (context, index, realIndex) {
        final item = _carouselItems[index];
        return Container(margin: const EdgeInsets.symmetric(horizontal: 4), decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)), child: Stack(children: [ClipRRect(borderRadius: BorderRadius.circular(20), child: CachedNetworkImage(imageUrl: item['image']!, height: 160, width: double.infinity, fit: BoxFit.cover, placeholder: (_, __) => Shimmer.fromColors(baseColor: const Color(0xFF2A3A54), highlightColor: const Color(0xFF3A4A64), child: Container(color: Colors.white)), errorWidget: (_, __, ___) => Container(color: const Color(0xFF1E2329)))), Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: LinearGradient(colors: [Colors.black.withOpacity(0.6), Colors.transparent], begin: Alignment.centerRight, end: Alignment.centerLeft))), Positioned(right: 20, top: 30, child: Text(item['title']!, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, shadows: [Shadow(color: Colors.black, blurRadius: 10)]))), Positioned(right: 20, top: 65, child: Text(item['subtitle']!, style: const TextStyle(color: Colors.white, fontSize: 14, shadows: [Shadow(color: Colors.black, blurRadius: 8)]))), Positioned(right: 20, bottom: 20, child: GestureDetector(onTap: () { HapticFeedback.lightImpact(); Navigator.push(context, MaterialPageRoute(builder: (_) => const OffersScreen())); }, child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: const Color(0xFFD4AF37), borderRadius: BorderRadius.circular(20)), child: const Text('تسوق الآن', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))))]));
      }),
      const SizedBox(height: 12),
      AnimatedSmoothIndicator(activeIndex: _carouselIndex, count: _carouselItems.length, effect: ExpandingDotsEffect(activeDotColor: const Color(0xFFD4AF37), dotColor: const Color(0xFF2B3139), dotHeight: 8, dotWidth: 8)),
    ]);
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [{'icon': Icons.category, 'label': 'فئات', 'screen': const CategoriesScreen()}, {'icon': Icons.store, 'label': 'أسواق', 'screen': const StoresScreen()}, {'icon': Icons.gavel, 'label': 'مزادات', 'screen': const AuctionsScreen()}, {'icon': Icons.local_offer, 'label': 'عروض', 'screen': const OffersScreen()}];
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: actions.map((a) => GestureDetector(onTap: () { HapticFeedback.lightImpact(); Navigator.push(context, MaterialPageRoute(builder: (_) => a['screen'] as Widget)); }, child: Column(children: [Container(width: 55, height: 55, decoration: BoxDecoration(color: const Color(0xFF1E2329), shape: BoxShape.circle), child: Icon(a['icon'] as IconData, color: const Color(0xFFD4AF37))), const SizedBox(height: 6), Text(a['label'] as String, style: const TextStyle(color: Colors.white, fontSize: 12))]))).toList());
  }

  Widget _buildSectionHeader(String title, {required VoidCallback onTap}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), TextButton(onPressed: () { HapticFeedback.lightImpact(); onTap(); }, child: const Text('عرض الكل', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 14)))]);
  }

  Widget _buildFollowingsList() {
    final stores = ['متجر التقنية', 'عالم الجوالات', 'الأزياء العصرية', 'مطعم النور'];
    return SizedBox(height: 100, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: stores.length, itemBuilder: (c, i) => GestureDetector(onTap: () { HapticFeedback.lightImpact(); }, child: Container(width: 140, margin: const EdgeInsets.only(right: 12), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF2B3139))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Container(width: 30, height: 30, decoration: BoxDecoration(color: const Color(0xFFD4AF37).withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: SvgPicture.asset('assets/icons/svg/store.svg', width: 18, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn))), const SizedBox(width: 8), Expanded(child: Text(stores[i], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), overflow: TextOverflow.ellipsis))]), const SizedBox(height: 8), Text(i == 0 ? 'منتج جديد' : i == 1 ? 'عرض خاص' : 'تخفيضات', style: TextStyle(color: const Color(0xFFD4AF37), fontSize: 11)), Text(i == 0 ? 'قبل ساعة' : i == 1 ? 'اليوم' : 'أمس', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 10))])))));
  }

  Widget _buildFeaturedStores() {
    return SizedBox(height: 120, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: _featuredStores.length, itemBuilder: (c, i) => GestureDetector(onTap: () { HapticFeedback.lightImpact(); Navigator.push(context, MaterialPageRoute(builder: (_) => StoreDetailScreen(storeId: '$i'))); }, child: Container(width: 160, margin: const EdgeInsets.only(right: 12), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF2B3139))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [ClipRRect(borderRadius: BorderRadius.circular(8), child: CachedNetworkImage(imageUrl: _featuredStores[i]['image']!, width: 30, height: 30, fit: BoxFit.cover, placeholder: (_, __) => Container(color: const Color(0xFF2A3A54)), errorWidget: (_, __, ___) => Container(color: const Color(0xFF1E2329), child: SvgPicture.asset('assets/icons/svg/store.svg', width: 18, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn))))), const SizedBox(width: 8), Expanded(child: Text(_featuredStores[i]['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), overflow: TextOverflow.ellipsis)), Container(width: 6, height: 6, decoration: BoxDecoration(shape: BoxShape.circle, color: (_featuredStores[i]['isOpen'] as bool) ? const Color(0xFF0ECB81) : const Color(0xFFF6465D)))]), const SizedBox(height: 6), Text(_featuredStores[i]['category']!, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10)), const SizedBox(height: 4), Row(children: [const Icon(Icons.star, color: Colors.amber, size: 12), const SizedBox(width: 2), Text('${_featuredStores[i]['rating']}', style: const TextStyle(color: Colors.white, fontSize: 11)), const Spacer(), Text((_featuredStores[i]['isOpen'] as bool) ? 'مفتوح' : 'مغلق', style: TextStyle(color: (_featuredStores[i]['isOpen'] as bool) ? const Color(0xFF0ECB81) : const Color(0xFFF6465D), fontSize: 10))])]))));
  }

  Widget _buildTrendingOffers() {
    return SizedBox(height: 180, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: _trendingOffers.length, itemBuilder: (c, i) => GestureDetector(onTap: () { HapticFeedback.lightImpact(); Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(productId: '', heroTag: _trendingOffers[i]['hero']!))); }, child: Container(width: 140, margin: const EdgeInsets.only(right: 12), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF2B3139))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Hero(tag: _trendingOffers[i]['hero']!, child: ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(12)), child: CachedNetworkImage(imageUrl: _trendingOffers[i]['image']!, height: 100, width: double.infinity, fit: BoxFit.cover, placeholder: (_, __) => Shimmer.fromColors(baseColor: const Color(0xFF2A3A54), highlightColor: const Color(0xFF3A4A64), child: Container(color: Colors.white)), errorWidget: (_, __, ___) => Container(color: const Color(0xFFF6465D).withOpacity(0.2), child: Center(child: Text('-${_trendingOffers[i]['discount']}%', style: const TextStyle(color: Color(0xFFF6465D), fontSize: 24, fontWeight: FontWeight.bold))))))), Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(_trendingOffers[i]['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), overflow: TextOverflow.ellipsis), const SizedBox(height: 4), Row(children: [Text(_trendingOffers[i]['price']!, style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 12)), const SizedBox(width: 4), Text(_trendingOffers[i]['old']!, style: const TextStyle(color: Color(0xFF5E6673), decoration: TextDecoration.lineThrough, fontSize: 10))])])]))));
  }


  Widget _buildNearby() {
    return GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, childAspectRatio: 2.5, crossAxisSpacing: 12, mainAxisSpacing: 12, children: _nearby.map((n) => Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF2B3139))), child: Row(children: [ClipRRect(borderRadius: BorderRadius.circular(8), child: CachedNetworkImage(imageUrl: n['image']!, width: 35, height: 35, fit: BoxFit.cover, placeholder: (_, __) => Container(color: const Color(0xFF2A3A54)), errorWidget: (_, __, ___) => Container(color: const Color(0xFFD4AF37).withOpacity(0.1), child: const Icon(Icons.location_on, color: Color(0xFFD4AF37), size: 20)))), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text(n['name']!, style: const TextStyle(color: Colors.white, fontSize: 12), overflow: TextOverflow.ellipsis), Row(children: [Text(n['distance']!, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10)), const SizedBox(width: 8), const Icon(Icons.star, size: 10, color: Colors.amber), Text('${n['rating']}', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10))])])),]))).toList());
  }

  Widget _buildProductsGrid() {
    return GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 12, mainAxisSpacing: 12), itemCount: _featuredProducts.length, itemBuilder: (context, index) => GestureDetector(onTap: () { HapticFeedback.lightImpact(); Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(productId: '', heroTag: _featuredProducts[index]['hero']!))); }, child: Container(decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF2B3139))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: Hero(tag: _featuredProducts[index]['hero']!, child: ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(12)), child: CachedNetworkImage(imageUrl: _featuredProducts[index]['image']!, width: double.infinity, fit: BoxFit.cover, placeholder: (_, __) => Shimmer.fromColors(baseColor: const Color(0xFF2A3A54), highlightColor: const Color(0xFF3A4A64), child: Container(color: Colors.white)), errorWidget: (_, __, ___) => Container(color: const Color(0xFFD4AF37).withOpacity(0.1), child: const Center(child: Icon(Icons.shopping_bag, color: Color(0xFFD4AF37), size: 40))))))), Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Expanded(child: Text(_featuredProducts[index]['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), overflow: TextOverflow.ellipsis)), GestureDetector(onTap: () { HapticFeedback.lightImpact(); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تمت الإضافة إلى السلة'), duration: Duration(seconds: 1), backgroundColor: Color(0xFF0ECB81))); }, child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: const Color(0xFFD4AF37).withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.add_shopping_cart, color: Color(0xFFD4AF37), size: 18)))]), const SizedBox(height: 4), Text('${_featuredProducts[index]['price']} ريال', style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 13))])),]))));
  }
}
