import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// ============================================
// Flex Yemen - بيانات السوق الكاملة
// 45 فئة | 200+ متجر | 29 منتج | 17 مول | 5 تصفية | 6 شريط
// ============================================

class FullMarketData {
  
  // ============================================
  // 1️⃣ الفئات الرئيسية (45)
  // ============================================
  static final List<Map<String, dynamic>> mainCategories = [
    {'id': '1', 'name': 'إلكترونيات', 'icon': Icons.devices, 'color': 0xFF2196F3, 'productCount': 1250, 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200'},
    {'id': '2', 'name': 'أزياء وملابس', 'icon': Icons.checkroom, 'color': 0xFFE91E63, 'productCount': 2340, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200'},
    {'id': '3', 'name': 'سيارات', 'icon': Icons.directions_car, 'color': 0xFFF6465D, 'productCount': 890, 'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=200'},
    {'id': '4', 'name': 'عقارات', 'icon': Icons.home, 'color': 0xFF4CAF50, 'productCount': 456, 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=200'},
    {'id': '5', 'name': 'أثاث ومنزل', 'icon': Icons.chair, 'color': 0xFFFF9800, 'productCount': 789, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200'},
    {'id': '6', 'name': 'مطاعم وكافيهات', 'icon': Icons.restaurant, 'color': 0xFF9C27B0, 'productCount': 456, 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200'},
    {'id': '7', 'name': 'خدمات', 'icon': Icons.build, 'color': 0xFF00BCD4, 'productCount': 345, 'image': 'https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=200'},
    {'id': '8', 'name': 'صحة وجمال', 'icon': Icons.favorite, 'color': 0xFFE91E63, 'productCount': 678, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=200'},
    {'id': '9', 'name': 'رياضة ولياقة', 'icon': Icons.sports_soccer, 'color': 0xFF4CAF50, 'productCount': 345, 'image': 'https://images.unsplash.com/photo-1461896836934-bd45ba15cfc1?w=200'},
    {'id': '10', 'name': 'كتب ومكتبات', 'icon': Icons.menu_book, 'color': 0xFF795548, 'productCount': 2340, 'image': 'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=200'},
    {'id': '11', 'name': 'ألعاب إلكترونية', 'icon': Icons.sports_esports, 'color': 0xFF9C27B0, 'productCount': 456, 'image': 'https://images.unsplash.com/photo-1593305841991-05c297ba4575?w=200'},
    {'id': '12', 'name': 'أطفال ومستلزمات', 'icon': Icons.child_care, 'color': 0xFF2196F3, 'productCount': 567, 'image': 'https://images.unsplash.com/photo-1471286174890-9c112ffca5b4?w=200'},
    {'id': '13', 'name': 'حيوانات أليفة', 'icon': Icons.pets, 'color': 0xFF8D6E63, 'productCount': 234, 'image': 'https://images.unsplash.com/photo-1450778869180-41d0601e046e?w=200'},
    {'id': '14', 'name': 'مجوهرات وذهب', 'icon': Icons.diamond, 'color': 0xFFFFC107, 'productCount': 345, 'image': 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=200'},
    {'id': '15', 'name': 'ساعات فاخرة', 'icon': Icons.watch, 'color': 0xFF607D8B, 'productCount': 234, 'image': 'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=200'},
    {'id': '16', 'name': 'عطور وبخور', 'icon': Icons.emoji_emotions, 'color': 0xFFE91E63, 'productCount': 456, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=200'},
    {'id': '17', 'name': 'حقائب وأكسسوارات', 'icon': Icons.shopping_bag, 'color': 0xFF9C27B0, 'productCount': 234, 'image': 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=200'},
    {'id': '18', 'name': 'أحذية', 'icon': Icons.shopping_bag, 'color': 0xFF795548, 'productCount': 345, 'image': 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=200'},
    {'id': '19', 'name': 'جوالات', 'icon': Icons.phone_android, 'color': 0xFF00BCD4, 'productCount': 567, 'image': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=200'},
    {'id': '20', 'name': 'كمبيوترات ولابتوب', 'icon': Icons.computer, 'color': 0xFF3F51B5, 'productCount': 345, 'image': 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=200'},
    {'id': '21', 'name': 'شاشات وتلفزيونات', 'icon': Icons.tv, 'color': 0xFF009688, 'productCount': 234, 'image': 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=200'},
    {'id': '22', 'name': 'أجهزة منزلية', 'icon': Icons.kitchen, 'color': 0xFF4CAF50, 'productCount': 456, 'image': 'https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=200'},
    {'id': '23', 'name': 'أدوات مطبخ', 'icon': Icons.coffee_maker, 'color': 0xFFFF9800, 'productCount': 234, 'image': 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=200'},
    {'id': '24', 'name': 'معدات صناعية', 'icon': Icons.precision_manufacturing, 'color': 0xFF607D8B, 'productCount': 123, 'image': 'https://images.unsplash.com/photo-1579547621113-e4bb2a19bdd6?w=200'},
    {'id': '25', 'name': 'مواد بناء', 'icon': Icons.construction, 'color': 0xFFFF9800, 'productCount': 345, 'image': 'https://images.unsplash.com/photo-1503387762-592deb58ef4e?w=200'},
    {'id': '26', 'name': 'أدوية ومستلزمات طبية', 'icon': Icons.medical_services, 'color': 0xFF4CAF50, 'productCount': 567, 'image': 'https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=200'},
    {'id': '27', 'name': 'بقالة وتموينات', 'icon': Icons.shopping_cart, 'color': 0xFF8BC34A, 'productCount': 890, 'image': 'https://images.unsplash.com/photo-1578916171728-46686eac8d58?w=200'},
    {'id': '28', 'name': 'حلويات ومعجنات', 'icon': Icons.cake, 'color': 0xFFE91E63, 'productCount': 234, 'image': 'https://images.unsplash.com/photo-1558301211-0d8c8ddee6ec?w=200'},
    {'id': '29', 'name': 'مشروبات وعصائر', 'icon': Icons.local_drink, 'color': 0xFF00BCD4, 'productCount': 345, 'image': 'https://images.unsplash.com/photo-1544145945-f90425340c7e?w=200'},
    {'id': '30', 'name': 'لحوم ودواجن', 'icon': Icons.egg, 'color': 0xFFF44336, 'productCount': 123, 'image': 'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?w=200'},
    {'id': '31', 'name': 'خضروات وفواكه', 'icon': Icons.eco, 'color': 0xFF4CAF50, 'productCount': 234, 'image': 'https://images.unsplash.com/photo-1610348725531-843dff563e2c?w=200'},
    {'id': '32', 'name': 'أسماك ومأكولات بحرية', 'icon': Icons.set_meal, 'color': 0xFF2196F3, 'productCount': 89, 'image': 'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=200'},
    {'id': '33', 'name': 'مكسرات وتمور', 'icon': Icons.cookie, 'color': 0xFF795548, 'productCount': 167, 'image': 'https://images.unsplash.com/photo-1604068549290-dea0e4a305ca?w=200'},
    {'id': '34', 'name': 'عسل ومنتجات طبيعية', 'icon': Icons.emoji_nature, 'color': 0xFFFFC107, 'productCount': 98, 'image': 'https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=200'},
    {'id': '35', 'name': 'بهارات وتوابل', 'icon': Icons.grain, 'color': 0xFFFF5722, 'productCount': 145, 'image': 'https://images.unsplash.com/photo-1532336414038-cf19250c5757?w=200'},
    {'id': '36', 'name': 'ألبان وأجبان', 'icon': Icons.food_bank, 'color': 0xFF81D4FA, 'productCount': 234, 'image': 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=200'},
    {'id': '37', 'name': 'مخبوزات', 'icon': Icons.bakery_dining, 'color': 0xFFFF9800, 'productCount': 156, 'image': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=200'},
    {'id': '38', 'name': 'أغذية مجمدة', 'icon': Icons.ac_unit, 'color': 0xFF2196F3, 'productCount': 189, 'image': 'https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=200'},
    {'id': '39', 'name': 'تنظيف وغسيل', 'icon': Icons.cleaning_services, 'color': 0xFF00BCD4, 'productCount': 267, 'image': 'https://images.unsplash.com/photo-1567113463300-102a7e8e9b7b?w=200'},
    {'id': '40', 'name': 'عناية شخصية', 'icon': Icons.face, 'color': 0xFFE91E63, 'productCount': 345, 'image': 'https://images.unsplash.com/photo-1526947425960-945c6e72858f?w=200'},
    {'id': '41', 'name': 'قرطاسية وأدوات مكتبية', 'icon': Icons.edit, 'color': 0xFF607D8B, 'productCount': 178, 'image': 'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=200'},
    {'id': '42', 'name': 'هدايا وتحف', 'icon': Icons.card_giftcard, 'color': 0xFFE91E63, 'productCount': 234, 'image': 'https://images.unsplash.com/photo-1544027993-37dbfe43562a?w=200'},
    {'id': '43', 'name': 'سفر وسياحة', 'icon': Icons.flight, 'color': 0xFF2196F3, 'productCount': 67, 'image': 'https://images.unsplash.com/photo-1436491865332-7a61a109bb05?w=200'},
    {'id': '44', 'name': 'تأمين', 'icon': Icons.security, 'color': 0xFF4CAF50, 'productCount': 45, 'image': 'https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=200'},
    {'id': '45', 'name': 'أخرى', 'icon': Icons.more_horiz, 'color': 0xFF9E9E9E, 'productCount': 500, 'image': 'https://images.unsplash.com/photo-1472851294608-062f824d29cc?w=200'},
  ];

  // ============================================
  // 2️⃣ أزرار التصفية (5)
  // ============================================
  static final List<Map<String, dynamic>> filterButtons = [
    {'id': 'favorites', 'name': 'المفضلات', 'icon': Icons.favorite},
    {'id': 'trending', 'name': 'رائج', 'icon': Icons.trending_up},
    {'id': 'alpha', 'name': 'Alpha', 'icon': Icons.sort_by_alpha},
    {'id': 'new', 'name': 'جديدة', 'icon': Icons.new_releases},
    {'id': 'top_rated', 'name': 'الأعلى ربحاً !!!', 'icon': Icons.star},
  ];

  // ============================================
  // 3️⃣ أزرار الشريط العلوي (6)
  // ============================================
  static final List<Map<String, String>> topBarButtons = [
    {'id': 'discover', 'name': 'اكتشف'},
    {'id': 'following', 'name': 'المتابعات'},
    {'id': 'trending', 'name': 'رائج'},
    {'id': 'ads', 'name': 'الإعلانات'},
    {'id': 'news', 'name': 'الأخبار'},
    {'id': 'academy', 'name': 'الأكاديمية'},
  ];

  // ============================================
  // 4️⃣ المتاجر (200+)
  // ============================================
  static List<Map<String, dynamic>> generateStores() {
    List<Map<String, dynamic>> stores = [];
    
    // إلكترونيات (25)
    List<String> electronics = [
      'جرير للإلكترونيات', 'متجر التقنية', 'إكسترا', 'سامسونج', 'آبل ستور',
      'هواوي', 'شاومي', 'لينوفو', 'ديل', 'HP', 'سوني', 'إل جي',
      'آيسر', 'آسوس', 'كانون', 'نيكون', 'جيم ستوب', 'بلايستيشن',
      'أنكر', 'بيلكن', 'جابيل', 'سامسونج اليمن', 'هايبر التقنية', 'الخليج للكمبيوتر', 'عالم الإلكترونيات'
    ];
    
    // أزياء (25)
    List<String> fashion = [
      'نون للأزياء', 'الأزياء العصرية', 'الخياط الذهبي', 'ثياب وأكثر', 'عبايات المملكة',
      'فساتين السهرة', 'جلابيات يمنية', 'أحذية الموضة', 'شنط وماركات', 'ساعات فاخرة',
      'نظارات الشمس', 'زارا', 'اتش اند ام', 'مانجو', 'بالنسياغا',
      'شانيل', 'رولكس', 'كارتييه', 'الثوب اليمني', 'متجر العباية',
      'الأحذية الرياضية', 'الشنط الجلدية', 'الإكسسوارات', 'الملابس الداخلية', 'متجر الحرير'
    ];
    
    // سيارات (20)
    List<String> cars = [
      'تويوتا', 'هونداي', 'نيسان', 'هوندا', 'كيا', 'فورد', 'شيفروليه',
      'مرسيدس', 'بي إم دبليو', 'لكزس', 'رنج روفر', 'جيب', 'دودج',
      'فولكس واجن', 'سوزوكي', 'ميتسوبيشي', 'معرض السيارات', 'تشليح',
      'قطع غيار', 'زينة سيارات'
    ];
    
    // عقارات (15)
    List<String> realestate = [
      'مكتب عقاري', 'فلل للأيجار', 'شقق تمليك', 'أراضي سكنية',
      'عقارات تجارية', 'مكاتب للإيجار', 'محلات تجارية', 'معارض',
      'مخازن', 'استراحات', 'مزارع', 'عمارات', 'مجمعات سكنية',
      'برج سكني', 'فنادق'
    ];
    
    // مطاعم (25)
    List<String> restaurants = [
      'مطعم البيت اليمني', 'مندي الملكي', 'حضرموت للمندي', 'تعز للمطبخ اليمني',
      'عدن للمأكولات', 'إب للوجبات', 'ذمار للمطاعم', 'قهوة البن',
      'عصائر طازجة', 'حلويات شرقية', 'بيتزا هت', 'ماكدونالدز',
      'كنتاكي', 'برجر كنج', 'صب واي', 'البيك',
      'مطعم هندي', 'مطعم صيني', 'مطعم تركي', 'مطعم لبناني',
      'شاورما', 'فلافل', 'فول وتميس', 'معصوب', 'كبدة'
    ];
    
    // صحة وجمال (25)
    List<String> health = [
      'صيدلية الحياة', 'صيدلية الشفاء', 'النهدي', 'الدواء', 'مستشفى',
      'مختبرات طبية', 'ماك', 'لوريال', 'نيفيا', 'كلينيك',
      'استي لودر', 'عطور الماجد', 'دهن عود', 'بخور', 'زيت الحشيش',
      'شامبو', 'صابون', 'ماسكات', 'فيتامينات', 'مكملات غذائية',
      'فرش أسنان', 'معجون أسنان', 'مزيل عرق', 'كريمات', 'عناية بالبشرة'
    ];
    
    // خدمات (25)
    List<String> services = [
      'صيانة منزلية', 'نظافة', 'كهربائي', 'سباك', 'مكيفات',
      'دهانات', 'جبس', 'سيراميك', 'حدادة', 'نجارة',
      'ألمنيوم', 'مظلات', 'عزل أسطح', 'مكافحة حشرات', 'نقل عفش',
      'توصيل طلبات', 'تصليح سيارات', 'غسيل سيارات', 'خياطة', 'تصوير',
      'تصميم جرافيك', 'برمجة', 'تسويق إلكتروني', 'ترجمة', 'تدريس خصوصي'
    ];
    
    // متاجر متنوعة (40)
    List<String> other = [
      'مكتبة', 'قرطاسية', 'ألعاب أطفال', 'هدايا', 'زهور',
      'حيوانات أليفة', 'طيور', 'أسماك زينة', 'معدات رياضية', 'دراجات',
      'خيام', 'شنط سفر', 'مفاتيح', 'سوبرماركت', 'هايبر',
      'مخبز', 'حلويات', 'مكسرات', 'تمور', 'عسل',
      'حليب', 'أجبان', 'بيض', 'خضروات', 'فواكه',
      'لحوم', 'دواجن', 'أسماك', 'بهارات', 'معلبات',
      'مشروبات', 'عصائر', 'شاي', 'قهوة', 'مياه',
      'منظفات', 'صابون', 'شامبو', 'مناديل', 'أكياس'
    ];
    
    stores.addAll(_mapStores(electronics, 'إلكترونيات', 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200'));
    stores.addAll(_mapStores(fashion, 'أزياء', 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200'));
    stores.addAll(_mapStores(cars, 'سيارات', 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=200'));
    stores.addAll(_mapStores(realestate, 'عقارات', 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=200'));
    stores.addAll(_mapStores(restaurants, 'مطاعم', 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200'));
    stores.addAll(_mapStores(health, 'صحة وجمال', 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=200'));
    stores.addAll(_mapStores(services, 'خدمات', 'https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=200'));
    stores.addAll(_mapStores(other, 'متنوعات', 'https://images.unsplash.com/photo-1472851294608-062f824d29cc?w=200'));
    
    return stores;
  }
  
  static List<Map<String, dynamic>> _mapStores(List<String> names, String category, String image) {
    return names.asMap().entries.map((e) {
      int i = e.key;
      return {
        'id': '${category}_$i',
        'name': e.value,
        'image': image,
        'category': category,
        'productsCount': 50 + (i * 7) % 100,
        'rating': 4.0 + (i % 10) * 0.1,
        'isVerified': i % 3 == 0,
        'followers': 100 + i * 25,
      };
    }).toList();
  }

  // ============================================
  // 5️⃣ المولات (17)
  // ============================================
  static final List<Map<String, dynamic>> malls = [
    {'id': '1', 'name': 'اليمن مول', 'city': 'صنعاء', 'stores': 250, 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=200'},
    {'id': '2', 'name': 'سيتي مول', 'city': 'صنعاء', 'stores': 180, 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1519567241046-7f570eee3ce6?w=200'},
    {'id': '3', 'name': 'غاليري مول', 'city': 'صنعاء', 'stores': 120, 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1519567241046-7f570eee3ce6?w=200'},
    {'id': '4', 'name': 'الموج مول', 'city': 'عدن', 'stores': 150, 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=200'},
    {'id': '5', 'name': 'كريتر مول', 'city': 'عدن', 'stores': 100, 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=200'},
    {'id': '6', 'name': 'تعز مول', 'city': 'تعز', 'stores': 80, 'rating': 4.4, 'image': 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=200'},
    {'id': '7', 'name': 'الحديدة مول', 'city': 'الحديدة', 'stores': 70, 'rating': 4.3, 'image': 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=200'},
    {'id': '8', 'name': 'المكلا مول', 'city': 'المكلا', 'stores': 60, 'rating': 4.5, 'image': 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=200'},
    {'id': '9', 'name': 'إب مول', 'city': 'إب', 'stores': 50, 'rating': 4.2, 'image': 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=200'},
    {'id': '10', 'name': 'معرض السيارات الحديثة', 'city': 'صنعاء', 'stores': 45, 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=200'},
    {'id': '11', 'name': 'معرض السيارات الفاخرة', 'city': 'عدن', 'stores': 30, 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=200'},
    {'id': '12', 'name': 'مجمع الذهب والمجوهرات', 'city': 'صنعاء', 'stores': 40, 'rating': 4.9, 'image': 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=200'},
    {'id': '13', 'name': 'سوق العطور الفاخرة', 'city': 'صنعاء', 'stores': 35, 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=200'},
    {'id': '14', 'name': 'مجمع الأثاث الفاخر', 'city': 'صنعاء', 'stores': 50, 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200'},
    {'id': '15', 'name': 'مول العاصمة', 'city': 'صنعاء', 'stores': 200, 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=200'},
    {'id': '16', 'name': 'مول الفردوس', 'city': 'عدن', 'stores': 85, 'rating': 4.5, 'image': 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=200'},
    {'id': '17', 'name': 'رد سي مول', 'city': 'صنعاء', 'stores': 90, 'rating': 4.5, 'image': 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=200'},
  ];

  // ============================================
  // 6️⃣ المنتجات (29)
  // ============================================
  static final List<Map<String, dynamic>> products = [
    {'id': 'p1', 'name': 'الخضروات والفواكه', 'price': 500, 'image': 'https://images.unsplash.com/photo-1610348725531-843dff563e2c?w=400'},
    {'id': 'p2', 'name': 'الدجاج واللحوم الطازجة', 'price': 2000, 'image': 'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?w=400'},
    {'id': 'p3', 'name': 'Coffers', 'price': 1500, 'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400'},
    {'id': 'p4', 'name': 'الطبخ والخير', 'price': 800, 'image': 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400'},
    {'id': 'p5', 'name': 'الألبان والأجبان والبيض', 'price': 1200, 'image': 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=400'},
    {'id': 'p6', 'name': 'ركن الأطفال', 'price': 3500, 'image': 'https://images.unsplash.com/photo-1471286174890-9c112ffca5b4?w=400'},
    {'id': 'p7', 'name': 'Aptamil', 'price': 4500, 'image': 'https://images.unsplash.com/photo-1584429377417-a62e2f1378e4?w=400'},
    {'id': 'p8', 'name': 'المشروبات والعصائر', 'price': 300, 'image': 'https://images.unsplash.com/photo-1544145945-f90425340c7e?w=400'},
    {'id': 'p9', 'name': 'الرز والسكر والحبوب', 'price': 900, 'image': 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400'},
    {'id': 'p10', 'name': 'الأغذية المعلبة', 'price': 400, 'image': 'https://images.unsplash.com/photo-1590004953392-5aba2e72269a?w=400'},
    {'id': 'p11', 'name': 'TRANS', 'price': 2500, 'image': 'https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=400'},
    {'id': 'p12', 'name': 'DOWN', 'price': 1800, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400'},
    {'id': 'p13', 'name': 'القهوة والشاي', 'price': 600, 'image': 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=400'},
    {'id': 'p14', 'name': 'الأغذية المجمدة', 'price': 700, 'image': 'https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=400'},
    {'id': 'p15', 'name': 'حبات خفيفة وشبس', 'price': 200, 'image': 'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=400'},
    {'id': 'p16', 'name': 'قسم الثلاجة', 'price': 1100, 'image': 'https://images.unsplash.com/photo-1571171637578-41bc2dd41cd2?w=400'},
    {'id': 'p17', 'name': 'التوابل والبهارات', 'price': 350, 'image': 'https://images.unsplash.com/photo-1532336414038-cf19250c5757?w=400'},
    {'id': 'p18', 'name': 'قسم الدايت', 'price': 1300, 'image': 'https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=400'},
    {'id': 'p19', 'name': 'المستهلكات والمناديل', 'price': 150, 'image': 'https://images.unsplash.com/photo-1583947215259-38e31be8751f?w=400'},
    {'id': 'p20', 'name': 'أطعمة الأقطار', 'price': 2200, 'image': 'https://images.unsplash.com/photo-1590004953392-5aba2e72269a?w=400'},
    {'id': 'p21', 'name': 'التنظيف والغسيل', 'price': 500, 'image': 'https://images.unsplash.com/photo-1567113463300-102a7e8e9b7b?w=400'},
    {'id': 'p22', 'name': 'مستلزمات إلكترونية', 'price': 3000, 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=400'},
    {'id': 'p23', 'name': 'Crystal', 'price': 5000, 'image': 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=400'},
    {'id': 'p24', 'name': 'مستلزمات الحيوانات الأليفة', 'price': 1600, 'image': 'https://images.unsplash.com/photo-1450778869180-41d0601e046e?w=400'},
    {'id': 'p25', 'name': 'القرطاسية', 'price': 400, 'image': 'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=400'},
    {'id': 'p26', 'name': 'king', 'price': 7500, 'image': 'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=400'},
    {'id': 'p27', 'name': 'الشوكولاتة والبسكويت', 'price': 500, 'image': 'https://images.unsplash.com/photo-1549007994-cb92caebd54b?w=400'},
    {'id': 'p28', 'name': 'وجبات خفيفة وشبس', 'price': 100, 'image': 'https://images.unsplash.com/photo-1621447504864-8686df5b8e37?w=400'},
    {'id': 'p29', 'name': 'العناية الشخصية', 'price': 750, 'image': 'https://images.unsplash.com/photo-1526947425960-945c6e72858f?w=400'},
  ];

  // ============================================
  // 7️⃣ ماركات عالمية
  // ============================================
  static final List<Map<String, dynamic>> brands = [
    {'name': 'Apple', 'logo': '🍎', 'color': 0xFF000000},
    {'name': 'Samsung', 'logo': '📱', 'color': 0xFF1428A0},
    {'name': 'Nike', 'logo': '👟', 'color': 0xFF000000},
    {'name': 'Adidas', 'logo': '👕', 'color': 0xFF000000},
    {'name': 'Zara', 'logo': '👗', 'color': 0xFF000000},
    {'name': 'Toyota', 'logo': '🚗', 'color': 0xFFEB0A1E},
    {'name': 'Sony', 'logo': '🎮', 'color': 0xFF000000},
    {'name': 'LG', 'logo': '📺', 'color': 0xFFA5004D},
    {'name': 'Nescafe', 'logo': '☕', 'color': 0xFFC8102E},
    {'name': 'Pepsi', 'logo': '🥤', 'color': 0xFF00539F},
  ];

  // ============================================
  // 8️⃣ عروض وإعلانات
  // ============================================
  static final List<Map<String, dynamic>> ads = [
    {'title': 'عروض الصيف', 'desc': 'خصم 40%', 'color': 0xFFF6465D, 'image': 'https://images.unsplash.com/photo-1607083206869-4c7672e72a8a?w=400'},
    {'title': 'تخفيضات الجمعة', 'desc': 'خصم 70%', 'color': 0xFF2196F3, 'image': 'https://images.unsplash.com/photo-1607082349566-187342175e2f?w=400'},
    {'title': 'عروض العيد', 'desc': 'خصم 50%', 'color': 0xFFFF9800, 'image': 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=400'},
    {'title': 'شحن مجاني', 'desc': 'لكل الطلبات', 'color': 0xFF4CAF50, 'image': 'https://images.unsplash.com/photo-1583258292688-d0213dc145a4?w=400'},
  ];
}
