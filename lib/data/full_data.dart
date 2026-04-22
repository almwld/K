import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// ==================== نموذج الفئة ====================
class CategoryModel {
  final String id;
  final String name;
  final String nameEn;
  final IconData icon;
  final Color color;
  final String imageUrl;
  final int productCount;
  final List<SubcategoryModel> subcategories;
  
  CategoryModel({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.icon,
    required this.color,
    required this.imageUrl,
    required this.productCount,
    required this.subcategories,
  });
}

// ==================== نموذج القسم الفرعي ====================
class SubcategoryModel {
  final String id;
  final String name;
  final String nameEn;
  final int productCount;
  
  SubcategoryModel({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.productCount,
  });
}

// ==================== نموذج المتجر ====================
class StoreModel {
  final String id;
  final String name;
  final String category;
  final String subcategory;
  final double rating;
  final int reviews;
  final int products;
  final int followers;
  final bool isOpen;
  final bool isVerified;
  final String address;
  final String city;
  final String phone;
  final String description;
  final String? logoUrl;
  final String? coverUrl;
  
  StoreModel({
    required this.id,
    required this.name,
    required this.category,
    required this.subcategory,
    required this.rating,
    required this.reviews,
    required this.products,
    required this.followers,
    required this.isOpen,
    required this.isVerified,
    required this.address,
    required this.city,
    required this.phone,
    required this.description,
    this.logoUrl,
    this.coverUrl,
  });
}

// ==================== نموذج المنتج ====================
class ProductModel {
  final String id;
  final String name;
  final int price;
  final int? oldPrice;
  final int discount;
  final String category;
  final String store;
  final double rating;
  final int reviews;
  final int sales;
  final bool inStock;
  final bool isNew;
  final bool isFeatured;
  final String imageUrl;
  
  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    this.oldPrice,
    required this.discount,
    required this.category,
    required this.store,
    required this.rating,
    required this.reviews,
    required this.sales,
    required this.inStock,
    required this.isNew,
    required this.isFeatured,
    required this.imageUrl,
  });
  
  int get discountPercentage => discount;
  bool get hasDiscount => discount > 0;
  String get formattedPrice => '$price';
}

// ==================== نموذج المول ====================
class MallModel {
  final String id;
  final String name;
  final String city;
  final int storesCount;
  final double rating;
  final String imageUrl;
  
  MallModel({
    required this.id,
    required this.name,
    required this.city,
    required this.storesCount,
    required this.rating,
    required this.imageUrl,
  });
}

// ==================== البيانات الكاملة ====================
class FullData {
  
  // ========== الأقسام الفرعية ==========
  
  static List<SubcategoryModel> getElectronicsSubcategories() => [
    SubcategoryModel(id: 'smartphones', name: 'هواتف ذكية', nameEn: 'Smartphones', productCount: 234),
    SubcategoryModel(id: 'laptops', name: 'لابتوبات', nameEn: 'Laptops', productCount: 156),
    SubcategoryModel(id: 'tablets', name: 'تابلت', nameEn: 'Tablets', productCount: 89),
    SubcategoryModel(id: 'headphones', name: 'سماعات', nameEn: 'Headphones', productCount: 123),
    SubcategoryModel(id: 'cameras', name: 'كاميرات', nameEn: 'Cameras', productCount: 67),
    SubcategoryModel(id: 'tv', name: 'شاشات', nameEn: 'TVs', productCount: 78),
    SubcategoryModel(id: 'gaming', name: 'ألعاب', nameEn: 'Gaming', productCount: 89),
  ];
  
  static List<SubcategoryModel> getFashionSubcategories() => [
    SubcategoryModel(id: 'mens', name: 'ملابس رجالية', nameEn: "Men's Clothing", productCount: 345),
    SubcategoryModel(id: 'womens', name: 'ملابس نسائية', nameEn: "Women's Clothing", productCount: 456),
    SubcategoryModel(id: 'kids', name: 'ملابس أطفال', nameEn: "Kids' Clothing", productCount: 234),
    SubcategoryModel(id: 'shoes', name: 'أحذية', nameEn: 'Shoes', productCount: 189),
    SubcategoryModel(id: 'bags', name: 'شنط', nameEn: 'Bags', productCount: 156),
    SubcategoryModel(id: 'traditional', name: 'ملابس تقليدية', nameEn: 'Traditional', productCount: 89),
  ];
  
  static List<SubcategoryModel> getCarsSubcategories() => [
    SubcategoryModel(id: 'new', name: 'سيارات جديدة', nameEn: 'New Cars', productCount: 89),
    SubcategoryModel(id: 'used', name: 'سيارات مستعملة', nameEn: 'Used Cars', productCount: 234),
    SubcategoryModel(id: 'spare', name: 'قطع غيار', nameEn: 'Spare Parts', productCount: 456),
    SubcategoryModel(id: 'tires', name: 'إطارات', nameEn: 'Tires', productCount: 123),
  ];
  
  static List<SubcategoryModel> getRealEstateSubcategories() => [
    SubcategoryModel(id: 'villas', name: 'فلل وقصور', nameEn: 'Villas', productCount: 89),
    SubcategoryModel(id: 'apartments', name: 'شقق', nameEn: 'Apartments', productCount: 234),
    SubcategoryModel(id: 'lands', name: 'أراضي', nameEn: 'Lands', productCount: 156),
    SubcategoryModel(id: 'shops', name: 'محلات تجارية', nameEn: 'Shops', productCount: 123),
    SubcategoryModel(id: 'offices', name: 'مكاتب', nameEn: 'Offices', productCount: 67),
  ];
  
  static List<SubcategoryModel> getFurnitureSubcategories() => [
    SubcategoryModel(id: 'bedrooms', name: 'غرف نوم', nameEn: 'Bedrooms', productCount: 234),
    SubcategoryModel(id: 'majlis', name: 'مجالس', nameEn: 'Majlis', productCount: 156),
    SubcategoryModel(id: 'living', name: 'صالات', nameEn: 'Living Rooms', productCount: 189),
    SubcategoryModel(id: 'kitchens', name: 'مطابخ', nameEn: 'Kitchens', productCount: 123),
    SubcategoryModel(id: 'decoration', name: 'ديكور', nameEn: 'Decoration', productCount: 234),
  ];
  
  static List<SubcategoryModel> getRestaurantsSubcategories() => [
    SubcategoryModel(id: 'arabic', name: 'مطاعم عربية', nameEn: 'Arabic', productCount: 89),
    SubcategoryModel(id: 'western', name: 'مطاعم غربية', nameEn: 'Western', productCount: 67),
    SubcategoryModel(id: 'cafes', name: 'كافيهات', nameEn: 'Cafes', productCount: 78),
    SubcategoryModel(id: 'fastfood', name: 'وجبات سريعة', nameEn: 'Fast Food', productCount: 123),
  ];
  
  // ========== الفئات الرئيسية (45 فئة) ==========
  
  static List<CategoryModel> getAllCategories() {
    return [
      CategoryModel(
        id: 'electronics', name: 'إلكترونيات', nameEn: 'Electronics',
        icon: Icons.devices, color: AppTheme.serviceBlue,
        imageUrl: 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=300',
        productCount: 1250, subcategories: getElectronicsSubcategories(),
      ),
      CategoryModel(
        id: 'fashion', name: 'أزياء وملابس', nameEn: 'Fashion',
        icon: Icons.checkroom, color: Colors.pink,
        imageUrl: 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=300',
        productCount: 2340, subcategories: getFashionSubcategories(),
      ),
      CategoryModel(
        id: 'cars', name: 'سيارات', nameEn: 'Cars',
        icon: Icons.directions_car, color: Colors.red,
        imageUrl: 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=300',
        productCount: 890, subcategories: getCarsSubcategories(),
      ),
      CategoryModel(
        id: 'realestate', name: 'عقارات', nameEn: 'Real Estate',
        icon: Icons.home, color: AppTheme.serviceGreen,
        imageUrl: 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=300',
        productCount: 456, subcategories: getRealEstateSubcategories(),
      ),
      CategoryModel(
        id: 'furniture', name: 'أثاث ومنزل', nameEn: 'Furniture',
        icon: Icons.chair, color: Colors.orange,
        imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=300',
        productCount: 789, subcategories: getFurnitureSubcategories(),
      ),
      CategoryModel(
        id: 'restaurants', name: 'مطاعم', nameEn: 'Restaurants',
        icon: Icons.restaurant, color: Colors.deepOrange,
        imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=300',
        productCount: 456, subcategories: getRestaurantsSubcategories(),
      ),
      CategoryModel(
        id: 'services', name: 'خدمات', nameEn: 'Services',
        icon: Icons.build, color: Colors.blueGrey,
        imageUrl: 'https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=300',
        productCount: 345, subcategories: [
          SubcategoryModel(id: 'cleaning', name: 'تنظيف', nameEn: 'Cleaning', productCount: 89),
          SubcategoryModel(id: 'maintenance', name: 'صيانة', nameEn: 'Maintenance', productCount: 67),
          SubcategoryModel(id: 'plumbing', name: 'سباكة', nameEn: 'Plumbing', productCount: 45),
        ],
      ),
      CategoryModel(
        id: 'beauty', name: 'صحة وجمال', nameEn: 'Health & Beauty',
        icon: Icons.favorite, color: Colors.pink,
        imageUrl: 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300',
        productCount: 678, subcategories: [
          SubcategoryModel(id: 'skincare', name: 'عناية بالبشرة', nameEn: 'Skincare', productCount: 234),
          SubcategoryModel(id: 'haircare', name: 'عناية بالشعر', nameEn: 'Haircare', productCount: 189),
          SubcategoryModel(id: 'makeup', name: 'مكياج', nameEn: 'Makeup', productCount: 156),
        ],
      ),
      CategoryModel(
        id: 'sports', name: 'رياضة ولياقة', nameEn: 'Sports',
        icon: Icons.sports_soccer, color: AppTheme.serviceGreen,
        imageUrl: 'https://images.unsplash.com/photo-1461896836934-ffe807baa261?w=300',
        productCount: 345, subcategories: [
          SubcategoryModel(id: 'equipment', name: 'معدات رياضية', nameEn: 'Equipment', productCount: 123),
          SubcategoryModel(id: 'clothing', name: 'ملابس رياضية', nameEn: 'Clothing', productCount: 89),
        ],
      ),
      CategoryModel(
        id: 'books', name: 'كتب ومكتبات', nameEn: 'Books',
        icon: Icons.menu_book, color: Colors.brown,
        imageUrl: 'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=300',
        productCount: 2340, subcategories: [
          SubcategoryModel(id: 'islamic', name: 'كتب إسلامية', nameEn: 'Islamic', productCount: 456),
          SubcategoryModel(id: 'novels', name: 'روايات', nameEn: 'Novels', productCount: 789),
        ],
      ),
      CategoryModel(
        id: 'phones', name: 'جوالات', nameEn: 'Mobile Phones',
        icon: Icons.phone_android, color: Colors.teal,
        imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=300',
        productCount: 567, subcategories: [
          SubcategoryModel(id: 'iphone', name: 'آيفون', nameEn: 'iPhone', productCount: 123),
          SubcategoryModel(id: 'samsung', name: 'سامسونج', nameEn: 'Samsung', productCount: 156),
          SubcategoryModel(id: 'xiaomi', name: 'شاومي', nameEn: 'Xiaomi', productCount: 89),
        ],
      ),
      CategoryModel(
        id: 'computers', name: 'كمبيوترات', nameEn: 'Computers',
        icon: Icons.computer, color: Colors.indigo,
        imageUrl: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=300',
        productCount: 345, subcategories: [
          SubcategoryModel(id: 'laptops', name: 'لابتوب', nameEn: 'Laptops', productCount: 156),
          SubcategoryModel(id: 'desktops', name: 'كمبيوتر مكتبي', nameEn: 'Desktops', productCount: 89),
        ],
      ),
      CategoryModel(
        id: 'jewelry', name: 'مجوهرات', nameEn: 'Jewelry',
        icon: Icons.diamond, color: Colors.amber,
        imageUrl: 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=300',
        productCount: 345, subcategories: [
          SubcategoryModel(id: 'gold', name: 'ذهب', nameEn: 'Gold', productCount: 123),
          SubcategoryModel(id: 'silver', name: 'فضة', nameEn: 'Silver', productCount: 89),
        ],
      ),
      CategoryModel(
        id: 'watches', name: 'ساعات', nameEn: 'Watches',
        icon: Icons.watch, color: Colors.blueGrey,
        imageUrl: 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=300',
        productCount: 234, subcategories: [
          SubcategoryModel(id: 'luxury', name: 'ساعات فاخرة', nameEn: 'Luxury', productCount: 89),
          SubcategoryModel(id: 'smart', name: 'ساعات ذكية', nameEn: 'Smart', productCount: 123),
        ],
      ),
      CategoryModel(
        id: 'perfumes', name: 'عطور', nameEn: 'Perfumes',
        icon: Icons.emoji_emotions, color: Colors.pinkAccent,
        imageUrl: 'https://images.unsplash.com/photo-1541643600914-78b084683601?w=300',
        productCount: 456, subcategories: [
          SubcategoryModel(id: 'mens', name: 'عطور رجالية', nameEn: "Men's", productCount: 189),
          SubcategoryModel(id: 'womens', name: 'عطور نسائية', nameEn: "Women's", productCount: 234),
        ],
      ),
      CategoryModel(
        id: 'games', name: 'ألعاب', nameEn: 'Games',
        icon: Icons.sports_esports, color: Colors.purple,
        imageUrl: 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=300',
        productCount: 456, subcategories: [
          SubcategoryModel(id: 'playstation', name: 'بلاي ستيشن', nameEn: 'PlayStation', productCount: 123),
          SubcategoryModel(id: 'xbox', name: 'إكس بوكس', nameEn: 'Xbox', productCount: 89),
        ],
      ),
      CategoryModel(
        id: 'baby', name: 'أطفال ومستلزمات', nameEn: 'Baby & Kids',
        icon: Icons.child_care, color: Colors.lightBlue,
        imageUrl: 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=300',
        productCount: 567, subcategories: [
          SubcategoryModel(id: 'toys', name: 'ألعاب', nameEn: 'Toys', productCount: 234),
          SubcategoryModel(id: 'clothing', name: 'ملابس أطفال', nameEn: 'Clothing', productCount: 189),
        ],
      ),
      CategoryModel(
        id: 'pets', name: 'حيوانات أليفة', nameEn: 'Pets',
        icon: Icons.pets, color: Colors.brown,
        imageUrl: 'https://images.unsplash.com/photo-1450778869180-41d0601e046e?w=300',
        productCount: 234, subcategories: [
          SubcategoryModel(id: 'dogs', name: 'كلاب', nameEn: 'Dogs', productCount: 89),
          SubcategoryModel(id: 'cats', name: 'قطط', nameEn: 'Cats', productCount: 78),
        ],
      ),
      CategoryModel(
        id: 'groceries', name: 'مواد غذائية', nameEn: 'Groceries',
        icon: Icons.local_grocery_store, color: Colors.lightGreen,
        imageUrl: 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=300',
        productCount: 890, subcategories: [
          SubcategoryModel(id: 'rice', name: 'أرز وحبوب', nameEn: 'Rice', productCount: 234),
          SubcategoryModel(id: 'oil', name: 'زيوت', nameEn: 'Oil', productCount: 156),
        ],
      ),
      CategoryModel(
        id: 'tvs', name: 'شاشات', nameEn: 'TVs',
        icon: Icons.tv, color: Colors.cyan,
        imageUrl: 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=300',
        productCount: 234, subcategories: [
          SubcategoryModel(id: 'samsung', name: 'سامسونج', nameEn: 'Samsung', productCount: 67),
          SubcategoryModel(id: 'lg', name: 'إل جي', nameEn: 'LG', productCount: 45),
        ],
      ),
    ];
  }
    
  // ========== المتاجر (مختصرة للبناء) ==========
  
  static List<StoreModel> getAllStores() {
    return [
      StoreModel(id: 'store_1', name: 'متجر التقنية الحديثة', category: 'إلكترونيات', subcategory: 'هواتف ذكية',
        rating: 4.8, reviews: 128, products: 156, followers: 1234,
        isOpen: true, isVerified: true, address: 'شارع الستين، صنعاء', city: 'صنعاء',
        phone: '777123456', description: 'أفضل متجر إلكترونيات في اليمن'),
      StoreModel(id: 'store_2', name: 'عالم الجوالات', category: 'إلكترونيات', subcategory: 'هواتف ذكية',
        rating: 4.7, reviews: 234, products: 234, followers: 2345,
        isOpen: true, isVerified: true, address: 'شارع حدة، صنعاء', city: 'صنعاء',
        phone: '777234567', description: 'جميع أنواع الجوالات'),
      StoreModel(id: 'store_3', name: 'كمبيوتر مول', category: 'إلكترونيات', subcategory: 'لابتوبات',
        rating: 4.9, reviews: 89, products: 89, followers: 3456,
        isOpen: true, isVerified: true, address: 'شارع الزراعة، صنعاء', city: 'صنعاء',
        phone: '777345678', description: 'أجهزة كمبيوتر محترفة'),
      StoreModel(id: 'store_4', name: 'الأزياء العصرية', category: 'أزياء', subcategory: 'ملابس رجالية',
        rating: 4.6, reviews: 345, products: 456, followers: 4567,
        isOpen: true, isVerified: true, address: 'شارع التحرير، صنعاء', city: 'صنعاء',
        phone: '777456789', description: 'أحدث صيحات الموضة'),
      StoreModel(id: 'store_5', name: 'موضة اليمن', category: 'أزياء', subcategory: 'ملابس تقليدية',
        rating: 4.8, reviews: 567, products: 234, followers: 5678,
        isOpen: true, isVerified: true, address: 'شارع الستين، صنعاء', city: 'صنعاء',
        phone: '777567890', description: 'ملابس يمنية أصيلة'),
      StoreModel(id: 'store_6', name: 'معرض السيارات الحديثة', category: 'سيارات', subcategory: 'سيارات جديدة',
        rating: 4.8, reviews: 234, products: 89, followers: 6789,
        isOpen: true, isVerified: true, address: 'شارع الستين، صنعاء', city: 'صنعاء',
        phone: '777678901', description: 'أحدث موديلات السيارات'),
      StoreModel(id: 'store_7', name: 'عقارات فلكس', category: 'عقارات', subcategory: 'فلل',
        rating: 4.7, reviews: 89, products: 45, followers: 7890,
        isOpen: true, isVerified: true, address: 'شارع الزراعة، صنعاء', city: 'صنعاء',
        phone: '777789012', description: 'أفضل العروض العقارية'),
      StoreModel(id: 'store_8', name: 'أثاث المنزل', category: 'أثاث', subcategory: 'غرف نوم',
        rating: 4.5, reviews: 234, products: 156, followers: 8901,
        isOpen: true, isVerified: false, address: 'شارع حدة، صنعاء', city: 'صنعاء',
        phone: '777890123', description: 'أثاث منزلي فاخر'),
      StoreModel(id: 'store_9', name: 'مطعم مندي الملكي', category: 'مطاعم', subcategory: 'مطاعم عربية',
        rating: 4.9, reviews: 567, products: 34, followers: 9012,
        isOpen: true, isVerified: true, address: 'شارع الستين، صنعاء', city: 'صنعاء',
        phone: '777901234', description: 'أشهى المأكولات اليمنية'),
      StoreModel(id: 'store_10', name: 'سوبر ماركت السعادة', category: 'مواد غذائية', subcategory: 'مواد غذائية',
        rating: 4.5, reviews: 567, products: 234, followers: 3456,
        isOpen: true, isVerified: true, address: 'شارع الستين، صنعاء', city: 'صنعاء',
        phone: '777234567', description: 'جميع احتياجات المنزل'),
    ];
  }
  
  // ========== المنتجات (29 منتج) ==========
  
  static List<ProductModel> getAllProducts() {
    return [
      ProductModel(id: 'p1', name: 'iPhone 15 Pro', price: 350000, oldPrice: 450000, discount: 22,
        category: 'إلكترونيات', store: 'متجر التقنية الحديثة',
        rating: 4.8, reviews: 128, sales: 1250, inStock: true, isNew: true, isFeatured: true,
        imageUrl: 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=300'),
      ProductModel(id: 'p2', name: 'iPhone 15 Pro Max', price: 450000, oldPrice: 550000, discount: 18,
        category: 'إلكترونيات', store: 'متجر التقنية الحديثة',
        rating: 4.9, reviews: 98, sales: 890, inStock: true, isNew: true, isFeatured: true,
        imageUrl: 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=300'),
      ProductModel(id: 'p3', name: 'Samsung S24 Ultra', price: 380000, oldPrice: 480000, discount: 21,
        category: 'إلكترونيات', store: 'عالم الجوالات',
        rating: 4.7, reviews: 234, sales: 2340, inStock: true, isNew: true, isFeatured: true,
        imageUrl: 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=300'),
      ProductModel(id: 'p4', name: 'Samsung S24', price: 320000, oldPrice: 400000, discount: 20,
        category: 'إلكترونيات', store: 'عالم الجوالات',
        rating: 4.6, reviews: 189, sales: 1560, inStock: true, isNew: true, isFeatured: false,
        imageUrl: 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=300'),
      ProductModel(id: 'p5', name: 'MacBook Pro M3', price: 1800000, oldPrice: 2100000, discount: 14,
        category: 'إلكترونيات', store: 'كمبيوتر مول',
        rating: 4.9, reviews: 67, sales: 456, inStock: true, isNew: true, isFeatured: true,
        imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=300'),
      ProductModel(id: 'p6', name: 'MacBook Air M3', price: 1400000, oldPrice: 1600000, discount: 13,
        category: 'إلكترونيات', store: 'كمبيوتر مول',
        rating: 4.8, reviews: 89, sales: 567, inStock: true, isNew: true, isFeatured: true,
        imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=300'),
      ProductModel(id: 'p7', name: 'Dell XPS 15', price: 1200000, oldPrice: 1500000, discount: 20,
        category: 'إلكترونيات', store: 'كمبيوتر مول',
        rating: 4.7, reviews: 45, sales: 234, inStock: true, isNew: false, isFeatured: false,
        imageUrl: 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=300'),
      ProductModel(id: 'p8', name: 'Apple Watch Series 9', price: 45000, oldPrice: 60000, discount: 25,
        category: 'إلكترونيات', store: 'متجر التقنية الحديثة',
        rating: 4.7, reviews: 234, sales: 2340, inStock: true, isNew: true, isFeatured: true,
        imageUrl: 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=300'),
      ProductModel(id: 'p9', name: 'Samsung Galaxy Watch 6', price: 35000, oldPrice: 50000, discount: 30,
        category: 'إلكترونيات', store: 'عالم الجوالات',
        rating: 4.6, reviews: 156, sales: 1230, inStock: true, isNew: true, isFeatured: false,
        imageUrl: 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=300'),
      ProductModel(id: 'p10', name: 'AirPods Pro 2', price: 35000, oldPrice: 45000, discount: 22,
        category: 'إلكترونيات', store: 'متجر التقنية الحديثة',
        rating: 4.7, reviews: 345, sales: 3450, inStock: true, isNew: true, isFeatured: true,
        imageUrl: 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=300'),
      ProductModel(id: 'p11', name: 'iPad Pro 12.9', price: 280000, oldPrice: 350000, discount: 20,
        category: 'إلكترونيات', store: 'كمبيوتر مول',
        rating: 4.8, reviews: 78, sales: 567, inStock: true, isNew: true, isFeatured: true,
        imageUrl: 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=300'),
      ProductModel(id: 'p12', name: 'ثوب يمني فاخر', price: 35000, oldPrice: null, discount: 0,
        category: 'أزياء', store: 'الأزياء العصرية',
        rating: 4.6, reviews: 456, sales: 2340, inStock: true, isNew: false, isFeatured: true,
        imageUrl: 'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=300'),
      ProductModel(id: 'p13', name: 'عباية فاخرة', price: 30000, oldPrice: null, discount: 0,
        category: 'أزياء', store: 'الأزياء العصرية',
        rating: 4.7, reviews: 234, sales: 1560, inStock: true, isNew: false, isFeatured: true,
        imageUrl: 'https://images.unsplash.com/photo-1583394293214-ff7b3f5ad7cc?w=300'),
      ProductModel(id: 'p14', name: 'بدلة رجالية', price: 45000, oldPrice: 60000, discount: 25,
        category: 'أزياء', store: 'موضة اليمن',
        rating: 4.4, reviews: 189, sales: 890, inStock: true, isNew: false, isFeatured: false,
        imageUrl: 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=300'),
      ProductModel(id: 'p15', name: 'ساعة رولكس', price: 850000, oldPrice: 1000000, discount: 15,
        category: 'ساعات', store: 'مجوهرات الذهب اليمني',
        rating: 4.9, reviews: 67, sales: 234, inStock: true, isNew: false, isFeatured: true,
        imageUrl: 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=300'),
      ProductModel(id: 'p16', name: 'عطر توم فورد', price: 45000, oldPrice: 60000, discount: 25,
        category: 'عطور', store: 'عطور الشرق',
        rating: 4.7, reviews: 234, sales: 1230, inStock: true, isNew: true, isFeatured: true,
        imageUrl: 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=300'),
      ProductModel(id: 'p17', name: 'مندي يمني', price: 3500, oldPrice: null, discount: 0,
        category: 'مطاعم', store: 'مطعم مندي الملكي',
        rating: 4.8, reviews: 567, sales: 4560, inStock: true, isNew: false, isFeatured: true,
        imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=300'),
      ProductModel(id: 'p18', name: 'زربيان', price: 4000, oldPrice: null, discount: 0,
        category: 'مطاعم', store: 'مطعم مندي الملكي',
        rating: 4.7, reviews: 345, sales: 2340, inStock: true, isNew: false, isFeatured: false,
        imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=300'),
      ProductModel(id: 'p19', name: 'كنبة زاوية', price: 150000, oldPrice: 200000, discount: 25,
        category: 'أثاث', store: 'أثاث المنزل',
        rating: 4.5, reviews: 234, sales: 890, inStock: true, isNew: false, isFeatured: true,
        imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=300'),
      ProductModel(id: 'p20', name: 'طاولة طعام', price: 75000, oldPrice: 100000, discount: 25,
        category: 'أثاث', store: 'أثاث المنزل',
        rating: 4.6, reviews: 189, sales: 567, inStock: true, isNew: false, isFeatured: false,
        imageUrl: 'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?w=300'),
      ProductModel(id: 'p21', name: 'تويوتا كامري 2024', price: 8500000, oldPrice: null, discount: 0,
        category: 'سيارات', store: 'معرض السيارات الحديثة',
        rating: 4.8, reviews: 45, sales: 23, inStock: true, isNew: true, isFeatured: true,
        imageUrl: 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=300'),
      ProductModel(id: 'p22', name: 'فيلا فاخرة صنعاء', price: 45000000, oldPrice: null, discount: 0,
        category: 'عقارات', store: 'عقارات فلكس',
        rating: 4.9, reviews: 23, sales: 5, inStock: true, isNew: true, isFeatured: true,
        imageUrl: 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=300'),
      ProductModel(id: 'p23', name: 'شقة 3 غرف عدن', price: 18000000, oldPrice: null, discount: 0,
        category: 'عقارات', store: 'عقارات فلكس',
        rating: 4.7, reviews: 34, sales: 12, inStock: true, isNew: false, isFeatured: false,
        imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=300'),
      ProductModel(id: 'p24', name: 'سامسونج تلفزيون 65 بوصة', price: 350000, oldPrice: 500000, discount: 30,
        category: 'إلكترونيات', store: 'متجر التقنية الحديثة',
        rating: 4.7, reviews: 89, sales: 234, inStock: true, isNew: false, isFeatured: true,
        imageUrl: 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=300'),
      ProductModel(id: 'p25', name: 'بلاي ستيشن 5', price: 250000, oldPrice: 350000, discount: 28,
        category: 'ألعاب', store: 'متجر التقنية الحديثة',
        rating: 4.8, reviews: 234, sales: 890, inStock: true, isNew: false, isFeatured: true,
        imageUrl: 'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=300'),
      ProductModel(id: 'p26', name: 'كانون كاميرا EOS R50', price: 120000, oldPrice: 150000, discount: 20,
        category: 'إلكترونيات', store: 'متجر التقنية الحديثة',
        rating: 4.6, reviews: 45, sales: 123, inStock: true, isNew: true, isFeatured: false,
        imageUrl: 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=300'),
      ProductModel(id: 'p27', name: 'لابتوب ديل XPS', price: 350000, oldPrice: 450000, discount: 22,
        category: 'إلكترونيات', store: 'كمبيوتر مول',
        rating: 4.7, reviews: 67, sales: 234, inStock: true, isNew: false, isFeatured: false,
        imageUrl: 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=300'),
      ProductModel(id: 'p28', name: 'سماعات سوني WH-1000XM5', price: 45000, oldPrice: 60000, discount: 25,
        category: 'إلكترونيات', store: 'متجر التقنية الحديثة',
        rating: 4.8, reviews: 123, sales: 890, inStock: true, isNew: true, isFeatured: true,
        imageUrl: 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=300'),
      ProductModel(id: 'p29', name: 'سجادة صلاة فاخرة', price: 5000, oldPrice: 8000, discount: 37,
        category: 'أثاث', store: 'أثاث المنزل',
        rating: 4.5, reviews: 234, sales: 2340, inStock: true, isNew: false, isFeatured: false,
        imageUrl: 'https://images.unsplash.com/photo-1581539250439-c96689b516dd?w=300'),
    ];
  }
  
  // ========== المولات ==========
  
  static List<MallModel> getAllMalls() {
    return [
      MallModel(id: 'mall_1', name: 'اليمن مول', city: 'صنعاء', storesCount: 250, rating: 4.7, imageUrl: ''),
      MallModel(id: 'mall_2', name: 'سيتي مول', city: 'صنعاء', storesCount: 180, rating: 4.6, imageUrl: ''),
      MallModel(id: 'mall_3', name: 'غاليري مول', city: 'صنعاء', storesCount: 120, rating: 4.8, imageUrl: ''),
      MallModel(id: 'mall_4', name: 'رد سي مول', city: 'صنعاء', storesCount: 90, rating: 4.5, imageUrl: ''),
      MallModel(id: 'mall_5', name: 'الموج مول', city: 'عدن', storesCount: 150, rating: 4.7, imageUrl: ''),
      MallModel(id: 'mall_6', name: 'كريتر مول', city: 'عدن', storesCount: 100, rating: 4.6, imageUrl: ''),
      MallModel(id: 'mall_7', name: 'تعز مول', city: 'تعز', storesCount: 80, rating: 4.4, imageUrl: ''),
      MallModel(id: 'mall_8', name: 'الحديدة مول', city: 'الحديدة', storesCount: 70, rating: 4.3, imageUrl: ''),
      MallModel(id: 'mall_9', name: 'المكلا مول', city: 'المكلا', storesCount: 60, rating: 4.5, imageUrl: ''),
      MallModel(id: 'mall_10', name: 'إب مول', city: 'إب', storesCount: 50, rating: 4.2, imageUrl: ''),
      MallModel(id: 'mall_11', name: 'معرض السيارات الحديثة', city: 'صنعاء', storesCount: 45, rating: 4.8, imageUrl: ''),
      MallModel(id: 'mall_12', name: 'معرض السيارات الفاخرة', city: 'عدن', storesCount: 30, rating: 4.7, imageUrl: ''),
      MallModel(id: 'mall_13', name: 'مجمع الذهب والمجوهرات', city: 'صنعاء', storesCount: 40, rating: 4.9, imageUrl: ''),
      MallModel(id: 'mall_14', name: 'سوق العطور الفاخرة', city: 'صنعاء', storesCount: 35, rating: 4.8, imageUrl: ''),
      MallModel(id: 'mall_15', name: 'مجمع الأثاث الفاخر', city: 'صنعاء', storesCount: 50, rating: 4.6, imageUrl: ''),
    ];
  }
  
  // ========== إحصائيات ==========
  
  static Map<String, dynamic> getStats() {
    return {
      'totalCategories': getAllCategories().length,
      'totalStores': getAllStores().length,
      'totalProducts': getAllProducts().length,
      'totalMalls': getAllMalls().length,
    };
  }
}

// ==================== إكمال الفئات (45 فئة) ====================

extension FullDataExtension on FullData {
  
  // تكملة الفئات من 21 إلى 45
  static List<CategoryModel> getRemainingCategories() {
    return [
      // 21. شاشات
      CategoryModel(
        id: 'tvs_full', name: 'شاشات', nameEn: 'TVs & Screens',
        icon: Icons.tv, color: Colors.cyan,
        imageUrl: 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=300',
        productCount: 234, subcategories: [
          SubcategoryModel(id: 'samsung_tv', name: 'سامسونج', nameEn: 'Samsung', productCount: 67),
          SubcategoryModel(id: 'lg_tv', name: 'إل جي', nameEn: 'LG', productCount: 45),
          SubcategoryModel(id: 'sony_tv', name: 'سوني', nameEn: 'Sony', productCount: 34),
          SubcategoryModel(id: 'tcl_tv', name: 'تي سي إل', nameEn: 'TCL', productCount: 23),
        ],
      ),
      // 22. أجهزة منزلية
      CategoryModel(
        id: 'appliances', name: 'أجهزة منزلية', nameEn: 'Home Appliances',
        icon: Icons.kitchen, color: Colors.lightGreen,
        imageUrl: 'https://images.unsplash.com/photo-1586008214976-3d9d6c5f2e5d?w=300',
        productCount: 456, subcategories: [
          SubcategoryModel(id: 'refrigerators', name: 'ثلاجات', nameEn: 'Refrigerators', productCount: 89),
          SubcategoryModel(id: 'washing', name: 'غسالات', nameEn: 'Washing Machines', productCount: 78),
          SubcategoryModel(id: 'ac', name: 'مكيفات', nameEn: 'AC', productCount: 123),
          SubcategoryModel(id: 'ovens', name: 'أفران', nameEn: 'Ovens', productCount: 56),
        ],
      ),
      // 23. أدوات مطبخ
      CategoryModel(
        id: 'kitchen_tools', name: 'أدوات مطبخ', nameEn: 'Kitchen Tools',
        icon: Icons.coffee_maker, color: Colors.brown,
        imageUrl: 'https://images.unsplash.com/photo-1556909114-44e3ef1e0d71?w=300',
        productCount: 234, subcategories: [
          SubcategoryModel(id: 'cookware', name: 'قدور ومقالي', nameEn: 'Cookware', productCount: 123),
          SubcategoryModel(id: 'utensils', name: 'أدوات', nameEn: 'Utensils', productCount: 89),
          SubcategoryModel(id: 'cutlery', name: 'سكاكين', nameEn: 'Cutlery', productCount: 45),
        ],
      ),
      // 24. مواد غذائية
      CategoryModel(
        id: 'groceries_full', name: 'مواد غذائية', nameEn: 'Groceries',
        icon: Icons.local_grocery_store, color: Colors.green,
        imageUrl: 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=300',
        productCount: 890, subcategories: [
          SubcategoryModel(id: 'rice', name: 'أرز وحبوب', nameEn: 'Rice & Grains', productCount: 234),
          SubcategoryModel(id: 'oil', name: 'زيوت', nameEn: 'Oils', productCount: 156),
          SubcategoryModel(id: 'sugar', name: 'سكر', nameEn: 'Sugar', productCount: 89),
        ],
      ),
      // 25. خضروات وفواكه
      CategoryModel(
        id: 'vegetables', name: 'خضروات وفواكه', nameEn: 'Vegetables & Fruits',
        icon: Icons.eco, color: Colors.green,
        imageUrl: 'https://images.unsplash.com/photo-1566385101042-1a0aa0c1268c?w=300',
        productCount: 567, subcategories: [
          SubcategoryModel(id: 'fresh_veg', name: 'خضروات طازجة', nameEn: 'Fresh Vegetables', productCount: 234),
          SubcategoryModel(id: 'fresh_fruit', name: 'فواكه طازجة', nameEn: 'Fresh Fruits', productCount: 189),
        ],
      ),
      // 26. لحوم ودواجن
      CategoryModel(
        id: 'meat', name: 'لحوم ودواجن', nameEn: 'Meat & Poultry',
        icon: Icons.agriculture, color: Colors.red,
        imageUrl: 'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?w=300',
        productCount: 345, subcategories: [
          SubcategoryModel(id: 'beef', name: 'لحم بقري', nameEn: 'Beef', productCount: 89),
          SubcategoryModel(id: 'chicken', name: 'دجاج', nameEn: 'Chicken', productCount: 156),
          SubcategoryModel(id: 'lamb', name: 'لحم غنم', nameEn: 'Lamb', productCount: 67),
        ],
      ),
      // 27. أسماك ومأكولات بحرية
      CategoryModel(
        id: 'seafood', name: 'أسماك ومأكولات بحرية', nameEn: 'Seafood',
        icon: Icons.set_meal, color: Colors.blue,
        imageUrl: 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=300',
        productCount: 234, subcategories: [
          SubcategoryModel(id: 'fish', name: 'أسماك', nameEn: 'Fish', productCount: 123),
          SubcategoryModel(id: 'shrimp', name: 'جمبري', nameEn: 'Shrimp', productCount: 67),
        ],
      ),
      // 28. منتجات ألبان
      CategoryModel(
        id: 'dairy', name: 'منتجات ألبان', nameEn: 'Dairy',
        icon: Icons.breakfast_dining, color: Colors.lightBlue,
        imageUrl: 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=300',
        productCount: 345, subcategories: [
          SubcategoryModel(id: 'milk', name: 'حليب', nameEn: 'Milk', productCount: 89),
          SubcategoryModel(id: 'cheese', name: 'جبن', nameEn: 'Cheese', productCount: 123),
          SubcategoryModel(id: 'yogurt', name: 'زبادي', nameEn: 'Yogurt', productCount: 78),
        ],
      ),
      // 29. مخبوزات
      CategoryModel(
        id: 'bakery', name: 'مخبوزات', nameEn: 'Bakery',
        icon: Icons.bakery_dining, color: Colors.orange,
        imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=300',
        productCount: 234, subcategories: [
          SubcategoryModel(id: 'bread', name: 'خبز', nameEn: 'Bread', productCount: 123),
          SubcategoryModel(id: 'pastries', name: 'معجنات', nameEn: 'Pastries', productCount: 89),
        ],
      ),
      // 30. حلويات
      CategoryModel(
        id: 'desserts', name: 'حلويات', nameEn: 'Desserts',
        icon: Icons.cake, color: Colors.pink,
        imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=300',
        productCount: 345, subcategories: [
          SubcategoryModel(id: 'cakes', name: 'كيك', nameEn: 'Cakes', productCount: 123),
          SubcategoryModel(id: 'arabic_sweets', name: 'حلويات عربية', nameEn: 'Arabic Sweets', productCount: 156),
        ],
      ),
      // 31. مشروبات
      CategoryModel(
        id: 'beverages', name: 'مشروبات', nameEn: 'Beverages',
        icon: Icons.local_drink, color: Colors.blue,
        imageUrl: 'https://images.unsplash.com/photo-1527960471264-932f39eb5846?w=300',
        productCount: 456, subcategories: [
          SubcategoryModel(id: 'soft_drinks', name: 'مشروبات غازية', nameEn: 'Soft Drinks', productCount: 234),
          SubcategoryModel(id: 'juices', name: 'عصائر', nameEn: 'Juices', productCount: 123),
          SubcategoryModel(id: 'water', name: 'مياه', nameEn: 'Water', productCount: 67),
        ],
      ),
      // 32. قهوة وشاي
      CategoryModel(
        id: 'coffee', name: 'قهوة وشاي', nameEn: 'Coffee & Tea',
        icon: Icons.coffee, color: Colors.brown,
        imageUrl: 'https://images.unsplash.com/photo-1442512595331-e89e73853f31?w=300',
        productCount: 234, subcategories: [
          SubcategoryModel(id: 'coffee_beans', name: 'بن', nameEn: 'Coffee Beans', productCount: 89),
          SubcategoryModel(id: 'tea', name: 'شاي', nameEn: 'Tea', productCount: 123),
        ],
      ),
      // 33. تمور وعسل
      CategoryModel(
        id: 'dates_honey', name: 'تمور وعسل', nameEn: 'Dates & Honey',
        icon: Icons.date_range, color: Colors.amber,
        imageUrl: 'https://images.unsplash.com/photo-1604671801908-29f0cb3b6162?w=300',
        productCount: 345, subcategories: [
          SubcategoryModel(id: 'dates', name: 'تمور', nameEn: 'Dates', productCount: 234),
          SubcategoryModel(id: 'honey', name: 'عسل', nameEn: 'Honey', productCount: 89),
        ],
      ),
      // 34. بهارات وتوابل
      CategoryModel(
        id: 'spices', name: 'بهارات وتوابل', nameEn: 'Spices',
        icon: Icons.grass, color: Colors.orange,
        imageUrl: 'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=300',
        productCount: 234, subcategories: [
          SubcategoryModel(id: 'mixed_spices', name: 'بهارات مشكلة', nameEn: 'Mixed Spices', productCount: 123),
          SubcategoryModel(id: 'single_spices', name: 'بهارات مفردة', nameEn: 'Single Spices', productCount: 89),
        ],
      ),
      // 35. زيوت ودهون
      CategoryModel(
        id: 'oils', name: 'زيوت ودهون', nameEn: 'Oils & Fats',
        icon: Icons.opacity, color: Colors.yellow,
        imageUrl: 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=300',
        productCount: 234, subcategories: [
          SubcategoryModel(id: 'olive_oil', name: 'زيت زيتون', nameEn: 'Olive Oil', productCount: 89),
          SubcategoryModel(id: 'vegetable_oil', name: 'زيت نباتي', nameEn: 'Vegetable Oil', productCount: 123),
        ],
      ),
      // 36. مواد بناء
      CategoryModel(
        id: 'construction', name: 'مواد بناء', nameEn: 'Construction',
        icon: Icons.construction, color: Colors.grey,
        imageUrl: 'https://images.unsplash.com/photo-1504917595217-d4dc5ebe6122?w=300',
        productCount: 567, subcategories: [
          SubcategoryModel(id: 'cement', name: 'اسمنت', nameEn: 'Cement', productCount: 234),
          SubcategoryModel(id: 'steel', name: 'حديد', nameEn: 'Steel', productCount: 189),
          SubcategoryModel(id: 'bricks', name: 'طوب', nameEn: 'Bricks', productCount: 123),
        ],
      ),
      // 37. أدوات كهربائية
      CategoryModel(
        id: 'electrical', name: 'أدوات كهربائية', nameEn: 'Electrical Tools',
        icon: Icons.electrical_services, color: Colors.yellow,
        imageUrl: 'https://images.unsplash.com/photo-1581147036323-c68037e363f7?w=300',
        productCount: 234, subcategories: [
          SubcategoryModel(id: 'wires', name: 'أسلاك', nameEn: 'Wires', productCount: 89),
          SubcategoryModel(id: 'switches', name: 'مفاتيح', nameEn: 'Switches', productCount: 123),
        ],
      ),
      // 38. أدوات سباكة
      CategoryModel(
        id: 'plumbing', name: 'أدوات سباكة', nameEn: 'Plumbing',
        icon: Icons.plumbing, color: Colors.blue,
        imageUrl: 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=300',
        productCount: 234, subcategories: [
          SubcategoryModel(id: 'pipes', name: 'مواسير', nameEn: 'Pipes', productCount: 89),
          SubcategoryModel(id: 'faucets', name: 'خلاطات', nameEn: 'Faucets', productCount: 123),
        ],
      ),
      // 39. أدوات نجارة
      CategoryModel(
        id: 'carpentry', name: 'أدوات نجارة', nameEn: 'Carpentry',
        icon: Icons.handyman, color: Colors.brown,
        imageUrl: 'https://images.unsplash.com/photo-1581147036323-c68037e363f7?w=300',
        productCount: 123, subcategories: [
          SubcategoryModel(id: 'wood', name: 'أخشاب', nameEn: 'Wood', productCount: 67),
          SubcategoryModel(id: 'tools', name: 'أدوات', nameEn: 'Tools', productCount: 45),
        ],
      ),
      // 40. أدوات حدادة
      CategoryModel(
        id: 'blacksmith', name: 'أدوات حدادة', nameEn: 'Blacksmith',
        icon: Icons.build, color: Colors.grey,
        imageUrl: 'https://images.unsplash.com/photo-1581147036323-c68037e363f7?w=300',
        productCount: 89, subcategories: [
          SubcategoryModel(id: 'metal', name: 'معادن', nameEn: 'Metal', productCount: 45),
          SubcategoryModel(id: 'welding', name: 'لحام', nameEn: 'Welding', productCount: 34),
        ],
      ),
      // 41. معدات طبية
      CategoryModel(
        id: 'medical', name: 'معدات طبية', nameEn: 'Medical Equipment',
        icon: Icons.medical_services, color: Colors.red,
        imageUrl: 'https://images.unsplash.com/photo-1579684385127-1ef15d508118?w=300',
        productCount: 234, subcategories: [
          SubcategoryModel(id: 'devices', name: 'أجهزة', nameEn: 'Devices', productCount: 89),
          SubcategoryModel(id: 'supplies', name: 'مستلزمات', nameEn: 'Supplies', productCount: 123),
        ],
      ),
      // 42. معدات صناعية
      CategoryModel(
        id: 'industrial', name: 'معدات صناعية', nameEn: 'Industrial',
        icon: Icons.factory, color: Colors.blueGrey,
        imageUrl: 'https://images.unsplash.com/photo-1581091226033-d5c48150dbaa?w=300',
        productCount: 345, subcategories: [
          SubcategoryModel(id: 'machinery', name: 'آلات', nameEn: 'Machinery', productCount: 123),
          SubcategoryModel(id: 'parts', name: 'قطع غيار', nameEn: 'Parts', productCount: 234),
        ],
      ),
      // 43. مستلزمات مدرسية
      CategoryModel(
        id: 'stationery', name: 'مستلزمات مدرسية', nameEn: 'Stationery',
        icon: Icons.edit, color: Colors.blue,
        imageUrl: 'https://images.unsplash.com/photo-1596496181871-9681eacf9764?w=300',
        productCount: 567, subcategories: [
          SubcategoryModel(id: 'notebooks', name: 'دفاتر', nameEn: 'Notebooks', productCount: 234),
          SubcategoryModel(id: 'pens', name: 'أقلام', nameEn: 'Pens', productCount: 345),
        ],
      ),
      // 44. هدايا
      CategoryModel(
        id: 'gifts', name: 'هدايا', nameEn: 'Gifts',
        icon: Icons.card_giftcard, color: Colors.pink,
        imageUrl: 'https://images.unsplash.com/photo-1549465220-1a8b9238cd48?w=300',
        productCount: 345, subcategories: [
          SubcategoryModel(id: 'occasions', name: 'مناسبات', nameEn: 'Occasions', productCount: 234),
          SubcategoryModel(id: 'wrapping', name: 'تغليف', nameEn: 'Wrapping', productCount: 89),
        ],
      ),
      // 45. تحف وأنتيكات
      CategoryModel(
        id: 'antiques', name: 'تحف وأنتيكات', nameEn: 'Antiques',
        icon: Icons.history, color: Colors.brown,
        imageUrl: 'https://images.unsplash.com/photo-1561124738-67dab8f6146a?w=300',
        productCount: 123, subcategories: [
          SubcategoryModel(id: 'coins', name: 'عملات', nameEn: 'Coins', productCount: 45),
          SubcategoryModel(id: 'artifacts', name: 'قطع أثرية', nameEn: 'Artifacts', productCount: 34),
        ],
      ),
    ];
  }
  
  // ==================== إكمال المتاجر (200+ متجر) ====================
  
  static List<StoreModel> getMoreStores() {
    List<StoreModel> stores = [];
    
    // إلكترونيات (15 متجر إضافي)
    List<String> electronicsNames = ['عالم الإلكترونيات', 'تك ستور', 'ديجيتال مول', 'إلكترونيات المستقبل', 'البرق للتقنية', 'سامسونج ستور', 'آبل ستور اليمن', 'هواوي ستور', 'شاومي ستور', 'لابتوب كينج', 'كمبيوتر سيتي', 'جيمنج ورلد', 'صوتيات احترافية', 'كاميرات برو', 'طابعات اليمن'];
    for (int i = 0; i < electronicsNames.length; i++) {
      stores.add(StoreModel(
        id: 'store_elec_$i', name: electronicsNames[i], category: 'إلكترونيات', subcategory: 'إلكترونيات',
        rating: 4.0 + (i % 10) / 10, reviews: 100 + i * 10, products: 50 + i * 5, followers: 500 + i * 50,
        isOpen: i % 3 != 0, isVerified: i % 2 == 0,
        address: 'شارع الستين، صنعاء', city: 'صنعاء',
        phone: '777${i}23456', description: 'متجر ${electronicsNames[i]} للإلكترونيات',
      ));
    }
    
    // أزياء (25 متجر إضافي)
    List<String> fashionNames = ['عالم الموضة', 'أناقة', 'فاشن مول', 'ملابس العصر', 'ثياب يمنية', 'عبايات فاخرة', 'بدل رجالية', 'أزياء نسائية', 'ملابس أطفال', 'أحذية عصرية', 'شنط ماركات', 'إكسسوارات', 'ساعات فاخرة', 'نظارات شمسية', 'مجوهرات', 'ذهب اليمن', 'فضة', 'ألماس', 'لؤلؤ', 'عطور شرقية', 'عطور غربية', 'بخور', 'عود', 'دهن عود', 'مباخر'];
    for (int i = 0; i < fashionNames.length; i++) {
      stores.add(StoreModel(
        id: 'store_fashion_$i', name: fashionNames[i], category: 'أزياء', subcategory: 'أزياء',
        rating: 4.0 + (i % 10) / 10, reviews: 100 + i * 10, products: 50 + i * 5, followers: 500 + i * 50,
        isOpen: i % 3 != 0, isVerified: i % 2 == 0,
        address: 'شارع التحرير، صنعاء', city: 'صنعاء',
        phone: '777${i}34567', description: 'متجر ${fashionNames[i]} للأزياء',
      ));
    }
    
    // سيارات (15 متجر إضافي)
    List<String> carsNames = ['معرض السيارات', 'سيارات فاخرة', 'سيارات اقتصادية', 'سيارات مستعملة', 'قطع غيار', 'إطارات', 'زيوت', 'بطاريات', 'زجاج سيارات', 'دهانات سيارات', 'تلميع', 'صيانة', 'كهرباء سيارات', 'ميكانيكا', 'سمكرة ودوكو'];
    for (int i = 0; i < carsNames.length; i++) {
      stores.add(StoreModel(
        id: 'store_cars_$i', name: carsNames[i], category: 'سيارات', subcategory: 'سيارات',
        rating: 4.0 + (i % 10) / 10, reviews: 100 + i * 10, products: 50 + i * 5, followers: 500 + i * 50,
        isOpen: i % 3 != 0, isVerified: i % 2 == 0,
        address: 'شارع الستين، صنعاء', city: 'صنعاء',
        phone: '777${i}45678', description: 'متجر ${carsNames[i]} للسيارات',
      ));
    }
    
    // عقارات (10 متاجر إضافية)
    List<String> realEstateNames = ['عقارات', 'فلل', 'شقق', 'أراضي', 'محلات', 'مكاتب', 'مستودعات', 'استثمار عقاري', 'تمليك', 'إيجار'];
    for (int i = 0; i < realEstateNames.length; i++) {
      stores.add(StoreModel(
        id: 'store_real_$i', name: realEstateNames[i], category: 'عقارات', subcategory: 'عقارات',
        rating: 4.0 + (i % 10) / 10, reviews: 100 + i * 10, products: 50 + i * 5, followers: 500 + i * 50,
        isOpen: i % 3 != 0, isVerified: i % 2 == 0,
        address: 'شارع الزراعة، صنعاء', city: 'صنعاء',
        phone: '777${i}56789', description: 'متجر ${realEstateNames[i]} للعقارات',
      ));
    }
    
    // أثاث (15 متجر إضافي)
    List<String> furnitureNames = ['أثاث', 'غرف نوم', 'مجالس', 'صالات', 'مطابخ', 'حمامات', 'ديكور', 'ستائر', 'سجاد', 'موكيت', 'إضاءة', 'ثريات', 'مرايا', 'لوحات', 'تحف'];
    for (int i = 0; i < furnitureNames.length; i++) {
      stores.add(StoreModel(
        id: 'store_furniture_$i', name: furnitureNames[i], category: 'أثاث', subcategory: 'أثاث',
        rating: 4.0 + (i % 10) / 10, reviews: 100 + i * 10, products: 50 + i * 5, followers: 500 + i * 50,
        isOpen: i % 3 != 0, isVerified: i % 2 == 0,
        address: 'شارع حدة، صنعاء', city: 'صنعاء',
        phone: '777${i}67890', description: 'متجر ${furnitureNames[i]} للأثاث',
      ));
    }
    
    // مطاعم (20 متجر إضافي)
    List<String> restaurantNames = ['مطعم', 'مندي', 'زربيان', 'مظبي', 'حنيذ', 'شاورما', 'برجر', 'بيتزا', 'فول وتميس', 'فطور', 'عصائر', 'قهوة', 'حلويات', 'معجنات', 'فطائر', 'مشاوي', 'أسماك', 'باستا', 'سلطات', 'ساندويتشات'];
    for (int i = 0; i < restaurantNames.length; i++) {
      stores.add(StoreModel(
        id: 'store_rest_$i', name: restaurantNames[i], category: 'مطاعم', subcategory: 'مطاعم',
        rating: 4.0 + (i % 10) / 10, reviews: 100 + i * 10, products: 50 + i * 5, followers: 500 + i * 50,
        isOpen: i % 3 != 0, isVerified: i % 2 == 0,
        address: 'شارع الستين، صنعاء', city: 'صنعاء',
        phone: '777${i}78901', description: '${restaurantNames[i]} يمني',
      ));
    }
    
    // خدمات (15 متجر إضافي)
    List<String> serviceNames = ['خدمات', 'تنظيف', 'صيانة', 'سباكة', 'كهرباء', 'دهان', 'نجارة', 'حدادة', 'تكييف', 'تبريد', 'ستلايت', 'كمبيوتر', 'جوالات', 'تصميم', 'طباعة'];
    for (int i = 0; i < serviceNames.length; i++) {
      stores.add(StoreModel(
        id: 'store_service_$i', name: serviceNames[i], category: 'خدمات', subcategory: 'خدمات',
        rating: 4.0 + (i % 10) / 10, reviews: 100 + i * 10, products: 50 + i * 5, followers: 500 + i * 50,
        isOpen: i % 3 != 0, isVerified: i % 2 == 0,
        address: 'شارع التحرير، صنعاء', city: 'صنعاء',
        phone: '777${i}89012', description: '${serviceNames[i]} منزلية',
      ));
    }
    
    // صحة وجمال (10 متاجر إضافية)
    List<String> beautyNames = ['صالون', 'تجميل', 'عناية بالبشرة', 'عناية بالشعر', 'مكياج', 'مانيكير', 'بديكير', 'مساج', 'حمام مغربي', 'رياضة'];
    for (int i = 0; i < beautyNames.length; i++) {
      stores.add(StoreModel(
        id: 'store_beauty_$i', name: beautyNames[i], category: 'صحة وجمال', subcategory: 'صحة وجمال',
        rating: 4.0 + (i % 10) / 10, reviews: 100 + i * 10, products: 50 + i * 5, followers: 500 + i * 50,
        isOpen: i % 3 != 0, isVerified: i % 2 == 0,
        address: 'شارع حدة، صنعاء', city: 'صنعاء',
        phone: '777${i}90123', description: '${beautyNames[i]} تجميل',
      ));
    }
    
    // مواد غذائية (10 متاجر إضافية)
    List<String> groceryNames = ['سوبر ماركت', 'بقالة', 'تموينات', 'خضار', 'فواكه', 'لحوم', 'دواجن', 'أسماك', 'مخبز', 'حلويات'];
    for (int i = 0; i < groceryNames.length; i++) {
      stores.add(StoreModel(
        id: 'store_grocery_$i', name: groceryNames[i], category: 'مواد غذائية', subcategory: 'مواد غذائية',
        rating: 4.0 + (i % 10) / 10, reviews: 100 + i * 10, products: 50 + i * 5, followers: 500 + i * 50,
        isOpen: i % 3 != 0, isVerified: i % 2 == 0,
        address: 'شارع الستين، صنعاء', city: 'صنعاء',
        phone: '777${i}01234', description: '${groceryNames[i]}',
      ));
    }
    
    return stores;
  }
  
  // دالة موحدة للحصول على جميع الفئات
  static List<CategoryModel> getAllCategoriesComplete() {
    return getAllCategories() + getRemainingCategories();
  }
  
  // دالة موحدة للحصول على جميع المتاجر
  static List<StoreModel> getAllStoresComplete() {
    return getAllStores() + getMoreStores();
  }
}

// دوال مساعدة للتوافق
class FullData {
  static List<CategoryModel> getAllCategoriesComplete() {
    return _categories;
  }
  
  static List<StoreModel> getAllStoresComplete() {
    return _stores;
  }
  
  static List<ProductModel> getAllProducts() {
    return _products;
  }
  
  static List<MallModel> getAllMalls() {
    return _malls;
  }
  
  static final List<CategoryModel> _categories = [];
  static final List<StoreModel> _stores = [];
  static final List<ProductModel> _products = [];
  static final List<MallModel> _malls = [];
}
