import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../models/category.dart';
import '../widgets/product_card.dart';
import '../widgets/shimmer_loading.dart';
import '../screens/product_detail_screen.dart';

class UltimateMarketplaceScreen extends StatefulWidget {
  const UltimateMarketplaceScreen({super.key});

  @override
  State<UltimateMarketplaceScreen> createState() => _UltimateMarketplaceScreenState();
}

class _UltimateMarketplaceScreenState extends State<UltimateMarketplaceScreen> {
  // State Management
  MainCategory? _selectedMainCategory;
  SubCategory? _selectedSubCategory;
  Mall? _selectedMall;
  bool _showVendors = false;
  final ScrollController _scrollController = ScrollController();
  
  // Filters
  RangeValues _priceRange = const RangeValues(0, 10000);
  double _minRating = 0;
  List<String> _selectedBrands = [];
  String _deliveryOption = 'all';

  // Mock Data - 45 فئة رئيسية
  final List<MainCategory> _categories = _generateMockCategories();

  @override
  void initState() {
    super.initState();
    _selectedMainCategory = _categories.first;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // AppBar مع شريط البحث
          _buildSliverAppBar(theme),
          
          // شريط الفئات الرئيسية (45 فئة)
          SliverPersistentHeader(
            pinned: true,
            delegate: _CategoryHeaderDelegate(
              child: _buildMainCategoryBar(theme, isDark),
              height: 60,
            ),
          ),
          
          // شريط الفروع الثانوية
          if (_selectedMainCategory != null)
            SliverPersistentHeader(
              pinned: true,
              delegate: _CategoryHeaderDelegate(
                child: _buildSubCategoryBar(theme, isDark),
                height: 50,
              ),
            ),
          
          // شريط المعارض والمولات
          if (_selectedMainCategory != null && _selectedMainCategory!.malls.isNotEmpty)
            SliverToBoxAdapter(
              child: _buildMallsSection(theme, isDark),
            ),
          
          // Toggle منتجات/متاجر
          SliverToBoxAdapter(
            child: _buildViewToggle(theme, isDark),
          ),
          
          // الشبكة الرئيسية (منتجات أو متاجر)
          _showVendors 
              ? _buildVendorsGrid(theme)
              : _buildProductsGrid(theme),
        ],
      ),
      
      // زر الفلاتر العائم
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFilterBottomSheet(context),
        backgroundColor: AppTheme.gold,
        child: const Icon(Icons.filter_list, color: Colors.black),
      ),
    );
  }

  // ==================== AppBar ====================
  Widget _buildSliverAppBar(ThemeData theme) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 120,
      backgroundColor: theme.scaffoldBackgroundColor,
      title: Container(
        height: 50,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'ابحث عن المنتجات، المتاجر، المولات...',
            hintStyle: const TextStyle(fontFamily: 'Changa', fontSize: 14),
            prefixIcon: const Icon(Icons.search, color: AppTheme.gold),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          style: const TextStyle(fontFamily: 'Changa'),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart_outlined),
        ),
      ],
    );
  }

  // ==================== شريط الفئات الرئيسية ====================
  Widget _buildMainCategoryBar(ThemeData theme, bool isDark) {
    return Container(
      height: 60,
      color: theme.scaffoldBackgroundColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedMainCategory?.id == category.id;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedMainCategory = category;
                _selectedSubCategory = null;
                _selectedMall = null;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                gradient: isSelected ? AppTheme.goldGradient : null,
                color: isSelected ? null : (isDark ? AppTheme.nightCard : Colors.grey[200]),
                borderRadius: BorderRadius.circular(30),
                boxShadow: isSelected ? [
                  BoxShadow(
                    color: AppTheme.gold.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ] : null,
              ),
              child: Center(
                child: Text(
                  category.name,
                  style: TextStyle(
                    fontFamily: 'Changa',
                    color: isSelected ? Colors.black : theme.textTheme.bodyMedium?.color,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ==================== شريط الفروع ====================
  Widget _buildSubCategoryBar(ThemeData theme, bool isDark) {
    if (_selectedMainCategory == null) return const SizedBox.shrink();
    
    final subCategories = _selectedMainCategory!.subCategories;
    
    return Container(
      height: 50,
      color: theme.scaffoldBackgroundColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: subCategories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            // زر "الكل"
            final isSelected = _selectedSubCategory == null;
            return _buildSubCategoryChip(
              'الكل',
              isSelected,
              theme,
              () {
                setState(() => _selectedSubCategory = null);
              },
            );
          }
          
          final sub = subCategories[index - 1];
          final isSelected = _selectedSubCategory?.id == sub.id;
          
          return _buildSubCategoryChip(
            sub.name,
            isSelected,
            theme,
            () {
              setState(() => _selectedSubCategory = sub);
            },
          );
        },
      ),
    );
  }

  Widget _buildSubCategoryChip(String label, bool isSelected, ThemeData theme, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.gold.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.gold : Colors.grey.withOpacity(0.3),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 12,
              color: isSelected ? AppTheme.gold : theme.textTheme.bodySmall?.color,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  // ==================== المعارض والمولات ====================
  Widget _buildMallsSection(ThemeData theme, bool isDark) {
    final malls = _selectedMainCategory!.malls;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'المعارض والمولات',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: malls.length,
            itemBuilder: (context, index) {
              final mall = malls[index];
              final isSelected = _selectedMall?.id == mall.id;
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedMall = isSelected ? null : mall;
                  });
                },
                child: Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: isDark ? AppTheme.nightCard : AppTheme.lightCard,
                    borderRadius: BorderRadius.circular(16),
                    border: isSelected ? Border.all(color: AppTheme.gold, width: 2) : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: mall.imageUrl,
                        height: 40,
                        width: 40,
                        errorWidget: (_, __, ___) => const Icon(Icons.store, color: AppTheme.gold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        mall.name,
                        style: const TextStyle(fontFamily: 'Changa', fontSize: 12, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '${mall.storesCount} متجر',
                        style: TextStyle(fontFamily: 'Changa', fontSize: 10, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  // ==================== Toggle منتجات/متاجر ====================
  Widget _buildViewToggle(ThemeData theme, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _showVendors = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: !_showVendors ? AppTheme.gold : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'المنتجات',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Changa',
                    color: !_showVendors ? Colors.black : theme.textTheme.bodyMedium?.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _showVendors = true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _showVendors ? AppTheme.gold : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'المتاجر',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Changa',
                    color: _showVendors ? Colors.black : theme.textTheme.bodyMedium?.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== شبكة المنتجات ====================
  Widget _buildProductsGrid(ThemeData theme) {
    List<Product> products = [];
    if (_selectedMainCategory != null) {
      products = _selectedMainCategory!.products;
      
      // تطبيق الفلاتر
      if (_selectedSubCategory != null) {
        // تصفية حسب الفرع
      }
      if (_selectedMall != null) {
        // تصفية حسب المول
      }
      products = products.where((p) => p.price >= _priceRange.start && p.price <= _priceRange.end).toList();
      products = products.where((p) => p.rating >= _minRating).toList();
    }
    
    if (products.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'لا توجد منتجات',
                style: theme.textTheme.titleLarge?.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }
    
    return SliverPadding(
      padding: const EdgeInsets.all(12),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final product = products[index];
            return ProductCard(
              id: product.id,
              title: product.name,
              image: product.imageUrl,
              price: product.price,
              isAvailable: product.inStock,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(
                      id: product.id,
                      title: product.name,
                      image: product.imageUrl,
                      price: product.price,
                      description: 'وصف المنتج ${product.name}',
                      sellerName: product.vendorName,
                      rating: product.rating,
                      reviewCount: product.reviewsCount,
                      images: [product.imageUrl],
                      inStock: product.inStock,
                    ),
                  ),
                );
              },
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }

  // ==================== شبكة المتاجر ====================
  Widget _buildVendorsGrid(ThemeData theme) {
    final vendors = _selectedMainCategory?.vendors ?? [];
    
    return SliverPadding(
      padding: const EdgeInsets.all(12),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.9,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final vendor = vendors[index];
            final isDark = theme.brightness == Brightness.dark;
            
            return Container(
              decoration: BoxDecoration(
                color: isDark ? AppTheme.nightCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.gold, width: 2),
                        ),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: vendor.logoUrl,
                            fit: BoxFit.cover,
                            errorWidget: (_, __, ___) => const Icon(Icons.store, color: AppTheme.gold),
                          ),
                        ),
                      ),
                      if (vendor.isVerified)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check, size: 14, color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    vendor.name,
                    style: const TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${vendor.productsCount} منتج',
                    style: TextStyle(fontFamily: 'Changa', fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      Text(
                        ' ${vendor.rating}',
                        style: const TextStyle(fontFamily: 'Changa', fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.gold),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    ),
                    child: const Text('متابعة', style: TextStyle(fontFamily: 'Changa', fontSize: 12)),
                  ),
                ],
              ),
            );
          },
          childCount: vendors.length,
        ),
      ),
    );
  }

  // ==================== Filter Bottom Sheet ====================
  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'تصفية النتائج',
                        style: TextStyle(fontFamily: 'Changa', fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView(
                      children: [
                        // السعر
                        const Text('نطاق السعر', style: TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold)),
                        RangeSlider(
                          values: _priceRange,
                          min: 0,
                          max: 10000,
                          divisions: 100,
                          labels: RangeLabels('${_priceRange.start.round()} ر.ي', '${_priceRange.end.round()} ر.ي'),
                          onChanged: (values) {
                            setModalState(() {
                              _priceRange = values;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        
                        // التقييم
                        const Text('التقييم', style: TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold)),
                        Wrap(
                          spacing: 8,
                          children: [0, 3, 4, 4.5].map((rating) {
                            final isSelected = _minRating == rating;
                            return ChoiceChip(
                              label: Text(rating == 0 ? 'الكل' : '$rating+ نجوم'),
                              selected: isSelected,
                              onSelected: (_) {
                                setModalState(() {
                                  _minRating = rating;
                                });
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                        
                        // خيارات التوصيل
                        const Text('التوصيل', style: TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold)),
                        ...['all', 'free', 'fast'].map((option) {
                          return RadioListTile<String>(
                            title: Text(
                              option == 'all' ? 'الكل' : option == 'free' ? 'توصيل مجاني' : 'توصيل سريع',
                              style: const TextStyle(fontFamily: 'Changa'),
                            ),
                            value: option,
                            groupValue: _deliveryOption,
                            onChanged: (value) {
                              setModalState(() {
                                _deliveryOption = value!;
                              });
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setModalState(() {
                              _priceRange = const RangeValues(0, 10000);
                              _minRating = 0;
                              _deliveryOption = 'all';
                            });
                            setState(() {});
                          },
                          child: const Text('مسح الكل'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {});
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold),
                          child: const Text('تطبيق', style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ==================== Mock Data Generator ====================
  static List<MainCategory> _generateMockCategories() {
    // 45 فئة رئيسية مع بيانات وهمية
    return [
      MainCategory(
        id: 1,
        name: 'الإلكترونيات',
        iconUrl: 'https://via.placeholder.com/50',
        subCategories: ['جوالات', 'كمبيوترات', 'أجهزة لوحية', 'سماعات', 'شواحن', 'ملحقات']
            .map((e) => SubCategory(id: 1, name: e, mainCategoryId: 1))
            .toList(),
        malls: [
          Mall(id: 1, name: 'مول التقنية', imageUrl: 'https://via.placeholder.com/100', storesCount: 45, mainCategoryId: 1),
          Mall(id: 2, name: 'معرض الإلكترونيات', imageUrl: 'https://via.placeholder.com/100', storesCount: 32, mainCategoryId: 1),
        ],
        vendors: List.generate(10, (i) => Vendor(
          id: 'v$i',
          name: 'متجر إلكترونيات ${i + 1}',
          logoUrl: 'https://via.placeholder.com/100',
          productsCount: 50 + i * 10,
          rating: 4.0 + (i % 2) * 0.5,
          isVerified: i % 3 == 0,
        )),
        products: List.generate(20, (i) => Product(
          id: 'p$i',
          name: 'منتج إلكتروني ${i + 1}',
          price: 500 + (i * 100).toDouble(),
          oldPrice: i % 3 == 0 ? 700 + (i * 100).toDouble() : null,
          imageUrl: 'https://via.placeholder.com/200',
          vendorName: 'متجر الإلكترونيات',
          vendorId: 'v1',
          rating: 4.5,
          reviewsCount: 100 + i,
          stockQuantity: 10 + i,
          categoryKey: 'electronics',
        )),
      ),
      // ... أضف باقي الفئات الـ 45 هنا
    ];
  }
}

// ==================== SliverPersistentHeader Delegate ====================
class _CategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _CategoryHeaderDelegate({required this.child, required this.height});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant _CategoryHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.height != height;
  }
}
