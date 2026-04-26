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
        Navigator.push(context, MaterialPageRoute(builder: (_) => const MarketsScreen()));
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
            onPressed: () => _showSearchDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(context, isDark),
          _buildCategoriesRow(context, isDark),
          _buildFilterButtons(context),
          _buildStickyHeader(context, isDark),
          Expanded(
            child: filteredStores.isEmpty
                ? _buildEmptyState(context, isDark)
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredStores.length,
                    itemBuilder: (context, index) => _buildStoreCard(context, filteredStores[index], isDark),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: () => _showSearchDialog(context),
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

  Widget _buildCategoriesRow(BuildContext context, bool isDark) {
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

  Widget _buildFilterButtons(BuildContext context) {
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

  Widget _buildStickyHeader(BuildContext context, bool isDark) {
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

  Widget _buildEmptyState(BuildContext context, bool isDark) {
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

  Widget _buildStoreCard(BuildContext context, Map<String, dynamic> store, bool isDark) {
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

  void _showSearchDialog(BuildContext context) {
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
