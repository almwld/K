import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../../widgets/product_card.dart';
import '../../widgets/store_card.dart';
import '../../widgets/category_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _carouselIndex = 0;

  final List<Map<String, String>> _carouselItems = [
    {'title': 'عرض خاص', 'subtitle': 'خصم 50% على الإلكترونيات', 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=600'},
    {'title': 'عروض البرق', 'subtitle': 'لفترة محدودة', 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=600'},
    {'title': 'عرض VIP', 'subtitle': 'خصم 25% للأعضاء', 'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=600'},
    {'title': 'توصيل مجاني', 'subtitle': 'للطلبات فوق 200,000 ريال', 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=600'},
    {'title': 'عروض رمضان', 'subtitle': 'خصومات تصل إلى 70%', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600'},
  ];

  final List<Map<String, dynamic>> _categories = [
    {'name': 'إلكترونيات', 'icon': Icons.devices, 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200', 'color': const Color(0xFF2196F3)},
    {'name': 'أزياء', 'icon': Icons.checkroom, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200', 'color': const Color(0xFFE91E63)},
    {'name': 'سيارات', 'icon': Icons.directions_car, 'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=200', 'color': const Color(0xFFF6465D)},
    {'name': 'عقارات', 'icon': Icons.home, 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=200', 'color': const Color(0xFF4CAF50)},
    {'name': 'أثاث', 'icon': Icons.chair, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200', 'color': const Color(0xFFFF9800)},
    {'name': 'مطاعم', 'icon': Icons.restaurant, 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200', 'color': const Color(0xFF9C27B0)},
    {'name': 'رياضة', 'icon': Icons.sports_soccer, 'image': 'https://images.unsplash.com/photo-1461896836934-ffe807baa261?w=200', 'color': const Color(0xFF00BCD4)},
    {'name': 'صحة وجمال', 'icon': Icons.favorite, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=200', 'color': const Color(0xFFE91E63)},
  ];

  final List<Map<String, dynamic>> _followings = [
    {'name': 'متجر التقنية', 'update': 'منتج جديد', 'time': 'قبل ساعة', 'avatar': 'https://randomuser.me/api/portraits/men/1.jpg'},
    {'name': 'مطعم مندي الملكي', 'update': 'عرض خاص', 'time': 'اليوم', 'avatar': 'https://randomuser.me/api/portraits/men/2.jpg'},
    {'name': 'الأزياء العصرية', 'update': 'تخفيضات', 'time': 'أمس', 'avatar': 'https://randomuser.me/api/portraits/women/1.jpg'},
    {'name': 'عطور الشرق', 'update': 'وصل حديثاً', 'time': 'منذ ساعتين', 'avatar': 'https://randomuser.me/api/portraits/men/3.jpg'},
  ];

  final List<Map<String, dynamic>> _trendingOffers = [
    {'name': 'iPhone 15 Pro', 'price': '350,000', 'old': '450,000', 'discount': 22, 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400', 'sold': '1.2K'},
    {'name': 'ساعة أبل الترا', 'price': '45,000', 'old': '60,000', 'discount': 25, 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400', 'sold': '890'},
    {'name': 'سماعات ايربودز', 'price': '35,000', 'old': '50,000', 'discount': 30, 'image': 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=400', 'sold': '2.3K'},
    {'name': 'ماك بوك برو', 'price': '1,800,000', 'old': '2,100,000', 'discount': 14, 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400', 'sold': '567'},
  ];

  final List<Map<String, dynamic>> _markets = [
    {'name': 'السوق اليمني', 'change': '+2.5%', 'volume': '1.2M', 'items': 1250, 'isUp': true},
    {'name': 'المولات', 'change': '+1.8%', 'volume': '890K', 'items': 450, 'isUp': true},
    {'name': 'المقاهي', 'change': '+3.2%', 'volume': '567K', 'items': 320, 'isUp': true},
    {'name': 'الفنادق', 'change': '-0.5%', 'volume': '456K', 'items': 95, 'isUp': false},
  ];

  final List<Map<String, dynamic>> _recommendedForYou = [
    {'name': 'سامسونج S24 Ultra', 'price': '380,000', 'rating': 4.9, 'image': 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=400', 'reason': 'بناءً على مشترياتك'},
    {'name': 'ساعة رولكس', 'price': '850,000', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400', 'reason': 'قد يعجبك'},
    {'name': 'عطر فاخر', 'price': '45,000', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=400', 'reason': 'الأشترى معاً'},
  ];

  final List<Map<String, dynamic>> _newArrivals = [
    {'name': 'آيفون 15', 'price': '320,000', 'date': 'اليوم', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400', 'isNew': true},
    {'name': 'سماعات سوني', 'price': '45,000', 'date': 'أمس', 'image': 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=400', 'isNew': true},
    {'name': 'لابتوب ديل', 'price': '350,000', 'date': 'الأسبوع', 'image': 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=400', 'isNew': false},
  ];

  final List<Map<String, dynamic>> _vipOffers = [
    {'name': 'عرض VIP حصري', 'discount': 25, 'code': 'VIP25', 'expiry': '24 ساعة', 'color': AppTheme.binanceGold},
    {'name': 'عرض Pro', 'discount': 15, 'code': 'PRO15', 'expiry': '48 ساعة', 'color': AppTheme.serviceBlue},
  ];

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
          SliverToBoxAdapter(child: _buildSectionHeader('📌 متابعاتك', 'عرض الكل', onTap: () {})),
          SliverToBoxAdapter(child: _buildFollowingsList()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('🔥 العروض الرائجة', 'عرض الكل', onTap: () {})),
          SliverToBoxAdapter(child: _buildTrendingOffers()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildVipSection()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('💰 اقتراحات لك', 'عرض الكل', onTap: () {})),
          SliverToBoxAdapter(child: _buildRecommendations()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('🆕 وصل حديثاً', 'عرض الكل', onTap: () {})),
          SliverToBoxAdapter(child: _buildNewArrivals()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('📊 الأسواق الرائجة', 'عرض الكل', onTap: () {})),
          SliverToBoxAdapter(child: _buildMarkets()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('⭐ الفئات', 'عرض الكل', onTap: () {})),
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
        IconButton(icon: const Icon(Icons.search, color: AppTheme.binanceGold), onPressed: () {}),
        IconButton(icon: const Icon(Icons.notifications_none, color: AppTheme.binanceGold), onPressed: () {}),
      ],
    );
  }

  Widget _buildStatsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF1E2329), Color(0xFF16213E)]),
        borderRadius: BorderRadius.circular(16),
      ),
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
    return Column(
      children: [
        Text(value, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10)),
      ],
    );
  }

  Widget _buildCarousel() {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _carouselItems.length,
          options: CarouselOptions(
            height: 160,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            viewportFraction: 0.9,
            onPageChanged: (i, _) => setState(() => _carouselIndex = i),
          ),
          itemBuilder: (_, i, __) {
            final item = _carouselItems[i];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(item['image']!, height: 160, width: double.infinity, fit: BoxFit.cover),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(colors: [Colors.black.withOpacity(0.6), Colors.transparent], begin: Alignment.centerRight, end: Alignment.centerLeft),
                    ),
                  ),
                  Positioned(right: 20, top: 30, child: Text(item['title']!, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
                  Positioned(right: 20, top: 65, child: Text(item['subtitle']!, style: const TextStyle(color: Colors.white70, fontSize: 14))),
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(color: AppTheme.binanceGold, borderRadius: BorderRadius.circular(20)),
                      child: const Text('تسوق الآن', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        AnimatedSmoothIndicator(
          activeIndex: _carouselIndex,
          count: _carouselItems.length,
          effect: ExpandingDotsEffect(activeDotColor: AppTheme.binanceGold, dotColor: AppTheme.binanceBorder),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {'icon': Icons.category, 'label': 'فئات', 'color': AppTheme.serviceBlue},
      {'icon': Icons.store, 'label': 'متاجر', 'color': AppTheme.binanceGreen},
      {'icon': Icons.gavel, 'label': 'مزادات', 'color': AppTheme.serviceOrange},
      {'icon': Icons.local_offer, 'label': 'عروض', 'color': AppTheme.binanceRed},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: actions.map((a) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: (a['color'] as Color).withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(a['icon'] as IconData, color: a['color'] as Color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(a['label'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
          ],
        )).toList(),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String action, {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Text(action, style: TextStyle(color: AppTheme.binanceGold, fontSize: 12)),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios, color: AppTheme.binanceGold, size: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFollowingsList() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _followings.length,
        itemBuilder: (_, i) => Container(
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
    );
  }

  Widget _buildTrendingOffers() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _trendingOffers.length,
        itemBuilder: (_, i) {
          final product = _trendingOffers[i];
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.binanceBorder)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(product['image'] as String, height: 100, width: double.infinity, fit: BoxFit.cover),
                    ),
                    Positioned(
                      top: 8, left: 8,
                      child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppTheme.binanceRed, borderRadius: BorderRadius.circular(4)), child: Text('-${product['discount']}%', style: const TextStyle(color: Colors.white, fontSize: 10))),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), maxLines: 1),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(product['price'] as String, style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold, fontSize: 12)),
                          const SizedBox(width: 4),
                          Text(product['old'] as String, style: const TextStyle(color: Color(0xFF5E6673), decoration: TextDecoration.lineThrough, fontSize: 10)),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text('${product['sold']} بيعت', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 9)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildVipSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFB8962E)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), shape: BoxShape.circle),
                  child: const Icon(Icons.workspace_premium, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('انضم إلى برنامج VIP', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
                      const Text('احصل على خصم 25% وشحن مجاني', style: TextStyle(color: Colors.black87, fontSize: 11)),
                      Row(
                        children: [
                          Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: const Text('VIP25', style: TextStyle(color: Colors.black, fontSize: 9))),
                          const SizedBox(width: 8),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: const Text('شحن مجاني', style: TextStyle(color: Colors.black, fontSize: 9))),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: const Text('اشترك', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendations() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _recommendedForYou.length,
        itemBuilder: (_, i) {
          final item = _recommendedForYou[i];
          return Container(
            width: 200,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.binanceBorder)),
            child: Row(
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(item['image'] as String, width: 50, height: 50, fit: BoxFit.cover)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(item['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), maxLines: 1),
                      Text(item['reason'] as String, style: TextStyle(color: AppTheme.binanceGold, fontSize: 9)),
                      Text('${item['price']} ريال', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
                    ],
                  ),
                ),
                Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: AppTheme.binanceGold.withOpacity(0.1), borderRadius: BorderRadius.circular(20)), child: const Icon(Icons.add_shopping_cart, color: AppTheme.binanceGold, size: 16)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewArrivals() {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _newArrivals.length,
        itemBuilder: (_, i) {
          final item = _newArrivals[i];
          return Container(
            width: 130,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.binanceBorder)),
            child: Stack(
              children: [
                Column(
                  children: [
                    ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(12)), child: Image.network(item['image'] as String, height: 80, width: double.infinity, fit: BoxFit.cover)),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(item['name'] as String, style: const TextStyle(color: Colors.white, fontSize: 11), maxLines: 1),
                        Text('${item['price']} ريال', style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold, fontSize: 11)),
                        Text(item['date'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 9)),
                      ]),
                    ),
                  ],
                ),
                if (item['isNew'] as bool)
                  Positioned(
                    top: 8, right: 8,
                    child: Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), decoration: BoxDecoration(color: AppTheme.binanceRed, borderRadius: BorderRadius.circular(4)), child: const Text('جديد', style: TextStyle(color: Colors.white, fontSize: 8))),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMarkets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: _markets.map((m) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Expanded(flex: 3, child: Text(m['name'] as String, style: const TextStyle(color: Colors.white))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: (m['isUp'] as bool) ? AppTheme.binanceGreen.withOpacity(0.1) : AppTheme.binanceRed.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                child: Row(children: [
                  Icon((m['isUp'] as bool) ? Icons.trending_up : Icons.trending_down, color: (m['isUp'] as bool) ? AppTheme.binanceGreen : AppTheme.binanceRed, size: 10),
                  const SizedBox(width: 2),
                  Text(m['change'] as String, style: TextStyle(color: (m['isUp'] as bool) ? AppTheme.binanceGreen : AppTheme.binanceRed, fontSize: 10)),
                ]),
              ),
              const SizedBox(width: 12),
              Text(m['volume'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
              const SizedBox(width: 8),
              Text('${m['items']}', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 11)),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        childAspectRatio: 0.85,
        children: _categories.map((cat) => Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(cat['image'] as String, height: 55, width: 55, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(height: 55, width: 55, color: (cat['color'] as Color).withOpacity(0.2), child: Icon(cat['icon'] as IconData, color: cat['color'] as Color, size: 24))),
            ),
            const SizedBox(height: 4),
            Text(cat['name'] as String, style: const TextStyle(color: Colors.white, fontSize: 10), textAlign: TextAlign.center),
          ],
        )).toList(),
      ),
    );
  }
}
