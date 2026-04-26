import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'إلكترونيات', 'icon': Icons.devices, 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=300', 'color': 0xFF2196F3, 'count': 1250},
    {'name': 'أزياء', 'icon': Icons.checkroom, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=300', 'color': 0xFFE91E63, 'count': 2340},
    {'name': 'سيارات', 'icon': Icons.directions_car, 'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=300', 'color': 0xFFF6465D, 'count': 890},
    {'name': 'عقارات', 'icon': Icons.home, 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=300', 'color': 0xFF4CAF50, 'count': 456},
    {'name': 'أثاث', 'icon': Icons.chair, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=300', 'color': 0xFFFF9800, 'count': 789},
    {'name': 'مطاعم', 'icon': Icons.restaurant, 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=300', 'color': 0xFF9C27B0, 'count': 456},
    {'name': 'خدمات', 'icon': Icons.build, 'image': 'https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=300', 'color': 0xFF00BCD4, 'count': 345},
    {'name': 'صحة وجمال', 'icon': Icons.favorite, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300', 'color': 0xFFE91E63, 'count': 678},
    {'name': 'رياضة', 'icon': Icons.sports_soccer, 'image': 'https://images.unsplash.com/photo-1461896836934-ffe807baa261?w=300', 'color': 0xFF4CAF50, 'count': 345},
    {'name': 'كتب', 'icon': Icons.menu_book, 'image': 'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=300', 'color': 0xFF795548, 'count': 2340},
    {'name': 'ألعاب', 'icon': Icons.sports_esports, 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=300', 'color': 0xFF9C27B0, 'count': 456},
    {'name': 'أطفال', 'icon': Icons.child_care, 'image': 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=300', 'color': 0xFF2196F3, 'count': 567},
    {'name': 'حيوانات', 'icon': Icons.pets, 'image': 'https://images.unsplash.com/photo-1450778869180-41d0601e046e?w=300', 'color': 0xFF8D6E63, 'count': 234},
    {'name': 'مجوهرات', 'icon': Icons.diamond, 'image': 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=300', 'color': 0xFFFFC107, 'count': 345},
    {'name': 'ساعات', 'icon': Icons.watch, 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=300', 'color': 0xFF607D8B, 'count': 234},
    {'name': 'عطور', 'icon': Icons.emoji_emotions, 'image': 'https://images.unsplash.com/photo-1541643600914-78b084683601?w=300', 'color': 0xFFE91E63, 'count': 456},
    {'name': 'حقائب', 'icon': Icons.shopping_bag, 'image': 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=300', 'color': 0xFF9C27B0, 'count': 234},
    {'name': 'أحذية', 'icon': Icons.shopping_bag, 'image': 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=300', 'color': 0xFF795548, 'count': 345},
    {'name': 'مواد غذائية', 'icon': Icons.local_grocery_store, 'image': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=300', 'color': 0xFF4CAF50, 'count': 567},
    {'name': 'خضروات وفواكه', 'icon': Icons.eco, 'image': 'https://images.unsplash.com/photo-1566385101042-1a0aa0c1268c?w=300', 'color': 0xFF8BC34A, 'count': 234},
    {'name': 'لحوم ودواجن', 'icon': Icons.agriculture, 'image': 'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?w=300', 'color': 0xFFF44336, 'count': 123},
    {'name': 'مخبوزات', 'icon': Icons.bakery_dining, 'image': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=300', 'color': 0xFF795548, 'count': 89},
    {'name': 'حلويات', 'icon': Icons.cake, 'image': 'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?w=300', 'color': 0xFFE91E63, 'count': 156},
    {'name': 'مشروبات', 'icon': Icons.local_drink, 'image': 'https://images.unsplash.com/photo-1527960471264-932f39eb5846?w=300', 'color': 0xFF2196F3, 'count': 234},
    {'name': 'قهوة وشاي', 'icon': Icons.coffee, 'image': 'https://images.unsplash.com/photo-1442512595331-e89e73853f31?w=300', 'color': 0xFF795548, 'count': 123},
    {'name': 'تمور وعسل', 'icon': Icons.date_range, 'image': 'https://images.unsplash.com/photo-1604671801908-29f0cb3b6162?w=300', 'color': 0xFF8D6E63, 'count': 78},
    {'name': 'مواد بناء', 'icon': Icons.construction, 'image': 'https://images.unsplash.com/photo-1504917595217-d4dc5ebe6122?w=300', 'color': 0xFF9E9E9E, 'count': 234},
    {'name': 'أدوات كهربائية', 'icon': Icons.electrical_services, 'image': 'https://images.unsplash.com/photo-1581147036323-c68037e363f7?w=300', 'color': 0xFFFF9800, 'count': 156},
    {'name': 'أدوات سباكة', 'icon': Icons.plumbing, 'image': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=300', 'color': 0xFF2196F3, 'count': 89},
    {'name': 'أدوات نجارة', 'icon': Icons.handyman, 'image': 'https://images.unsplash.com/photo-1504917595217-d4dc5ebe6122?w=300', 'color': 0xFF795548, 'count': 67},
    {'name': 'معدات طبية', 'icon': Icons.medical_services, 'image': 'https://images.unsplash.com/photo-1579684385127-1ef15d508118?w=300', 'color': 0xFF2196F3, 'count': 123},
    {'name': 'مستلزمات مكتبية', 'icon': Icons.edit, 'image': 'https://images.unsplash.com/photo-1596496181871-9681eacf9764?w=300', 'color': 0xFF607D8B, 'count': 234},
    {'name': 'هدايا', 'icon': Icons.card_giftcard, 'image': 'https://images.unsplash.com/photo-1549465220-1a8b9238cd48?w=300', 'color': 0xFFE91E63, 'count': 345},
    {'name': 'تحف', 'icon': Icons.history, 'image': 'https://images.unsplash.com/photo-1561124738-67dab8f6146a?w=300', 'color': 0xFF8D6E63, 'count': 89},
    {'name': 'كاميرات', 'icon': Icons.camera_alt, 'image': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=300', 'color': 0xFF9C27B0, 'count': 156},
    {'name': 'طائرات درون', 'icon': Icons.flight, 'image': 'https://images.unsplash.com/photo-1473968512647-3e447244af8f?w=300', 'color': 0xFF00BCD4, 'count': 45},
    {'name': 'منظفات', 'icon': Icons.cleaning_services, 'image': 'https://images.unsplash.com/photo-1563453392212-326f5e854473?w=300', 'color': 0xFF2196F3, 'count': 123},
    {'name': 'عناية بالسيارات', 'icon': Icons.car_repair, 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=300', 'color': 0xFFF44336, 'count': 89},
    {'name': 'مستحضرات تجميل', 'icon': Icons.face, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300', 'color': 0xFFE91E63, 'count': 456},
    {'name': 'عناية بالشعر', 'icon': Icons.content_cut, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300', 'color': 0xFF9C27B0, 'count': 234},
    {'name': 'عناية بالبشرة', 'icon': Icons.spa, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300', 'color': 0xFF4CAF50, 'count': 345},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        title: const Text('جميع الفئات', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.binanceDark,
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          return GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.binanceCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(cat['color'] as int).withOpacity(0.3)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: CachedNetworkImage(
                      imageUrl: cat['image'] as String,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(width: 70, height: 70, color: Color(cat['color'] as int).withOpacity(0.2)),
                      errorWidget: (_, __, ___) => Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(color: Color(cat['color'] as int).withOpacity(0.2), shape: BoxShape.circle),
                        child: Icon(cat['icon'] as IconData, color: Color(cat['color'] as int), size: 35),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cat['name'] as String,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${cat['count']} منتج',
                    style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11),
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
