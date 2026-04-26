import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../../widgets/stories_widget.dart';
import '../wallet/wallet_screen.dart';
import '../chat/chat_screen.dart';
import '../ai_assistant_screen.dart';
import '../notifications_screen.dart';
import '../profile/profile_screen.dart';
import '../categories/all_categories_screen.dart';
import '../stores/stores_screen.dart';
import '../auctions/auctions_screen.dart';
import '../offers_screen.dart';
import '../cart/cart_screen.dart';
import '../search_screen.dart';
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

  final List<Map<String, dynamic>> _stories = [
    {'id': 'user', 'name': 'إضافة حالة', 'imageUrl': '', 'time': '', 'isUser': true},
    {'id': '1', 'name': 'أحمد محمد', 'imageUrl': 'https://randomuser.me/api/portraits/men/1.jpg', 'time': 'منذ 5 دقائق', 'isViewed': false},
    {'id': '2', 'name': 'متجر التقنية', 'imageUrl': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200', 'time': 'منذ ساعة', 'isViewed': false},
  ];

  final List<Map<String, String>> _carouselItems = [
    {'title': 'عرض خاص', 'subtitle': 'خصم 50% على الإلكترونيات', 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=600'},
    {'title': 'عروض البرق', 'subtitle': 'لفترة محدودة', 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=600'},
    {'title': 'عرض VIP', 'subtitle': 'خصم 25% للأعضاء', 'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=600'},
  ];

  void _navigateTo(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
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
                const Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Text('الحالات', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500))),
                StoriesWidget(stories: _stories, onAddStory: () {}),
              ],
            ),
          ),
          SliverToBoxAdapter(child: _buildStatsCard()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildCarousel()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildQuickActions()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('📌 متابعاتك', 'عرض الكل', onTap: () => _navigateTo(const FollowingScreen()))),
          SliverToBoxAdapter(child: _buildFollowingsList()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('🔥 العروض الرائجة', 'عرض الكل', onTap: () => _navigateTo(const OffersScreen()))),
          SliverToBoxAdapter(child: _buildTrendingOffers()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('📊 الأسواق الرائجة', 'عرض الكل', onTap: () => _navigateTo(const MarketsScreen()))),
          SliverToBoxAdapter(child: _buildMarkets()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('📍 بالقرب منك', 'عرض الكل', onTap: () => _navigateTo(const NearbyScreen()))),
          SliverToBoxAdapter(child: _buildNearbyGrid()),
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
      title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('FLEX', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.binanceGold)),
        const SizedBox(width: 6),
        Text('YEMEN', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppTheme.binanceGold.withOpacity(0.8))),
      ]),
      centerTitle: true,
      actions: [
        IconButton(icon: const Icon(Icons.search, color: AppTheme.binanceGold), onPressed: () => _navigateTo(const SearchScreen())),
        IconButton(icon: const Icon(Icons.notifications_none, color: AppTheme.binanceGold), onPressed: () => _navigateTo(const NotificationsScreen())),
        PopupMenuButton<String>(
          icon: const Icon(Icons.menu, color: AppTheme.binanceGold),
          color: AppTheme.binanceCard,
          onSelected: (value) {
            if (value == 'wallet') _navigateTo(const WalletScreen());
            if (value == 'chat') _navigateTo(const ChatScreen());
            if (value == 'ai') _navigateTo(const AIAssistantScreen());
            if (value == 'profile') _navigateTo(const ProfileScreen());
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'wallet', child: Row(children: [Icon(Icons.account_balance_wallet_outlined, color: AppTheme.binanceGold), SizedBox(width: 8), Text('المحفظة', style: TextStyle(color: Colors.white))])),
            const PopupMenuItem(value: 'chat', child: Row(children: [Icon(Icons.chat_bubble_outline, color: AppTheme.binanceGold), SizedBox(width: 8), Text('الدردشة', style: TextStyle(color: Colors.white))])),
            const PopupMenuItem(value: 'ai', child: Row(children: [Icon(Icons.smart_toy_outlined, color: AppTheme.binanceGold), SizedBox(width: 8), Text('المساعد الذكي', style: TextStyle(color: Colors.white))])),
            const PopupMenuItem(value: 'profile', child: Row(children: [Icon(Icons.person_outline, color: AppTheme.binanceGold), SizedBox(width: 8), Text('الملف الشخصي', style: TextStyle(color: Colors.white))])),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF1E2329), Color(0xFF16213E)]), borderRadius: BorderRadius.circular(16)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        _buildStatItem('إجمالي المشتريات', '1,234,567', AppTheme.binanceGold),
        Container(width: 1, height: 30, color: AppTheme.binanceBorder),
        _buildStatItem('نقاط الولاء', '1,250', AppTheme.binanceGreen),
        Container(width: 1, height: 30, color: AppTheme.binanceBorder),
        _buildStatItem('الطلبات', '24', AppTheme.serviceBlue),
      ]),
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
    return Column(children: [
      CarouselSlider.builder(
        itemCount: _carouselItems.length,
        options: CarouselOptions(height: 160, autoPlay: true, viewportFraction: 0.9, onPageChanged: (i, _) => setState(() => _carouselIndex = i)),
        itemBuilder: (_, i, __) => GestureDetector(
          onTap: () => _navigateTo(const OffersScreen()),
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
      {'icon': Icons.category, 'label': 'فئات', 'screen': const AllCategoriesScreen()},
      {'icon': Icons.store, 'label': 'متاجر', 'screen': const StoresScreen()},
      {'icon': Icons.gavel, 'label': 'مزادات', 'screen': const AuctionsScreen()},
      {'icon': Icons.shopping_cart, 'label': 'السلة', 'screen': const CartScreen()},
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

  Widget _buildFollowingsList() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 3,
        itemBuilder: (_, i) => GestureDetector(
          onTap: () => _navigateTo(const FollowingScreen()),
          child: Container(
            width: 150,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              CircleAvatar(radius: 20, backgroundColor: AppTheme.binanceGold.withOpacity(0.2), child: Icon(Icons.store, color: AppTheme.binanceGold, size: 20)),
              const SizedBox(width: 8),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('متجر تقنية', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                Text(i == 0 ? 'منتج جديد' : 'عرض خاص', style: TextStyle(color: AppTheme.binanceGold, fontSize: 10)),
                Text(i == 0 ? 'قبل ساعة' : 'اليوم', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 9)),
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
        itemCount: 3,
        itemBuilder: (_, i) => GestureDetector(
          onTap: () => _navigateTo(const OffersScreen()),
          child: Container(
            width: 150,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.binanceBorder)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(12)), child: Image.network('https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400', height: 100, width: double.infinity, fit: BoxFit.cover)),
              Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('iPhone 15 Pro', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                Row(children: [
                  const Text('350,000', style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(width: 4),
                  const Text('450,000', style: TextStyle(color: Color(0xFF5E6673), decoration: TextDecoration.lineThrough, fontSize: 10)),
                ]),
              ])),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildMarkets() {
    final markets = [
      {'name': 'السوق اليمني', 'change': '+2.5%', 'isUp': true},
      {'name': 'المولات', 'change': '+1.8%', 'isUp': true},
      {'name': 'الفنادق', 'change': '-0.5%', 'isUp': false},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: markets.map((m) => GestureDetector(
          onTap: () => _navigateTo(const MarketsScreen()),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
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
              const Text('1.2M', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
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
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          GestureDetector(
            onTap: () => _navigateTo(const NearbyScreen()),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12)),
              child: Row(children: [
                Container(width: 40, height: 40, decoration: BoxDecoration(color: AppTheme.binanceGold.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.store, color: AppTheme.binanceGold)),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('سوبر ماركت', style: TextStyle(color: Colors.white, fontSize: 12)),
                  const Text('0.3 كم', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 10)),
                ])),
              ]),
            ),
          ),
          GestureDetector(
            onTap: () => _navigateTo(const NearbyScreen()),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12)),
              child: Row(children: [
                Container(width: 40, height: 40, decoration: BoxDecoration(color: AppTheme.binanceGold.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.restaurant, color: AppTheme.binanceGold)),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('مطعم', style: TextStyle(color: Colors.white, fontSize: 12)),
                  const Text('0.8 كم', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 10)),
                ])),
              ]),
            ),
          ),
        ],
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
        children: [
          GestureDetector(onTap: () => _navigateTo(const AllCategoriesScreen()), child: Column(children: [ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network('https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200', height: 55, width: 55, fit: BoxFit.cover)), const SizedBox(height: 4), const Text('إلكترونيات', style: TextStyle(color: Colors.white, fontSize: 10))])),
          GestureDetector(onTap: () => _navigateTo(const AllCategoriesScreen()), child: Column(children: [ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network('https://images.unsplash.com/photo-1445205170230-053b83016050?w=200', height: 55, width: 55, fit: BoxFit.cover)), const SizedBox(height: 4), const Text('أزياء', style: TextStyle(color: Colors.white, fontSize: 10))])),
          GestureDetector(onTap: () => _navigateTo(const AllCategoriesScreen()), child: Column(children: [ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network('https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=200', height: 55, width: 55, fit: BoxFit.cover)), const SizedBox(height: 4), const Text('سيارات', style: TextStyle(color: Colors.white, fontSize: 10))])),
          GestureDetector(onTap: () => _navigateTo(const AllCategoriesScreen()), child: Column(children: [ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network('https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200', height: 55, width: 55, fit: BoxFit.cover)), const SizedBox(height: 4), const Text('أثاث', style: TextStyle(color: Colors.white, fontSize: 10))])),
        ],
      ),
    );
  }
}
