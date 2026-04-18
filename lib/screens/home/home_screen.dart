import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../all_ads_screen.dart';
import '../cart/cart_screen.dart';
import '../notifications_screen.dart';
import '../product_detail_screen.dart';
import '../login_screen.dart';
import '../register_screen.dart';
import '../../models/cart_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentCarouselIndex = 0;
  
  final List<Map<String, dynamic>> _carouselItems = [
    {'image': 'https://via.placeholder.com/400x200/0F172A/D4AF37?text=خصم+40%25+إلكترونيات', 'title': 'خصم 40% على الإلكترونيات', 'badge': 'عرض محدود'},
    {'image': 'https://via.placeholder.com/400x200/16213E/D4AF37?text=مزداد+الجنابي', 'title': 'أكبر مزداد للسيوف التراثية', 'badge': 'شارك الآن'},
    {'image': 'https://via.placeholder.com/400x200/1A2A44/D4AF37?text=عروض+رمضان', 'title': 'عروض رمضان الخاصة', 'badge': 'خصم 30%'},
  ];

  final List<Map<String, dynamic>> _categories = [
    {'name': 'أزياء', 'icon': Icons.checkroom, 'color': Colors.pink},
    {'name': 'إلكترونيات', 'icon': Icons.phone_android, 'color': Colors.blue},
    {'name': 'سيارات', 'icon': Icons.directions_car, 'color': Colors.red},
    {'name': 'عقارات', 'icon': Icons.home, 'color': Colors.green},
    {'name': 'أثاث', 'icon': Icons.chair, 'color': Colors.orange},
    {'name': 'خدمات', 'icon': Icons.handyman, 'color': Colors.purple},
  ];

  final List<Map<String, dynamic>> _featuredProducts = [
    {'id': '1', 'name': 'ايفون 15 برو', 'price': 4500.0, 'oldPrice': 5000.0, 'image': 'https://via.placeholder.com/200?text=iPhone', 'rating': 4.8, 'inStock': true},
    {'id': '2', 'name': 'ساعة ذكية', 'price': 1200.0, 'oldPrice': 1500.0, 'image': 'https://via.placeholder.com/200?text=Watch', 'rating': 4.5, 'inStock': true},
    {'id': '3', 'name': 'سماعات لاسلكية', 'price': 350.0, 'image': 'https://via.placeholder.com/200?text=Headphones', 'rating': 4.3, 'inStock': true},
    {'id': '4', 'name': 'حقيبة يد', 'price': 250.0, 'image': 'https://via.placeholder.com/200?text=Bag', 'rating': 4.6, 'inStock': true},
  ];

  bool get _isLoggedIn => Supabase.instance.client.auth.currentUser != null;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: AppBar(
        title: Row(
          children: [
            const Text('FLEX', style: TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold, color: AppTheme.gold, fontSize: 24)),
            const SizedBox(width: 4),
            Text('YEMEN', style: TextStyle(fontFamily: 'Changa', fontSize: 14, color: AppTheme.goldLight)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => themeManager.toggleTheme(),
            icon: Icon(themeManager.isDarkMode ? Icons.light_mode : Icons.dark_mode, color: Colors.white),
          ),
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
          ),
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // شريط البحث
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.nightCard : AppTheme.lightCard,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'ابحث عن المنتجات...',
                    hintStyle: const TextStyle(fontFamily: 'Changa'),
                    prefixIcon: const Icon(Icons.search, color: AppTheme.gold),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
            ),
            
            // Carousel
            SizedBox(
              height: 200,
              child: PageView.builder(
                onPageChanged: (index) => setState(() => _currentCarouselIndex = index),
                itemCount: _carouselItems.length,
                itemBuilder: (context, index) {
                  final item = _carouselItems[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
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
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.gold,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              item['badge'],
                              style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Changa'),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item['title'],
                            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Changa'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // مؤشرات Carousel
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _carouselItems.asMap().entries.map((e) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentCarouselIndex == e.key ? AppTheme.gold : Colors.grey.withOpacity(0.5),
                  ),
                );
              }).toList(),
            ),
            
            // ✅ أزرار تسجيل الدخول وإنشاء حساب (تظهر فقط للمستخدمين غير المسجلين)
            if (!_isLoggedIn)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.gold,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'تسجيل الدخول',
                          style: TextStyle(fontFamily: 'Changa', fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const RegisterScreen()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppTheme.gold, width: 2),
                          foregroundColor: AppTheme.gold,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'إنشاء حساب',
                          style: TextStyle(fontFamily: 'Changa', fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            
            // رسالة ترحيب للمستخدم المسجل
            if (_isLoggedIn)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: AppTheme.goldGradient,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.waving_hand, color: Colors.black),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'مرحباً بعودتك! استمتع بالتسوق 🛍️',
                          style: const TextStyle(fontFamily: 'Changa', fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            
            // الفئات
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('الأقسام الرئيسية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Changa')),
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AllAdsScreen())),
                    child: Text('عرض الكل', style: TextStyle(color: AppTheme.gold, fontFamily: 'Changa')),
                  ),
                ],
              ),
            ),
            
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: cat['color'].withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(cat['icon'], color: cat['color']),
                          ),
                          const SizedBox(height: 8),
                          Text(cat['name'], style: const TextStyle(fontSize: 12, fontFamily: 'Changa'), textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // المنتجات المميزة
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('منتجات مميزة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Changa')),
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AllAdsScreen())),
                    child: Text('عرض الكل', style: TextStyle(color: AppTheme.gold, fontFamily: 'Changa')),
                  ),
                ],
              ),
            ),
            
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _featuredProducts.length,
              itemBuilder: (context, index) {
                final product = _featuredProducts[index];
                return _buildProductCard(product, isDark);
              },
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, bool isDark) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
              id: product['id'],
              title: product['name'],
              image: product['image'],
              price: product['price'],
              description: 'وصف المنتج ${product['name']}',
              sellerName: 'متجر Flex',
              rating: product['rating'],
              reviewCount: 120,
              images: [product['image']],
              inStock: product['inStock'],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.nightCard : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(product['image'], height: 130, width: double.infinity, fit: BoxFit.cover),
                ),
                if (product['oldPrice'] != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.error,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'خصم ${(((product['oldPrice'] - product['price']) / product['oldPrice']) * 100).round()}%',
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'Changa'),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Changa', fontSize: 13), maxLines: 1),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      Text(' ${product['rating']}', style: const TextStyle(fontSize: 12, fontFamily: 'Changa')),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text('${product['price']} ر.ي', style: const TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold, fontFamily: 'Changa', fontSize: 14)),
                      if (product['oldPrice'] != null) ...[
                        const SizedBox(width: 6),
                        Text('${product['oldPrice']}', style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey[500], fontSize: 11, fontFamily: 'Changa')),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
