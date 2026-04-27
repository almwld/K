import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../../data/full_market_data.dart';
import 'store_detail_screen.dart';
import '../following_screen.dart';
import '../offers_screen.dart';
import '../all_ads_screen.dart';
import '../markets_screen.dart';
import '../discover_screen.dart';
import '../news_screen.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;
  int _selectedTopBar = 0;
  int _selectedFilter = 0;
  String _selectedCategory = 'الكل';
  String _searchQuery = '';
  
  final List<String> _topBarButtons = [
    'اكتشف', 'المتابعات', 'رائج', 'الإعلانات', 'الأخبار', 'المزيد'
  ];
  
  final List<String> _filterButtons = [
    'المفضلات', 'رائج', 'VIP', 'جديدة', 'الأعلى بيعاً!!!'
  ];
  
  List<String> get _categories {
    List<String> cats = ['الكل'];
    for (var c in FullMarketData.mainCategories) {
      cats.add(c['name'] as String);
    }
    return cats;
  }
  
  List<Map<String, dynamic>> get _filteredStores {
    var stores = List<Map<String, dynamic>>.from(FullMarketData.stores);
    
    if (_selectedCategory != 'الكل') {
      stores = stores.where((s) => s['category'] == _selectedCategory).toList();
    }
    
    if (_selectedFilter == 1) {
      stores.sort((a, b) => (b['sales'] as String).replaceAll('K', '').compareTo((a['sales'] as String).replaceAll('K', '')));
    } else if (_selectedFilter == 2) {
      stores = stores.where((s) => s['rating'] >= 4.8).toList();
    } else if (_selectedFilter == 3) {
      stores = stores.where((s) => s['id'] == '1' || s['id'] == '2').toList();
    } else if (_selectedFilter == 4) {
      stores.sort((a, b) => (b['sales'] as String).replaceAll('K', '').compareTo((a['sales'] as String).replaceAll('K', '')));
    }
    
    if (_searchQuery.isNotEmpty) {
      stores = stores.where((s) => s['name'].toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }
    
    return stores;
  }

  void _onTopBarTap(int index) {
    setState(() => _selectedTopBar = index);
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const DiscoverScreen()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const FollowingScreen()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const OffersScreen()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const AllAdsScreen()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const NewsScreen()));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('قريباً'), backgroundColor: AppTheme.binanceGold));
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (mounted) {
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
      }
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
    final filteredStores = _filteredStores;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('المتاجر', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/icons/svg/search.svg', width: 22, height: 22),
            onPressed: () => _showSearchDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(isDark),
          _buildCategoriesRow(isDark),
          _buildFilterButtons(),
          _buildStickyHeader(isDark),
          Expanded(
            child: filteredStores.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredStores.length,
                    itemBuilder: (context, index) => _buildStoreCard(filteredStores[index], isDark),
                  ),
          ),
          _buildMallsSection(),
          _buildBrandsSection(),
          _buildSpecialSections(),
          _buildDeliverySection(),
          _buildRecommendedProductsSection(),
          _buildProductsGrid(),
          _buildAdsSection(),
          _buildDailyProductsSection(),
          _buildCommoditiesSection(),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: _showSearchDialog,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? AppTheme.binanceCard : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppTheme.binanceBorder),
          ),
          child: Row(
            children: [
              SvgPicture.asset('assets/icons/svg/search.svg', width: 20, height: 20),
              const SizedBox(width: 12),
              Text('ابحث عن متجر...', style: TextStyle(color: isDark ? Colors.grey.shade400 : Colors.grey.shade600)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesRow(bool isDark) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = category),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                gradient: isSelected ? AppTheme.goldGradient : null,
                color: isSelected ? null : (isDark ? AppTheme.binanceCard : Colors.grey.shade200),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isSelected ? Colors.transparent : AppTheme.binanceBorder),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.black : (isDark ? Colors.white : Colors.black87),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterButtons() {
    return Container(
      height: 45,
      margin: const EdgeInsets.only(top: 4),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _filterButtons.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedFilter == index;
          final button = _filterButtons[index];
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.binanceGold : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isSelected ? Colors.transparent : AppTheme.binanceGold.withOpacity(0.5)),
              ),
              child: Text(
                button,
                style: TextStyle(
                  color: isSelected ? Colors.black : AppTheme.binanceGold,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStickyHeader(bool isDark) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: _scrollOffset > 50 ? 45 : 0,
      child: _scrollOffset > 50
          ? Container(
              decoration: BoxDecoration(
                color: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
                border: Border(bottom: BorderSide(color: AppTheme.binanceBorder)),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _topBarButtons.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedTopBar == index;
                  return GestureDetector(
                    onTap: () => _onTopBarTap(index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.binanceGold : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _topBarButtons[index],
                        style: TextStyle(
                          color: isSelected ? Colors.black : AppTheme.binanceGold,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          : const SizedBox(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/svg/store.svg', width: 60, height: 60),
          const SizedBox(height: 16),
          Text('لا توجد متاجر', style: TextStyle(color: AppTheme.binanceGold.withOpacity(0.5))),
        ],
      ),
    );
  }

  Widget _buildStoreCard(Map<String, dynamic> store, bool isDark) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StoreDetailScreen(storeId: store['id']))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.binanceCard : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.binanceBorder),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: store['image'],
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppTheme.binanceCard),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          store['name'],
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      if (store['isFollowing'] as bool)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: AppTheme.binanceGold.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                          child: const Text('متابع', style: TextStyle(color: AppTheme.binanceGold, fontSize: 10)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(store['category'], style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/svg/star_gold.svg', width: 14, height: 14),
                      const SizedBox(width: 4),
                      Text('${store['rating']}', style: const TextStyle(color: Colors.white, fontSize: 13)),
                      const SizedBox(width: 8),
                      Text('${store['products']} منتج', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 10)),
                      const Spacer(),
                      Text('${store['sales']}', style: TextStyle(color: AppTheme.binanceGold, fontSize: 12)),
                      const SizedBox(width: 4),
                      const Text('مبيعات', style: TextStyle(color: Color(0xFF5E6673), fontSize: 10)),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildMallsSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final malls = FullMarketData.malls;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('المولات والمعارض', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: malls.length,
            itemBuilder: (context, index) {
              final mall = malls[index];
              return Container(
                width: 280,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.binanceCard : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.binanceBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: CachedNetworkImage(
                        imageUrl: mall['image'],
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(color: AppTheme.binanceCard),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mall['name'],
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 12, color: AppTheme.binanceGold),
                              const SizedBox(width: 4),
                              Text(mall['city'], style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
                              const SizedBox(width: 12),
                              const Icon(Icons.store, size: 12, color: AppTheme.binanceGold),
                              const SizedBox(width: 4),
                              Text('${mall['stores']} متجر', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
                              const SizedBox(width: 12),
                              const Icon(Icons.star, size: 12, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text('${mall['rating']}', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildProductsGrid() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final products = FullMarketData.products;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('أفضل المنتجات', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/product/${product['id']}'),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.binanceCard : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.binanceBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: CachedNetworkImage(
                              imageUrl: product['image'],
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (_, __) => Container(color: AppTheme.binanceCard),
                            ),
                          ),
                          if (product['oldPrice'] != null)
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: AppTheme.binanceRed, borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  _calculateDiscount(product['price'], product['oldPrice']),
                                  style: const TextStyle(color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'],
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                product['price'],
                                style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              if (product['oldPrice'] != null) ...[
                                const SizedBox(width: 4),
                                Text(
                                  product['oldPrice'],
                                  style: const TextStyle(color: Color(0xFF5E6673), decoration: TextDecoration.lineThrough, fontSize: 10),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(Icons.star, size: 10, color: Colors.amber),
                              const SizedBox(width: 2),
                              Text('${product['rating']}', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10)),
                              const Spacer(),
                              Text('${product['sales']}', style: TextStyle(color: AppTheme.binanceGold, fontSize: 10)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  String _calculateDiscount(String price, String? oldPrice) {
    if (oldPrice == null) return 'جديد';
    try {
      double p = double.parse(price.replaceAll(',', ''));
      double op = double.parse(oldPrice.replaceAll(',', ''));
      int discount = ((op - p) / op * 100).round();
      return '-$discount%';
    } catch (e) {
      return 'جديد';
    }
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.binanceCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('البحث عن متجر', style: TextStyle(color: Colors.white)),
        content: TextField(
          autofocus: true,
          onChanged: (value) => setState(() => _searchQuery = value),
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'اسم المتجر...',
            hintStyle: const TextStyle(color: Color(0xFF5E6673)),
            prefixIcon: Icon(Icons.search, color: AppTheme.binanceGold),
            filled: true,
            fillColor: AppTheme.binanceDark,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء', style: TextStyle(color: Color(0xFF9CA3AF)))),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {});
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceGold),
            child: const Text('بحث', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}

  // ==================== قسم الإعلانات ====================
  Widget _buildAdsSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final List<Map<String, dynamic>> _ads = [
      {'title': 'عرض خاص على الإلكترونيات', 'discount': '50%', 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=400', 'color': 0xFF2196F3},
      {'title': 'تخفيضات العيد', 'discount': '30%', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400', 'color': 0xFFF6465D},
      {'title': 'عروض VIP', 'discount': '25%', 'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=400', 'color': 0xFFD4AF37},
      {'title': 'توصيل مجاني', 'discount': '100%', 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400', 'color': 0xFF4CAF50},
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('عروض وإعلانات', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _ads.length,
            itemBuilder: (context, index) {
              final ad = _ads[index];
              return Container(
                width: 300,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(ad['color'] as int), Color(ad['color'] as int).withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 16,
                      top: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            ad['title'],
                            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'خصم ${ad['discount']}',
                            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 16,
                      bottom: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'استفد الآن',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // ==================== قسم الاستهلاكيات والمنتجات اليومية ====================
  Widget _buildDailyProductsSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final List<Map<String, dynamic>> _dailyProducts = [
      {'name': 'خبز عربي', 'price': '1,000', 'image': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=200', 'category': 'مخبوزات'},
      {'name': 'حليب طازج', 'price': '1,500', 'image': 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=200', 'category': 'ألبان'},
      {'name': 'بيض', 'price': '800', 'image': 'https://images.unsplash.com/photo-1582727657635-c771002bd5a6?w=200', 'category': 'بيض'},
      {'name': 'زبادي', 'price': '500', 'image': 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=200', 'category': 'ألبان'},
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('الاستهلاكيات اليومية', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _dailyProducts.length,
            itemBuilder: (context, index) {
              final product = _dailyProducts[index];
              return Container(
                width: 130,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.binanceCard : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.binanceBorder),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        product['image'],
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product['name'],
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      maxLines: 1,
                    ),
                    Text(
                      product['price'],
                      style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold, fontSize: 11),
                    ),
                    Text(
                      product['category'],
                      style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 9),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // ==================== قسم السلع والمواد التموينية ====================
  Widget _buildCommoditiesSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final List<Map<String, dynamic>> _commodities = [
      {'name': 'أرز بسمتي', 'price': '8,000', 'kg': '5 كجم', 'image': 'https://images.unsplash.com/photo-1586201375761-83865001e8ac?w=200'},
      {'name': 'زيت دوار الشمس', 'price': '3,500', 'kg': '1.8 لتر', 'image': 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=200'},
      {'name': 'سكر أبيض', 'price': '2,500', 'kg': '2 كجم', 'image': 'https://images.unsplash.com/photo-1586201375761-83865001e8ac?w=200'},
      {'name': 'طحين', 'price': '1,800', 'kg': '2 كجم', 'image': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=200'},
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('السلع والمواد التموينية', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _commodities.length,
            itemBuilder: (context, index) {
              final commodity = _commodities[index];
              return Container(
                width: 140,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.binanceCard : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.binanceBorder),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        commodity['image'],
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      commodity['name'],
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      maxLines: 1,
                    ),
                    Text(
                      commodity['price'],
                      style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold, fontSize: 11),
                    ),
                    Text(
                      commodity['kg'],
                      style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 9),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // ==================== قسم الماركات والعلامات التجارية ====================
  Widget _buildBrandsSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final List<Map<String, dynamic>> _brands = [
      {'name': 'Apple', 'logo': '🍎', 'products': 234, 'color': 0xFF000000},
      {'name': 'Samsung', 'logo': '📱', 'products': 156, 'color': 0xFF1428A0},
      {'name': 'Nike', 'logo': '✓', 'products': 89, 'color': 0xFF000000},
      {'name': 'Adidas', 'logo': '👟', 'products': 67, 'color': 0xFF000000},
      {'name': 'Sony', 'logo': '🎮', 'products': 123, 'color': 0xFF000000},
      {'name': 'LG', 'logo': '📺', 'products': 45, 'color': 0xFFC70039},
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('ماركات عالمية', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _brands.length,
            itemBuilder: (context, index) {
              final brand = _brands[index];
              return Container(
                width: 100,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.binanceCard : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.binanceBorder),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(brand['logo'], style: const TextStyle(fontSize: 30)),
                    const SizedBox(height: 4),
                    Text(brand['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    Text('${brand['products']} منتج', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10)),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // ==================== قسم الأقسام الخاصة ====================
  Widget _buildSpecialSections() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final List<Map<String, dynamic>> _specialSections = [
      {'name': 'العروض الحصرية', 'icon': '🏷️', 'color': 0xFFF6465D, 'count': 45},
      {'name': 'المنتجات الأكثر مبيعاً', 'icon': '🔥', 'color': 0xFFFF9800, 'count': 89},
      {'name': 'وصل حديثاً', 'icon': '🆕', 'color': 0xFF4CAF50, 'count': 234},
      {'name': 'المنتجات المخفضة', 'icon': '💰', 'color': 0xFF2196F3, 'count': 67},
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('أقسام خاصة', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _specialSections.length,
            itemBuilder: (context, index) {
              final section = _specialSections[index];
              return Container(
                width: 140,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(section['color'] as int), Color(section['color'] as int).withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(section['icon'], style: const TextStyle(fontSize: 28)),
                    const SizedBox(height: 4),
                    Text(section['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center),
                    Text('${section['count']} منتج', style: const TextStyle(color: Colors.white70, fontSize: 10)),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // ==================== قسم التوصيل السريع ====================
  Widget _buildDeliverySection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD4AF37), Color(0xFFB8962E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.local_shipping, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('توصيل سريع', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                const Text('اطلب الآن واحصل على طلبك خلال 24 ساعة', style: TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('توصيل مجاني للطلبات فوق 200,000 ريال', style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== قسم المنتجات الموصى بها ====================
  Widget _buildRecommendedProductsSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final List<Map<String, dynamic>> _recommendedProducts = [
      {'name': 'ساعة رياضية', 'price': '25,000', 'oldPrice': '40,000', 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=200', 'rating': 4.7},
      {'name': 'سماعات لاسلكية', 'price': '15,000', 'oldPrice': '25,000', 'image': 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=200', 'rating': 4.6},
      {'name': 'حقيبة ظهر', 'price': '8,000', 'oldPrice': '15,000', 'image': 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=200', 'rating': 4.5},
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('قد يعجبك أيضاً', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _recommendedProducts.length,
            itemBuilder: (context, index) {
              final product = _recommendedProducts[index];
              return Container(
                width: 150,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.binanceCard : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.binanceBorder),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(product['image'], width: 50, height: 50, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(product['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11), maxLines: 2),
                          Text(product['price'], style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold, fontSize: 10)),
                          Row(
                            children: [
                              const Icon(Icons.star, size: 10, color: Colors.amber),
                              const SizedBox(width: 2),
                              Text('${product['rating']}', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 9)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
