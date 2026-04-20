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

  // =================