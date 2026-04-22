import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';
import '../search_screen.dart';
import '../notifications_screen.dart';
import '../categories_screen.dart';
import '../auctions/auctions_screen.dart';
import '../offers_screen.dart';
import '../stores/stores_screen.dart';
import '../stores/store_detail_screen.dart';
import '../product/product_detail_screen.dart';
import '../favorites_screen.dart';
import '../track_order_screen.dart';
import '../checkout/checkout_screen.dart';
import '../wallet/wallet_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: const Color(0xFF0B0E11),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('FLEX', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
                const SizedBox(width: 6),
                Text('YEMEN', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: const Color(0xFFD4AF37).withOpacity(0.8))),
              ],
            ),
            actions: [
              IconButton(icon: SvgPicture.asset('assets/icons/svg/search.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen()))),
              IconButton(icon: SvgPicture.asset('assets/icons/svg/notification.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()))),
            ],
          ),
          
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // السلايدر
                  _buildPromoSlider(context),
                  const SizedBox(height: 20),
                  
                  // أزرار سريعة: فئات - أسواق - مزادات - عروض
                  _buildQuickActions(context),
                  const SizedBox(height: 20),
                  
                  // متابعاتك
                  _buildSectionHeader('متابعاتك', onSeeAll: () => Navigator.pushNamed(context, '/following')),
                  _buildFollowingsList(context),
                  const SizedBox(height: 20),
                  
                  // متاجر مميزة
                  _buildSectionHeader('متاجر مميزة', onSeeAll: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StoresScreen()))),
                  _buildFeaturedStores(context),
                  const SizedBox(height: 20),
                  
                  // استكشف أكثر
                  _buildExploreMore(context),
                  const SizedBox(height: 20),
                  
                  // العروض الرائجة
                  _buildSectionHeader('العروض الرائجة', onSeeAll: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OffersScreen()))),
                  _buildTrendingOffers(context),
                  const SizedBox(height: 20),
                  
                  // الأسواق الرائجة
                  _buildSectionHeader('الأسواق الرائجة', onSeeAll: () => Navigator.pushNamed(context, '/markets')),
                  _buildTrendingMarkets(context),
                  const SizedBox(height: 20),
                  
                  // بالقرب منك
                  _buildSectionHeader('بالقرب منك', onSeeAll: () => Navigator.pushNamed(context, '/nearby')),
                  _buildNearby(context),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoSlider(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OffersScreen())),
      child: Container(
        height: 160,
        decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFAA8C2C)]), borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Positioned(right: 20, top: 30, child: const Text('عرض خاص', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold))),
            Positioned(right: 20, top: 65, child: const Text('خصم 50% على الإلكترونيات', style: TextStyle(color: Colors.black87, fontSize: 14))),
            Positioned(right: 20, bottom: 20, child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)), child: const Text('تسوق الآن', style: TextStyle(color: Color(0xFFD4AF37))))),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      {'icon': Icons.category, 'label': 'فئات', 'route': () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoriesScreen()))},
      {'icon': Icons.store, 'label': 'أسواق', 'route': () => Navigator.pushNamed(context, '/markets')},
      {'icon': Icons.gavel, 'label': 'مزادات', 'route': () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AuctionsScreen()))},
      {'icon': Icons.local_offer, 'label': 'عروض', 'route': () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OffersScreen()))},
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: actions.map((a) => GestureDetector(
        onTap: () => a['route'] as VoidCallback,
        child: Column(children: [Container(width: 55, height: 55, decoration: BoxDecoration(color: const Color(0xFF1E2329), shape: BoxShape.circle), child: Icon(a['icon'] as IconData, color: const Color(0xFFD4AF37))), const SizedBox(height: 6), Text(a['label'] as String, style: const TextStyle(color: Colors.white, fontSize: 12))]),
      )).toList(),
    );
  }

  Widget _buildSectionHeader(String title, {required VoidCallback onSeeAll}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), TextButton(onPressed: onSeeAll, child: const Text('عرض الكل', style: TextStyle(color: Color(0xFFD4AF37))))]),
    );
  }

  Widget _buildFollowingsList(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: 4, itemBuilder: (c, i) => GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StoreDetailScreen(storeId: '$i'))),
        child: Container(width: 150, margin: const EdgeInsets.only(right: 12), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Container(width: 40, height: 40, decoration: BoxDecoration(color: const Color(0xFFD4AF37).withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.store, color: Color(0xFFD4AF37))), const SizedBox(width: 8), Expanded(child: Text('متجر ${i+1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))]), const SizedBox(height: 8), Text('منتج جديد', style: TextStyle(color: const Color(0xFFD4AF37), fontSize: 11)), Text('قبل ساعة', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 10))])),
      )),
    );
  }

  Widget _buildFeaturedStores(BuildContext context) {
    return SizedBox(height: 130, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: 4, itemBuilder: (c, i) => GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StoreDetailScreen(storeId: '$i'))),
      child: Container(width: 160, margin: const EdgeInsets.only(right: 12), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Container(width: 35, height: 35, decoration: BoxDecoration(color: const Color(0xFFD4AF37).withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.store, color: Color(0xFFD4AF37))), const SizedBox(width: 8), Expanded(child: Text('متجر مميز ${i+1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))), Container(width: 6, height: 6, decoration: BoxDecoration(shape: BoxShape.circle, color: i < 3 ? const Color(0xFF0ECB81) : const Color(0xFFF6465D)))]), const SizedBox(height: 6), Text('إلكترونيات', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10)), const SizedBox(height: 4), Row(children: [const Icon(Icons.star, color: Colors.amber, size: 12), const SizedBox(width: 2), Text('${4.5 + i*0.1}', style: const TextStyle(color: Colors.white, fontSize: 11)), const Spacer(), Text(i < 3 ? 'مفتوح' : 'مغلق', style: TextStyle(color: i < 3 ? const Color(0xFF0ECB81) : const Color(0xFFF6465D), fontSize: 10))])])),
    ));
  }

  Widget _buildExploreMore(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/explore'),
      child: Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(16)), child: Row(children: [const Icon(Icons.explore, color: Color(0xFFD4AF37)), const SizedBox(width: 12), const Expanded(child: Text('استكشف أكثر', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))), const Icon(Icons.arrow_forward, color: Color(0xFFD4AF37))])),
    );
  }

  Widget _buildTrendingOffers(BuildContext context) {
    return SizedBox(height: 180, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: 3, itemBuilder: (c, i) => GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(productId: 'offer$i'))),
      child: Container(width: 140, margin: const EdgeInsets.only(right: 12), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(height: 100, decoration: BoxDecoration(color: const Color(0xFFF6465D).withOpacity(0.2), borderRadius: const BorderRadius.vertical(top: Radius.circular(12))), child: Center(child: Text('-${[50,30,40][i]}%', style: const TextStyle(color: Color(0xFFF6465D), fontSize: 24, fontWeight: FontWeight.bold)))), Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(['iPhone 15', 'MacBook', 'Samsung'][i], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Row(children: [Text(['350', '1,800', '380'][i], style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)), const SizedBox(width: 4), Text(['450', '2,100', '450'][i], style: const TextStyle(color: Color(0xFF5E6673), decoration: TextDecoration.lineThrough, fontSize: 10))])])])])),
    ));
  }

  Widget _buildTrendingMarkets(BuildContext context) {
    return Column(
      children: [
        _buildMarketItem('السوق اليمني', '+2.5%', '1.2M', 1250, true),
        _buildMarketItem('المولات', '+1.8%', '890K', 450, true),
        _buildMarketItem('المقاهي', '+3.2%', '567K', 320, true),
        _buildMarketItem('الفنادق', '-0.5%', '456K', 95, false),
      ],
    );
  }

  Widget _buildMarketItem(String name, String change, String volume, int items, bool isUp) {
    return Container(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(children: [Expanded(flex: 3, child: Text(name, style: const TextStyle(color: Colors.white)))), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: isUp ? const Color(0xFF0ECB81).withOpacity(0.1) : const Color(0xFFF6465D).withOpacity(0.1), borderRadius: BorderRadius.circular(4)), child: Row(children: [Icon(isUp ? Icons.trending_up : Icons.trending_down, color: isUp ? const Color(0xFF0ECB81) : const Color(0xFFF6465D), size: 10), const SizedBox(width: 2), Text(change, style: TextStyle(color: isUp ? const Color(0xFF0ECB81) : const Color(0xFFF6465D), fontSize: 10))])), const SizedBox(width: 12), Expanded(child: Text(volume, style: const TextStyle(color: Color(0xFF9CA3AF)), textAlign: TextAlign.end)), const SizedBox(width: 12), Expanded(child: Text('$items', style: const TextStyle(color: Color(0xFF5E6673)), textAlign: TextAlign.end))]));
  }

  Widget _buildNearby(BuildContext context) {
    return GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, childAspectRatio: 2.2, crossAxisSpacing: 12, mainAxisSpacing: 12, children: List.generate(4, (i) => Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: Row(children: [Container(width: 40, height: 40, decoration: BoxDecoration(color: const Color(0xFFD4AF37).withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.store, color: Color(0xFFD4AF37))), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text(['متجر الذهبية', 'متجر الكس', 'متجر السيم', 'مطعم النور'][i], style: const TextStyle(color: Colors.white, fontSize: 12)), Row(children: [Text(['0.3', '0.8', '1.2', '0.5'][i] + ' كم', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10)), const SizedBox(width: 8), const Icon(Icons.star, size: 10, color: Colors.amber), Text('${[4.5,4.8,4.3,4.6][i]}', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10))])])])))));
  }
}
