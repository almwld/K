import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'product_detail_screen.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const CategoryProductsScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  List<Map<String, dynamic>> _products = [];
  bool _isLoading = true;

  // منتجات كل قسم (10 منتجات لكل قسم)
  final Map<String, List<Map<String, dynamic>>> _productsByCategory = {
    'restaurants': [
      {'name': 'مندي يمني', 'price': '3,500', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=300', 'description': 'لحم ضأن مع أرز - طعم لا يقاوم'},
      {'name': 'مقلقل دجاج', 'price': '2,500', 'image': 'https://images.unsplash.com/photo-1559847844-5315695dadae?w=300', 'description': 'بهارات يمنية أصلية'},
      {'name': 'فتة يمنية', 'price': '2,000', 'image': 'https://images.unsplash.com/photo-1563379926898-05f4575a45d8?w=300', 'description': 'فتة باللحم والزبادي'},
      {'name': 'شاورما عربية', 'price': '1,500', 'image': 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=300', 'description': 'دجاج ولحم - ساندوتشات شهية'},
      {'name': 'زبيدي مشوي', 'price': '4,000', 'image': 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=300', 'description': 'سمك طازج مع أرز'},
      {'name': 'عصير طبيعي', 'price': '500', 'image': 'https://images.unsplash.com/photo-1600891964092-4316c288032e?w=300', 'description': 'عصائر فواكه طبيعية'},
      {'name': 'كنافة', 'price': '1,000', 'image': 'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?w=300', 'description': 'كنافة بالقشطة'},
      {'name': 'بيتزا إيطالية', 'price': '2,500', 'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=300', 'description': 'بيتزا طازجة بالجبن'},
      {'name': 'برجر لحم', 'price': '1,800', 'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300', 'description': 'برجر طازج مع بطاطس'},
      {'name': 'مقبلات مشكلة', 'price': '1,200', 'image': 'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=300', 'description': 'مقبلات ساخنة متنوعة'},
    ],
    'real_estate': [
      {'name': 'فيلا فاخرة صنعاء', 'price': '45,000,000', 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=300', 'description': '250 متر - 5 غرف - حديقة خاصة'},
      {'name': 'شقة مطلة على البحر', 'price': '25,000,000', 'image': 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=300', 'description': '3 غرف - مطلة على البحر'},
      {'name': 'أرض سكنية تعز', 'price': '12,000,000', 'image': 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=300', 'description': '500 متر - سكني'},
      {'name': 'برج تجاري المكلا', 'price': '120,000,000', 'image': 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=300', 'description': '10 طوابق - موقع مميز'},
      {'name': 'منتجع سياحي سقطرى', 'price': '250,000,000', 'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=300', 'description': 'منتجع فاخر على البحر'},
      {'name': 'شقة 3 غرف عدن', 'price': '18,000,000', 'image': 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=300', 'description': 'موقع ممتاز - تشطيب فاخر'},
      {'name': 'فيلا مسبح الحديدة', 'price': '35,000,000', 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=300', 'description': 'مسبح خاص - حديقة كبيرة'},
      {'name': 'أرض تجارية إب', 'price': '8,000,000', 'image': 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=300', 'description': '300 متر - موقع مميز'},
      {'name': 'مزرعة عنب', 'price': '15,000,000', 'image': 'https://images.unsplash.com/photo-1625246333195-78d9c38ad449?w=300', 'description': 'مزرعة عنب - 10 ألاف متر'},
      {'name': 'قصر فاخر', 'price': '300,000,000', 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=300', 'description': '1000 متر - 10 غرف'},
    ],
    'cars': [
      {'name': 'تويوتا كامري 2024', 'price': '8,500,000', 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=300', 'description': 'فل كامل - 0 كم'},
      {'name': 'مرسيدس S-Class', 'price': '45,000,000', 'image': 'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=300', 'description': 'فاخرة - موديل 2024'},
      {'name': 'بي إم دبليو X6', 'price': '38,000,000', 'image': 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=300', 'description': 'دفع رباعي - فاخر'},
      {'name': 'هونداي النترا', 'price': '5,500,000', 'image': 'https://images.unsplash.com/photo-1568605117036-5fe5e7fa0ac7?w=300', 'description': 'مواصفات عالية'},
      {'name': 'نيسان باترول', 'price': '25,000,000', 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=300', 'description': 'دفع رباعي - 8 ركاب'},
      {'name': 'تيسلا موديل S', 'price': '60,000,000', 'image': 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=300', 'description': 'كهربائية - 600 كم'},
      {'name': 'فورد موستانج', 'price': '30,000,000', 'image': 'https://images.unsplash.com/photo-1584345604476-8ec5e12e42dd?w=300', 'description': 'رياضية - V8'},
      {'name': 'شيفروليه كابتيفا', 'price': '12,000,000', 'image': 'https://images.unsplash.com/photo-1568605117036-5fe5e7fa0ac7?w=300', 'description': 'عائلية - 7 ركاب'},
      {'name': 'هوندا سي آر في', 'price': '15,000,000', 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=300', 'description': 'دفع رباعي صغير'},
      {'name': 'كيا سبورتاج', 'price': '10,000,000', 'image': 'https://images.unsplash.com/photo-1568605117036-5fe5e7fa0ac7?w=300', 'description': 'مواصفات ممتازة'},
    ],
    'electronics': [
      {'name': 'ماك بوك برو M3', 'price': '1,800,000', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=300', 'description': 'M3 Max - 16GB RAM'},
      {'name': 'ايفون 15 برو', 'price': '450,000', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=300', 'description': '256GB - شريحتين'},
      {'name': 'سامسونج اس 24', 'price': '380,000', 'image': 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=300', 'description': '256GB - كاميرا 200MP'},
      {'name': 'شاشة سامسونج 65', 'price': '350,000', 'image': 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=300', 'description': '4K UHD - ذكية'},
      {'name': 'بلاي ستيشن 5', 'price': '250,000', 'image': 'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=300', 'description': 'ديجيتال إديشن'},
      {'name': 'سماعات ايربودز', 'price': '45,000', 'image': 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=300', 'description': 'Pro 2 - عزل ضوضاء'},
      {'name': 'ايباد برو', 'price': '280,000', 'image': 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=300', 'description': '12.9 بوصة - M2'},
      {'name': 'كاميرا كانون', 'price': '120,000', 'image': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=300', 'description': 'EOS R50 - عدسة 18-45'},
      {'name': 'سماعات سوني', 'price': '35,000', 'image': 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=300', 'description': 'لاسلكية - WH-1000XM5'},
      {'name': 'لابتوب ديل XPS', 'price': '350,000', 'image': 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=300', 'description': 'Intel i7 - 16GB RAM'},
    ],
    'fashion': [
      {'name': 'ثوب يمني فاخر', 'price': '35,000', 'image': 'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=300', 'description': 'قماش فاخر - تطريز يدوي'},
      {'name': 'معطف شتوي', 'price': '25,000', 'image': 'https://images.unsplash.com/photo-1539533113208-f6df8cc8b543?w=300', 'description': 'صوف طبيعي - مقاسات'},
      {'name': 'عباية نسائية', 'price': '30,000', 'image': 'https://images.unsplash.com/photo-1583394293214-ff7b3f5ad7cc?w=300', 'description': 'تطريز فاخر - خامة ممتازة'},
      {'name': 'حذاء رياضي', 'price': '15,000', 'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300', 'description': 'مقاسات مختلفة - أصلي'},
      {'name': 'شنطة يد', 'price': '25,000', 'image': 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=300', 'description': 'جلد طبيعي - فاخر'},
      {'name': 'ساعة رجالية', 'price': '45,000', 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=300', 'description': 'ستيل - كوارتز'},
      {'name': 'نظارة شمسية', 'price': '8,000', 'image': 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=300', 'description': 'حماية UV400'},
      {'name': 'ربطة عنق', 'price': '3,000', 'image': 'https://images.unsplash.com/photo-1589756823695-278bc923f962?w=300', 'description': 'حرير - ألوان متعددة'},
      {'name': 'قميص رسمي', 'price': '12,000', 'image': 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=300', 'description': 'قطن - مقاسات'},
      {'name': 'بنطلون جينز', 'price': '10,000', 'image': 'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=300', 'description': 'جينز - مقاسات رجالي'},
    ],
    'furniture': [
      {'name': 'كنبة زاوية', 'price': '150,000', 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=300', 'description': 'مخمل فاخر - لون بيج'},
      {'name': 'طاولة طعام', 'price': '75,000', 'image': 'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?w=300', 'description': 'خشب زان - 6 كراسي'},
      {'name': 'سرير مفرد', 'price': '60,000', 'image': 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=300', 'description': 'خشب - مرتبة طبية'},
      {'name': 'خزانة ملابس', 'price': '80,000', 'image': 'https://images.unsplash.com/photo-1595428774223-ef52624120d2?w=300', 'description': '4 أبواب - مرآة'},
      {'name': 'مكتب كمبيوتر', 'price': '35,000', 'image': 'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=300', 'description': 'مودرن - أدراج'},
      {'name': 'كرسي مكتب', 'price': '20,000', 'image': 'https://images.unsplash.com/photo-1505843490538-5133c6c7d0e1?w=300', 'description': 'قابل للدوران - مريح'},
      {'name': 'سجادة صلاة', 'price': '5,000', 'image': 'https://images.unsplash.com/photo-1581539250439-c96689b516dd?w=300', 'description': 'مخمل - نقشات إسلامية'},
      {'name': 'ستائر', 'price': '15,000', 'image': 'https://images.unsplash.com/photo-1509644056419-6e2b3f9ee1de?w=300', 'description': 'مخمل - معتمة'},
      {'name': 'إضاءة LED', 'price': '8,000', 'image': 'https://images.unsplash.com/photo-1565814636199-ae8133055c1c?w=300', 'description': 'ثريا مودرن'},
      {'name': 'مرآة حائط', 'price': '12,000', 'image': 'https://images.unsplash.com/photo-1618220179428-22790b461013?w=300', 'description': 'إطار ذهبي - كبيرة'},
    ],
    'services': [
      {'name': 'تنسيق حفلات زفاف', 'price': '150,000', 'image': 'https://images.unsplash.com/photo-1519225421980-715cb0215aed?w=300', 'description': 'تنسيق كامل - ديكورات'},
      {'name': 'تنظيف منازل شامل', 'price': '35,000', 'image': 'https://images.unsplash.com/photo-1563453392212-326f5e854473?w=300', 'description': 'تنظيف عميق - تعقيم'},
      {'name': 'تصميم داخلي فاخر', 'price': '200,000', 'image': 'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?w=300', 'description': 'تصميم كامل - ديكور'},
      {'name': 'صيانة مكيفات', 'price': '15,000', 'image': 'https://images.unsplash.com/photo-1633608607992-28810f6df2db?w=300', 'description': 'تنظيف - فريون - تصليح'},
      {'name': 'نقل أثاث', 'price': '20,000', 'image': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=300', 'description': 'نقل وتغليف - عمالة مدربة'},
      {'name': 'تصليح كهرباء', 'price': '10,000', 'image': 'https://images.unsplash.com/photo-1581147036323-c68037e363f7?w=300', 'description': 'تمديدات - تصليح أعطال'},
      {'name': 'تركيب كاميرات', 'price': '25,000', 'image': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=300', 'description': 'كاميرات مراقبة - إنذار'},
      {'name': 'دروس خصوصية', 'price': '8,000', 'image': 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=300', 'description': 'جميع المواد - أونلاين'},
      {'name': 'تصوير فوتوغرافي', 'price': '30,000', 'image': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=300', 'description': 'تصوير مناسبات - فيديو'},
      {'name': 'تطبيقات وبرمجة', 'price': '100,000', 'image': 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=300', 'description': 'تطبيقات جوال - مواقع'},
    ],
  };

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    setState(() {
      _products = _productsByCategory[widget.categoryId] ?? [];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(title: widget.categoryName),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _products.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.category, size: 80, color: AppTheme.goldColor.withOpacity(0.5)),
                      const SizedBox(height: 16),
                      Text(widget.categoryName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('سيتم إضافة منتجات هذا القسم قريباً'),
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
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final product = _products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(
                              productId: '${widget.categoryId}_$index',
                              productName: product['name'],
                              productId: product['id'] ?? "", productName: product['name'] ?? "", int.parse(product['price'].replaceAll(',', '')),
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
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${product['price']} ريال',
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
