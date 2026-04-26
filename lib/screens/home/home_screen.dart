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
import '../following_screen.dart';
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
    {'title': 'مزادات حية', 'subtitle': 'شارك في المزادات', 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=600', 'buttonText': 'اشترك الآن', 'badge': 'مزاد حي', 'discount': '75%'},
    {'title': 'عروض الإلكترونيات', 'subtitle': 'خصم يصل إلى 50%', 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=600', 'buttonText': 'تسوق الآن', 'badge': 'عرض محدود', 'discount': '50%'},
    {'title': 'عروض VIP', 'subtitle': 'خصم 25% للأعضاء', 'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=600', 'buttonText': 'انضم الآن', 'badge': 'VIP فقط', 'discount': '25%'},
    {'title': 'توصيل مجاني', 'subtitle': 'لطلبات +200,000', 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=600', 'buttonText': 'اطلب الآن', 'badge': 'شحن مجاني', 'discount': '100%'},
    {'title': 'عروض العيد', 'subtitle': 'خصومات تصل إلى 60%', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600', 'buttonText': 'استفد الآن', 'badge': 'عرض خاص', 'discount': '60%'},
  ];

  // بيانات الحالات (Stories)
  final List<StoryModel> _stories = [
    StoryModel(id: 'user', name: 'إضافة حالة', imageUrl: '', time: '', isUser: true),
    StoryModel(id: '1', name: 'أحمد محمد', imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg', time: 'منذ 5 دقائق', isViewed: false),
    StoryModel(id: '2', name: 'متجر التقنية', imageUrl: 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200', time: 'منذ ساعة', isViewed: false),
    StoryModel(id: '3', name: 'سارة علي', imageUrl: 'https://randomuser.me/api/portraits/women/1.jpg', time: 'منذ 3 ساعات', isViewed: true),
  ];

  // المتابعات (التجار)
  final List<Map<String, dynamic>> _followings = [
    {'name': 'متجر التقنية', 'update': 'منتج جديد', 'time': 'قبل ساعة', 'storeId': '1'},
    {'name': 'مطعم مندي الملكي', 'update': 'عرض خاص', 'time': 'اليوم', 'storeId': '2'},
    {'name': 'الأزياء العصرية', 'update': 'تخفيضات', 'time': 'أمس', 'storeId': '3'},
    {'name': 'عطور الشرق', 'update': 'وصل حديثاً', 'time': 'منذ ساعتين', 'storeId': '4'},
  ];

  // الأسواق اليمنية
  final List<Map<String, dynamic>> _markets = [
    {'name': 'السوق اليمني', 'change': '+2.5%', 'volume': '1.2M', 'items': 1250, 'isUp': true, 'description': 'أكبر سوق في اليمن'},
    {'name': 'المولات', 'change': '+1.8%', 'volume': '890K', 'items': 450, 'isUp': true, 'description': 'أحدث المولات'},
    {'name': 'المقاهي', 'change': '+3.2%', 'volume': '567K', 'items': 320, 'isUp': true, 'description': 'أشهر المقاهي'},
    {'name': 'الفنادق', 'change': '-0.5%', 'volume': '456K', 'items': 95, 'isUp': false, 'description': 'فنادق فاخرة'},
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

  void _addStory() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('إضافة حالة - قريباً'), backgroundColor: AppTheme.binanceGold));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      body: CustomScrollView(
        slivers: [
          // الحالات
          SliverToBoxAdapter(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Text('الحالات', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500))),
            StoriesWidget(stories: _stories, onAddStory: _addStory),
          ])),
          SliverToBoxAdapter(child: const SizedBox(height: 8)),
          // بطاقة الإحصائيات
          SliverToBoxAdapter(child: _buildStatsCard()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          // السلايدر
          SliverToBoxAdapter(child: _buildCarousel()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          // متابعاتك
          SliverToBoxAdapter(child: _buildSectionHeader('متابعاتك', 'مشاهدة الكل', onTap: () => _navigateTo(const FollowingScreen()))),
          SliverToBoxAdapter(child: _buildFollowingsList()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          // الأسواق الرائجة
          SliverToBoxAdapter(child: _buildSectionHeader('الأسواق الرائجة', 'استكشف الان', onTap: () => _navigateTo(const MarketsScreen()))),
          SliverToBoxAdapter(child: _buildMarkets()),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
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
          GestureDetector(onTap: () => _navigateToStats('purchases'), child: _buildStatItem('إجمالي المشتريات', '1,234,567', AppTheme.binanceGold)),
          Container(width: 1, height: 30, color: AppTheme.binanceBorder),
          GestureDetector(onTap: () => _navigateToStats('points'), child: _buildStatItem('نقاط الولاء', '1,250', AppTheme.binanceGreen)),
          Container(width: 1, height: 30, color: AppTheme.binanceBorder),
          GestureDetector(onTap: () => _navigateToStats('orders'), child: _buildStatItem('الطلبات', '24', AppTheme.serviceBlue)),
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
        options: CarouselOptions(height: 180, autoPlay: true, viewportFraction: 0.9, enlargeCenterPage: true, onPageChanged: (i, _) => setState(() => _carouselIndex = i)),
        itemBuilder: (context, index, realIndex) {
          final item = _carouselItems[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppTheme.binanceGold, AppTheme.binanceGold.withOpacity(0.7)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(20),
              ),
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
          onTap: () => _navigateTo(const FollowingScreen()),
          child: Container(
            width: 150,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                CircleAvatar(radius: 20, backgroundColor: AppTheme.binanceGold.withOpacity(0.2), child: Icon(Icons.store, color: AppTheme.binanceGold, size: 20)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_followings[i]['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), maxLines: 1),
                      Text(_followings[i]['update'] as String, style: TextStyle(color: AppTheme.binanceGold, fontSize: 10)),
                      Text(_followings[i]['time'] as String, style: const TextStyle(color: Color(0xFF5E6673), fontSize: 9)),
                    ],
                  ),
                ),
              ],
            ),
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
          onTap: () => _navigateTo(const MarketsScreen()),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(m['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)), Text(m['description'] as String, style: const TextStyle(color: Color(0xFF5E6673), fontSize: 10))])),
                Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: (m['isUp'] as bool) ? AppTheme.binanceGreen.withOpacity(0.1) : AppTheme.binanceRed.withOpacity(0.1), borderRadius: BorderRadius.circular(4)), child: Row(children: [
                  Icon((m['isUp'] as bool) ? Icons.trending_up : Icons.trending_down, color: (m['isUp'] as bool) ? AppTheme.binanceGreen : AppTheme.binanceRed, size: 10),
                  const SizedBox(width: 2), Text(m['change'] as String, style: TextStyle(color: (m['isUp'] as bool) ? AppTheme.binanceGreen : AppTheme.binanceRed, fontSize: 10)),
                ])),
                const SizedBox(width: 12), Text(m['volume'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
                const SizedBox(width: 8), Text('${m['items']}', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 11)),
                const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 14),
              ],
            ),
          ),
        )).toList(),
      ),
    );
  }
}

class StoryModel {
  final String id, name, imageUrl, time;
  final bool isViewed;
  final bool isUser;

  StoryModel({required this.id, required this.name, required this.imageUrl, required this.time, this.isViewed = false, this.isUser = false});
}
