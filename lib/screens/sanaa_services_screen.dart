import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class SanaaServicesScreen extends StatefulWidget {
  const SanaaServicesScreen({super.key});

  @override
  State<SanaaServicesScreen> createState() => _SanaaServicesScreenState();
}

class _SanaaServicesScreenState extends State<SanaaServicesScreen> {
  String _selectedCategory = 'all';
  
  final List<Map<String, dynamic>> _categories = [
    {'id': 'all', 'name': 'الكل', 'icon': Icons.grid_view, 'color': AppTheme.goldColor},
    {'id': 'hospitals', 'name': 'مستشفيات', 'icon': Icons.local_hospital, 'color': 0xFFF44336},
    {'id': 'universities', 'name': 'جامعات', 'icon': Icons.school, 'color': 0xFF2196F3},
    {'id': 'shops', 'name': 'محلات', 'icon': Icons.store, 'color': 0xFF4CAF50},
    {'id': 'restaurants', 'name': 'مطاعم', 'icon': Icons.restaurant, 'color': 0xFFFF9800},
    {'id': 'cafes', 'name': 'مقاهي', 'icon': Icons.coffee, 'color': 0xFF9C27B0},
    {'id': 'hotels', 'name': 'فنادق', 'icon': Icons.hotel, 'color': 0xFF795548},
    {'id': 'malls', 'name': 'مولات', 'icon': Icons.shopping_mall, 'color': 0xFFE91E63},
    {'id': 'pharmacies', 'name': 'صيدليات', 'icon': Icons.medical_services, 'color': 0xFF00BCD4},
    {'id': 'gyms', 'name': 'نوادي رياضية', 'icon': Icons.fitness_center, 'color': 0xFF8BC34A},
    {'id': 'beauty', 'name': 'صالونات تجميل', 'icon': Icons.spa, 'color': 0xFFE91E63},
    {'id': 'car_services', 'name': 'خدمات سيارات', 'icon': Icons.car_repair, 'color': 0xFF607D8B},
    {'id': 'electronics', 'name': 'إلكترونيات', 'icon': Icons.electrical_services, 'color': 0xFF2196F3},
    {'id': 'furniture', 'name': 'أثاث', 'icon': Icons.weekend, 'color': 0xFF795548},
    {'id': 'clothing', 'name': 'ملابس', 'icon': Icons.checkroom, 'color': 0xFFE91E63},
    {'id': 'jewelry', 'name': 'مجوهرات', 'icon': Icons.diamond, 'color': 0xFFD4AF37},
  ];

  // ==================== 50+ محل في صنعاء ====================
  final List<Map<String, dynamic>> _shops = [
    // مجوهرات (10)
    {'name': 'مجوهرات الذهب اليمني', 'area': 'سوق الذهب', 'category': 'مجوهرات', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=300', 'type': 'luxury', 'whatsapp': '712345678'},
    {'name': 'محل الذهب والماس', 'area': 'الستين', 'category': 'مجوهرات', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=300', 'type': 'luxury', 'whatsapp': '712345679'},
    {'name': 'جواهر اليمن', 'area': 'السبعين', 'category': 'مجوهرات', 'rating': 4.9, 'image': 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=300', 'type': 'luxury', 'whatsapp': '712345680'},
    {'name': 'الذهب الأبيض', 'area': 'حدة', 'category': 'مجوهرات', 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=300', 'type': 'luxury', 'whatsapp': '712345681'},
    {'name': 'مجوهرات الأصيل', 'area': 'مدينة الثورة', 'category': 'مجوهرات', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=300', 'type': 'luxury', 'whatsapp': '712345682'},
    
    // عطور (10)
    {'name': 'العود الملكي', 'area': 'الستين', 'category': 'عطور', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=300', 'type': 'premium', 'whatsapp': '712345683'},
    {'name': 'عطور الشرق', 'area': 'السبعين', 'category': 'عطور', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=300', 'type': 'premium', 'whatsapp': '712345684'},
    {'name': 'مسك الختام', 'area': 'حدة', 'category': 'عطور', 'rating': 4.9, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=300', 'type': 'premium', 'whatsapp': '712345685'},
    {'name': 'عطور الفرنسية', 'area': 'الروضة', 'category': 'عطور', 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=300', 'type': 'premium', 'whatsapp': '712345686'},
    {'name': 'عطور العربية', 'area': 'التحرير', 'category': 'عطور', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=300', 'type': 'premium', 'whatsapp': '712345687'},
    
    // ملابس (15)
    {'name': 'الأزياء العصرية', 'area': 'الستين', 'category': 'ملابس', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=300', 'type': 'fashion', 'whatsapp': '712345688'},
    {'name': 'موضة اليمن', 'area': 'السبعين', 'category': 'ملابس', 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=300', 'type': 'fashion', 'whatsapp': '712345689'},
    {'name': 'العبايات الفاخرة', 'area': 'حدة', 'category': 'ملابس', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1583394293214-ff7b3f5ad7cc?w=300', 'type': 'fashion', 'whatsapp': '712345690'},
    {'name': 'الملابس التركية', 'area': 'الروضة', 'category': 'ملابس', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=300', 'type': 'fashion', 'whatsapp': '712345691'},
    {'name': 'بوتيك ريماس', 'area': 'الستين', 'category': 'ملابس', 'rating': 4.9, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=300', 'type': 'fashion', 'whatsapp': '712345692'},
    {'name': 'الملابس الرجالية', 'area': 'السبعين', 'category': 'ملابس', 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=300', 'type': 'fashion', 'whatsapp': '712345693'},
    {'name': 'الأطفال عالمي', 'area': 'حدة', 'category': 'ملابس', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=300', 'type': 'kids', 'whatsapp': '712345694'},
    
    // إلكترونيات (10)
    {'name': 'الإلكترونيات الحديثة', 'area': 'الستين', 'category': 'إلكترونيات', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=300', 'type': 'electronics', 'whatsapp': '712345695'},
    {'name': 'عالم الجوالات', 'area': 'السبعين', 'category': 'إلكترونيات', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=300', 'type': 'electronics', 'whatsapp': '712345696'},
    {'name': 'أجهزة كمبيوتر', 'area': 'حدة', 'category': 'إلكترونيات', 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=300', 'type': 'electronics', 'whatsapp': '712345697'},
    {'name': 'عالم الشاشات', 'area': 'الروضة', 'category': 'إلكترونيات', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=300', 'type': 'electronics', 'whatsapp': '712345698'},
    {'name': 'إلكترونيات أبوظبي', 'area': 'الستين', 'category': 'إلكترونيات', 'rating': 4.9, 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=300', 'type': 'electronics', 'whatsapp': '712345699'},
    
    // أثاث (10)
    {'name': 'الأثاث الفاخر', 'area': 'الستين', 'category': 'أثاث', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=300', 'type': 'furniture', 'whatsapp': '712345700'},
    {'name': 'غرف النوم الملكية', 'area': 'السبعين', 'category': 'أثاث', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=300', 'type': 'furniture', 'whatsapp': '712345701'},
    {'name': 'المجالس العربية', 'area': 'حدة', 'category': 'أثاث', 'rating': 4.9, 'image': 'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?w=300', 'type': 'furniture', 'whatsapp': '712345702'},
    {'name': 'أثاث المكاتب', 'area': 'الروضة', 'category': 'أثاث', 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=300', 'type': 'furniture', 'whatsapp': '712345703'},
    {'name': 'ديكور المنزل', 'area': 'الستين', 'category': 'أثاث', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1618220179428-22790b461013?w=300', 'type': 'furniture', 'whatsapp': '712345704'},
    
    // أحذية (10)
    {'name': 'الأحذية العالمية', 'area': 'الستين', 'category': 'أحذية', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300', 'type': 'shoes', 'whatsapp': '712345705'},
    {'name': 'أحذية رجالية', 'area': 'السبعين', 'category': 'أحذية', 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=300', 'type': 'shoes', 'whatsapp': '712345706'},
    {'name': 'أحذية نسائية', 'area': 'حدة', 'category': 'أحذية', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=300', 'type': 'shoes', 'whatsapp': '712345707'},
    {'name': 'أحذية رياضية', 'area': 'الروضة', 'category': 'أحذية', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300', 'type': 'sports', 'whatsapp': '712345708'},
    {'name': 'شنط وحقائب', 'area': 'الستين', 'category': 'أحذية', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=300', 'type': 'bags', 'whatsapp': '712345709'},
    
    // ساعات (10)
    {'name': 'الساعات العالمية', 'area': 'الستين', 'category': 'ساعات', 'rating': 4.9, 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=300', 'type': 'luxury', 'whatsapp': '712345710'},
    {'name': 'ساعات رولكس', 'area': 'السبعين', 'category': 'ساعات', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=300', 'type': 'luxury', 'whatsapp': '712345711'},
    {'name': 'ساعات كاسيو', 'area': 'حدة', 'category': 'ساعات', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=300', 'type': 'sports', 'whatsapp': '712345712'},
    {'name': 'ساعات سيكو', 'area': 'الروضة', 'category': 'ساعات', 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=300', 'type': 'classic', 'whatsapp': '712345713'},
    {'name': 'ساعات ذكية', 'area': 'الستين', 'category': 'ساعات', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=300', 'type': 'smart', 'whatsapp': '712345714'},
    
    // مستحضرات تجميل (10)
    {'name': 'مستحضرات التجميل', 'area': 'الستين', 'category': 'تجميل', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300', 'type': 'cosmetics', 'whatsapp': '712345715'},
    {'name': 'العناية بالبشرة', 'area': 'السبعين', 'category': 'تجميل', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300', 'type': 'skincare', 'whatsapp': '712345716'},
    {'name': 'مكياج احترافي', 'area': 'حدة', 'category': 'تجميل', 'rating': 4.9, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300', 'type': 'makeup', 'whatsapp': '712345717'},
    {'name': 'العناية بالشعر', 'area': 'الروضة', 'category': 'تجميل', 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300', 'type': 'haircare', 'whatsapp': '712345718'},
    {'name': 'عطور ومكياج', 'area': 'الستين', 'category': 'تجميل', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300', 'type': 'cosmetics', 'whatsapp': '712345719'},
  ];

  // ==================== المستشفيات ====================
  final List<Map<String, dynamic>> _hospitals = [
    {'name': 'مستشفى الثورة العام', 'area': 'الستين', 'rating': 4.5, 'phone': '01-123456', 'image': 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=300', 'type': 'حكومي', 'specialties': 'عامة'},
    {'name': 'مستشفى الكويت', 'area': 'حدة', 'rating': 4.6, 'phone': '01-234567', 'image': 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=300', 'type': 'حكومي', 'specialties': 'عامة'},
    {'name': 'مستشفى الأمل', 'area': 'الروضة', 'rating': 4.7, 'phone': '01-345678', 'image': 'https://images.unsplash.com/photo-1586773860418-d37222d8fce3?w=300', 'type': 'خاص', 'specialties': 'نساء وولادة'},
    {'name': 'مستشفى العلوم والتكنولوجيا', 'area': 'السبعين', 'rating': 4.8, 'phone': '01-456789', 'image': 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=300', 'type': 'خاص', 'specialties': 'تخصصي'},
    {'name': 'مستشفى آزال', 'area': 'الستين', 'rating': 4.4, 'phone': '01-567890', 'image': 'https://images.unsplash.com/photo-1586773860418-d37222d8fce3?w=300', 'type': 'خاص', 'specialties': 'عامة'},
    {'name': 'مستشفى اليمن السعيد', 'area': 'التحرير', 'rating': 4.3, 'phone': '01-678901', 'image': 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=300', 'type': 'خاص', 'specialties': 'عامة'},
    {'name': 'مستشفى الشعب', 'area': 'مدينة الثورة', 'rating': 4.2, 'phone': '01-789012', 'image': 'https://images.unsplash.com/photo-1586773860418-d37222d8fce3?w=300', 'type': 'حكومي', 'specialties': 'عامة'},
    {'name': 'مستشفى العلفي', 'area': 'الستين', 'rating': 4.6, 'phone': '01-890123', 'image': 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=300', 'type': 'خاص', 'specialties': 'القلب'},
  ];

  // ==================== الجامعات ====================
  final List<Map<String, dynamic>> _universities = [
    {'name': 'جامعة صنعاء', 'area': 'الستين', 'rating': 4.7, 'students': '80,000+', 'image': 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=300', 'type': 'حكومية', 'established': '1970'},
    {'name': 'جامعة العلوم والتكنولوجيا', 'area': 'السبعين', 'rating': 4.6, 'students': '25,000+', 'image': 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=300', 'type': 'خاصة', 'established': '1994'},
    {'name': 'جامعة الإيمان', 'area': 'الحصب', 'rating': 4.5, 'students': '15,000+', 'image': 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=300', 'type': 'أهلية', 'established': '1996'},
    {'name': 'جامعة الناصر', 'area': 'الروضة', 'rating': 4.4, 'students': '12,000+', 'image': 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=300', 'type': 'خاصة', 'established': '1998'},
    {'name': 'جامعة الملكة أروى', 'area': 'السبعين', 'rating': 4.5, 'students': '8,000+', 'image': 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=300', 'type': 'خاصة', 'established': '1996'},
    {'name': 'جامعة الرازي', 'area': 'الستين', 'rating': 4.3, 'students': '10,000+', 'image': 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=300', 'type': 'خاصة', 'established': '2000'},
    {'name': 'جامعة اليمنية', 'area': 'مدينة الثورة', 'rating': 4.2, 'students': '20,000+', 'image': 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=300', 'type': 'خاصة', 'established': '2005'},
    {'name': 'كلية المجتمع', 'area': 'التحرير', 'rating': 4.1, 'students': '5,000+', 'image': 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=300', 'type': 'حكومية', 'established': '1998'},
  ];

  // ==================== المطاعم ====================
  final List<Map<String, dynamic>> _restaurants = [
    {'name': 'مطعم المندي الملكي', 'area': 'الستين', 'cuisine': 'يمني', 'rating': 4.8, 'price': 'متوسط', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=300'},
    {'name': 'مطعم السمك اليمني', 'area': 'حدة', 'cuisine': 'مأكولات بحرية', 'rating': 4.9, 'price': 'مرتفع', 'image': 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=300'},
    {'name': 'مطعم الفتة الشعبية', 'area': 'مدينة الثورة', 'cuisine': 'يمني', 'rating': 4.7, 'price': 'اقتصادي', 'image': 'https://images.unsplash.com/photo-1563379926898-05f4575a45d8?w=300'},
    {'name': 'بيتزا هت', 'area': 'السبعين', 'cuisine': 'إيطالي', 'rating': 4.5, 'price': 'متوسط', 'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=300'},
    {'name': 'كنتاكي', 'area': 'الستين', 'cuisine': 'وجبات سريعة', 'rating': 4.4, 'price': 'متوسط', 'image': 'https://images.unsplash.com/photo-1562967914-608f82629710?w=300'},
  ];

  // ==================== المقاهي ====================
  final List<Map<String, dynamic>> _cafes = [
    {'name': 'ستاربكس', 'area': 'السبعين', 'rating': 4.7, 'price': 'مرتفع', 'image': 'https://images.unsplash.com/photo-1507133750040-4a8f57021571?w=300'},
    {'name': 'مقهى الجبل الأخضر', 'area': 'الروضة', 'rating': 4.6, 'price': 'متوسط', 'image': 'https://images.unsplash.com/photo-1442512595331-e89e73853f31?w=300'},
    {'name': 'كوفي شوب روز', 'area': 'حدة', 'rating': 4.8, 'price': 'مرتفع', 'image': 'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=300'},
  ];

  // ==================== الفنادق ====================
  final List<Map<String, dynamic>> _hotels = [
    {'name': 'فندق موفنبيك', 'area': 'الستين', 'stars': 5, 'rating': 4.8, 'price': 'مرتفع', 'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=300'},
    {'name': 'فندق شيراتون', 'area': 'حدة', 'stars': 5, 'rating': 4.7, 'price': 'مرتفع', 'image': 'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=300'},
    {'name': 'فندق بوريفاج', 'area': 'السبعين', 'stars': 4, 'rating': 4.5, 'price': 'متوسط', 'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=300'},
  ];

  // ==================== المولات ====================
  final List<Map<String, dynamic>> _malls = [
    {'name': 'اليمن مول', 'area': 'الستين', 'shops': 150, 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=300'},
    {'name': 'سيتي مول', 'area': 'السبعين', 'shops': 120, 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1519567241046-7f570eee3ce6?w=300'},
    {'name': 'فاميلي مول', 'area': 'حدة', 'shops': 80, 'rating': 4.5, 'image': 'https://images.unsplash.com/photo-1491637639811-60e2756cc1c7?w=300'},
  ];

  // ==================== الصيدليات ====================
  final List<Map<String, dynamic>> _pharmacies = [
    {'name': 'صيدلية النهدي', 'area': 'الستين', 'rating': 4.8, 'hours': '24 ساعة', 'image': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300'},
    {'name': 'صيدلية الدواء', 'area': 'السبعين', 'rating': 4.7, 'hours': '8ص-12ص', 'image': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300'},
    {'name': 'صيدلية العز', 'area': 'حدة', 'rating': 4.6, 'hours': '24 ساعة', 'image': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300'},
  ];

  // ==================== النوادي الرياضية ====================
  final List<Map<String, dynamic>> _gyms = [
    {'name': 'جيم فيتنس برو', 'area': 'الستين', 'rating': 4.7, 'price': '25,000/شهر', 'image': 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=300'},
    {'name': 'جيم بودي شيب', 'area': 'السبعين', 'rating': 4.6, 'price': '20,000/شهر', 'image': 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=300'},
    {'name': 'جيم جولد', 'area': 'حدة', 'rating': 4.8, 'price': '30,000/شهر', 'image': 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=300'},
  ];

  // ==================== صالونات التجميل ====================
  final List<Map<String, dynamic>> _beautySalons = [
    {'name': 'صالون لمسة جمال', 'area': 'الستين', 'rating': 4.8, 'services': 'شامل', 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300'},
    {'name': 'صالون بيوتي سبا', 'area': 'السبعين', 'rating': 4.7, 'services': 'عناية بالبشرة', 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300'},
    {'name': 'صالون روز', 'area': 'حدة', 'rating': 4.9, 'services': 'شامل', 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300'},
  ];

  // ==================== خدمات السيارات ====================
  final List<Map<String, dynamic>> _carServices = [
    {'name': 'مركز البركة لصيانة السيارات', 'area': 'الستين', 'rating': 4.7, 'services': 'صيانة شاملة', 'image': 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=300'},
    {'name': 'معرض السيارات الحديثة', 'area': 'السبعين', 'rating': 4.8, 'services': 'بيع وشراء', 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=300'},
    {'name': 'غسيل سيارات بروفيشنال', 'area': 'حدة', 'rating': 4.6, 'services': 'غسيل وتلميع', 'image': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=300'},
  ];

  List<Map<String, dynamic>> get _filteredItems {
    switch (_selectedCategory) {
      case 'hospitals': return _hospitals;
      case 'universities': return _universities;
      case 'shops': return _allShops;
      case 'restaurants': return _restaurants;
      case 'cafes': return _cafes;
      case 'hotels': return _hotels;
      case 'malls': return _malls;
      case 'pharmacies': return _pharmacies;
      case 'gyms': return _gyms;
      case 'beauty': return _beautySalons;
      case 'car_services': return _carServices;
      default: return [..._hospitals, ..._universities, ..._allShops, ..._restaurants, ..._cafes, ..._hotels, ..._malls, ..._pharmacies, ..._gyms, ..._beautySalons, ..._carServices];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final items = _filteredItems;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'خدمات صنعاء'),
      body: Column(
        children: [
          _buildCategories(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) => _buildServiceCard(items[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final isSelected = _selectedCategory == cat['id'];
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = cat['id']),
            child: Container(
              width: 80,
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.goldColor.withOpacity(0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isSelected ? AppTheme.goldColor : Colors.grey.withOpacity(0.2)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(cat['icon'], color: isSelected ? AppTheme.goldColor : Color(cat['color']), size: 28),
                  const SizedBox(height: 4),
                  Text(cat['name'], style: TextStyle(fontSize: 11, color: isSelected ? AppTheme.goldColor : null), textAlign: TextAlign.center),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: item['image'],
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(height: 120, color: Colors.grey[300], child: const Center(child: CircularProgressIndicator())),
                  errorWidget: (_, __, ___) => Container(height: 120, color: Colors.grey[300], child: const Icon(Icons.image)),
                ),
                if (item.containsKey('rating'))
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(8)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.star, size: 10, color: Colors.amber), Text(' ${item['rating']}', style: const TextStyle(color: Colors.white, fontSize: 10))]),
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
                Text(item['name'], maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(item['area'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                if (item.containsKey('price')) Text(item['price'], style: TextStyle(fontSize: 11, color: AppTheme.goldColor)),
                if (item.containsKey('whatsapp')) Row(children: [const Icon(Icons.whatsapp, size: 12, color: Colors.green), const SizedBox(width: 4), Text(item['whatsapp'], style: const TextStyle(fontSize: 10, color: Colors.grey))]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

  // ==================== محلات إضافية (50+ محل جديد) ====================
  final List<Map<String, dynamic>> _moreShops = [
    // محلات مواد غذائية (10)
    {'name': 'سوبر ماركت السعيد', 'area': 'الستين', 'category': 'مواد غذائية', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=300', 'type': 'supermarket', 'whatsapp': '712345720'},
    {'name': 'سوبر ماركت العاقل', 'area': 'السبعين', 'category': 'مواد غذائية', 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=300', 'type': 'supermarket', 'whatsapp': '712345721'},
    {'name': 'أسواق الأمان', 'area': 'حدة', 'category': 'مواد غذائية', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=300', 'type': 'supermarket', 'whatsapp': '712345722'},
    {'name': 'سوق الخضراوات المركزي', 'area': 'الروضة', 'category': 'خضروات وفواكه', 'rating': 4.5, 'image': 'https://images.unsplash.com/photo-1566385101042-1a0aa0c1268c?w=300', 'type': 'market', 'whatsapp': '712345723'},
    {'name': 'محلات الجزارة الفاخر', 'area': 'الستين', 'category': 'لحوم', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?w=300', 'type': 'butcher', 'whatsapp': '712345724'},
    {'name': 'محلات الدواجن', 'area': 'السبعين', 'category': 'دواجن', 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?w=300', 'type': 'poultry', 'whatsapp': '712345725'},
    {'name': 'تمور المدينة', 'area': 'حدة', 'category': 'تمور', 'rating': 4.9, 'image': 'https://images.unsplash.com/photo-1604671801908-29f0cb3b6162?w=300', 'type': 'dates', 'whatsapp': '712345726'},
    {'name': 'العسل الجبلي', 'area': 'الروضة', 'category': 'عسل', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1587049352847-4a222e784d33?w=300', 'type': 'honey', 'whatsapp': '712345727'},
    {'name': 'بهارات اليمن', 'area': 'الستين', 'category': 'بهارات', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1532336414038-cf19250c5757?w=300', 'type': 'spices', 'whatsapp': '712345728'},
    {'name': 'مكسرات اليمن', 'area': 'السبعين', 'category': 'مكسرات', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1599599810769-bcde5a160d32?w=300', 'type': 'nuts', 'whatsapp': '712345729'},
    
    // محلات أدوات منزلية (10)
    {'name': 'أدوات منزلية البيت', 'area': 'الستين', 'category': 'أدوات منزلية', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1586008214976-3d9d6c5f2e5d?w=300', 'type': 'home', 'whatsapp': '712345730'},
    {'name': 'السيراميك الفاخر', 'area': 'السبعين', 'category': 'سيراميك', 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?w=300', 'type': 'ceramic', 'whatsapp': '712345731'},
    {'name': 'الستائر والديكور', 'area': 'حدة', 'category': 'ستائر', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1509644056419-6e2b3f9ee1de?w=300', 'type': 'curtains', 'whatsapp': '712345732'},
    {'name': 'الإضاءة الحديثة', 'area': 'الروضة', 'category': 'إضاءة', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1565814636199-ae8133055c1c?w=300', 'type': 'lighting', 'whatsapp': '712345733'},
    {'name': 'الأجهزة الكهربائية', 'area': 'الستين', 'category': 'أجهزة كهربائية', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1586008214976-3d9d6c5f2e5d?w=300', 'type': 'appliances', 'whatsapp': '712345734'},
    {'name': 'أدوات المطبخ', 'area': 'السبعين', 'category': 'أدوات مطبخ', 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1556909114-44e3ef1e0d71?w=300', 'type': 'kitchen', 'whatsapp': '712345735'},
    {'name': 'أواني منزلية', 'area': 'حدة', 'category': 'أواني', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1586008214976-3d9d6c5f2e5d?w=300', 'type': 'utensils', 'whatsapp': '712345736'},
    {'name': 'المفروشات المنزلية', 'area': 'الروضة', 'category': 'مفروشات', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=300', 'type': 'furnishings', 'whatsapp': '712345737'},
    {'name': 'السجاد اليمني', 'area': 'الستين', 'category': 'سجاد', 'rating': 4.9, 'image': 'https://images.unsplash.com/photo-1581539250439-c96689b516dd?w=300', 'type': 'carpets', 'whatsapp': '712345738'},
    {'name': 'المراتب الطبية', 'area': 'السبعين', 'category': 'مراتب', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=300', 'type': 'mattresses', 'whatsapp': '712345739'},
    
    // محلات العطور والبخور (10)
    {'name': 'البخور اليمني', 'area': 'الستين', 'category': 'بخور', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1583422409519-37f2e1de7ec9?w=300', 'type': 'incense', 'whatsapp': '712345740'},
    {'name': 'العود الفاخر', 'area': 'السبعين', 'category': 'عود', 'rating': 4.9, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=300', 'type': 'oud', 'whatsapp': '712345741'},
    {'name': 'الخلطات العطرية', 'area': 'حدة', 'category': 'خلطات عطرية', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=300', 'type': 'blends', 'whatsapp': '712345742'},
    {'name': 'العطور الفرنسية', 'area': 'الروضة', 'category': 'عطور فرنسية', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=300', 'type': 'french', 'whatsapp': '712345743'},
    {'name': 'العطور العربية', 'area': 'الستين', 'category': 'عطور عربية', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=300', 'type': 'arabic', 'whatsapp': '712345744'},
    
    // محلات مستلزمات الأطفال (10)
    {'name': 'عالم الأطفال', 'area': 'الستين', 'category': 'مستلزمات أطفال', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=300', 'type': 'baby', 'whatsapp': '712345745'},
    {'name': 'ألعاب الأطفال', 'area': 'السبعين', 'category': 'ألعاب', 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=300', 'type': 'toys', 'whatsapp': '712345746'},
    {'name': 'ملابس الأطفال', 'area': 'حدة', 'category': 'ملابس أطفال', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=300', 'type': 'kids_clothes', 'whatsapp': '712345747'},
    {'name': 'أحذية الأطفال', 'area': 'الروضة', 'category': 'أحذية أطفال', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=300', 'type': 'kids_shoes', 'whatsapp': '712345748'},
    {'name': 'عربات الأطفال', 'area': 'الستين', 'category': 'عربات أطفال', 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=300', 'type': 'strollers', 'whatsapp': '712345749'},
    
    // محلات مستحضرات تجميل إضافية (10)
    {'name': 'مستحضرات طبيعية', 'area': 'الستين', 'category': 'طبيعي', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300', 'type': 'natural', 'whatsapp': '712345750'},
    {'name': 'العناية بالشعر', 'area': 'السبعين', 'category': 'شعر', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300', 'type': 'hair', 'whatsapp': '712345751'},
    {'name': 'العناية بالبشرة', 'area': 'حدة', 'category': 'بشرة', 'rating': 4.9, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300', 'type': 'skin', 'whatsapp': '712345752'},
    {'name': 'مكياج احترافي', 'area': 'الروضة', 'category': 'مكياج', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300', 'type': 'makeup', 'whatsapp': '712345753'},
    {'name': 'أدوات تجميل', 'area': 'الستين', 'category': 'أدوات تجميل', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300', 'type': 'tools', 'whatsapp': '712345754'},
  ];

  // دمج المحلات مع الإضافات
  final List<Map<String, dynamic>> _allShops = [
    ..._shops,
    ..._moreShops,
  ];
