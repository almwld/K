import '../advanced_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/shimmer_image.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_manager.dart';
import '../../data/market_data.dart';
import '../../widgets/market_top_tabs.dart';
import '../../widgets/market_grid_table.dart';
import '../../models/market_item.dart';
import '../product/product_detail_screen.dart';
import '../category_products_screen.dart';
import '../all_ads_screen.dart';
import '../cart/cart_screen.dart';
import '../notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _currentCarouselIndex = 0;
  bool _isLoading = true;
  String _selectedMarketTab = 'اكتشف';
  List<MarketItem> _displayItems = [];
  List<MarketItem> _featuredProducts = [];
  late AnimationController _themeRotationController;
  late Animation<double> _themeRotationAnimation;
  
  final List<Map<String, dynamic>> _carouselItems = [
    {'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=800', 'title': 'سيارات جديدة', 'subtitle': 'أحدث الموديلات', 'discount': 'خصم 25%'},
    {'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=800', 'title': 'عقارات فاخرة', 'subtitle': 'فلل وشقق', 'discount': 'خصم 30%'},
    {'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800', 'title': 'إلكترونيات', 'subtitle': 'هواتف وكمبيوترات', 'discount': 'خصم 40%'},
    {'image': 'https://images.unsplash.com/photo-1558591710-4b4a1ae0f04d?w=800', 'title': 'مزادات حية', 'subtitle': 'سيارات وعقارات', 'discount': 'مزايدة الآن'},
  ];

  final List<Map<String, dynamic>> _categories = [
    {'id': 'electronics', 'name': 'إلكترونيات', 'icon': Icons.electrical_services, 'color': 0xFF3B82F6},
    {'id': 'cars', 'name': 'سيارات', 'icon': Icons.directions_car, 'color': 0xFF10B981},
    {'id': 'real_estate', 'name': 'عقارات', 'icon': Icons.house, 'color': 0xFF8B5CF6},
    {'id': 'fashion', 'name': 'أزياء', 'icon': Icons.checkroom, 'color': 0xFFF59E0B},
    {'id': 'restaurants', 'name': 'مطاعم', 'icon': Icons.restaurant, 'color': 0xFFEF4444},
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
    _themeRotationController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _themeRotationAnimation = Tween<double>(begin: 0, end: 2.5).animate(CurvedAnimation(parent: _themeRotationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _themeRotationController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _featuredProducts = MarketData.getTrending().take(6).toList();
      _displayItems = MarketData.getAllItems().take(20).toList();
      _isLoading = false;
    });
  }

  void _onMarketTabSelected(String tab) {
    setState(() {
      _selectedMarketTab = tab;
      if (tab == 'اكتشف') {
        _displayItems = MarketData.getAllItems().take(25).toList();
      } else if (tab == 'رائج') {
        _displayItems = MarketData.getTrending();
      } else if (tab == 'الاعلانات') {
        _displayItems = MarketData.getOffers();
      } else {
        _displayItems = MarketData.getAllItems().take(25).toList();
      }
    });
  }

  void _onFavoriteToggle(MarketItem item) {
    setState(() => item.isFavorite = !item.isFavorite);
  }

  void _toggleTheme(ThemeManager themeManager) {
    _themeRotationController.forward(from: 0);
    themeManager.setThemeModeIndex(themeManager.isDarkMode ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeManager = context.watch<ThemeManager>();
    
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Scaffold(
          backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
          appBar: AppBar(
            title: const Text('فلكس يمن', style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: AppTheme.primaryBlue,
            foregroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            actions: [
              AnimatedBuilder(
                animation: _themeRotationAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _themeRotationAnimation.value * 3.14159 * 2,
                    child: IconButton(
                      onPressed: () => _toggleTheme(themeManager),
                      icon: Icon(themeManager.isDarkMode ? Icons.light_mode : Icons.dark_mode, color: Colors.white),
                    ),
                  );
                },
              ),
              IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())), icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white)),
              IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())), icon: const Icon(Icons.notifications_outlined, color: Colors.white)),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _loadData,
                  color: AppTheme.primaryBlue,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        _isLoading ? _buildCarouselShimmer() : _buildCarousel(),
                        const SizedBox(height: 16),
                        _buildAuctionBanner(),
                        const SizedBox(height: 20),
                        _buildSectionHeader('الأقسام الرئيسية'),
                        const SizedBox(height: 12),
                        _isLoading ? _buildCategoriesShimmer() : _buildCategories(),
                        const SizedBox(height: 20),
                        _buildSectionHeader('منتجات مميزة'),
                        const SizedBox(height: 12),
                        _isLoading ? _buildProductsShimmer() : _buildFeaturedProducts(),
                        const SizedBox(height: 20),
                        _buildSectionHeader('السوق المتجدد'),
                        const SizedBox(height: 8),
                        Container(
                          height: 400,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppTheme.getCardColor(context),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: _isLoading
                                ? const Center(child: CircularProgressIndicator())
                                : MarketGridTable(items: _displayItems, filterType: 'رائج', onFavoriteToggle: _onFavoriteToggle),
                          ),
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
              MarketTopTabs(onTabSelected: _onMarketTabSelected, selectedTab: _selectedMarketTab),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCarouselShimmer() {
    return Container(height: 180, margin: const EdgeInsets.symmetric(horizontal: 16), decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(20)));
  }
  
  Widget _buildCarousel() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(height: 180, autoPlay: true, viewportFraction: 0.9, onPageChanged: (index, _) => setState(() => _currentCarouselIndex = index)),
          items: _carouselItems.map((item) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Stack(
                children: [
                  ShimmerImage(imageUrl: item['image'] as String, borderRadius: BorderRadius.circular(20), height: 180, width: double.infinity),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(colors: [Colors.transparent, Colors.black.withOpacity(0.7)]),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: AppTheme.goldAccent, borderRadius: BorderRadius.circular(12)), child: Text(item['discount'] as String, style: const TextStyle(color: Colors.white, fontSize: 10))),
                            const SizedBox(height: 4),
                            Text(item['title'] as String, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(item['subtitle'] as String, style: const TextStyle(color: Colors.white70, fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _carouselItems.asMap().entries.map((e) {
            return Container(
              width: 8, height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(shape: BoxShape.circle, color: _currentCarouselIndex == e.key ? AppTheme.primaryBlue : Colors.grey.withOpacity(0.5)),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAuctionBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(gradient: LinearGradient(colors: [AppTheme.goldAccent, AppTheme.goldDark]), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('مزاد الجنابي', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const Text('أكبر مزاد للسيوف التراثية', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppTheme.goldAccent), child: const Text('شارك الآن')),
              ],
            ),
          ),
          const Icon(Icons.emoji_events, size: 50, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AllAdsScreen())), child: Text('عرض الكل', style: TextStyle(color: AppTheme.primaryBlue))),
        ],
      ),
    );
  }

  Widget _buildCategoriesShimmer() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 6,
        itemBuilder: (_, __) => Container(
          width: 80, margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle), child: const SizedBox(width: 30, height: 30)),
              const SizedBox(height: 8),
              Container(height: 10, width: 60, color: Colors.grey[300]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryProductsScreen(categoryId: cat['id'] as String, categoryName: cat['name'] as String))),
            child: Container(
              width: 80, margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Color(cat['color'] as int).withOpacity(0.1), shape: BoxShape.circle), child: Icon(cat['icon'] as IconData, color: Color(cat['color'] as int), size: 30)),
                  const SizedBox(height: 8),
                  Text(cat['name'] as String, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductsShimmer() {
    return GridView.builder(
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), padding: const EdgeInsets.symmetric(horizontal: 12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.75),
      itemCount: 4,
      itemBuilder: (_, __) => Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Container(height: 130, color: Colors.grey[300]),
            Padding(padding: const EdgeInsets.all(8), child: Column(children: [Container(height: 14, color: Colors.grey[300]), const SizedBox(height: 8), Container(height: 12, width: 80, color: Colors.grey[300])])),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedProducts() {
    if (_featuredProducts.isEmpty) return const SizedBox(height: 200, child: Center(child: Text('لا توجد منتجات مميزة')));
    return GridView.builder(
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), padding: const EdgeInsets.symmetric(horizontal: 12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.75, crossAxisSpacing: 12, mainAxisSpacing: 12),
      itemCount: _featuredProducts.length,
      itemBuilder: (context, index) {
        final product = _featuredProducts[index];
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(productId: product.name, productName: product.name, storeName: product.store))),
          child: Container(
            decoration: BoxDecoration(color: AppTheme.lightSurface, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(16)), child: ShimmerImage(imageUrl: product.imageUrl, height: 130, width: double.infinity)),
                Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(product.name, maxLines: 2, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), const SizedBox(height: 4), Text(product.formattedPrice, style: TextStyle(color: AppTheme.priceColor, fontWeight: FontWeight.bold, fontSize: 14))])),
              ],
            ),
          ),
        );
      },
    );
  }
}
