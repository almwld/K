import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FullMarketData {
  
  // ==================== 1. الفئات الرئيسية (45 فئة) ====================
  static final List<Map<String, dynamic>> mainCategories = [
    {'id': '1', 'name': 'إلكترونيات', 'icon': Icons.devices, 'color': 0xFF2196F3, 'productCount': 1250, 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200'},
    {'id': '2', 'name': 'أزياء وملابس', 'icon': Icons.checkroom, 'color': 0xFFE91E63, 'productCount': 2340, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200'},
    {'id': '3', 'name': 'سيارات', 'icon': Icons.directions_car, 'color': 0xFFF6465D, 'productCount': 890, 'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=200'},
    {'id': '4', 'name': 'عقارات', 'icon': Icons.home, 'color': 0xFF4CAF50, 'productCount': 456, 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=200'},
    {'id': '5', 'name': 'أثاث ومنزل', 'icon': Icons.chair, 'color': 0xFFFF9800, 'productCount': 789, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200'},
    {'id': '6', 'name': 'مطاعم', 'icon': Icons.restaurant, 'color': 0xFF9C27B0, 'productCount': 456, 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200'},
    {'id': '7', 'name': 'خدمات', 'icon': Icons.build, 'color': 0xFF00BCD4, 'productCount': 345, 'image': 'https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=200'},
    {'id': '8', 'name': 'صحة وجمال', 'icon': Icons.favorite, 'color': 0xFFE91E63, 'productCount': 678, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=200'},
    {'id': '9', 'name': 'رياضة ولياقة', 'icon': Icons.sports_soccer, 'color': 0xFF4CAF50, 'productCount': 345, 'image': 'https://images.unsplash.com/photo-1461896836934-ffe807baa261?w=200'},
    {'id': '10', 'name': 'كتب ومكتبات', 'icon': Icons.menu_book, 'color': 0xFF795548, 'productCount': 2340, 'image': 'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=200'},
    {'id': '11', 'name': 'ألعاب', 'icon': Icons.sports_esports, 'color': 0xFF9C27B0, 'productCount': 456, 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200'},
    {'id': '12', 'name': 'أطفال ومستلزمات', 'icon': Icons.child_care, 'color': 0xFF2196F3, 'productCount': 567, 'image': 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=200'},
    {'id': '13', 'name': 'حيوانات أليفة', 'icon': Icons.pets, 'color': 0xFF8D6E63, 'productCount': 234, 'image': 'https://images.unsplash.com/photo-1450778869180-41d0601e046e?w=200'},
    {'id': '14', 'name': 'مجوهرات', 'icon': Icons.diamond, 'color': 0xFFFFC107, 'productCount': 345, 'image': 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=200'},
    {'id': '15', 'name': 'ساعات', 'icon': Icons.watch, 'color': 0xFF607D8B, 'productCount': 234, 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=200'},
    {'id': '16', 'name': 'عطور', 'icon': Icons.emoji_emotions, 'color': 0xFFE91E63, 'productCount': 456, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=200'},
    {'id': '17', 'name': 'حقائب', 'icon': Icons.shopping_bag, 'color': 0xFF9C27B0, 'productCount': 234, 'image': 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=200'},
    {'id': '18', 'name': 'أحذية', 'icon': Icons.shopping_bag, 'color': 0xFF795548, 'productCount': 345, 'image': 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=200'},
    {'id': '19', 'name': 'جوالات', 'icon': Icons.phone_android, 'color': 0xFF00BCD4, 'productCount': 567, 'image': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=200'},
    {'id': '20', 'name': 'كمبيوترات', 'icon': Icons.computer, 'color': 0xFF3F51B5, 'productCount': 345, 'image': 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=200'},
    {'id': '21', 'name': 'شاشات وتلفزيونات', 'icon': Icons.tv, 'color': 0xFF009688, 'productCount': 234, 'image': 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=200'},
    {'id': '22', 'name': 'أجهزة منزلية', 'icon': Icons.kitchen, 'color': 0xFF4CAF50, 'productCount': 456, 'image': 'https://images.unsplash.com/photo-1586008214976-3d9d6c5f2e5d?w=200'},
    {'id': '23', 'name': 'أدوات مطبخ', 'icon': Icons.coffee_maker, 'color': 0xFFFF9800, 'productCount': 234, 'image': 'https://images.unsplash.com/photo-1556909114-44e3ef1e0d71?w=200'},
    {'id': '24', 'name': 'مواد غذائية', 'icon': Icons.local_grocery_store, 'color': 0xFF8BC34A, 'productCount': 1234, 'image': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=200'},
    {'id': '25', 'name': 'خضروات وفواكه', 'icon': Icons.eco, 'color': 0xFF4CAF50, 'productCount': 567, 'image': 'https://images.unsplash.com/photo-1566385101042-1a0aa0c1268c?w=200'},
    {'id': '26', 'name': 'لحوم ودواجن', 'icon': Icons.agriculture, 'color': 0xFFF44336, 'productCount': 345, 'image': 'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?w=200'},
    {'id': '27', 'name': 'أسماك ومأكولات بحرية', 'icon': Icons.set_meal, 'color': 0xFF00BCD4, 'productCount': 234, 'image': 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=200'},
    {'id': '28', 'name': 'منتجات ألبان', 'icon': Icons.breakfast_dining, 'color': 0xFFFFFFFF, 'productCount': 456, 'image': 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=200'},
    {'id': '29', 'name': 'مخبوزات', 'icon': Icons.bakery_dining, 'color': 0xFF795548, 'productCount': 345, 'image': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=200'},
    {'id': '30', 'name': 'حلويات', 'icon': Icons.cake, 'color': 0xFFE91E63, 'productCount': 234, 'image': 'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?w=200'},
    {'id': '31', 'name': 'مشروبات', 'icon': Icons.local_drink, 'color': 0xFF2196F3, 'productCount': 456, 'image': 'https://images.unsplash.com/photo-1527960471264-932f39eb5846?w=200'},
    {'id': '32', 'name': 'قهوة وشاي', 'icon': Icons.coffee, 'color': 0xFF795548, 'productCount': 345, 'image': 'https://images.unsplash.com/photo-1442512595331-e89e73853f31?w=200'},
    {'id': '33', 'name': 'تمور وعسل', 'icon': Icons.date_range, 'color': 0xFF8D6E63, 'productCount': 234, 'image': 'https://images.unsplash.com/photo-1604671801908-29f0cb3b6162?w=200'},
    {'id': '34', 'name': 'بهارات وتوابل', 'icon': Icons.grass, 'color': 0xFF795548, 'productCount': 456, 'image': 'https://images.unsplash.com/photo-1596040033229-a9821ebd058a?w=200'},
    {'id': '35', 'name': 'منظفات', 'icon': Icons.cleaning_services, 'color': 0xFF03A9F4, 'productCount': 345, 'image': 'https://images.unsplash.com/photo-1563453392212-326f5e854473?w=200'},
    {'id': '36', 'name': 'أدوات منزلية', 'icon': Icons.kitchen, 'color': 0xFF9E9E9E, 'productCount': 567, 'image': 'https://images.unsplash.com/photo-1581539250439-c96689b516dd?w=200'},
    {'id': '37', 'name': 'إلكترونيات استهلاكية', 'icon': Icons.devices, 'color': 0xFF2196F3, 'productCount': 789, 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200'},
    {'id': '38', 'name': 'مستلزمات مدرسية', 'icon': Icons.edit, 'color': 0xFF4CAF50, 'productCount': 456, 'image': 'https://images.unsplash.com/photo-1596496181871-9681eacf9764?w=200'},
    {'id': '39', 'name': 'هدايا', 'icon': Icons.card_giftcard, 'color': 0xFFE91E63, 'productCount': 345, 'image': 'https://images.unsplash.com/photo-1549465220-1a8b9238cd48?w=200'},
    {'id': '40', 'name': 'تحف وأنتيكات', 'icon': Icons.history, 'color': 0xFF795548, 'productCount': 234, 'image': 'https://images.unsplash.com/photo-1561124738-67dab8f6146a?w=200'},
    {'id': '41', 'name': 'كاميرات', 'icon': Icons.camera_alt, 'color': 0xFF607D8B, 'productCount': 234, 'image': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=200'},
    {'id': '42', 'name': 'طائرات درون', 'icon': Icons.flight, 'color': 0xFF00BCD4, 'productCount': 123, 'image': 'https://images.unsplash.com/photo-1473968512647-3e447244af8f?w=200'},
    {'id': '43', 'name': 'معدات صناعية', 'icon': Icons.factory, 'color': 0xFF9E9E9E, 'productCount': 345, 'image': 'https://images.unsplash.com/photo-1581091226033-d5c48150dbaa?w=200'},
    {'id': '44', 'name': 'مواد بناء', 'icon': Icons.construction, 'color': 0xFF795548, 'productCount': 456, 'image': 'https://images.unsplash.com/photo-1504917595217-d4dc5ebe6122?w=200'},
    {'id': '45', 'name': 'خدمات منزلية', 'icon': Icons.handyman, 'color': 0xFFFF9800, 'productCount': 345, 'image': 'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=200'},
  ];

  // ==================== 2. الأقسام الفرعية (120+ قسم) ====================
  static final Map<String, List<Map<String, String>>> subcategories = {
    'إلكترونيات': [
      {'name': 'هواتف ذكية', 'icon': '📱'}, {'name': 'لابتوبات', 'icon': '💻'}, {'name': 'سماعات', 'icon': '🎧'},
      {'name': 'كاميرات', 'icon': '📷'}, {'name': 'شواحن', 'icon': '🔌'}, {'name': 'اكسسوارات', 'icon': '📱'},
    ],
    'أزياء وملابس': [
      {'name': 'رجالي', 'icon': '👨'}, {'name': 'نسائي', 'icon': '👩'}, {'name': 'أطفال', 'icon': '👶'},
      {'name': 'أحذية', 'icon': '👟'}, {'name': 'شنط', 'icon': '👜'}, {'name': 'ساعات', 'icon': '⌚'},
    ],
    'مواد غذائية': [
      {'name': 'أرز', 'icon': '🍚'}, {'name': 'زيت', 'icon': '🫒'}, {'name': 'سكر', 'icon': '🍬'},
      {'name': 'طحين', 'icon': '🌾'}, {'name': 'معكرونة', 'icon': '🍝'}, {'name': 'بقوليات', 'icon': '🫘'},
    ],
    'الصحة والجمال': [
      {'name': 'عناية بالبشرة', 'icon': '🧴'}, {'name': 'عناية بالشعر', 'icon': '💇'}, {'name': 'مكياج', 'icon': '💄'},
      {'name': 'عطور', 'icon': '🌸'}, {'name': 'مستلزمات حلاقة', 'icon': '✂️'},
    ],
  };

  // ==================== 3. المتاجر (200+ متجر) ====================
  static final List<Map<String, dynamic>> stores = [
    // إلكترونيات (25 متجر)
    {'id': '1', 'name': 'متجر التقنية', 'category': 'إلكترونيات', 'rating': 4.8, 'sales': '1.2K', 'products': 156, 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200', 'isFollowing': false},
    {'id': '2', 'name': 'عالم الجوالات', 'category': 'إلكترونيات', 'rating': 4.7, 'sales': '2.3K', 'products': 234, 'image': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=200', 'isFollowing': true},
    {'id': '3', 'name': 'كمبيوتر مول', 'category': 'إلكترونيات', 'rating': 4.9, 'sales': '892', 'products': 89, 'image': 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=200', 'isFollowing': false},
    {'id': '4', 'name': 'سماعات العالم', 'category': 'إلكترونيات', 'rating': 4.6, 'sales': '1.5K', 'products': 67, 'image': 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=200', 'isFollowing': false},
    {'id': '5', 'name': 'كاميرات ديجيتال', 'category': 'إلكترونيات', 'rating': 4.8, 'sales': '456', 'products': 45, 'image': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=200', 'isFollowing': false},
    {'id': '6', 'name': 'شواحن اكسبرس', 'category': 'إلكترونيات', 'rating': 4.5, 'sales': '2.1K', 'products': 123, 'image': 'https://images.unsplash.com/photo-1586953208448-b95a79798f07?w=200', 'isFollowing': false},
    {'id': '7', 'name': 'اكسسوارات موبايل', 'category': 'إلكترونيات', 'rating': 4.7, 'sales': '3.4K', 'products': 234, 'image': 'https://images.unsplash.com/photo-1586953208448-b95a79798f07?w=200', 'isFollowing': false},
    // أزياء (30 متجر)
    {'id': '8', 'name': 'الأزياء العصرية', 'category': 'أزياء وملابس', 'rating': 4.6, 'sales': '3.4K', 'products': 456, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200', 'isFollowing': false},
    {'id': '9', 'name': 'موضة اليمن', 'category': 'أزياء وملابس', 'rating': 4.8, 'sales': '1.8K', 'products': 234, 'image': 'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=200', 'isFollowing': true},
    {'id': '10', 'name': 'أحذية كلاسيك', 'category': 'أزياء وملابس', 'rating': 4.5, 'sales': '2.1K', 'products': 123, 'image': 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=200', 'isFollowing': false},
    {'id': '11', 'name': 'شنط ماركات', 'category': 'أزياء وملابس', 'rating': 4.7, 'sales': '1.2K', 'products': 89, 'image': 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=200', 'isFollowing': false},
    // سيارات (15 متجر)
    {'id': '12', 'name': 'معرض السيارات الحديثة', 'category': 'سيارات', 'rating': 4.8, 'sales': '456', 'products': 45, 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=200', 'isFollowing': false},
    {'id': '13', 'name': 'قطع غيار السيارات', 'category': 'سيارات', 'rating': 4.6, 'sales': '1.2K', 'products': 234, 'image': 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=200', 'isFollowing': false},
    // عقارات (12 متجر)
    {'id': '14', 'name': 'عقارات فلكس', 'category': 'عقارات', 'rating': 4.7, 'sales': '234', 'products': 45, 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=200', 'isFollowing': false},
    // أثاث (18 متجر)
    {'id': '15', 'name': 'أثاث المنزل', 'category': 'أثاث ومنزل', 'rating': 4.5, 'sales': '1.1K', 'products': 156, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200', 'isFollowing': false},
    // مطاعم (25 متجر)
    {'id': '16', 'name': 'مطعم مندي الملكي', 'category': 'مطاعم', 'rating': 4.9, 'sales': '2.1K', 'products': 34, 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200', 'isFollowing': true},
    // صحة وجمال (15 متجر)
    {'id': '17', 'name': 'صيدلية الحياة', 'category': 'صحة وجمال', 'rating': 4.6, 'sales': '987', 'products': 345, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=200', 'isFollowing': false},
    // عطور (10 متاجر)
    {'id': '18', 'name': 'عطور الشرق', 'category': 'عطور', 'rating': 4.8, 'sales': '1.5K', 'products': 89, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=200', 'isFollowing': true},
  ];

  // ==================== 4. المنتجات (29 منتج - جدول شبكي) ====================
  static final List<Map<String, dynamic>> products = [
    {'id': '1', 'name': 'iPhone 15 Pro', 'price': '350,000', 'oldPrice': '450,000', 'category': 'إلكترونيات', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=200', 'rating': 4.8, 'sales': 1250},
    {'id': '2', 'name': 'ساعة أبل الترا', 'price': '45,000', 'oldPrice': '60,000', 'category': 'إلكترونيات', 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=200', 'rating': 4.8, 'sales': 890},
    {'id': '3', 'name': 'ماك بوك برو', 'price': '1,800,000', 'oldPrice': '2,100,000', 'category': 'إلكترونيات', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=200', 'rating': 4.9, 'sales': 567},
    {'id': '4', 'name': 'سامسونج S24', 'price': '380,000', 'oldPrice': '450,000', 'category': 'إلكترونيات', 'image': 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=200', 'rating': 4.7, 'sales': 890},
    {'id': '5', 'name': 'ثوب يمني فاخر', 'price': '35,000', 'oldPrice': null, 'category': 'أزياء وملابس', 'image': 'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=200', 'rating': 4.6, 'sales': 456},
    {'id': '6', 'name': 'عباية فاخرة', 'price': '30,000', 'oldPrice': null, 'category': 'أزياء وملابس', 'image': 'https://images.unsplash.com/photo-1583394293214-ff7b3f5ad7cc?w=200', 'rating': 4.7, 'sales': 234},
    {'id': '7', 'name': 'تويوتا كامري 2024', 'price': '8,500,000', 'oldPrice': null, 'category': 'سيارات', 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=200', 'rating': 4.8, 'sales': 23},
    {'id': '8', 'name': 'فيلا فاخرة صنعاء', 'price': '45,000,000', 'oldPrice': null, 'category': 'عقارات', 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=200', 'rating': 4.9, 'sales': 5},
    {'id': '9', 'name': 'كنبة زاوية', 'price': '150,000', 'oldPrice': '200,000', 'category': 'أثاث ومنزل', 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200', 'rating': 4.5, 'sales': 156},
    {'id': '10', 'name': 'مندي يمني', 'price': '3,500', 'oldPrice': null, 'category': 'مطاعم', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200', 'rating': 4.8, 'sales': 2340},
    {'id': '11', 'name': 'سماعات ايربودز', 'price': '35,000', 'oldPrice': '50,000', 'category': 'إلكترونيات', 'image': 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=200', 'rating': 4.7, 'sales': 2340},
    {'id': '12', 'name': 'سجادة صلاة', 'price': '5,000', 'oldPrice': '8,000', 'category': 'منتجات', 'image': 'https://images.unsplash.com/photo-1581539250439-c96689b516dd?w=200', 'rating': 4.5, 'sales': 345},
    {'id': '13', 'name': 'عطر توم فورد', 'price': '45,000', 'oldPrice': '60,000', 'category': 'عطور', 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=200', 'rating': 4.8, 'sales': 567},
    {'id': '14', 'name': 'آيباد برو', 'price': '280,000', 'oldPrice': null, 'category': 'إلكترونيات', 'image': 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=200', 'rating': 4.9, 'sales': 1234},
    {'id': '15', 'name': 'بلاي ستيشن 5', 'price': '250,000', 'oldPrice': '350,000', 'category': 'ألعاب', 'image': 'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=200', 'rating': 4.8, 'sales': 567},
    {'id': '16', 'name': 'كاميرا كانون', 'price': '120,000', 'oldPrice': '150,000', 'category': 'كاميرات', 'image': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=200', 'rating': 4.6, 'sales': 234},
    {'id': '17', 'name': 'لابتوب ديل', 'price': '350,000', 'oldPrice': '450,000', 'category': 'إلكترونيات', 'image': 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=200', 'rating': 4.7, 'sales': 345},
    {'id': '18', 'name': 'ساعة رولكس', 'price': '850,000', 'oldPrice': '1,000,000', 'category': 'ساعات', 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=200', 'rating': 4.9, 'sales': 89},
    {'id': '19', 'name': 'شنطة ظهر', 'price': '15,000', 'oldPrice': '25,000', 'category': 'حقائب', 'image': 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=200', 'rating': 4.5, 'sales': 789},
    {'id': '20', 'name': 'حذاء رياضي', 'price': '25,000', 'oldPrice': '40,000', 'category': 'أحذية', 'image': 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=200', 'rating': 4.7, 'sales': 1234},
    {'id': '21', 'name': 'قلم فاخر', 'price': '500', 'oldPrice': '1,000', 'category': 'مكتبية', 'image': 'https://images.unsplash.com/photo-1596496181871-9681eacf9764?w=200', 'rating': 4.6, 'sales': 2345},
    {'id': '22', 'name': 'دفتر ملاحظات', 'price': '200', 'oldPrice': '500', 'category': 'مكتبية', 'image': 'https://images.unsplash.com/photo-1596496181871-9681eacf9764?w=200', 'rating': 4.5, 'sales': 3456},
    {'id': '23', 'name': 'طقم رياضي', 'price': '35,000', 'oldPrice': '50,000', 'category': 'رياضة', 'image': 'https://images.unsplash.com/photo-1461896836934-ffe807baa261?w=200', 'rating': 4.7, 'sales': 456},
    {'id': '24', 'name': 'دراجة هوائية', 'price': '45,000', 'oldPrice': '60,000', 'category': 'رياضة', 'image': 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=200', 'rating': 4.8, 'sales': 234},
    {'id': '25', 'name': 'كتاب تعليمي', 'price': '3,000', 'oldPrice': null, 'category': 'كتب', 'image': 'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=200', 'rating': 4.6, 'sales': 567},
    {'id': '26', 'name': 'رواية عربية', 'price': '2,000', 'oldPrice': null, 'category': 'كتب', 'image': 'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=200', 'rating': 4.5, 'sales': 890},
    {'id': '27', 'name': 'سلة غذاء متكاملة', 'price': '25,000', 'oldPrice': '35,000', 'category': 'مواد غذائية', 'image': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=200', 'rating': 4.6, 'sales': 234},
    {'id': '28', 'name': 'حليب أطفال', 'price': '2,500', 'oldPrice': null, 'category': 'أطفال', 'image': 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=200', 'rating': 4.7, 'sales': 1234},
    {'id': '29', 'name': 'عسل طبيعي', 'price': '3,000', 'oldPrice': '5,000', 'category': 'تمور وعسل', 'image': 'https://images.unsplash.com/photo-1587049352847-4a222e784d33?w=200', 'rating': 4.8, 'sales': 567},
  ];

  // ==================== 5. المولات والمعارض (15+ مول) ====================
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
}
