class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final List<String> images;
  final String category;
  final String city;
  final String sellerId;
  final String sellerName;
  final double? rating;
  final int? reviewCount;
  final DateTime createdAt;
  final bool isFeatured;
  final bool isAuction;
  final DateTime? auctionEndTime;
  final double? currentBid;
  final int? quantity;
  final String? condition;
  final List<String>? tags;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.category,
    required this.city,
    required this.sellerId,
    required this.sellerName,
    this.rating,
    this.reviewCount,
    required this.createdAt,
    this.isFeatured = false,
    this.isAuction = false,
    this.auctionEndTime,
    this.currentBid,
    this.quantity,
    this.condition,
    this.tags,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      images: List<String>.from(json['images'] ?? []),
      category: json['category'] ?? '',
      city: json['city'] ?? '',
      sellerId: json['seller_id'] ?? '',
      sellerName: json['seller_name'] ?? '',
      rating: json['rating']?.toDouble(),
      reviewCount: json['review_count'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      isFeatured: json['is_featured'] ?? false,
      isAuction: json['is_auction'] ?? false,
      auctionEndTime: json['auction_end_time'] != null ? DateTime.parse(json['auction_end_time']) : null,
      currentBid: json['current_bid']?.toDouble(),
      quantity: json['quantity'],
      condition: json['condition'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'images': images,
      'category': category,
      'city': city,
      'seller_id': sellerId,
      'seller_name': sellerName,
      'rating': rating,
      'review_count': reviewCount,
      'created_at': createdAt.toIso8601String(),
      'is_featured': isFeatured,
      'is_auction': isAuction,
      'auction_end_time': auctionEndTime?.toIso8601String(),
      'current_bid': currentBid,
      'quantity': quantity,
      'condition': condition,
      'tags': tags,
    };
  }
}

// Sample products with real image URLs
final List<ProductModel> sampleProducts = [
  ProductModel(
    id: '1', title: 'آيفون 15 برو ماكس', description: 'هاتف آيفون 15 برو ماكس 256GB', price: 450000,
    images: ['https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400'], category: 'إلكترونيات', city: 'صنعاء',
    sellerId: '1', sellerName: 'متجر التقنية', rating: 4.9, reviewCount: 128, createdAt: DateTime.now(), isFeatured: true,
  ),
  ProductModel(
    id: '2', title: 'سامسونج S24 الترا', description: 'سامسونج جالاكسي S24 الترا 512GB', price: 380000,
    images: ['https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400'], category: 'إلكترونيات', city: 'صنعاء',
    sellerId: '1', sellerName: 'متجر التقنية', rating: 4.8, reviewCount: 95, createdAt: DateTime.now(), isFeatured: true,
  ),
  ProductModel(
    id: '3', title: 'ماك بوك برو M3', description: 'ماك بوك برو M3 14 بوصة', price: 1800000,
    images: ['https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400'], category: 'إلكترونيات', city: 'عدن',
    sellerId: '1', sellerName: 'متجر التقنية', rating: 4.9, reviewCount: 67, createdAt: DateTime.now(), isFeatured: true,
  ),
  ProductModel(
    id: '4', title: 'تويوتا كامري 2024', description: 'تويوتا كامري 2024 فول اوبشن', price: 8500000,
    images: ['https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400'], category: 'سيارات', city: 'صنعاء',
    sellerId: '2', sellerName: 'معرض السيارات', rating: 4.7, reviewCount: 45, createdAt: DateTime.now(), isFeatured: true,
  ),
  ProductModel(
    id: '5', title: 'شقة فاخرة في حدة', description: 'شقة 3 غرف في حدة', price: 35000000,
    images: ['https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400'], category: 'عقارات', city: 'صنعاء',
    sellerId: '3', sellerName: 'عقارات فلكس', rating: 4.8, reviewCount: 56, createdAt: DateTime.now(), isFeatured: true,
  ),
];
