import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import 'store_detail_screen.dart';
import '../following_screen.dart';
import '../offers_screen.dart';
import '../all_ads_screen.dart';
import '../notifications_screen.dart';

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
  
  // أزرار الشريط العلوي (تظهر تحت الفلاتر وتصبح Sticky عند التمرير)
  final List<String> _topBarButtons = [
    'اكتشف', 'المتابعات', 'رائج', 'الإعلانات', 'الأخبار', 'المزيد'
  ];
  
  // أزرار التصفية العلوية
  final List<String> _filterButtons = [
    'المفضلات', 'رائج', 'VIP', 'جديدة', 'الأعلى بيعاً!!!'
  ];
  
  // الفئات الرئيسية
  final List<String> _categories = [
    'الكل', 'إلكترونيات', 'أزياء', 'سيارات', 'عقارات', 'أثاث', 'مطاعم',
    'صحة وجمال', 'رياضة', 'كتب', 'ألعاب', 'أطفال', 'حيوانات'
  ];
  
  // المتاجر
  final List<Map<String, dynamic>> _stores = [
    {'id': '1', 'name': 'متجر التقنية', 'category': 'إلكترونيات', 'rating': 4.8, 'sales': '1.2K', 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200', 'products': 156},
    {'id': '2', 'name': 'عالم الجوالات', 'category': 'إلكترونيات', 'rating': 4.7, 'sales': '2.3K', 'isFollowing': true, 'image': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=200', 'products': 234},
    {'id': '3', 'name': 'الأزياء العصرية', 'category': 'أزياء', 'rating': 4.6, 'sales': '3.4K', 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200', 'products': 456},
    {'id': '4', 'name': 'معرض السيارات الحديثة', 'category': 'سيارات', 'rating': 4.8, 'sales': '456', 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=200', 'products': 45},
    {'id': '5', 'name': 'عقارات فلكس', 'category': 'عقارات', 'rating': 4.7, 'sales': '234', 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=200', 'products': 45},
    {'id': '6', 'name': 'أثاث المنزل', 'category': 'أثاث', 'rating': 4.5, 'sales': '1.1K', 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200', 'products': 156},
    {'id': '7', 'name': 'مطعم مندي الملكي', 'category': 'مطاعم', 'rating': 4.9, 'sales': '2.1K', 'isFollowing': true, 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200', 'products': 34},
    {'id': '8', 'name': 'صيدلية الحياة', 'category': 'صحة وجمال', 'rating': 4.6, 'sales': '987', 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=200', 'products': 345},
  ];

  List<Map<String, dynamic>> get _filteredStores {
    var stores = List<Map<String, dynamic>>.from(_stores);
    
    if (_selectedCategory != 'الكل') {
      stores = stores.where((s) => s['category'] == _selectedCategory).toList();
    }
    
    if (_selectedFilter == 1) { // رائج
      stores.sort((a, b) => (b['sales'] as String).replaceAll('K', '').compareTo((a['sales'] as String).replaceAll('K', '')));
    } else if (_selectedFilter == 2) { // VIP
      stores = stores.where((s) => s['rating'] >= 4.8).toList();
    } else if (_selectedFilter == 3) { // جديدة
      stores = stores.where((s) => s['id'] == '1' || s['id'] == '2').toList();
    } else if (_selectedFilter == 4) { // الأعلى بيعاً
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
      case 0: // اكتشف
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('اكتشف - قريباً'), backgroundColor: AppTheme.binanceGold));
        break;
      case 1: // المتابعات
        Navigator.push(context, MaterialPageRoute(builder: (_) => const FollowingScreen()));
        break;
      case 2: // رائج
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('الرائج - قريباً'), backgroundColor: AppTheme.binanceGold));
        break;
      case 3: // الإعلانات
        Navigator.push(context, MaterialPageRoute(builder: (_) => const AllAdsScreen()));
        break;
      case 4: // الأخبار
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('الأخبار - قريباً'), backgroundColor: AppTheme.binanceGold));
        break;
      case 5: // المزيد
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('المزيد - قريباً'), backgroundColor: AppTheme.binanceGold));
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
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
            icon: SvgPicture.asset('assets/icons/svg/search.svg', width: 22, height: 22, colorFilter: const ColorFilter.mode(AppTheme.binanceGold, BlendMode.srcIn)),
            onPressed: () => _showSearchDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          // شريط البحث
          Padding(
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
                    SvgPicture.asset('assets/icons/svg/search.svg', width: 20, height: 20, colorFilter: const ColorFilter.mode(AppTheme.binanceGold, BlendMode.srcIn)),
                    const SizedBox(width: 12),
                    Text('ابحث عن متجر...', style: TextStyle(color: isDark ? Colors.grey.shade400 : Colors.grey.shade600)),
                  ],
                ),
              ),
            ),
          ),
          
          // الفئات (Horizontal Scroll)
          SizedBox(
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
          ),
          
          // أزرار التصفية (Filter Buttons)
          Container(
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
          ),
          
          // أزرار الشريط العلوي (Sticky - تظهر عند التمرير)
          AnimatedContainer(
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
          ),
          
          // قائمة المتاجر
          Expanded(
            child: filteredStores.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/svg/store.svg', width: 60, height: 60, colorFilter: ColorFilter.mode(AppTheme.binanceGold.withOpacity(0.3), BlendMode.srcIn)),
                        const SizedBox(height: 16),
                        Text('لا توجد متاجر', style: TextStyle(color: AppTheme.binanceGold.withOpacity(0.5))),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredStores.length,
                    itemBuilder: (context, index) => _buildStoreCard(filteredStores[index], isDark),
                  ),
          ),
        ],
      ),
    );
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
}
