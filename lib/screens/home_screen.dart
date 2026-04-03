import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'category_products_screen.dart';
import 'all_ads_screen.dart';
import 'auctions_screen.dart';
import 'garden_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentCarouselIndex = 0;
  final PageController _pageController = PageController();
  
  // 10 سلايدرات تغطي جميع أقسام المتجر مع أكلات
  final List<Map<String, dynamic>> _carouselItems = [
    {
      'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800',
      'title': 'مندي يمني',
      'subtitle': 'لحم ضأن مع أرز - طعم لا يقاوم',
      'category': 'مطاعم',
      'categoryId': 'restaurants',
      'discount': 'خصم 20%',
      'icon': Icons.restaurant,
    },
    {
      'image': 'https://images.unsplash.com/photo-1559847844-5315695dadae?w=800',
      'title': 'مقلقل دجاج',
      'subtitle': 'بهارات يمنية أصلية',
      'category': 'مطاعم',
      'categoryId': 'restaurants',
      'discount': 'خصم 15%',
      'icon': Icons.restaurant,
    },
    {
      'image': 'https://images.unsplash.com/photo-1563379926898-05f4575a45d8?w=800',
      'title': 'فتة يمنية',
      'subtitle': 'فتة باللحم والزبادي',
      'category': 'مطاعم',
      'categoryId': 'restaurants',
      'discount': 'خصم 10%',
      'icon': Icons.restaurant,
    },
    {
      'image': 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800',
      'title': 'شاورما عربية',
      'subtitle': 'دجاج ولحم - ساندوتشات شهية',
      'category': 'مطاعم',
      'categoryId': 'restaurants',
      'discount': 'خصم 25%',
      'icon': Icons.restaurant,
    },
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
      'title': 'سيارات جديدة',
      'subtitle': 'أحدث الموديلات بأفضل الأسعار',
      'category': 'سيارات',
      'categoryId': 'cars',
      'discount': 'تخفيضات تصل إلى 25%',
      'icon': Icons.directions_car,
    },
    {
      'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800',
      'title': 'إلكترونيات',
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
      'title': 'أثاث منزلي',
      'subtitle': 'غرف نوم، مجالس، مطابخ',
      'category': 'أثاث',
      'categoryId': 'furniture',
      'discount': 'خصم يصل إلى 35%',
      'icon': Icons.weekend,
    },
    {
      'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800',
      'title': 'خدمات منزلية',
      'subtitle': 'تنظيف، صيانة، نقل أثاث',
      'category': 'خدمات',
      'categoryId': 'services',
      'discount': 'خصم 20%',
      'icon': Icons.build,
    },
  ];

  // منتجات كل قسم (10 منتجات لكل قسم)
  final Map<String, List<Map<String, dynamic>>> _productsByCategory = {
    'restaurants': [
      {'name': 'مندي يمني', 'price': '3,500', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=300', 'tag': 'مطعم'},
      {'name': 'مقلقل دجاج', 'price': '2,500', 'image': 'https://images.unsplash.com/photo-1559847844-5315695dadae?w=300', 'tag': 'مطعم'},
      {'name': 'فتة يمنية', 'price': '2,000', 'image': 'https://images.unsplash.com/photo-1563379926898-05f4575a45d8?w=300', 'tag': 'مطعم'},
      {'name': 'شاورما عربية', 'price': '1,500', 'image': 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=300', 'tag': 'مطعم'},
      {'name': 'زبيدي مشوي', 'price': '4,000', 'image': 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=300', 'tag': 'مطعم'},
      {'name': 'عصير طبيعي', 'price': '500', 'image': 'https://images.unsplash.com/photo-1600891964092-4316c288032e?w=300', 'tag': 'مطعم'},
      {'name': 'كنافة', 'price': '1,000', 'image': 'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?w=300', 'tag': 'مطعم'},
      {'name': 'بيتزا إيطالية', 'price': '2,500', 'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=300', 'tag': 'مطعم'},
      {'name': 'برجر لحم', 'price': '1,800', 'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300', 'tag': 'مطعم'},
      {'name': 'مقبلات مشكلة', 'price': '1,200', 'image': 'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=300', 'tag': 'مطعم'},
    ],
    'real_estate': [
      {'name': 'فيلا فاخرة صنعاء', 'price': '45,000,000', 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=300', 'tag': 'عقار'},
      {'name': 'شقة مطلة على البحر', 'price': '25,000,000', 'image': 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=300', 'tag': 'عقار'},
      {'name': 'أرض سكنية تعز', 'price': '12,000,000', 'image': 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=300', 'tag': 'عقار'},
      {'name': 'برج تجاري المكلا', 'price': '120,000,000', 'image': 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=300', 'tag': 'عقار'},
      {'name': 'منتجع سياحي سقطرى', 'price': '250,000,000', 'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=300', 'tag': 'عقار'},
      {'name': 'شقة 3 غرف عدن', 'price': '18,000,000', 'image': 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=300', 'tag': 'عقار'},
      {'name': 'فيلا مسبح الحديدة', 'price': '35,000,000', 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=300', 'tag': 'عقار'},
      {'name': 'أرض تجارية إب', 'price': '8,000,000', 'image': 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=300', 'tag': 'عقار'},
      {'name': 'مزرعة عنب', 'price': '15,000,000', 'image': 'https://images.unsplash.com/photo-1625246333195-78d9c38ad449?w=300', 'tag': 'عقار'},
      {'name': 'قصر فاخر', 'price': '300,000,000', 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=300', 'tag': 'عقار'},
    ],
    'cars': [
      {'name': 'تويوتا كامري 2024', 'price': '8,500,000', 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=300', 'tag': 'سيارة'},
      {'name': 'مرسيدس S-Class', 'price': '45,000,000', 'image': 'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=300', 'tag': 'سيارة'},
      {'name': 'بي إم دبليو X6', 'price': '38,000,000', 'image': 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=300', 'tag': 'سيارة'},
      {'name': 'هونداي النترا', 'price': '5,500,000', 'image': 'https://images.unsplash.com/photo-1568605117036-5fe5e7fa0ac7?w=300', 'tag': 'سيارة'},
      {'name': 'نيسان باترول', 'price': '25,000,000', 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=300', 'tag': 'سيارة'},
      {'name': 'تيسلا موديل S', 'price': '60,000,000', 'image': 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=300', 'tag': 'سيارة'},
      {'name': 'فورد موستانج', 'price': '30,000,000', 'image': 'https://images.unsplash.com/photo-1584345604476-8ec5e12e42dd?w=300', 'tag': 'سيارة'},
      {'name': 'شيفروليه كابتيفا', 'price': '12,000,000', 'image': 'https://images.unsplash.com/photo-1568605117036-5fe5e7fa0ac7?w=300', 'tag': 'سيارة'},
      {'name': 'هوندا سي آر في', 'price': '15,000,000', 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=300', 'tag': 'سيارة'},
      {'name': 'كيا سبورتاج', 'price': '10,000,000', 'image': 'https://images.unsplash.com/photo-1568605117036-5fe5e7fa0ac7?w=300', 'tag': 'سيارة'},
    ],
    'electronics': [
      {'name': 'ماك بوك برو M3', 'price': '1,800,000', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=300', 'tag': 'إلكتروني'},
      {'name': 'ايفون 15 برو', 'price': '450,000', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=300', 'tag': 'إلكتروني'},
      {'name': 'سامسونج اس 24', 'price': '380,000', 'image': 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=300', 'tag': 'إلكتروني'},
      {'name': 'شاشة سامسونج 65', 'price': '350,000', 'image': 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=300', 'tag': 'إلكتروني'},
      {'name': 'بلاي ستيشن 5', 'price': '250,000', 'image': 'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=300', 'tag': 'إلكتروني'},
      {'name': 'سماعات ايربودز', 'price': '45,000', 'image': 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=300', 'tag': 'إلكتروني'},
      {'name': 'ايباد برو', 'price': '280,000', 'image': 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=300', 'tag': 'إلكتروني'},
      {'name': 'كاميرا كانون', 'price': '120,000', 'image': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=300', 'tag': 'إلكتروني'},
      {'name': 'سماعات سوني', 'price': '35,000', 'image': 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=300', 'tag': 'إلكتروني'},
      {'name': 'لابتوب ديل XPS', 'price': '350,000', 'image': 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=300', 'tag': 'إلكتروني'},
    ],
    'fashion': [
      {'name': 'ثوب يمني فاخر', 'price': '35,000', 'image': 'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=300', 'tag': 'أزياء'},
      {'name': 'معطف شتوي', 'price': '25,000', 'image': 'https://images.unsplash.com/photo-1539533113208-f6df8cc8b543?w=300', 'tag': 'أزياء'},
      {'name': 'عباية نسائية', 'price': '30,000', 'image': 'https://images.unsplash.com/photo-1583394293214-ff7b3f5ad7cc?w=300', 'tag': 'أزياء'},
      {'name': 'حذاء رياضي', 'price': '15,000', 'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300', 'tag': 'أزياء'},
      {'name': 'شنطة يد', 'price': '25,000', 'image': 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=300', 'tag': 'أزياء'},
      {'name': 'ساعة رجالية', 'price': '45,000', 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=300', 'tag': 'أزياء'},
      {'name': 'نظارة شمسية', 'price': '8,000', 'image': 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=300', 'tag': 'أزياء'},
      {'name': 'ربطة عنق', 'price': '3,000', 'image': 'https://images.unsplash.com/photo-1589756823695-278bc923f962?w=300', 'tag': 'أزياء'},
      {'name': 'قميص رسمي', 'price': '12,000', 'image': 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=300', 'tag': 'أزياء'},
      {'name': 'بنطلون جينز', 'price': '10,000', 'image': 'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=300', 'tag': 'أزياء'},
    ],
    'furniture': [
      {'name': 'كنبة زاوية', 'price': '150,000', 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=300', 'tag': 'أثاث'},
      {'name': 'طاولة طعام', 'price': '75,000', 'image': 'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?w=300', 'tag': 'أثاث'},
      {'name': 'سرير مفرد', 'price': '60,000', 'image': 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=300', 'tag': 'أثاث'},
      {'name': 'خزانة ملابس', 'price': '80,000', 'image': 'https://images.unsplash.com/photo-1595428774223-ef52624120d2?w=300', 'tag': 'أثاث'},
      {'name': 'مكتب كمبيوتر', 'price': '35,000', 'image': 'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=300', 'tag': 'أثاث'},
      {'name': 'كرسي مكتب', 'price': '20,000', 'image': 'https://images.unsplash.com/photo-1505843490538-5133c6c7d0e1?w=300', 'tag': 'أثاث'},
      {'name': 'سجادة صلاة', 'price': '5,000', 'image': 'https://images.unsplash.com/photo-1581539250439-c96689b516dd?w=300', 'tag': 'أثاث'},
      {'name': 'ستائر', 'price': '15,000', 'image': 'https://images.unsplash.com/photo-1509644056419-6e2b3f9ee1de?w=300', 'tag': 'أثاث'},
      {'name': 'إضاءة LED', 'price': '8,000', 'image': 'https://images.unsplash.com/photo-1565814636199-ae8133055c1c?w=300', 'tag': 'أثاث'},
      {'name': 'مرآة حائط', 'price': '12,000', 'image': 'https://images.unsplash.com/photo-1618220179428-22790b461013?w=300', 'tag': 'أثاث'},
    ],
    'services': [
      {'name': 'تنسيق حفلات زفاف', 'price': '150,000', 'image': 'https://images.unsplash.com/photo-1519225421980-715cb0215aed?w=300', 'tag': 'خدمة'},
      {'name': 'تنظيف منازل شامل', 'price': '35,000', 'image': 'https://images.unsplash.com/photo-1563453392212-326f5e854473?w=300', 'tag': 'خدمة'},
      {'name': 'تصميم داخلي فاخر', 'price': '200,000', 'image': 'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?w=300', 'tag': 'خدمة'},
      {'name': 'صيانة مكيفات', 'price': '15,000', 'image': 'https://images.unsplash.com/photo-1633608607992-28810f6df2db?w=300', 'tag': 'خدمة'},
      {'name': 'نقل أثاث', 'price': '20,000', 'image': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=300', 'tag': 'خدمة'},
      {'name': 'تصليح كهرباء', 'price': '10,000', 'image': 'https://images.unsplash.com/photo-1581147036323-c68037e363f7?w=300', 'tag': 'خدمة'},
      {'name': 'تركيب كاميرات', 'price': '25,000', 'image': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=300', 'tag': 'خدمة'},
      {'name': 'دروس خصوصية', 'price': '8,000', 'image': 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=300', 'tag': 'خدمة'},
      {'name': 'تصوير فوتوغرافي', 'price': '30,000', 'image': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=300', 'tag': 'خدمة'},
      {'name': 'تطبيقات وبرمجة', 'price': '100,000', 'image': 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=300', 'tag': 'خدمة'},
    ],
  };

  final List<Map<String, dynamic>> _mainCategories = [
    {'id': 'real_estate', 'name': 'عقارات', 'icon': Icons.house, 'color': 0xFF2196F3},
    {'id': 'cars', 'name': 'سيارات', 'icon': Icons.directions_car, 'color': 0xFF4CAF50},
    {'id': 'electronics', 'name': 'إلكترونيات', 'icon': Icons.electrical_services, 'color': 0xFF9C27B0},
    {'id': 'fashion', 'name': 'أزياء', 'icon': Icons.checkroom, 'color': 0xFFE91E63},
    {'id': 'furniture', 'name': 'أثاث', 'icon': Icons.weekend, 'color': 0xFF795548},
    {'id': 'services', 'name': 'خدمات', 'icon': Icons.build, 'color': 0xFF607D8B},
    {'id': 'restaurants', 'name': 'مطاعم', 'icon': Icons.restaurant, 'color': 0xFFF44336},
  ];

  @override
  void initState() {
    super.initState();
    // بدء التشغيل التلقائي للسلايدر
    Future.delayed(Duration.zero, () {
      _startAutoPlay();
    });
  }

  void _startAutoPlay() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _currentCarouselIndex = (_currentCarouselIndex + 1) % _carouselItems.length;
        });
        _startAutoPlay();
      }
    });
  }

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
            _buildSectionHeader('الأقسام الرئيسية', ''),
            _buildMainCategories(),
            const SizedBox(height: 24),
            _buildSectionHeader('مطاعم وأكلات شهية', 'عرض الكل'),
            _buildCategoryProducts('restaurants', 'مطاعم'),
            const SizedBox(height: 24),
            _buildSectionHeader('عقارات فاخرة', 'عرض الكل'),
            _buildCategoryProducts('real_estate', 'عقارات'),
            const SizedBox(height: 24),
            _buildSectionHeader('سيارات جديدة', 'عرض الكل'),
            _buildCategoryProducts('cars', 'سيارات'),
            const SizedBox(height: 24),
            _buildSectionHeader('إلكترونيات', 'عرض الكل'),
            _buildCategoryProducts('electronics', 'إلكترونيات'),
            const SizedBox(height: 24),
            _buildSectionHeader('أزياء وموضة', 'عرض الكل'),
            _buildCategoryProducts('fashion', 'أزياء'),
            const SizedBox(height: 24),
            _buildSectionHeader('أثاث منزلي', 'عرض الكل'),
            _buildCategoryProducts('furniture', 'أثاث'),
            const SizedBox(height: 24),
            _buildSectionHeader('خدمات منزلية', 'عرض الكل'),
            _buildCategoryProducts('services', 'خدمات'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            itemCount: _carouselItems.length,
            onPageChanged: (index, reason) {
              setState(() {
                _currentCarouselIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final item = _carouselItems[index];
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
                  margin: const EdgeInsets.symmetric(horizontal: 8),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(item['icon'], size: 14, color: Colors.white),
                                const SizedBox(width: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              item['subtitle'],
                              style: const TextStyle(color: Colors.white70, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _carouselItems.asMap().entries.map((entry) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentCarouselIndex == entry.key
                    ? AppTheme.goldColor
                    : Colors.grey.withOpacity(0.5),
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

  Widget _buildMainCategories() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _mainCategories.length,
        itemBuilder: (context, index) {
          final category = _mainCategories[index];
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
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(category['color']).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(category['icon'], color: Color(category['color']), size: 30),
                  ),
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

  Widget _buildCategoryProducts(String categoryId, String categoryName) {
    final products = _productsByCategory[categoryId] ?? [];
    
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryProductsScreen(
                    categoryId: categoryId,
                    categoryName: categoryName,
                  ),
                ),
              );
            },
            child: Container(
              width: 150,
              margin: const EdgeInsets.symmetric(horizontal: 4),
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
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 120,
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
                              color: AppTheme.goldColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              product['tag'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
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
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${product['price']} ريال',
                          style: TextStyle(
                            color: AppTheme.goldColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
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
    );
  }
}
