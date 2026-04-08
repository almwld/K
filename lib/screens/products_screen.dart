import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> with SingleTickerProviderStateMixin {
  int _selectedCategoryIndex = 0;
  late AnimationController _animationController;

  // قائمة الفئات (لشريط التصفية)
  final List<CategoryFilter> _categories = [
    CategoryFilter(id: 'all', name: 'الكل', icon: Icons.grid_view),
    CategoryFilter(id: 'electronics', name: 'إلكترونيات', icon: Icons.electrical_services),
    CategoryFilter(id: 'fashion', name: 'أزياء', icon: Icons.checkroom),
    CategoryFilter(id: 'furniture', name: 'أثاث', icon: Icons.weekend),
    CategoryFilter(id: 'cars', name: 'سيارات', icon: Icons.directions_car),
    CategoryFilter(id: 'real_estate', name: 'عقارات', icon: Icons.house),
  ];

  // قائمة المنتجات (بيانات تجريبية)
  List<ProductModel> _allProducts = [];

  List<ProductModel> get _filteredProducts {
    if (_selectedCategoryIndex == 0) return _allProducts;
    final selectedCategory = _categories[_selectedCategoryIndex];
    return _allProducts.where((p) => p.categoryId == selectedCategory.id).toList();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _loadProducts();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _loadProducts() {
    // بيانات تجريبية (يمكن استبدالها بـ API لاحقاً)
    _allProducts = [
      ProductModel(
        id: '1',
        name: 'آيفون 15 برو ماكس',
        description: 'أحدث هاتف من Apple',
        price: 450000,
        imageUrl: 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=300',
        categoryId: 'electronics',
        categoryName: 'إلكترونيات',
        seller: 'متجر التقنية',
        rating: 4.8,
        reviewCount: 124,
        discountPercent: 10,
      ),
      ProductModel(
        id: '2',
        name: 'سامسونج S24 الترا',
        description: 'هاتف ذكي متطور',
        price: 380000,
        imageUrl: 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=300',
        categoryId: 'electronics',
        categoryName: 'إلكترونيات',
        seller: 'متجر التقنية',
        rating: 4.7,
        reviewCount: 98,
        discountPercent: 15,
      ),
      ProductModel(
        id: '3',
        name: 'ماك بوك برو M3',
        description: 'لابتوب احترافي',
        price: 1800000,
        imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=300',
        categoryId: 'electronics',
        categoryName: 'إلكترونيات',
        seller: 'متجر أبل',
        rating: 4.9,
        reviewCount: 56,
        discountPercent: 5,
      ),
      ProductModel(
        id: '4',
        name: 'ثوب يمني فاخر',
        description: 'ثوب يمني تقليدي',
        price: 35000,
        imageUrl: 'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=300',
        categoryId: 'fashion',
        categoryName: 'أزياء',
        seller: 'متجر الأزياء',
        rating: 4.6,
        reviewCount: 42,
        discountPercent: 20,
      ),
      ProductModel(
        id: '5',
        name: 'كنبة زاوية فاخرة',
        description: 'كنبة مودرن',
        price: 150000,
        imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=300',
        categoryId: 'furniture',
        categoryName: 'أثاث',
        seller: 'معرض الأثاث',
        rating: 4.5,
        reviewCount: 23,
        discountPercent: null,
      ),
      ProductModel(
        id: '6',
        name: 'تويوتا كامري 2024',
        description: 'سيارة جديدة',
        price: 8500000,
        imageUrl: 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=300',
        categoryId: 'cars',
        categoryName: 'سيارات',
        seller: 'معرض السيارات',
        rating: 4.9,
        reviewCount: 31,
        discountPercent: 5,
      ),
      ProductModel(
        id: '7',
        name: 'فيلا فاخرة صنعاء',
        description: 'فيلا بمساحة 400 متر',
        price: 45000000,
        imageUrl: 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=300',
        categoryId: 'real_estate',
        categoryName: 'عقارات',
        seller: 'مكتب عقاري',
        rating: 4.7,
        reviewCount: 12,
        discountPercent: null,
      ),
      ProductModel(
        id: '8',
        name: 'مندي يمني',
        description: 'لحم ضأن مع أرز',
        price: 3500,
        imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=300',
        categoryId: 'restaurants',
        categoryName: 'مطاعم',
        seller: 'مطعم الأصيل',
        rating: 4.8,
        reviewCount: 67,
        discountPercent: 10,
      ),
    ];
    setState(() {});
  }

  void _onCategorySelected(int index) {
    if (_selectedCategoryIndex == index) return;
    _animationController.reset();
    _animationController.forward();
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  void _showProductDetails(ProductModel product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم النقر على ${product.name}'), duration: const Duration(seconds: 1)),
    );
  }

  void _addToCart(ProductModel product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم إضافة ${product.name} إلى السلة'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filteredProducts = _filteredProducts;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المنتجات'),
      body: Column(
        children: [
          // شريط التصفية الأفقي (Horizontal Filter Bar)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkSurface : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(_categories.length, (index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategoryIndex == index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: _buildFilterChip(category, isSelected, index),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // شبكة المنتجات
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              child: filteredProducts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inventory, size: 80, color: isDark ? Colors.grey[600] : Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            'لا توجد منتجات',
                            style: TextStyle(fontSize: 18, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'اختر فئة أخرى',
                            style: TextStyle(fontSize: 14, color: isDark ? Colors.grey[500] : Colors.grey[500]),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      key: ValueKey(_selectedCategoryIndex),
                      padding: const EdgeInsets.all(12),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.68,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        return FadeTransition(
                          opacity: _animationController.drive(
                            Tween<double>(begin: 0.5, end: 1.0),
                          ),
                          child: ProductCard(
                            product: filteredProducts[index],
                            onTap: () => _showProductDetails(filteredProducts[index]),
                            onAddToCart: () => _addToCart(filteredProducts[index]),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(CategoryFilter category, bool isSelected, int index) {
    return GestureDetector(
      onTap: () => _onCategorySelected(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.goldColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? AppTheme.goldColor : (Theme.of(context).brightness == Brightness.dark ? Colors.grey[700]! : Colors.grey[300]!),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.goldColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              category.icon,
              size: 18,
              color: isSelected ? Colors.white : (Theme.of(context).brightness == Brightness.dark ? Colors.grey[400] : Colors.grey[600]),
            ),
            const SizedBox(width: 8),
            Text(
              category.name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? Colors.white : (Theme.of(context).brightness == Brightness.dark ? Colors.grey[300] : Colors.grey[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryFilter {
  final String id;
  final String name;
  final IconData icon;

  CategoryFilter({
    required this.id,
    required this.name,
    required this.icon,
  });
}
