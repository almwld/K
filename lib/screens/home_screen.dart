import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../services/image_cache_service.dart';
import 'category_products_screen.dart';
import 'all_ads_screen.dart';
import 'auctions_screen.dart';
import 'garden_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentCarouselIndex = 0;
  int _visibleProductsCount = 10;
  bool _isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();

  // 10 سلايدرات
  final List<Map<String, dynamic>> _carouselItems = [
    {'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800', 'title': 'مندي يمني', 'subtitle': 'لحم ضأن مع أرز', 'category': 'مطاعم', 'categoryId': 'restaurants', 'discount': 'خصم 20%', 'icon': Icons.restaurant},
    {'image': 'https://images.unsplash.com/photo-1559847844-5315695dadae?w=800', 'title': 'مقلقل دجاج', 'subtitle': 'بهارات يمنية', 'category': 'مطاعم', 'categoryId': 'restaurants', 'discount': 'خصم 15%', 'icon': Icons.restaurant},
    {'image': 'https://images.unsplash.com/photo-1563379926898-05f4575a45d8?w=800', 'title': 'فتة يمنية', 'subtitle': 'فتة باللحم', 'category': 'مطاعم', 'categoryId': 'restaurants', 'discount': 'خصم 10%', 'icon': Icons.restaurant},
    {'image': 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800', 'title': 'شاورما عربية', 'subtitle': 'دجاج ولحم', 'category': 'مطاعم', 'categoryId': 'restaurants', 'discount': 'خصم 25%', 'icon': Icons.restaurant},
    {'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=800', 'title': 'عقارات فاخرة', 'subtitle': 'فلل وشقق', 'category': 'عقارات', 'categoryId': 'real_estate', 'discount': 'خصم 30%', 'icon': Icons.house},
    {'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=800', 'title': 'سيارات جديدة', 'subtitle': 'أحدث الموديلات', 'category': 'سيارات', 'categoryId': 'cars', 'discount': 'خصم 25%', 'icon': Icons.directions_car},
    {'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800', 'title': 'إلكترونيات', 'subtitle': 'هواتف وكومبيوترات', 'category': 'إلكترونيات', 'categoryId': 'electronics', 'discount': 'خصم 40%', 'icon': Icons.electrical_services},
    {'image': 'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=800', 'title': 'أزياء وموضة', 'subtitle': 'ملابس وأحذية', 'category': 'أزياء', 'categoryId': 'fashion', 'discount': 'خصم 50%', 'icon': Icons.checkroom},
    {'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800', 'title': 'أثاث منزلي', 'subtitle': 'غرف نوم ومجالس', 'category': 'أثاث', 'categoryId': 'furniture', 'discount': 'خصم 35%', 'icon': Icons.weekend},
    {'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800', 'title': 'خدمات منزلية', 'subtitle': 'تنظيف وصيانة', 'category': 'خدمات', 'categoryId': 'services', 'discount': 'خصم 20%', 'icon': Icons.build},
  ];

  // جميع المنتجات
  final List<Map<String, dynamic>> _allProducts = [
    {'name': 'مندي يمني', 'price': '3,500', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=300', 'tag': 'مطعم'},
    {'name': 'مقلقل دجاج', 'price': '2,500', 'image': 'https://images.unsplash.com/photo-1559847844-5315695dadae?w=300', 'tag': 'مطعم'},
    {'name': 'فتة يمنية', 'price': '2,000', 'image': 'https://images.unsplash.com/photo-1563379926898-05f4575a45d8?w=300', 'tag': 'مطعم'},
    {'name': 'شاورما عربية', 'price': '1,500', 'image': 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=300', 'tag': 'مطعم'},
    {'name': 'زبيدي مشوي', 'price': '4,000', 'image': 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=300', 'tag': 'مطعم'},
    {'name': 'عصير طبيعي', 'price': '500', 'image': 'https://images.unsplash.com/photo-1600891964092-4316c288032e?w=300', 'tag': 'مطعم'},
    {'name': 'فيلا فاخرة صنعاء', 'price': '45,000,000', 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=300', 'tag': 'عقار'},
    {'name': 'شقة مطلة على البحر', 'price': '25,000,000', 'image': 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=300', 'tag': 'عقار'},
    {'name': 'تويوتا كامري 2024', 'price': '8,500,000', 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=300', 'tag': 'سيارة'},
    {'name': 'مرسيدس S-Class', 'price': '45,000,000', 'image': 'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=300', 'tag': 'سيارة'},
    {'name': 'ماك بوك برو M3', 'price': '1,800,000', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=300', 'tag': 'إلكتروني'},
    {'name': 'ايفون 15 برو', 'price': '450,000', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=300', 'tag': 'إلكتروني'},
    {'name': 'ثوب يمني فاخر', 'price': '35,000', 'image': 'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=300', 'tag': 'أزياء'},
    {'name': 'كنبة زاوية', 'price': '150,000', 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=300', 'tag': 'أثاث'},
  ];

  List<Map<String, dynamic>> get _visibleProducts {
    return _allProducts.take(_visibleProductsCount).toList();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    ImageCacheService.clearOldCache();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      _loadMoreProducts();
    }
  }

  Future<void> _loadMoreProducts() async {
    if (_isLoadingMore) return;
    if (_visibleProductsCount >= _allProducts.length) return;

    setState(() {
      _isLoadingMore = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _visibleProductsCount += 10;
      if (_visibleProductsCount > _allProducts.length) {
        _visibleProductsCount = _allProducts.length;
      }
      _isLoadingMore = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final visibleProducts = _visibleProducts;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('فلكس يمن'),
        backgroundColor: AppTheme.goldColor,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        actions: [
          // زر تسجيل الدخول
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            icon: const Icon(Icons.login, size: 20, color: Colors.black),
            label: const Text('دخول', style: TextStyle(color: Colors.black)),
          ),
          const SizedBox(width: 8),
          // زر إنشاء حساب
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RegisterScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppTheme.goldColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('إنشاء حساب', style: TextStyle(fontSize: 12)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCarousel(),
            const SizedBox(height: 16),
            _buildMazadAlJanabi(),
            const SizedBox(height: 24),
            _buildSectionHeader('الأقسام الرئيسية', ''),
            _buildMainCategories(),
            const SizedBox(height: 24),
            _buildSectionHeader('منتجات مميزة', 'عرض الكل'),
            _buildProductsGrid(visibleProducts),
            if (_isLoadingMore) _buildLoadingIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              setState(() => _currentCarouselIndex = index);
            },
          ),
          items: _carouselItems.map((item) {
            return Builder(builder: (context) {
              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryProductsScreen(categoryId: item['categoryId'], categoryName: item['category']))),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(image: CachedNetworkImageProvider(item['image']), fit: BoxFit.cover),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.7)]),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                              Icon(item['icon'], size: 14, color: Colors.white),
                              const SizedBox(width: 4),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: AppTheme.goldColor, borderRadius: BorderRadius.circular(12)),
                                child: Text(item['discount'], style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                            ]),
                            const SizedBox(height: 4),
                            Text(item['title'], style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(item['subtitle'], style: const TextStyle(color: Colors.white70, fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
          }).toList(),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _carouselItems.asMap().entries.map((entry) {
            return Container(
              width: 8, height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(shape: BoxShape.circle, color: _currentCarouselIndex == entry.key ? AppTheme.goldColor : Colors.grey.withOpacity(0.5)),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMazadAlJanabi() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(gradient: LinearGradient(colors: [AppTheme.goldColor, AppTheme.goldDark]), borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('مزاد الجنابي', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const Text('أكبر مزاد للسيوف التراثية', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AuctionsScreen())),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppTheme.goldColor),
                  child: const Text('شارك الآن'),
                ),
              ],
            ),
          ),
          const Icon(Icons.emoji_events, size: 60, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String? seeAll) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          if (seeAll != null && seeAll.isNotEmpty)
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AllAdsScreen())),
              child: Text(seeAll, style: TextStyle(color: AppTheme.goldColor)),
            ),
        ],
      ),
    );
  }

  Widget _buildMainCategories() {
    final List<Map<String, dynamic>> categories = [
      {'id': 'real_estate', 'name': 'عقارات', 'icon': Icons.house, 'color': 0xFF2196F3},
      {'id': 'cars', 'name': 'سيارات', 'icon': Icons.directions_car, 'color': 0xFF4CAF50},
      {'id': 'electronics', 'name': 'إلكترونيات', 'icon': Icons.electrical_services, 'color': 0xFF9C27B0},
      {'id': 'fashion', 'name': 'أزياء', 'icon': Icons.checkroom, 'color': 0xFFE91E63},
      {'id': 'furniture', 'name': 'أثاث', 'icon': Icons.weekend, 'color': 0xFF795548},
      {'id': 'services', 'name': 'خدمات', 'icon': Icons.build, 'color': 0xFF607D8B},
      {'id': 'restaurants', 'name': 'مطاعم', 'icon': Icons.restaurant, 'color': 0xFFF44336},
    ];
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryProductsScreen(categoryId: cat['id'], categoryName: cat['name']))),
            child: Container(
              width: 80, margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Color(cat['color']).withOpacity(0.1), shape: BoxShape.circle),
                    child: Icon(cat['icon'], color: Color(cat['color']), size: 30)),
                  const SizedBox(height: 8),
                  Text(cat['name'], style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductsGrid(List<Map<String, dynamic>> products) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 12, mainAxisSpacing: 12,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _buildProductCard(product);
      },
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getCardColor(context),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: product['image'],
                height: 130,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 130,
                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                  child: Center(
                    child: SizedBox(
                      height: 30, width: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD4AF37)),
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 130, color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product['name'], maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 4),
                  Text('${product['price']} ريال', style: TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                    child: Text(product['tag'], style: TextStyle(color: AppTheme.goldColor, fontSize: 10)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD4AF37)),
        ),
      ),
    );
  }
}
