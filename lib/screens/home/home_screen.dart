import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/shimmer_image.dart';
import '../../providers/auth_provider.dart';
import '../../data/market_data.dart';
import '../../widgets/market_top_tabs.dart';
import '../../widgets/market_grid_table.dart';
import '../../models/market_item.dart';
import '../product/product_detail_screen.dart';
import '../category_products_screen.dart';
import '../all_ads_screen.dart';
import '../login_screen.dart';
import '../register_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentCarouselIndex = 0;
  bool _isLoading = true;
  String _selectedMarketTab = 'اكتشف';
  String _selectedFilter = 'رائج';
  List<MarketItem> _displayItems = [];
  final ScrollController _scrollController = ScrollController();
  bool _showAppBar = true;
  bool _showBottomBar = true;
  
  final List<Map<String, dynamic>> _carouselItems = [
    {'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=800', 'title': 'سيارات جديدة', 'subtitle': 'أحدث الموديلات', 'discount': 'خصم 25%'},
    {'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=800', 'title': 'عقارات فاخرة', 'subtitle': 'فلل وشقق', 'discount': 'خصم 30%'},
    {'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800', 'title': 'إلكترونيات', 'subtitle': 'هواتف وكمبيوترات', 'discount': 'خصم 40%'},
    {'image': 'https://images.unsplash.com/photo-1558591710-4b4a1ae0f04d?w=800', 'title': 'مزادات حية', 'subtitle': 'سيارات وعقارات', 'discount': 'مزايدة الآن'},
  ];

  List<Map<String, dynamic>> _products = [];
  final List<Map<String, dynamic>> _categories = [
    {'id': 'electronics', 'name': 'إلكترونيات', 'icon': Icons.electrical_services, 'color': 0xFF9C27B0},
    {'id': 'cars', 'name': 'سيارات', 'icon': Icons.directions_car, 'color': 0xFF4CAF50},
    {'id': 'real_estate', 'name': 'عقارات', 'icon': Icons.house, 'color': 0xFF2196F3},
    {'id': 'fashion', 'name': 'أزياء', 'icon': Icons.checkroom, 'color': 0xFFE91E63},
    {'id': 'furniture', 'name': 'أثاث', 'icon': Icons.weekend, 'color': 0xFF795548},
    {'id': 'restaurants', 'name': 'مطاعم', 'icon': Icons.restaurant, 'color': 0xFFFF9800},
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (_showAppBar || _showBottomBar) {
        setState(() {
          _showAppBar = false;
          _showBottomBar = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (!_showAppBar || !_showBottomBar) {
        setState(() {
          _showAppBar = true;
          _showBottomBar = true;
        });
      }
    }
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _products = [
        {'id': '1', 'name': 'تويوتا كامري 2024', 'price': '95,000', 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400', 'tag': 'سيارات'},
        {'id': '2', 'name': 'فيلا فاخرة', 'price': '2,500,000', 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400', 'tag': 'عقارات'},
        {'id': '3', 'name': 'ماك بوك برو', 'price': '6,500', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400', 'tag': 'إلكترونيات'},
        {'id': '4', 'name': 'مندي لحم', 'price': '65', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400', 'tag': 'مطاعم'},
        {'id': '5', 'name': 'مزاد سيارات', 'price': 'مزايدة', 'image': 'https://images.unsplash.com/photo-1558591710-4b4a1ae0f04d?w=400', 'tag': 'مزادات'},
        {'id': '6', 'name': 'آيفون 15 برو', 'price': '4,500', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400', 'tag': 'إلكترونيات'},
      ];
      _displayItems = MarketData.getTrending();
      _isLoading = false;
    });
  }

  void _onMarketTabSelected(String tab) {
    setState(() {
      _selectedMarketTab = tab;
      switch (tab) {
        case 'اكتشف':
          _displayItems = MarketData.getAllItems().take(25).toList();
          break;
        case 'المتابعات':
          _displayItems = MarketData.getAllItems().where((i) => i.isFavorite).toList();
          break;
        case 'رائج':
          _displayItems = MarketData.getTrending();
          break;
        case 'الاعلانات':
          _displayItems = MarketData.getOffers();
          break;
        case 'الاخبار':
          _displayItems = MarketData.getNewArrivals();
          break;
        case 'مولات':
          _displayItems = MarketData.getBySection('مولات');
          break;
        case 'بقالة':
          _displayItems = MarketData.getBySection('بقالات');
          break;
        case 'مزادات':
          _displayItems = MarketData.getBySection('مزادات');
          break;
        default:
          _displayItems = MarketData.getAllItems().take(25).toList();
      }
    });
  }

  void _onFavoriteToggle(MarketItem item) {
    setState(() {
      item.isFavorite = !item.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // استخدام Consumer للاستماع لتغيرات AuthProvider
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final isLoggedIn = authProvider.isAuthenticated;
        
        return Scaffold(
          backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
          appBar: _showAppBar ? AppBar(
            title: const Text('فلكس يمن', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            backgroundColor: AppTheme.goldColor,
            foregroundColor: Colors.black,
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.black)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined, color: Colors.black)),
            ],
          ) : null,
          body: Column(
            children: [
              // أزرار الدخول والتسجيل - تظهر فقط إذا لم يكن مسجلاً
              if (!isLoggedIn && _showAppBar) _buildAuthButtons(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _loadData,
                  color: AppTheme.goldColor,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        _isLoading ? const CarouselShimmer() : _buildCarousel(),
                        const SizedBox(height: 16),
                        _buildSectionHeader('الأقسام الرئيسية'),
                        _isLoading ? _buildCategoriesShimmer() : _buildCategories(),
                        const SizedBox(height: 24),
                        _buildSectionHeader('منتجات مميزة'),
                        _isLoading ? const ProductGridShimmer() : _buildProductsGrid(),
                        const SizedBox(height: 24),
                        _buildSectionHeader('السوق المتجدد'),
                        const SizedBox(height: 8),
                        Container(
                          height: 450,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: _isLoading
                                ? const Center(child: CircularProgressIndicator())
                                : MarketGridTable(
                                    items: _displayItems,
                                    filterType: _selectedFilter,
                                    onFavoriteToggle: _onFavoriteToggle,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
              if (_showBottomBar)
                MarketTopTabs(
                  onTabSelected: _onMarketTabSelected,
                  selectedTab: _selectedMarketTab,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAuthButtons() {
    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: const Text('دخول', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
              style: OutlinedButton.styleFrom(foregroundColor: AppTheme.goldColor, side: const BorderSide(color: AppTheme.goldColor, width: 2), padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: const Text('إنشاء حساب', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesShimmer() {
    return SizedBox(height: 100, child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: 6, itemBuilder: (context, index) => const CategoryShimmer()));
  }

  Widget _buildCarousel() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(height: 180, autoPlay: true, enlargeCenterPage: true, viewportFraction: 0.9, onPageChanged: (index, reason) => setState(() => _currentCarouselIndex = index)),
          items: _carouselItems.map((item) => Builder(
            builder: (context) => Container(
              width: double.infinity, margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Stack(
                children: [
                  ShimmerImage(imageUrl: item['image'], borderRadius: BorderRadius.circular(20), height: 180, width: double.infinity),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.7)])),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: AppTheme.goldColor, borderRadius: BorderRadius.circular(12)), child: Text(item['discount'], style: const TextStyle(color: Colors.white, fontSize: 10))),
                            const SizedBox(height: 4), Text(item['title'], style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(item['subtitle'], style: const TextStyle(color: Colors.white70, fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )).toList(),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: _carouselItems.asMap().entries.map((entry) => Container(width: 8, height: 8, margin: const EdgeInsets.symmetric(horizontal: 4), decoration: BoxDecoration(shape: BoxShape.circle, color: _currentCarouselIndex == entry.key ? AppTheme.goldColor : Colors.grey.withOpacity(0.5)))).toList()),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AllAdsScreen())), child: Text('عرض الكل', style: TextStyle(color: AppTheme.goldColor)))]) );
  }

  Widget _buildCategories() {
    return SizedBox(height: 100, child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: _categories.length, itemBuilder: (context, index) {
      final cat = _categories[index];
      return GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryProductsScreen(categoryId: cat['id'], categoryName: cat['name']))),
        child: Container(width: 80, margin: const EdgeInsets.symmetric(horizontal: 8), child: Column(children: [Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Color(cat['color']).withOpacity(0.1), shape: BoxShape.circle), child: Icon(cat['icon'], color: Color(cat['color']), size: 30)), const SizedBox(height: 8), Text(cat['name'], style: const TextStyle(fontSize: 12))])),
      );
    }));
  }

  Widget _buildProductsGrid() {
    return GridView.builder(
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), padding: const EdgeInsets.symmetric(horizontal: 12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 12, mainAxisSpacing: 12),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(productId: product['id'], productName: product['name']))),
          child: Container(
            decoration: BoxDecoration(color: AppTheme.getCardColor(context), borderRadius: BorderRadius.circular(12)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(12)), child: ShimmerImage(imageUrl: product['image'], height: 130, width: double.infinity)),
                Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(product['name'], maxLines: 2, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), const SizedBox(height: 4), Text('${product['price']} ريال', style: TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold, fontSize: 14)), const SizedBox(height: 4), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Text(product['tag'], style: TextStyle(color: AppTheme.goldColor, fontSize: 10)))])),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class CarouselShimmer extends StatelessWidget {
  const CarouselShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(height: 180, margin: const EdgeInsets.symmetric(horizontal: 16), decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(20)));
  }
}

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(width: 80, margin: const EdgeInsets.symmetric(horizontal: 8), child: Column(children: [Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle), child: const SizedBox(width: 30, height: 30)), const SizedBox(height: 8), Container(height: 10, width: 60, color: Colors.grey[300])]));
  }
}

class ProductGridShimmer extends StatelessWidget {
  const ProductGridShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 12, mainAxisSpacing: 12),
      itemCount: 6,
      itemBuilder: (context, index) => Container(decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(height: 130, color: Colors.grey[300]), Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(height: 14, width: double.infinity, color: Colors.grey[300]), const SizedBox(height: 8), Container(height: 12, width: 80, color: Colors.grey[300]), const SizedBox(height: 8), Container(height: 16, width: 60, color: Colors.grey[300])]))])),
    );
  }
}
