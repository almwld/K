import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../theme/app_theme.dart';
import '../../utils/navigation_extensions.dart';
import '../../models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _carouselIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  // صور احترافية من Unsplash
  static const String _electronicsImage = 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=600';
  static const String _fashionImage = 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=600';
  static const String _carsImage = 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=600';
  static const String _realEstateImage = 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=600';
  static const String _foodImage = 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600';
  static const String _storeImage = 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=600';
  static const String _productImage = 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600';

  // بيانات السلايدر
  final List<Map<String, dynamic>> _carouselItems = [
    {
      'title': 'عرض خاص',
      'subtitle': 'خصم 50% على الإلكترونيات',
      'color': const Color(0xFFF0B90B),
      'image': _electronicsImage,
    },
    {
      'title': 'عروض البرق',
      'subtitle': 'لفترة محدودة',
      'color': const Color(0xFF0ECB81),
      'image': _fashionImage,
    },
    {
      'title': 'عرض VIP',
      'subtitle': 'خصم 25% للأعضاء',
      'color': const Color(0xFF2196F3),
      'image': _carsImage,
    },
    {
      'title': 'سيارات جديدة',
      'subtitle': 'أحدث الموديلات',
      'color': const Color(0xFFFF9800),
      'image': _realEstateImage,
    },
  ];

  // بيانات المتابعات
  final List<Map<String, dynamic>> _followings = [
    {'name': 'متجر التقنية', 'update': 'منتج جديد', 'time': 'قبل ساعة', 'image': _electronicsImage},
    {'name': 'مطعم فلكس', 'update': 'عرض خاص', 'time': 'اليوم', 'image': _foodImage},
    {'name': 'أزياء فلكس', 'update': 'تخفيضات', 'time': 'الأسبوع', 'image': _fashionImage},
    {'name': 'متجر الذهبية', 'update': 'خصم 30%', 'time': 'أمس', 'image': _storeImage},
  ];

  // بيانات المتاجر المميزة
  final List<Map<String, dynamic>> _featuredStores = [
    {'name': 'متجر التقنية', 'category': 'إلكترونيات', 'rating': 4.8, 'isOpen': true, 'image': _electronicsImage},
    {'name': 'متجر كابيس', 'category': 'مطاعم', 'rating': 4.7, 'isOpen': true, 'image': _foodImage},
    {'name': 'متجر الذهبية', 'category': 'أزياء', 'rating': 4.9, 'isOpen': false, 'image': _fashionImage},
  ];

  // بيانات الأماكن القريبة
  final List<Map<String, dynamic>> _nearby = [
    {'name': 'متجر الذهبية', 'distance': '0.3 كم', 'rating': 4.5, 'image': _fashionImage},
    {'name': 'متجر الكس', 'distance': '0.8 كم', 'rating': 4.8, 'image': _storeImage},
    {'name': 'متجر السيم', 'distance': '1.2 كم', 'rating': 4.3, 'image': _electronicsImage},
    {'name': 'مطعم النور', 'distance': '0.5 كم', 'rating': 4.6, 'image': _foodImage},
  ];

  // بيانات الأسواق
  final List<Map<String, dynamic>> _markets = [
    {'name': 'السوق اليمني', 'change': '+2.5%', 'volume': '1.2M', 'items': 1250, 'isUp': true},
    {'name': 'المولات', 'change': '+1.8%', 'volume': '890K', 'items': 450, 'isUp': true},
    {'name': 'المقاهي', 'change': '+3.2%', 'volume': '567K', 'items': 320, 'isUp': true},
    {'name': 'الفنادق', 'change': '-0.5%', 'volume': '456K', 'items': 95, 'isUp': false},
  ];

  // بيانات المنتجات الموصى بها
  final List<ProductModel> _recommendedProducts = sampleProducts.take(4).toList();

  // شيمر للتحميل
  Widget _buildShimmer({double? width, double? height, BorderRadius? borderRadius}) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF2A3A54),
      highlightColor: const Color(0xFF3A4A64),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }

  // صورة مع شيمر
  Widget _buildCachedImage(String url, {double? width, double? height, BoxFit fit = BoxFit.cover, BorderRadius? borderRadius}) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => _buildShimmer(width: width, height: height, borderRadius: borderRadius),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFF1E2329),
          borderRadius: borderRadius,
        ),
        child: const Icon(Icons.image_not_supported, color: Colors.grey),
      ),
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: DecorationImage(image: imageProvider, fit: fit),
        ),
      ),
    );
  }

  void _navigateTo(String route) {
    // التنقل للشاشات
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      body: CustomScrollView(
        slivers: [
          // AppBar
          SliverToBoxAdapter(child: _buildAppBar()),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // بطاقة الإحصائيات
          SliverToBoxAdapter(child: _buildStatsCard()),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // سلايدر العروض
          SliverToBoxAdapter(child: _buildPromoSlider()),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // الإجراءات السريعة
          SliverToBoxAdapter(child: _buildQuickActions()),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // متابعاتك
          SliverToBoxAdapter(child: _buildSectionHeader('متابعاتك')),
          SliverToBoxAdapter(child: _buildFollowingsList()),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // محتوى يعجبك
          SliverToBoxAdapter(child: _buildSectionHeader('محتوى يعجبك')),
          SliverToBoxAdapter(child: _buildForYouList()),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // متاجر مميزة
          SliverToBoxAdapter(child: _buildSectionHeader('متاجر مميزة')),
          SliverToBoxAdapter(child: _buildFeaturedStores()),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // العروض الرائجة
          SliverToBoxAdapter(child: _buildSectionHeader('العروض الرائجة')),
          SliverToBoxAdapter(child: _buildTrendingOffers()),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // موصى به لك
          SliverToBoxAdapter(child: _buildSectionHeader('موصى به لك')),
          SliverToBoxAdapter(child: _buildRecommendedProducts()),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // الأسواق الرائجة
          SliverToBoxAdapter(child: _buildSectionHeader('الأسواق الرائجة')),
          SliverToBoxAdapter(child: _buildMarketsList()),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // بالقرب منك
          SliverToBoxAdapter(child: _buildSectionHeader('بالقرب منك')),
          SliverToBoxAdapter(child: _buildNearbyGrid()),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFF0B90B), width: 2),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFD4AF37), Color(0xFFB8962E)],
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.person, color: Colors.white, size: 28),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'مرحباً، أحمد',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Changa'),
                  ),
                  Text(
                    'مرحباً بعودتك',
                    style: TextStyle(color: const Color(0xFFF0B90B), fontSize: 12, fontFamily: 'Changa'),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              _buildIconButton(SvgPicture.asset("assets/icons/svg/search.svg", width: 24, height: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn))),
              const SizedBox(width: 8),
              _buildIconButton(SvgPicture.asset("assets/icons/svg/notification.svg", width: 24, height: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn))),
              const SizedBox(width: 8),
              _buildIconButton(Icons.qr_code_scanner),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2329),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: const Color(0xFFF0B90B), size: 20),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF1E2329), const Color(0xFF0B0E11)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF2B3139)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('إجمالي المبيعات (شهري)', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12, fontFamily: 'Changa')),
              Icon(Icons.more_horiz, color: const Color(0xFFF0B90B), size: 20),
            ],
          ),
          const SizedBox(height: 8),
          const Text('1,234,567', style: TextStyle(color: Color(0xFFF0B90B), fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Changa')),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF0ECB81).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.trending_up, color: Color(0xFF0ECB81), size: 14),
                const SizedBox(width: 4),
                const Text('+12.5%', style: TextStyle(color: Color(0xFF0ECB81), fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Changa')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoSlider() {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _carouselItems.length,
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 160,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) => setState(() => _carouselIndex = index),
          ),
          itemBuilder: (context, index, realIndex) {
            final item = _carouselItems[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: _buildCachedImage(
                      item['image'] as String,
                      height: 160,
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 20,
                    child: Text(
                      item['title'] as String,
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Changa'),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 55,
                    child: Text(
                      item['subtitle'] as String,
                      style: const TextStyle(color: Colors.white70, fontSize: 12, fontFamily: 'Changa'),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0B90B),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('تسوق الآن', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Changa')),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        AnimatedSmoothIndicator(
          activeIndex: _carouselIndex,
          count: _carouselItems.length,
          effect: ExpandingDotsEffect(
            activeDotColor: const Color(0xFFF0B90B),
            dotColor: const Color(0xFF2B3139),
            dotHeight: 8,
            dotWidth: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {'icon': Icons.category, 'label': 'فئات'},
      {'icon': Icons.store, 'label': 'أسواق'},
      {'icon': Icons.gavel, 'label': 'مزادات'},
      {'icon': Icons.local_offer, 'label': 'عروض'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: actions.map((action) {
          return Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2329),
                  shape: BoxShape.circle,
                ),
                child: Icon(action['icon'] as IconData, color: const Color(0xFFF0B90B), size: 28),
              ),
              const SizedBox(height: 8),
              Text(action['label'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12, fontFamily: 'Changa')),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Changa')),
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text('عرض الكل', style: TextStyle(color: const Color(0xFFF0B90B), fontSize: 12, fontFamily: 'Changa')),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios, color: const Color(0xFFF0B90B), size: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFollowingsList() {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _followings.length,
        itemBuilder: (context, index) {
          final item = _followings[index];
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2329),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2B3139)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _buildCachedImage(item['image'] as String, width: 40, height: 40),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(item['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Changa')),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(item['update'] as String, style: TextStyle(color: const Color(0xFFF0B90B), fontSize: 11, fontFamily: 'Changa')),
                Text(item['time'] as String, style: const TextStyle(color: Color(0xFF5E6673), fontSize: 10, fontFamily: 'Changa')),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildForYouList() {
    final products = sampleProducts.take(3).toList();
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () => product.navigateToDetail(context),
            child: Container(
              width: 200,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2329),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2B3139)),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: _buildCachedImage(
                      product.images.isNotEmpty ? product.images[0] : _productImage,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(product.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Changa'), maxLines: 1),
                        Text(product.formattedPrice, style: TextStyle(color: const Color(0xFFF0B90B), fontWeight: FontWeight.bold, fontFamily: 'Changa')),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 12),
                            const SizedBox(width: 2),
                            Text('${product.rating}', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10, fontFamily: 'Changa')),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0B90B).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.add_shopping_cart, color: Color(0xFFF0B90B), size: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedStores() {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _featuredStores.length,
        itemBuilder: (context, index) {
          final item = _featuredStores[index];
          return Container(
            width: 160,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2329),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2B3139)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _buildCachedImage(item['image'] as String, width: 35, height: 35),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(item['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, fontFamily: 'Changa')),
                    ),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (item['isOpen'] as bool) ? const Color(0xFF0ECB81) : const Color(0xFFF6465D),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(item['category'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10, fontFamily: 'Changa')),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 12),
                    const SizedBox(width: 2),
                    Text('${item['rating']}', style: const TextStyle(color: Colors.white, fontSize: 11, fontFamily: 'Changa')),
                    const Spacer(),
                    Text(
                      (item['isOpen'] as bool) ? 'مفتوح' : 'مغلق',
                      style: TextStyle(
                        color: (item['isOpen'] as bool) ? const Color(0xFF0ECB81) : const Color(0xFFF6465D),
                        fontSize: 10,
                        fontFamily: 'Changa',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrendingOffers() {
    final products = sampleProducts.take(3).toList();
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final discount = [50, 30, 40][index];
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2329),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2B3139)),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6465D),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('- $discount%', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Changa')),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: _buildCachedImage(
                        product.images.isNotEmpty ? product.images[0] : _productImage,
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Text(product.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, fontFamily: 'Changa'), maxLines: 1),
                      const SizedBox(height: 2),
                      Text(product.formattedPrice, style: TextStyle(color: const Color(0xFFF0B90B), fontWeight: FontWeight.bold, fontSize: 12, fontFamily: 'Changa')),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecommendedProducts() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _recommendedProducts.length,
        itemBuilder: (context, index) {
          final product = _recommendedProducts[index];
          return GestureDetector(
            onTap: () => product.navigateToDetail(context),
            child: Container(
              width: 150,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2329),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2B3139)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: _buildCachedImage(
                      product.images.isNotEmpty ? product.images[0] : _productImage,
                      height: 100,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12, fontFamily: 'Changa'), maxLines: 1),
                        const SizedBox(height: 2),
                        Text(product.formattedPrice, style: TextStyle(color: const Color(0xFFF0B90B), fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'Changa')),
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

  Widget _buildMarketsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: _markets.map((market) {
          final isUp = market['isUp'] as bool;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2329),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF2B3139)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(market['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13, fontFamily: 'Changa')),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: isUp ? const Color(0xFF0ECB81).withOpacity(0.1) : const Color(0xFFF6465D).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(isUp ? Icons.trending_up : Icons.trending_down, color: isUp ? const Color(0xFF0ECB81) : const Color(0xFFF6465D), size: 10),
                        const SizedBox(width: 2),
                        Text(market['change'] as String, style: TextStyle(color: isUp ? const Color(0xFF0ECB81) : const Color(0xFFF6465D), fontSize: 10, fontFamily: 'Changa')),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(market['volume'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11, fontFamily: 'Changa'), textAlign: TextAlign.end),
                ),
                Expanded(
                  flex: 1,
                  child: Text('${market['items']}', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 11, fontFamily: 'Changa'), textAlign: TextAlign.end),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNearbyGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _nearby.length,
        itemBuilder: (context, index) {
          final item = _nearby[index];
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2329),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2B3139)),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: _buildCachedImage(item['image'] as String, width: 40, height: 40),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(item['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12, fontFamily: 'Changa'), maxLines: 1),
                      Row(
                        children: [
                          Text(item['distance'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10, fontFamily: 'Changa')),
                          const SizedBox(width: 8),
                          const Icon(Icons.star, size: 10, color: Colors.amber),
                          const SizedBox(width: 2),
                          Text('${item['rating']}', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10, fontFamily: 'Changa')),
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
    );
  }
}
