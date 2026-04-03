import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'category_products_screen.dart';
import 'all_ads_screen.dart';
import 'auctions_screen.dart';
import 'garden_screen.dart';
import 'search_screen.dart';
import 'notifications_screen.dart';
import 'favorites_screen.dart';
import 'offers_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentCarouselIndex = 0;
  
  final List<Map<String, dynamic>> _carouselItems = [
    {'image': 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=800', 'title': 'عروض رمضان', 'subtitle': 'خصومات تصل إلى 50%'},
    {'image': 'https://images.unsplash.com/photo-1563013544-824ae1b704d3?w=800', 'title': 'تخفيضات الصيف', 'subtitle': 'أفضل العروض'},
    {'image': 'https://images.unsplash.com/photo-1472851294608-062f824d29cc?w=800', 'title': 'مزاد الجنابي', 'subtitle': 'أكبر مزاد للسيوف التراثية'},
  ];

  // 30 منتج مقترح
  final List<Map<String, dynamic>> _featuredProducts = List.generate(30, (index) {
    final products = [
      {'name': 'تويوتا كامري 2024', 'price': '850,000', 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=300'},
      {'name': 'ماك بوك برو M3', 'price': '1,800,000', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=300'},
      {'name': 'سامسونج اس 24 الترا', 'price': '350,000', 'image': 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=300'},
      {'name': 'ايفون 15 برو', 'price': '400,000', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=300'},
      {'name': 'ساعة ابل', 'price': '120,000', 'image': 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=300'},
      {'name': 'سماعات ايربودز', 'price': '45,000', 'image': 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=300'},
      {'name': 'بلاي ستيشن 5', 'price': '250,000', 'image': 'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=300'},
      {'name': 'شاشة سامسونج 65 بوصة', 'price': '350,000', 'image': 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=300'},
      {'name': 'ثلاجة سامسونج', 'price': '280,000', 'image': 'https://images.unsplash.com/photo-1586008214976-3d9d6c5f2e5d?w=300'},
      {'name': 'غسالة اتوماتيك', 'price': '95,000', 'image': 'https://images.unsplash.com/photo-1626806787461-102c1bfaaea1?w=300'},
    ];
    return products[index % products.length];
  });

  final List<Map<String, dynamic>> _mainCategories = [
    {'id': 'real_estate', 'name': 'عقارات', 'icon': Icons.house, 'color': 0xFF2196F3},
    {'id': 'cars', 'name': 'سيارات', 'icon': Icons.directions_car, 'color': 0xFF4CAF50},
    {'id': 'electronics', 'name': 'إلكترونيات', 'icon': Icons.electrical_services, 'color': 0xFF9C27B0},
    {'id': 'fashion', 'name': 'أزياء', 'icon': Icons.checkroom, 'color': 0xFFE91E63},
  ];

  final List<Map<String, dynamic>> _allCategories = [
    {'id': 'games', 'name': 'ألعاب', 'icon': Icons.sports_esports},
    {'id': 'services', 'name': 'خدمات', 'icon': Icons.build},
    {'id': 'restaurants', 'name': 'مطاعم', 'icon': Icons.restaurant},
    {'id': 'furniture', 'name': 'أثاث', 'icon': Icons.weekend},
    {'id': 'agriculture', 'name': 'زراعة', 'icon': Icons.agriculture},
    {'id': 'beauty', 'name': 'جمال', 'icon': Icons.spa},
    {'id': 'sports', 'name': 'رياضة', 'icon': Icons.sports_soccer},
    {'id': 'books', 'name': 'كتب', 'icon': Icons.menu_book},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'فلكس يمن'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCarousel(),
            const SizedBox(height: 16),
            _buildMazadAlJanabi(),
            const SizedBox(height: 24),
            _buildMainCategories(),
            const SizedBox(height: 16),
            _buildSectionHeader('جميع الأقسام', 'عرض الكل'),
            _buildAllCategories(),
            const SizedBox(height: 24),
            _buildSectionHeader('منتجات مميزة', ''),
            _buildFeaturedProducts(),
            const SizedBox(height: 16),
            _buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        onPageChanged: (index, reason) {
          setState(() {
            _currentCarouselIndex = index;
          });
        },
      ),
      items: _carouselItems.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(item['image']),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item['title'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item['subtitle'],
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildMazadAlJanabi() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.goldColor, AppTheme.goldDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'مزاد الجنابي',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'أكبر مزاد للسيوف التراثية',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AuctionsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.goldColor,
                  ),
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

  Widget _buildMainCategories() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _mainCategories.length,
        itemBuilder: (context, index) {
          final category = _mainCategories[index];
          return _buildCategoryCircle(category['name'], category['icon'], category['color']);
        },
      ),
    );
  }

  Widget _buildCategoryCircle(String name, IconData icon, int color) {
    return GestureDetector(
      onTap: () {
        // TODO: التنقل إلى صفحة الفئة
      },
      child: Container(
        width: 70,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(color).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Color(color), size: 30),
            ),
            const SizedBox(height: 8),
            Text(name, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String? seeAll) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (seeAll != null && seeAll.isNotEmpty)
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AllAdsScreen()),
                );
              },
              child: Text(seeAll, style: TextStyle(color: AppTheme.goldColor)),
            ),
        ],
      ),
    );
  }

  Widget _buildAllCategories() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _allCategories.length,
        itemBuilder: (context, index) {
          final category = _allCategories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryProductsScreen(
                    categoryId: category['id'],
                    categoryName: category['name'],
                  ),
                ),
              );
            },
            child: Container(
              width: 80,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.getCardColor(context),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(category['icon'], size: 30, color: AppTheme.goldColor),
                  const SizedBox(height: 8),
                  Text(
                    category['name'],
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedProducts() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _featuredProducts.length,
      itemBuilder: (context, index) {
        final product = _featuredProducts[index];
        return Container(
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
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.person_outline, 'حسابات', '/profile'),
          _buildNavItem(Icons.map_outlined, 'الخريطة', '/map'),
          _buildNavItem(Icons.storefront_outlined, 'المتجر', '/all_ads'),
          _buildNavItem(Icons.favorite_border, 'المفضلة', '/favorites'),
          _buildNavItem(Icons.chat_bubble_outline, 'الدردشة', '/chat'),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        children: [
          Icon(icon, color: AppTheme.goldColor, size: 24),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}
