import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../search_screen.dart';
import '../notifications_screen.dart';
import '../categories_screen.dart';
import '../auctions/auctions_screen.dart';
import '../offers_screen.dart';
import '../stores/stores_screen.dart';
import '../product/product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _carouselIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();
  bool _isLoading = true;

  final List<Map<String, String>> _carouselItems = [
    {'title': 'عرض خاص', 'subtitle': 'خصم 50% على الإلكترونيات', 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=600'},
    {'title': 'عروض البرق', 'subtitle': 'لفترة محدودة', 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=600'},
    {'title': 'عرض VIP', 'subtitle': 'خصم 25% للأعضاء', 'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=600'},
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: _buildAppBar(context),
      body: _isLoading ? _buildShimmerLoading() : _buildContent(context),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView(padding: const EdgeInsets.all(16), children: [Shimmer.fromColors(baseColor: const Color(0xFF2A3A54), highlightColor: const Color(0xFF3A4A64), child: Column(children: [Container(height: 160, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))), const SizedBox(height: 20), Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: List.generate(4, (_) => Container(width: 55, height: 55, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)))), const SizedBox(height: 20), Container(height: 100, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12))), const SizedBox(height: 20), Container(height: 120, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12))), const SizedBox(height: 20), Container(height: 180, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)))]))]);
  }

  Widget _buildContent(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async { setState(() => _isLoading = true); await Future.delayed(const Duration(seconds: 1)); setState(() => _isLoading = false); },
      color: const Color(0xFFD4AF37),
      backgroundColor: const Color(0xFF1E2329),
      child: ListView(padding: const EdgeInsets.all(16), children: [
        _buildCarousel(),
        const SizedBox(height: 20),
        _buildQuickActions(context),
        const SizedBox(height: 20),
        _buildSectionHeader('منتجات مميزة', onTap: () {}),
        const SizedBox(height: 12),
        _buildProductsGrid(),
        const SizedBox(height: 20),
      ]),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0B0E11),
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Text('FLEX', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))), const SizedBox(width: 6), Text('YEMEN', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: const Color(0xFFD4AF37).withOpacity(0.8)))]),
      actions: [IconButton(icon: SvgPicture.asset('assets/icons/svg/search.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen()))), IconButton(icon: SvgPicture.asset('assets/icons/svg/notification.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())))],
    );
  }

  Widget _buildCarousel() {
    return Column(children: [
      CarouselSlider.builder(carouselController: _carouselController, itemCount: _carouselItems.length, options: CarouselOptions(height: 160, autoPlay: true, autoPlayInterval: const Duration(seconds: 4), enlargeCenterPage: true, viewportFraction: 0.9, onPageChanged: (index, reason) => setState(() => _carouselIndex = index)), itemBuilder: (context, index, realIndex) {
        final item = _carouselItems[index];
        return Container(margin: const EdgeInsets.symmetric(horizontal: 4), decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)), child: Stack(children: [ClipRRect(borderRadius: BorderRadius.circular(20), child: CachedNetworkImage(imageUrl: item['image']!, height: 160, width: double.infinity, fit: BoxFit.cover, placeholder: (_, __) => Shimmer.fromColors(baseColor: const Color(0xFF2A3A54), highlightColor: const Color(0xFF3A4A64), child: Container(color: Colors.white)), errorWidget: (_, __, ___) => Container(color: const Color(0xFF1E2329)))), Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: LinearGradient(colors: [Colors.black.withOpacity(0.6), Colors.transparent], begin: Alignment.centerRight, end: Alignment.centerLeft))), Positioned(right: 20, top: 30, child: Text(item['title']!, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, shadows: [Shadow(color: Colors.black, blurRadius: 10)]))), Positioned(right: 20, top: 65, child: Text(item['subtitle']!, style: const TextStyle(color: Colors.white, fontSize: 14, shadows: [Shadow(color: Colors.black, blurRadius: 8)]))), Positioned(right: 20, bottom: 20, child: GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OffersScreen())), child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: const Color(0xFFD4AF37), borderRadius: BorderRadius.circular(20)), child: const Text('تسوق الآن', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))))]));
      }),
      const SizedBox(height: 12),
      AnimatedSmoothIndicator(activeIndex: _carouselIndex, count: _carouselItems.length, effect: ExpandingDotsEffect(activeDotColor: const Color(0xFFD4AF37), dotColor: const Color(0xFF2B3139), dotHeight: 8, dotWidth: 8)),
    ]);
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [{'icon': Icons.category, 'label': 'فئات', 'screen': const CategoriesScreen()}, {'icon': Icons.store, 'label': 'أسواق', 'screen': const StoresScreen()}, {'icon': Icons.gavel, 'label': 'مزادات', 'screen': const AuctionsScreen()}, {'icon': Icons.local_offer, 'label': 'عروض', 'screen': const OffersScreen()}];
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: actions.map((a) => GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => a['screen'] as Widget)), child: Column(children: [Container(width: 55, height: 55, decoration: BoxDecoration(color: const Color(0xFF1E2329), shape: BoxShape.circle), child: Icon(a['icon'] as IconData, color: const Color(0xFFD4AF37))), const SizedBox(height: 6), Text(a['label'] as String, style: const TextStyle(color: Colors.white, fontSize: 12))]))).toList());
  }

  Widget _buildSectionHeader(String title, {required VoidCallback onTap}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), TextButton(onPressed: onTap, child: const Text('عرض الكل', style: TextStyle(color: Color(0xFFD4AF37))))]);
  }

  Widget _buildProductsGrid() {
    final products = [{'name': 'ساعة أبل الترا', 'price': '45,000', 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400'}, {'name': 'سماعات ايربودز برو', 'price': '35,000', 'image': 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=400'}, {'name': 'آيباد برو M2', 'price': '280,000', 'image': 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400'}, {'name': 'كاميرا كانون R50', 'price': '120,000', 'image': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=400'}];
    return GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 12, mainAxisSpacing: 12), itemCount: products.length, itemBuilder: (context, index) => GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductDetailScreen(productId: ''))), child: Container(decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(12)), child: CachedNetworkImage(imageUrl: products[index]['image']!, width: double.infinity, fit: BoxFit.cover, placeholder: (_, __) => Shimmer.fromColors(baseColor: const Color(0xFF2A3A54), highlightColor: const Color(0xFF3A4A64), child: Container(color: Colors.white)), errorWidget: (_, __, ___) => Container(color: const Color(0xFFD4AF37).withOpacity(0.1), child: const Center(child: Icon(Icons.shopping_bag, color: Color(0xFFD4AF37), size: 40)))))), Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(products[index]['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), overflow: TextOverflow.ellipsis), const SizedBox(height: 4), Text('${products[index]['price']} ريال', style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 13))])),]))));
  }
}
