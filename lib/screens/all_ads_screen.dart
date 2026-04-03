import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'category_products_screen.dart';

class AllAdsScreen extends StatefulWidget {
  const AllAdsScreen({super.key});

  @override
  State<AllAdsScreen> createState() => _AllAdsScreenState();
}

class _AllAdsScreenState extends State<AllAdsScreen> {
  String _selectedCategory = 'الكل';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  // قائمة جميع الفئات الـ 52
  final List<Map<String, String>> _categories = [
    {'id': 'all', 'name': 'الكل'},
    {'id': 'real_estate', 'name': 'عقارات'},
    {'id': 'cars', 'name': 'سيارات'},
    {'id': 'electronics', 'name': 'إلكترونيات'},
    {'id': 'fashion', 'name': 'أزياء'},
    {'id': 'furniture', 'name': 'أثاث'},
    {'id': 'restaurants', 'name': 'مطاعم'},
    {'id': 'services', 'name': 'خدمات'},
    {'id': 'games', 'name': 'ألعاب'},
    {'id': 'agriculture', 'name': 'زراعة'},
    {'id': 'beauty', 'name': 'صحة وجمال'},
    {'id': 'education', 'name': 'تعليم'},
    {'id': 'baby', 'name': 'مستلزمات أطفال'},
    {'id': 'sports', 'name': 'رياضة'},
    {'id': 'jewelry', 'name': 'مجوهرات'},
    {'id': 'watches', 'name': 'ساعات'},
    {'id': 'perfumes', 'name': 'عطور'},
    {'id': 'bags', 'name': 'حقائب'},
    {'id': 'shoes', 'name': 'أحذية'},
    {'id': 'phones', 'name': 'جوالات'},
    {'id': 'laptops', 'name': 'كمبيوترات'},
    {'id': 'tv', 'name': 'شاشات'},
    {'id': 'home_appliances', 'name': 'أجهزة منزلية'},
    {'id': 'books', 'name': 'كتب'},
    {'id': 'gifts', 'name': 'هدايا'},
    {'id': 'flowers', 'name': 'ورود'},
    {'id': 'bakery', 'name': 'مخبوزات'},
    {'id': 'grocery', 'name': 'مواد غذائية'},
    {'id': 'meat', 'name': 'لحوم'},
    {'id': 'vegetables', 'name': 'خضروات وفواكه'},
    {'id': 'dairy', 'name': 'منتجات ألبان'},
    {'id': 'drinks', 'name': 'مشروبات'},
    {'id': 'coffee', 'name': 'قهوة'},
    {'id': 'dates', 'name': 'تمور'},
    {'id': 'honey', 'name': 'عسل'},
    {'id': 'incense', 'name': 'بخور وعود'},
    {'id': 'carpets', 'name': 'سجاد'},
    {'id': 'lighting', 'name': 'إضاءة'},
    {'id': 'curtains', 'name': 'ستائر'},
    {'id': 'tools', 'name': 'أدوات كهربائية'},
    {'id': 'construction', 'name': 'مواد بناء'},
    {'id': 'medical', 'name': 'معدات طبية'},
    {'id': 'pets', 'name': 'حيوانات أليفة'},
    {'id': 'stationery', 'name': 'قرطاسية'},
    {'id': 'handicrafts', 'name': 'حرف يدوية'},
    {'id': 'antiques', 'name': 'تحف'},
    {'id': 'cameras', 'name': 'كاميرات'},
    {'id': 'drones', 'name': 'طائرات درون'},
    {'id': 'kitchen', 'name': 'أدوات مطبخ'},
    {'id': 'plumbing', 'name': 'أدوات سباكة'},
    {'id': 'ac', 'name': 'تكييف'},
    {'id': 'cleaning', 'name': 'مواد تنظيف'},
  ];

  // منتجات تجريبية
  final List<Map<String, dynamic>> _allProducts = List.generate(50, (index) {
    final categories = ['cars', 'electronics', 'fashion', 'furniture', 'phones', 'laptops'];
    final categoryNames = ['سيارات', 'إلكترونيات', 'أزياء', 'أثاث', 'جوالات', 'كمبيوترات'];
    final products = [
      {'name': 'تويوتا كامري 2024', 'price': '850,000', 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=300'},
      {'name': 'ايفون 15 برو', 'price': '400,000', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=300'},
      {'name': 'ثوب يمني فاخر', 'price': '35,000', 'image': 'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=300'},
      {'name': 'كنبة زاوية', 'price': '150,000', 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=300'},
      {'name': 'سامسونج اس 24', 'price': '350,000', 'image': 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=300'},
      {'name': 'ماك بوك برو', 'price': '1,800,000', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=300'},
    ];
    final catIndex = index % categories.length;
    return {
      'id': '${index + 1}',
      'name': products[catIndex]['name'],
      'price': products[catIndex]['price'],
      'image': products[catIndex]['image'],
      'categoryId': categories[catIndex],
      'categoryName': categoryNames[catIndex],
    };
  });

  List<Map<String, dynamic>> get _filteredProducts {
    var products = _allProducts;
    
    // فلتر حسب الفئة
    if (_selectedCategory != 'الكل') {
      products = products.where((p) => p['categoryName'] == _selectedCategory).toList();
    }
    
    // فلتر حسب البحث
    if (_searchQuery.isNotEmpty) {
      products = products.where((p) => 
        p['name'].toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }
    
    return products;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final products = _filteredProducts;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'جميع الإعلانات'),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategoriesFilter(),
          Expanded(
            child: products.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'لا توجد منتجات',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CategoryProductsScreen(
                                categoryId: product['categoryId'],
                                categoryName: product['categoryName'],
                              ),
                            ),
                          );
                        },
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
                                child: Image.network(
                                  product['image'],
                                  height: 130,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    height: 130,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.image),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['name'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${product['price']} ريال',
                                      style: TextStyle(
                                        color: AppTheme.goldColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppTheme.goldColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        product['categoryName'],
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: AppTheme.goldColor,
                                        ),
                                      ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'ابحث عن منتج...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchQuery = '';
                      _searchController.clear();
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppTheme.goldColor.withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppTheme.goldColor.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppTheme.goldColor, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesFilter() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category['name'];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              label: Text(category['name']!),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = selected ? category['name']! : 'الكل';
                });
              },
              selectedColor: AppTheme.goldColor,
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
