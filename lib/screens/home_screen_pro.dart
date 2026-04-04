import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/view_mode_provider.dart';
import 'sanaa_services_screen.dart';
import 'map/interactive_map_screen.dart';
import 'wallet/wallet_screen.dart';
import 'profile_screen.dart';
import 'chat_screen.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';
import 'notifications_screen.dart';

class HomeScreenPro extends StatefulWidget {
  const HomeScreenPro({super.key});

  @override
  State<HomeScreenPro> createState() => _HomeScreenProState();
}

class _HomeScreenProState extends State<HomeScreenPro> with SingleTickerProviderStateMixin {
  int _currentTab = 0;
  int _currentCarouselIndex = 0;
  String _selectedMarket = 'اليمنية';
  late TabController _tabController;
  
  // الأسواق
  final List<Map<String, dynamic>> _markets = [
    {'name': 'اليمنية', 'change': '+2.5%', 'color': 0xFF4CAF50, 'volume': '1.2M', 'items': 1250, 'trend': 'up'},
    {'name': 'المولات', 'change': '+1.8%', 'color': 0xFF2196F3, 'volume': '890K', 'items': 450, 'trend': 'up'},
    {'name': 'المقاهي', 'change': '+3.2%', 'color': 0xFFFF9800, 'volume': '567K', 'items': 320, 'trend': 'up'},
    {'name': 'الاستراحات', 'change': '+0.5%', 'color': 0xFF9C27B0, 'volume': '234K', 'items': 180, 'trend': 'up'},
    {'name': 'الفنادق', 'change': '+4.1%', 'color': 0xFFF44336, 'volume': '456K', 'items': 95, 'trend': 'up'},
  ];
  
  // الأقسام الرئيسية
  final List<Map<String, dynamic>> _sections = [
    {'name': 'المفضلات', 'icon': Icons.favorite, 'color': 0xFFF44336, 'route': FavoritesScreen},
    {'name': 'الأسواق', 'icon': Icons.store, 'color': 0xFF2196F3, 'route': SanaaServicesScreen},
    {'name': 'المنتجات', 'icon': Icons.shopping_bag, 'color': 0xFFD4AF37, 'route': null},
    {'name': 'بالجملة', 'icon': Icons.inventory, 'color': 0xFF4CAF50, 'route': null},
    {'name': 'بالتجزئة', 'icon': Icons.storefront, 'color': 0xFFFF9800, 'route': null},
    {'name': 'رائج', 'icon': Icons.trending_up, 'color': 0xFFF44336, 'route': null},
    {'name': 'VIP', 'icon': Icons.star, 'color': 0xFFD4AF37, 'route': null},
    {'name': 'جديده', 'icon': Icons.fiber_new, 'color': 0xFF9C27B0, 'route': null},
    {'name': 'الأعلى مبيعا', 'icon': Icons.emoji_events, 'color': 0xFFFF9800, 'route': null},
    {'name': 'عروض', 'icon': Icons.local_offer, 'color': 0xFFF44336, 'route': null},
  ];
  
  // المنتجات الرائجة
  final List<Map<String, dynamic>> _trendingProducts = [
    {'name': 'تويوتا كامري 2025', 'price': '9,500,000', 'change': '+12%', 'volume': '234', 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=300', 'tag': 'سيارة'},
    {'name': 'فيلا فاخرة صنعاء', 'price': '45,000,000', 'change': '+8%', 'volume': '89', 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=300', 'tag': 'عقار'},
    {'name': 'iPhone 15 Pro', 'price': '350,000', 'change': '+25%', 'volume': '1.2K', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=300', 'tag': 'إلكتروني'},
    {'name': 'مندي يمني', 'price': '3,500', 'change': '+5%', 'volume': '892', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=300', 'tag': 'مطعم'},
    {'name': 'ثوب يمني', 'price': '25,000', 'change': '+15%', 'volume': '456', 'image': 'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=300', 'tag': 'أزياء'},
  ];
  
  // الإعلانات
  final List<Map<String, dynamic>> _ads = [
    {'title': 'عروض السيارات', 'subtitle': 'خصم يصل إلى 30%', 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400'},
    {'title': 'عقارات فاخرة', 'subtitle': 'تملك الآن', 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400'},
    {'title': 'عروض المطاعم', 'subtitle': 'خصم 20%', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400'},
  ];
  
  // الأخبار
  final List<Map<String, dynamic>> _news = [
    {'title': 'إطلاق منصة فلكس يمن الجديدة', 'date': 'منذ ساعة', 'views': '1.2K', 'image': 'https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=200'},
    {'title': 'عروض حصرية في المولات', 'date': 'منذ 3 ساعات', 'views': '856', 'image': 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=200'},
    {'title': 'انطلاق مزاد الجنابي', 'date': 'منذ يوم', 'views': '2.3K', 'image': 'https://images.unsplash.com/photo-1606760227091-3dd870d97f1d?w=200'},
    {'title': 'افتتاح فروع جديدة', 'date': 'منذ يومين', 'views': '567', 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200'},
  ];
  
  // الأكاديمية
  final List<Map<String, dynamic>> _academy = [
    {'title': 'كيف تبدأ في عالم التجارة', 'duration': '15 دقيقة', 'level': 'مبتدئ', 'students': '1.2K', 'image': 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=200'},
    {'title': 'استراتيجيات التسويق الناجح', 'duration': '25 دقيقة', 'level': 'متقدم', 'students': '856', 'image': 'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=200'},
    {'title': 'إدارة المتاجر الإلكترونية', 'duration': '30 دقيقة', 'level': 'متوسط', 'students': '2.1K', 'image': 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=200'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final viewMode = Provider.of<ViewModeProvider>(context);
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0E17) : const Color(0xFFF5F5F5),
      appBar: _buildAppBar(viewMode),
      body: Column(
        children: [
          _buildMarketSelector(),
          _buildMarketStats(),
          _buildSectionsGrid(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMarketView(),
                _buildProductsView(),
                _buildNewsView(),
                _buildAcademyView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  PreferredSizeWidget _buildAppBar(ViewModeProvider viewMode) {
    return AppBar(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppTheme.goldColor, AppTheme.goldDark]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('FLX', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
          const Text('فلكس يمن', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppTheme.goldColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('PRO', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
          },
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Switch(
            value: viewMode.isPro,
            onChanged: (_) => viewMode.toggleMode(),
            activeColor: AppTheme.goldColor,
          ),
        ),
      ],
    );
  }
  
  Widget _buildMarketSelector() {
    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _markets.length,
        itemBuilder: (context, index) {
          final market = _markets[index];
          final isSelected = _selectedMarket == market['name'];
          return GestureDetector(
            onTap: () => setState(() => _selectedMarket = market['name']),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.goldColor : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isSelected ? AppTheme.goldColor : Colors.grey.withOpacity(0.3)),
              ),
              child: Text(market['name'], style: TextStyle(color: isSelected ? Colors.white : null)),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildMarketStats() {
    final selectedMarket = _markets.firstWhere((m) => m['name'] == _selectedMarket);
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppTheme.goldColor, AppTheme.goldDark]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(children: [const Text('السوق', style: TextStyle(color: Colors.white70, fontSize: 12)), Text(selectedMarket['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
          Container(width: 1, height: 40, color: Colors.white24),
          Column(children: [const Text('التغير', style: TextStyle(color: Colors.white70, fontSize: 12)), Text(selectedMarket['change'], style: TextStyle(color: selectedMarket['change'].contains('+') ? Colors.green : Colors.red, fontWeight: FontWeight.bold))]),
          Container(width: 1, height: 40, color: Colors.white24),
          Column(children: [const Text('الحجم', style: TextStyle(color: Colors.white70, fontSize: 12)), Text(selectedMarket['volume'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
          Container(width: 1, height: 40, color: Colors.white24),
          Column(children: [const Text('المنتجات', style: TextStyle(color: Colors.white70, fontSize: 12)), Text('${selectedMarket['items']}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
        ],
      ),
    );
  }
  
  Widget _buildSectionsGrid() {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _sections.length,
        itemBuilder: (context, index) {
          final section = _sections[index];
          return GestureDetector(
            onTap: () {
              if (section['route'] != null) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => section['route']()));
              }
            },
            child: Container(
              width: 70,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(section['color']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(section['icon'], color: Color(section['color']), size: 24),
                  ),
                  const SizedBox(height: 4),
                  Text(section['name'], style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTabItem('الأسواق', 0),
          _buildTabItem('المنتجات', 1),
          _buildTabItem('الأخبار', 2),
          _buildTabItem('الأكاديمية', 3),
        ],
      ),
    );
  }
  
  Widget _buildTabItem(String title, int index) {
    final isSelected = _tabController.index == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _tabController.animateTo(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.goldColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(title, textAlign: TextAlign.center, style: TextStyle(color: isSelected ? Colors.white : null, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
  
  Widget _buildMarketView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // كاروسيل الإعلانات
        CarouselSlider(
          options: CarouselOptions(height: 160, autoPlay: true, enlargeCenterPage: true, viewportFraction: 0.9),
          items: _ads.map((ad) => Builder(builder: (context) => GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SanaaServicesScreen()));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), image: DecorationImage(image: NetworkImage(ad['image']), fit: BoxFit.cover)),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.7)])),
                child: Align(alignment: Alignment.bottomRight, child: Padding(padding: const EdgeInsets.all(16),
                  child: Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.end,
                    children: [Text(ad['title'], style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), Text(ad['subtitle'], style: const TextStyle(color: Colors.white70))]),
                )),
              ),
            ),
          ))).toList(),
        ),
        const SizedBox(height: 24),
        // المنتجات الرائجة
        const Text('رائج الآن', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ..._trendingProducts.map((product) => _buildTrendingProduct(product)),
        const SizedBox(height: 16),
        // زر عرض الكل
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SanaaServicesScreen()));
            },
            child: Text('عرض الكل', style: TextStyle(color: AppTheme.goldColor)),
          ),
        ),
      ],
    );
  }
  
  Widget _buildTrendingProduct(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SanaaServicesScreen()));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.getCardColor(context),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(product['image'], width: 60, height: 60, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(width: 60, height: 60, color: Colors.grey[300], child: const Icon(Icons.image)))),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('${product['price']} ر.ي', style: TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold)),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                    child: Text(product['tag'], style: TextStyle(color: AppTheme.goldColor, fontSize: 10))),
                ],
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(product['change'], style: TextStyle(color: product['change'].contains('+') ? Colors.green : Colors.red)),
                Text('حجم: ${product['volume']}', style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProductsView() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 12, mainAxisSpacing: 12),
      itemCount: 20,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SanaaServicesScreen()));
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.getCardColor(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network('https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=300', height: 120, width: double.infinity, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(height: 120, color: Colors.grey[300], child: const Icon(Icons.image)))),
                Padding(padding: const EdgeInsets.all(8),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('منتج ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 2),
                      const SizedBox(height: 4),
                      Text('${(index + 1) * 10000} ر.ي', style: TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildNewsView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _news.length,
      itemBuilder: (context, index) {
        final news = _news[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.getCardColor(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(news['image'], width: 60, height: 60, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(width: 60, height: 60, color: Colors.grey[300], child: const Icon(Icons.image)))),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(news['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Row(children: [Text(news['date'], style: const TextStyle(fontSize: 11, color: Colors.grey)), const SizedBox(width: 12), Text('👁 ${news['views']}', style: const TextStyle(fontSize: 11, color: Colors.grey))]),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildAcademyView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _academy.length,
      itemBuilder: (context, index) {
        final item = _academy[index];
        return GestureDetector(
          onTap: () {
            // TODO: فتح صفحة الدورة
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.getCardColor(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(item['image'], width: 60, height: 60, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(width: 60, height: 60, color: Colors.grey[300], child: const Icon(Icons.school)))),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Row(children: [Text(item['duration'], style: const TextStyle(fontSize: 11, color: Colors.grey)), const SizedBox(width: 12), Text(item['level'], style: TextStyle(fontSize: 11, color: AppTheme.goldColor))]),
                      const SizedBox(height: 4),
                      Text('${item['students']} طالب', style: const TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                ),
                const Icon(Icons.play_circle, color: AppTheme.goldColor),
              ],
            ),
          ),
        );
      },
    );
  }
}
