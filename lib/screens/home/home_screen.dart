import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../../widgets/stories_widget.dart';
import '../../widgets/product_card.dart';
import '../categories/all_categories_screen.dart';
import '../stores/stores_screen.dart';
import '../auctions/auctions_screen.dart';
import '../offers_screen.dart';
import '../cart/cart_screen.dart';
import '../wallet/wallet_screen.dart';
import '../stats/sales_stats_screen.dart';
import '../stats/loyalty_points_screen.dart';
import '../stats/orders_stats_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _carouselIndex = 0;

  // قائمة السلايدرات (5 سلايدرات)
  final List<Map<String, dynamic>> _carouselItems = [
    {
      'title': 'عروض الإلكترونيات',
      'subtitle': 'خصم يصل إلى 50% على الأجهزة الحديثة',
      'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=600',
      'gradient': [AppTheme.serviceBlue, AppTheme.serviceBlue.withOpacity(0.7)],
      'buttonText': 'تسوق الآن',
      'buttonRoute': '/categories/electronics',
      'badge': 'عرض محدود',
      'discount': '50%',
    },
    {
      'title': 'مزادات حية',
      'subtitle': 'شارك في المزادات واحصل على أفضل الأسعار',
      'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=600',
      'gradient': [AppTheme.binanceGreen, AppTheme.binanceGreen.withOpacity(0.7)],
      'buttonText': 'اشترك الآن',
      'buttonRoute': '/auctions',
      'badge': 'مزاد حي',
      'discount': '75%',
    },
    {
      'title': 'عروض VIP',
      'subtitle': 'خصم 25% إضافي للأعضاء الجدد',
      'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=600',
      'gradient': [AppTheme.binanceGold, AppTheme.binanceGold.withOpacity(0.7)],
      'buttonText': 'انضم الآن',
      'buttonRoute': '/vip',
      'badge': 'VIP فقط',
      'discount': '25%',
    },
    {
      'title': 'توصيل مجاني',
      'subtitle': 'للطلبات التي تزيد عن 200,000 ريال',
      'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=600',
      'gradient': [AppTheme.serviceOrange, AppTheme.serviceOrange.withOpacity(0.7)],
      'buttonText': 'اطلب الآن',
      'buttonRoute': '/cart',
      'badge': 'شحن مجاني',
      'discount': '100%',
    },
    {
      'title': 'عروح رمضان',
      'subtitle': 'خصومات تصل إلى 70% على جميع المنتجات',
      'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600',
      'gradient': [AppTheme.binanceRed, AppTheme.binanceRed.withOpacity(0.7)],
      'buttonText': 'استفد الآن',
      'buttonRoute': '/offers',
      'badge': 'عرض خاص',
      'discount': '70%',
    },
  ];

  // بيانات الحالات (Stories)
  final List<StoryModel> _stories = [
    StoryModel(id: 'user', name: 'إضافة حالة', imageUrl: '', time: '', isUser: true),
    StoryModel(id: '1', name: 'أحمد محمد', imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg', time: 'منذ 5 دقائق', isViewed: false),
    StoryModel(id: '2', name: 'متجر التقنية', imageUrl: 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200', time: 'منذ ساعة', isViewed: false),
    StoryModel(id: '3', name: 'سارة علي', imageUrl: 'https://randomuser.me/api/portraits/women/1.jpg', time: 'منذ 3 ساعات', isViewed: true),
  ];

  final List<Map<String, dynamic>> _categories = [
    {'name': 'إلكترونيات', 'icon': Icons.devices, 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200', 'color': const Color(0xFF2196F3)},
    {'name': 'أزياء', 'icon': Icons.checkroom, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200', 'color': const Color(0xFFE91E63)},
    {'name': 'سيارات', 'icon': Icons.directions_car, 'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=200', 'color': const Color(0xFFF6465D)},
    {'name': 'عقارات', 'icon': Icons.home, 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=200', 'color': const Color(0xFF4CAF50)},
    {'name': 'أثاث', 'icon': Icons.chair, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200', 'color': const Color(0xFFFF9800)},
    {'name': 'مطاعم', 'icon': Icons.restaurant, 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200', 'color': const Color(0xFF9C27B0)},
  ];

  final List<Map<String, dynamic>> _trendingOffers = [
    {'name': 'iPhone 15 Pro', 'price': '350,000', 'old': '450,000', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400'},
    {'name': 'ساعة أبل الترا', 'price': '45,000', 'old': '60,000', 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400'},
    {'name': 'ماك بوك برو', 'price': '1,800,000', 'old': '2,100,000', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400'},
  ];

  final List<Map<String, dynamic>> _markets = [
    {'name': 'السوق اليمني', 'change': '+2.5%', 'volume': '1.2M', 'items': 1250, 'isUp': true},
    {'name': 'المولات', 'change': '+1.8%', 'volume': '890K', 'items': 450, 'isUp': true},
    {'name': 'المقاهي', 'change': '+3.2%', 'volume': '567K', 'items': 320, 'isUp': true},
    {'name': 'الفنادق', 'change': '-0.5%', 'volume': '456K', 'items': 95, 'isUp': false},
  ];

  final List<Map<String, dynamic>> _products = [
    {'name': 'ساعة أبل الترا', 'price': '45,000', 'oldPrice': '60,000', 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400', 'discount': 25, 'rating': 4.8},
    {'name': 'سماعات ايربودز', 'price': '35,000', 'oldPrice': '50,000', 'image': 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=400', 'discount': 30, 'rating': 4.7},
    {'name': 'آيباد برو', 'price': '280,000', 'oldPrice': null, 'image': 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400', 'discount': 0, 'rating': 4.9},
  ];

  void _navigateTo(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  void _navigateToStats(String type) {
    switch (type) {
      case 'purchases':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SalesStatsScreen(
              title: 'إجمالي المشتريات',
              totalValue: '1,234,567 ريال',
              details: const [
                {'label': 'إلكترونيات', 'value': '450,000', 'date': 'آخر 30 يوم', 'icon': Icons.devices, 'color': Color(0xFF2196F3)},
                {'label': 'أزياء', 'value': '234,000', 'date': 'آخر 30 يوم', 'icon': Icons.checkroom, 'color': Color(0xFFE91E63)},
                {'label': 'أثاث', 'value': '150,000', 'date': 'آخر 30 يوم', 'icon': Icons.chair, 'color': Color(0xFFFF9800)},
                {'label': 'مطاعم', 'value': '89,000', 'date': 'آخر 30 يوم', 'icon': Icons.restaurant, 'color': Color(0xFF9C27B0)},
              ],
            ),
          ),
        );
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
    // Navigator.push(context, MaterialPageRoute(builder: (_) => const AddStoryScreen()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('إضافة حالة - قريباً'), backgroundColor: AppTheme.binanceGold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: _buildAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text('الحالات', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                ),
                StoriesWidget(stories: _stories, onAddStory: _addStory),
              ],
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 8)),
          SliverToBoxAdapter(child: _buildStatsCard()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildCarousel()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildQuickActions()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('🔥 العروض الرائجة', 'عرض الكل', onTap: () {})),
          SliverToBoxAdapter(child: _buildTrendingOffers()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('📊 الأسواق الرائجة', 'عرض الكل', onTap: () {})),
          SliverToBoxAdapter(child: _buildMarkets()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('⭐ الفئات', 'عرض الكل', onTap: () => _navigateTo(const AllCategoriesScreen()))),
          SliverToBoxAdapter(child: _buildCategoriesGrid()),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => _navigateToStats('purchases'),
            child: _buildStatItem('إجمالي المشتريات', '1,234,567', AppTheme.binanceGold),
          ),
          Container(width: 1, height: 30, color: AppTheme.binanceBorder),
          GestureDetector(
            onTap: () => _navigateToStats('points'),
            child: _buildStatItem('نقاط الولاء', '1,250', AppTheme.binanceGreen),
          ),
          Container(width: 1, height: 30, color: AppTheme.binanceBorder),
          GestureDetector(
            onTap: () => _navigateToStats('orders'),
            child: _buildStatItem('الطلبات', '24', AppTheme.serviceBlue),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(children: [
      Text(value, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10)),
    ]);
  }

  Widget _buildCarousel() {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _carouselItems.length,
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            onPageChanged: (i, _) => setState(() => _carouselIndex = i),
          ),
          itemBuilder: (context, index, realIndex) {
            final item = _carouselItems[index];
            return GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: item['gradient'] as List<Color>,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    // الخلفية (صورة مع تعتيم)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        item['image'],
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(color: Colors.grey[800]),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                      ),
                    ),
                    // شارة الخصم/العرض
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.binanceRed,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.local_offer, color: Colors.white, size: 12),
                            const SizedBox(width: 4),
                            Text(item['badge'], style: const TextStyle(color: Colors.white, fontSize: 10)),
                          ],
                        ),
                      ),
                    ),
                    // نسبة الخصم
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'خصم ${item['discount']}',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ),
                    // النص الرئيسي
                    Positioned(
                      right: 20,
                      top: 50,
                      child: Text(
                        item['title'],
                        style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 85,
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          item['subtitle'],
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ),
                    ),
                    // زر الإجراء
                    Positioned(
                      right: 20,
                      bottom: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          item['buttonText'],
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        AnimatedSmoothIndicator(
          activeIndex: _carouselIndex,
          count: _carouselItems.length,
          effect: ExpandingDotsEffect(
            activeDotColor: AppTheme.binanceGold,
            dotColor: AppTheme.binanceBorder,
            dotHeight: 8,
            dotWidth: 8,
          ),
        ),
      ],
    );
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: actions.map((a) => GestureDetector(
          onTap: () => _navigateTo(a['screen'] as Widget),
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

  Widget _buildTrendingOffers() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _trendingOffers.length,
        itemBuilder: (_, i) => Container(
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
    );
  }

  Widget _buildMarkets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: _markets.map((m) => Container(
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
          onTap: () => _navigateTo(const AllCategoriesScreen()),
          child: Column(children: [
            ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(cat['image'] as String, height: 55, width: 55, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(height: 55, width: 55, color: (cat['color'] as Color).withOpacity(0.2), child: Icon(cat['icon'] as IconData, color: cat['color'] as Color, size: 24)))),
            const SizedBox(height: 4), Text(cat['name'] as String, style: const TextStyle(color: Colors.white, fontSize: 10), textAlign: TextAlign.center),
          ]),
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
