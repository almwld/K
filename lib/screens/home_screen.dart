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
  
  // 10 سلايدرات تغطي جميع أقسام المتجر
  final List<Map<String, dynamic>> _carouselItems = [
    {
      'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=800',
      'title': 'عقارات فاخرة',
      'subtitle': 'فلل، شقق، أراضي بأسعار مميزة',
      'category': 'عقارات',
      'categoryId': 'real_estate',
      'discount': 'خصم يصل إلى 30%',
      'icon': Icons.house,
    },
    {
      'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=800',
      'title': 'سيارات جديدة ومستعملة',
      'subtitle': 'أحدث الموديلات بأفضل الأسعار',
      'category': 'سيارات',
      'categoryId': 'cars',
      'discount': 'تخفيضات تصل إلى 25%',
      'icon': Icons.directions_car,
    },
    {
      'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800',
      'title': 'إلكترونيات وأجهزة',
      'subtitle': 'هواتف، كمبيوترات، شاشات',
      'category': 'إلكترونيات',
      'categoryId': 'electronics',
      'discount': 'خصم يصل إلى 40%',
      'icon': Icons.electrical_services,
    },
    {
      'image': 'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=800',
      'title': 'أزياء وموضة',
      'subtitle': 'ملابس، أحذية، إكسسوارات',
      'category': 'أزياء',
      'categoryId': 'fashion',
      'discount': 'تخفيضات تصل إلى 50%',
      'icon': Icons.checkroom,
    },
    {
      'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800',
      'title': 'أثاث منزلي فاخر',
      'subtitle': 'غرف نوم، مجالس، مطابخ',
      'category': 'أثاث',
      'categoryId': 'furniture',
      'discount': 'خصم يصل إلى 35%',
      'icon': Icons.weekend,
    },
    {
      'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800',
      'title': 'مطاعم وأكلات شهية',
      'subtitle': 'أشهى المأكولات اليمنية والعربية',
      'category': 'مطاعم',
      'categoryId': 'restaurants',
      'discount': 'عروض تصل إلى 30%',
      'icon': Icons.restaurant,
    },
    {
      'image': 'https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=800',
      'title': 'خدمات منزلية ومهنية',
      'subtitle': 'تنظيف، صيانة، نقل أثاث',
      'category': 'خدمات',
      'categoryId': 'services',
      'discount': 'خصم 20% للخدمات الأولى',
      'icon': Icons.build,
    },
    {
      'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800',
      'title': 'ألعاب إلكترونية',
      'subtitle': 'بلاي ستيشن، ألعاب كمبيوتر',
      'category': 'ألعاب',
      'categoryId': 'games',
      'discount': 'تخفيضات تصل إلى 45%',
      'icon': Icons.sports_esports,
    },
    {
      'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=800',
      'title': 'صحة وجمال',
      'subtitle': 'مكياج، عطور، عناية بالبشرة',
      'category': 'جمال',
      'categoryId': 'beauty',
      'discount': 'خصم يصل إلى 30%',
      'icon': Icons.spa,
    },
    {
      'image': 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=800',
      'title': 'كتب وتعليم',
      'subtitle': 'كتب، دورات، مستلزمات مدرسية',
      'category': 'تعليم',
      'categoryId': 'education',
      'discount': 'خصم 25%',
      'icon': Icons.menu_book,
    },
  ];

  // 30 منتج مميز (عقارات + مولات + منتجات متنوعة)
  final List<Map<String, dynamic>> _featuredProducts = [
    // عقارات فاخرة
    {'name': 'فيلا فاخرة في صنعاء', 'price': '45,000,000', 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=300', 'tag': 'عقار', 'tagColor': 0xFF2196F3},
    {'name': 'شقة مطلة على البحر - عدن', 'price': '25,000,000', 'image': 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=300', 'tag': 'عقار', 'tagColor': 0xFF2196F3},
    {'name': 'أرض سكنية - تعز', 'price': '12,000,000', 'image': 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=300', 'tag': 'عقار', 'tagColor': 0xFF2196F3},
    {'name': 'برج تجاري - المكلا', 'price': '120,000,000', 'image': 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=300', 'tag': 'عقار', 'tagColor': 0xFF2196F3},
    {'name': 'منتجع سياحي - سقطرى', 'price': '250,000,000', 'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=300', 'tag': 'عقار', 'tagColor': 0xFF2196F3},
    
    // مولات ومراكز تجارية
    {'name': 'مول اليمن مول - صنعاء', 'price': '85,000,000', 'image': 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=300', 'tag': 'مول', 'tagColor': 0xFF9C27B0},
    {'name': 'سيتي مول - عدن', 'price': '65,000,000', 'image': 'https://images.unsplash.com/photo-1519567241046-7f570eee3ce6?w=300', 'tag': 'مول', 'tagColor': 0xFF9C27B0},
    {'name': 'الراشد مول - تعز', 'price': '55,000,000', 'image': 'https://images.unsplash.com/photo-1534452203293-494d7ddbf7e0?w=300', 'tag': 'مول', 'tagColor': 0xFF9C27B0},
    {'name': 'الهايبر مول - الحديدة', 'price': '45,000,000', 'image': 'https://images.unsplash.com/photo-1567401893414-76b7b1e5a7a5?w=300', 'tag': 'مول', 'tagColor': 0xFF9C27B0},
    {'name': 'فاميلي مول - إب', 'price': '35,000,000', 'image': 'https://images.unsplash.com/photo-1491637639811-60e2756cc1c7?w=300', 'tag': 'مول', 'tagColor': 0xFF9C27B0},
    
    // سيارات فاخرة
    {'name': 'تويوتا كامري 2024', 'price': '8,500,000', 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=300', 'tag': 'سيارة', 'tagColor': 0xFF4CAF50},
    {'name': 'مرسيدس S-Class', 'price': '45,000,000', 'image': 'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=300', 'tag': 'سيارة', 'tagColor': 0xFF4CAF50},
    {'name': 'بي إم دبليو X6', 'price': '38,000,000', 'image': 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=300', 'tag': 'سيارة', 'tagColor': 0xFF4CAF50},
    
    // إلكترونيات فاخرة
    {'name': 'ماك بوك برو M3', 'price': '1,800,000', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=300', 'tag': 'إلكتروني', 'tagColor': 0xFFE91E63},
    {'name': 'ايفون 15 برو ماكس', 'price': '450,000', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=300', 'tag': 'إلكتروني', 'tagColor': 0xFFE91E63},
    {'name': 'سامسونج اس 24 الترا', 'price': '380,000', 'image': 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=300', 'tag': 'إلكتروني', 'tagColor': 0xFFE91E63},
    
    // أجهزة منزلية فاخرة
    {'name': 'ثلاجة سامسونج 24 قدم', 'price': '350,000', 'image': 'https://images.unsplash.com/photo-1586008214976-3d9d6c5f2e5d?w=300', 'tag': 'منزلي', 'tagColor': 0xFF795548},
    {'name': 'غسالة LG أوتوماتيك', 'price': '120,000', 'image': 'https://images.unsplash.com/photo-1626806787461-102c1bfaaea1?w=300', 'tag': 'منزلي', 'tagColor': 0xFF795548},
    {'name': 'مكيف سبليت 3 طن', 'price': '95,000', 'image': 'https://images.unsplash.com/photo-1633608607992-28810f6df2db?w=300', 'tag': 'منزلي', 'tagColor': 0xFF795548},
    
    // مجوهرات وساعات
    {'name': 'ساعة رولكس', 'price': '850,000', 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=300', 'tag': 'مجوهرات', 'tagColor': 0xFFFF9800},
    {'name': 'طقم ذهب عيار 21', 'price': '1,200,000', 'image': 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=300', 'tag': 'مجوهرات', 'tagColor': 0xFFFF9800},
    
    // عطور فاخرة
    {'name': 'عود كمبودي فاخر', 'price': '250,000', 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=300', 'tag': 'عطر', 'tagColor': 0xFF9C27B0},
    {'name': 'مسك أبيض ملكي', 'price': '180,000', 'image': 'https://images.unsplash.com/photo-1541643600914-78b084683601?w=300', 'tag': 'عطر', 'tagColor': 0xFF9C27B0},
    
    // مطاعم فاخرة
    {'name': 'عشاء رومانسي (لفردين)', 'price': '25,000', 'image': 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=300', 'tag': 'مطعم', 'tagColor': 0xFFF44336},
    {'name': 'بوفيه مفتوح (10 أشخاص)', 'price': '80,000', 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=300', 'tag': 'مطعم', 'tagColor': 0xFFF44336},
    
    // خدمات فاخرة
    {'name': 'تنسيق حفلات زفاف', 'price': '150,000', 'image': 'https://images.unsplash.com/photo-1519225421980-715cb0215aed?w=300', 'tag': 'خدمة', 'tagColor': 0xFF607D8B},
    {'name': 'تنظيف منازل (شامل)', 'price': '35,000', 'image': 'https://images.unsplash.com/photo-1563453392212-326f5e854473?w=300', 'tag': 'خدمة', 'tagColor': 0xFF607D8B},
    {'name': 'تصميم داخلي فاخر', 'price': '200,000', 'image': 'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?w=300', 'tag': 'خدمة', 'tagColor': 0xFF607D8B},
  ];

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
            _buildSectionHeader('منتجات حصرية', ''),
            _buildFeaturedProducts(),
            const SizedBox(height: 16),
            _buildBottomNavBar(),
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
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoryProductsScreen(
                          categoryId: item['categoryId'],
                          categoryName: item['category'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(item['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(item['icon'], size: 16, color: Colors.white),
                                  const SizedBox(width: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppTheme.goldColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      item['discount'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
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
                                style: const TextStyle(color: Colors.white70, fontSize: 12),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  item['category'],
                                  style: const TextStyle(color: Colors.white70, fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _carouselItems.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _buildCarousel(),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentCarouselIndex == entry.key
                      ? AppTheme.goldColor
                      : Colors.grey.withOpacity(0.5),
                ),
              ),
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
                child: Stack(
                  children: [
                    Image.network(
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
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Color(product['tagColor']),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          product['tag'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${product['price']} ريال',
                      style: TextStyle(
                        color: AppTheme.goldColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
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
