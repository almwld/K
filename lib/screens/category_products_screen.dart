import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'product_detail_screen.dart';

// ============================================
// المنتجات الافتراضية لجميع الفئات الـ 52
// ============================================
final Map<String, List<Map<String, dynamic>>> defaultProducts = {
  // الزراعة
  'agriculture': [
    {'id': 'ag1', 'name': 'سماد عضوي', 'price': 2500, 'image': 'https://images.unsplash.com/photo-1625246333195-78d9c38ad449?w=300', 'description': 'سماد طبيعي 10 كجم'},
    {'id': 'ag2', 'name': 'بذور قمح', 'price': 1500, 'image': 'https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=300', 'description': 'بذور قمح عالية الجودة'},
    {'id': 'ag3', 'name': 'مبيد حشري', 'price': 3500, 'image': 'https://images.unsplash.com/photo-1585320806297-9794b3e4eeae?w=300', 'description': 'مبيد آمن وفعال'},
  ],
  // الإلكترونيات
  'electronics': [
    {'id': 'el1', 'name': 'iPhone 15 Pro', 'price': 350000, 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=300', 'description': 'أحدث إصدار من آيفون'},
    {'id': 'el2', 'name': 'Samsung S24', 'price': 320000, 'image': 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=300', 'description': 'كاميرا 200 ميجابكسل'},
    {'id': 'el3', 'name': 'MacBook Pro', 'price': 850000, 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=300', 'description': 'M3 Max chip'},
    {'id': 'el4', 'name': 'iPad Pro', 'price': 250000, 'image': 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=300', 'description': 'شاشة 12.9 بوصة'},
  ],
  // السيارات
  'cars': [
    {'id': 'car1', 'name': 'تويوتا كامري 2024', 'price': 8500000, 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=300', 'description': 'فل كامل'},
    {'id': 'car2', 'name': 'هونداي النترا 2024', 'price': 5500000, 'image': 'https://images.unsplash.com/photo-1568605117036-5fe5e7fa0ac7?w=300', 'description': 'مواصفات عالية'},
    {'id': 'car3', 'name': 'مرسيدس E-Class', 'price': 18500000, 'image': 'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=300', 'description': 'فاخرة'},
  ],
  // العقارات
  'realestate': [
    {'id': 're1', 'name': 'فيلا في صنعاء', 'price': 45000000, 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=300', 'description': '250 متر - 5 غرف'},
    {'id': 're2', 'name': 'شقة في عدن', 'price': 25000000, 'image': 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=300', 'description': '3 غرف - مطلة على البحر'},
    {'id': 're3', 'name': 'أرض في تعز', 'price': 12000000, 'image': 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=300', 'description': '500 متر - سكني'},
  ],
  // الأزياء
  'fashion': [
    {'id': 'fa1', 'name': 'ثوب يمني', 'price': 25000, 'image': 'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=300', 'description': 'قماش فاخر - تطريز يدوي'},
    {'id': 'fa2', 'name': 'معطف رجالي', 'price': 35000, 'image': 'https://images.unsplash.com/photo-1539533113208-f6df8cc8b543?w=300', 'description': 'شتوي - صوف طبيعي'},
    {'id': 'fa3', 'name': 'عباية نسائية', 'price': 30000, 'image': 'https://images.unsplash.com/photo-1583394293214-ff7b3f5ad7cc?w=300', 'description': 'تطريز فاخر'},
  ],
  // الأثاث
  'furniture': [
    {'id': 'fur1', 'name': 'كنبة زاوية', 'price': 150000, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=300', 'description': 'مخمل فاخر'},
    {'id': 'fur2', 'name': 'طاولة طعام', 'price': 75000, 'image': 'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?w=300', 'description': 'خشب زان - 6 كراسي'},
  ],
  // المطاعم
  'restaurants': [
    {'id': 'res1', 'name': 'وجبة مندي', 'price': 3500, 'image': 'https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?w=300', 'description': 'لحم ضأن - أرز'},
    {'id': 'res2', 'name': 'مقلقل', 'price': 2500, 'image': 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=300', 'description': 'دجاج - بهارات يمنية'},
  ],
  // العطور
  'perfumes': [
    {'id': 'per1', 'name': 'عود ملكي', 'price': 45000, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=300', 'description': 'عطر شرقي فاخر'},
    {'id': 'per2', 'name': 'مسك أبيض', 'price': 25000, 'image': 'https://images.unsplash.com/photo-1541643600914-78b084683601?w=300', 'description': 'عبير ثابت'},
  ],
  // الجوالات
  'phones': [
    {'id': 'ph1', 'name': 'iPhone 15', 'price': 300000, 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=300', 'description': 'A16 Bionic'},
    {'id': 'ph2', 'name': 'Samsung A54', 'price': 120000, 'image': 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=300', 'description': 'كاميرا 50MP'},
  ],
  // الكمبيوترات
  'laptops': [
    {'id': 'lap1', 'name': 'MacBook Air', 'price': 450000, 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=300', 'description': 'M2 - 8GB RAM'},
    {'id': 'lap2', 'name': 'Dell XPS', 'price': 350000, 'image': 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=300', 'description': 'Intel i7 - 16GB'},
  ],
  // الشاشات
  'tv': [
    {'id': 'tv1', 'name': 'Samsung 65"', 'price': 250000, 'image': 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=300', 'description': '4K UHD - ذكي'},
    {'id': 'tv2', 'name': 'LG 55"', 'price': 180000, 'image': 'https://images.unsplash.com/photo-1593784991095-a205069470b6?w=300', 'description': 'OLED - 4K'},
  ],
  // الأجهزة المنزلية
  'home_appliances': [
    {'id': 'ha1', 'name': 'ثلاجة 18 قدم', 'price': 150000, 'image': 'https://images.unsplash.com/photo-1586008214976-3d9d6c5f2e5d?w=300', 'description': 'موفرة للطاقة'},
    {'id': 'ha2', 'name': 'غسالة أوتوماتيك', 'price': 85000, 'image': 'https://images.unsplash.com/photo-1626806787461-102c1bfaaea1?w=300', 'description': '10 كجم - تنشيف'},
  ],
  // الرياضة
  'sports': [
    {'id': 'sp1', 'name': 'حذاء رياضي', 'price': 15000, 'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300', 'description': 'مقاسات مختلفة'},
    {'id': 'sp2', 'name': 'قميص نادي', 'price': 8000, 'image': 'https://images.unsplash.com/photo-1577223625816-7546f13df25d?w=300', 'description': 'أصلي'},
  ],
  // الجمال
  'beauty': [
    {'id': 'be1', 'name': 'طقم مكياج', 'price': 25000, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300', 'description': '12 قطعة'},
    {'id': 'be2', 'name': 'كريم عناية', 'price': 8000, 'image': 'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=300', 'description': 'ترطيب عميق'},
  ],
  // الكتب
  'books': [
    {'id': 'bo1', 'name': 'رواية', 'price': 5000, 'image': 'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=300', 'description': 'أدب عربي'},
    {'id': 'bo2', 'name': 'كتاب ديني', 'price': 8000, 'image': 'https://images.unsplash.com/photo-1589998059171-988d887df646?w=300', 'description': 'تفسير'},
  ],
  // الساعات
  'watches': [
    {'id': 'wa1', 'name': 'ساعة رجالية', 'price': 45000, 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=300', 'description': 'ستيل - كوارتز'},
    {'id': 'wa2', 'name': 'ساعة ذكية', 'price': 35000, 'image': 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=300', 'description': 'Apple Watch'},
  ],
  // الحقائب
  'bags': [
    {'id': 'bag1', 'name': 'شنطة يد', 'price': 25000, 'image': 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=300', 'description': 'جلد طبيعي'},
    {'id': 'bag2', 'name': 'شنطة سفر', 'price': 35000, 'image': 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=300', 'description': 'مقوى'},
  ],
  // الأحذية
  'shoes': [
    {'id': 'sh1', 'name': 'حذاء رسمي', 'price': 20000, 'image': 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=300', 'description': 'جلد - لون أسود'},
    {'id': 'sh2', 'name': 'صندل', 'price': 8000, 'image': 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?w=300', 'description': 'مريح'},
  ],
  // العسل
  'honey': [
    {'id': 'hon1', 'name': 'عسل سدر', 'price': 15000, 'image': 'https://images.unsplash.com/photo-1587049352847-4a222e784d33?w=300', 'description': '1 كجم - طبيعي'},
    {'id': 'hon2', 'name': 'عسل جبلي', 'price': 20000, 'image': 'https://images.unsplash.com/photo-1587049352851-8d86e5db9d3b?w=300', 'description': 'نقي 100%'},
  ],
  // البخور
  'incense': [
    {'id': 'inc1', 'name': 'عود كمبودي', 'price': 35000, 'image': 'https://images.unsplash.com/photo-1583422409519-37f2e1de7ec9?w=300', 'description': 'درجة أولى'},
    {'id': 'inc2', 'name': 'بحريني', 'price': 25000, 'image': 'https://images.unsplash.com/photo-1600851616325-3f8c0d3e6b6a?w=300', 'description': 'فاخر'},
  ],
  // السجاد
  'carpets': [
    {'id': 'car1', 'name': 'سجاد إيراني', 'price': 120000, 'image': 'https://images.unsplash.com/photo-1581539250439-c96689b516dd?w=300', 'description': 'حرير - يدوي'},
    {'id': 'car2', 'name': 'موكيت', 'price': 45000, 'image': 'https://images.unsplash.com/photo-1581539250439-c96689b516dd?w=300', 'description': 'مقاس 3×4'},
  ],
};

class CategoryProductsScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  const CategoryProductsScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  List<Map<String, dynamic>> get _products {
    return defaultProducts[categoryId] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final products = _products;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(title: categoryName),
      body: products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.category,
                    size: 80,
                    color: AppTheme.goldColor.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    categoryName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'سيتم إضافة منتجات هذا القسم قريباً',
                    style: TextStyle(
                      color: AppTheme.getSecondaryTextColor(context),
                    ),
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
                        builder: (_) => ProductDetailScreen(
                          productId: product['id'],
                          productName: product['name'],
                          productPrice: product['price'],
                          productImage: product['image'],
                          productDescription: product['description'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.getCardColor(context),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            product['image'],
                            height: 130,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              height: 130,
                              color: Colors.grey[300],
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.grey[600],
                              ),
                            ),
                            loadingBuilder: (_, child, progress) {
                              if (progress == null) return child;
                              return Container(
                                height: 130,
                                color: AppTheme.goldColor.withOpacity(0.1),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            },
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
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${product['price']} ر.ي',
                                style: TextStyle(
                                  color: AppTheme.goldColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
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
