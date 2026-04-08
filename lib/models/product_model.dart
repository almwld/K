class ProductModel {
  final String id;
  final String title;
  final String name;
  final String description;
  final double price;
  final double? oldPrice;
  final List<String> images;
  final String category;
  final String? sellerId;
  final String? sellerName;
  final double? rating;
  final int? reviewCount;
  final int stock;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? condition;
  final String? location;
  final String? city;

  ProductModel({
    required this.id,
    required this.title,
    required this.name,
    required this.description,
    required this.price,
    this.oldPrice,
    required this.images,
    required this.category,
    this.sellerId,
    this.sellerName,
    this.rating,
    this.reviewCount,
    required this.stock,
    required this.isAvailable,
    required this.createdAt,
    this.updatedAt,
    this.condition,
    this.location, this.city,
  });

  // دالة لتحويل JSON إلى كائن
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? json['name'] ?? '',
      name: json['name'] ?? json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      oldPrice: json['old_price']?.toDouble(),
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      category: json['category'] ?? '',
      sellerId: json['seller_id']?.toString(),
      sellerName: json['seller_name'],
      rating: json['rating']?.toDouble(),
      reviewCount: json['review_count'],
      stock: json['stock'] ?? 0,
      isAvailable: json['is_available'] ?? true,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
      condition: json['condition'],
      location: json['location'],
      city: json['city'] ?? json['location'],
    );
  }

  // دالة لتحويل كائن إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'name': name,
      'description': description,
      'price': price,
      'old_price': oldPrice,
      'images': images,
      'category': category,
      'seller_id': sellerId,
      'seller_name': sellerName,
      'rating': rating,
      'review_count': reviewCount,
      'stock': stock,
      'is_available': isAvailable,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'condition': condition,
      'location': location,
      'city': city,
    };
  }

  // نسخة من المنتج
  ProductModel copyWith({
    String? id,
    String? title,
    String? name,
    String? description,
    double? price,
    double? oldPrice,
    List<String>? images,
    String? category,
    String? sellerId,
    String? sellerName,
    double? rating,
    int? reviewCount,
    int? stock,
    bool? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? condition,
    String? location,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      images: images ?? this.images,
      category: category ?? this.category,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      stock: stock ?? this.stock,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      condition: condition ?? this.condition,
      location: location ?? this.location, this.city,
    );
  }

  // دالة للحصول على سعر منسق
  String get formattedPrice {
    return '${price.toStringAsFixed(0)} ريال';
  }

  // دالة للحصول على نسبة الخصم
  double? get discountPercentage {
    if (oldPrice != null && oldPrice! > 0) {
      return ((oldPrice! - price) / oldPrice!) * 100;
    }
    return null;
  }

  // دالة للحصول على سعر الخصم المنسق
  String? get formattedOldPrice {
    if (oldPrice != null) {
      return '${oldPrice!.toStringAsFixed(0)} ريال';
    }
    return null;
  }
}

// عينات من المنتجات للاختبار
final List<ProductModel> sampleProducts = [
  ProductModel(
    id: '1',
    title: 'تويوتا كامري 2024',
    name: 'تويوتا كامري 2024',
    description: 'سيارة جديدة بالكامل، فاخرة وموفرة للوقود',
    price: 8500000,
    oldPrice: 9000000,
    images: ['https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400'],
    category: 'سيارات',
    rating: 4.8,
    reviewCount: 45,
    stock: 5,
    isAvailable: true,
    createdAt: DateTime.now(),
    condition: 'جديد',
    location: 'صنعاء',
  ),
  ProductModel(
    id: '2',
    title: 'ماك بوك برو M3',
    name: 'ماك بوك برو M3',
    description: 'أحدث إصدار من أجهزة ماك بوك برو',
    price: 1800000,
    oldPrice: 2000000,
    images: ['https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400'],
    category: 'إلكترونيات',
    rating: 4.9,
    reviewCount: 120,
    stock: 10,
    isAvailable: true,
    createdAt: DateTime.now(),
    condition: 'جديد',
    location: 'صنعاء',
  ),
  ProductModel(
    id: '3',
    title: 'ايفون 15 برو',
    name: 'ايفون 15 برو',
    description: 'هاتف ذكي من Apple بأحدث التقنيات',
    price: 450000,
    oldPrice: 500000,
    images: ['https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400'],
    category: 'إلكترونيات',
    rating: 4.7,
    reviewCount: 89,
    stock: 15,
    isAvailable: true,
    createdAt: DateTime.now(),
    condition: 'جديد',
    location: 'صنعاء',
  ),
];
