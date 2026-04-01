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
      auctionEndTime: json['auction_end_time'] != null
          ? DateTime.parse(json['auction_end_time'])
          : null,
      currentBid: json['current_bid']?.toDouble(),
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
    };
  }
}

// Sample products
final List<ProductModel> sampleProducts = [
  ProductModel(
    id: '1',
    title: 'آيفون 14 برو ماكس',
    description: 'هاتف آيفون 14 برو ماكس بحالة ممتازة',
    price: 350000,
    images: [],
    category: 'إلكترونيات',
    city: 'صنعاء',
    sellerId: '1',
    sellerName: 'متجر التقنية',
    rating: 4.5,
    reviewCount: 12,
    createdAt: DateTime.now(),
    isFeatured: true,
  ),
  ProductModel(
    id: '2',
    title: 'تويوتا كامري 2020',
    description: 'سيارة تويوتا كامري موديل 2020',
    price: 4500000,
    images: [],
    category: 'سيارات',
    city: 'عدن',
    sellerId: '2',
    sellerName: 'سوق السيارات',
    rating: 4.2,
    reviewCount: 8,
    createdAt: DateTime.now(),
    isFeatured: true,
  ),
  ProductModel(
    id: '3',
    title: 'فيلا فاخرة في حدة',
    description: 'فيلا فاخرة 5 غرف في حدة',
    price: 150000000,
    images: [],
    category: 'عقارات',
    city: 'صنعاء',
    sellerId: '3',
    sellerName: 'عقارات فلكس',
    rating: 4.8,
    reviewCount: 25,
    createdAt: DateTime.now(),
    isFeatured: true,
  ),
  ProductModel(
    id: '4',
    title: 'بدلة رجالية فاخرة',
    description: 'بدلة رجالية فاخرة مقاس L',
    price: 25000,
    images: [],
    category: 'أزياء',
    city: 'تعز',
    sellerId: '4',
    sellerName: 'أزياء فلكس',
    rating: 4.0,
    reviewCount: 5,
    createdAt: DateTime.now(),
    isFeatured: false,
  ),
];

// Auction products
final List<ProductModel> sampleAuctions = [
  ProductModel(
    id: 'a1',
    title: 'ساعة رولكس أصلية',
    description: 'ساعة رولكس أصلية بحالة ممتازة',
    price: 500000,
    images: [],
    category: 'إكسسوارات',
    city: 'صنعاء',
    sellerId: '5',
    sellerName: 'مجوهرات فلكس',
    rating: 4.9,
    reviewCount: 45,
    createdAt: DateTime.now(),
    isAuction: true,
    auctionEndTime: DateTime.now().add(const Duration(days: 2)),
    currentBid: 520000,
  ),
  ProductModel(
    id: 'a2',
    title: 'لوحة فنية نادرة',
    description: 'لوحة فنية يمنية نادرة',
    price: 200000,
    images: [],
    category: 'فنون',
    city: 'عدن',
    sellerId: '6',
    sellerName: 'معرض الفن',
    rating: 4.7,
    reviewCount: 18,
    createdAt: DateTime.now(),
    isAuction: true,
    auctionEndTime: DateTime.now().add(const Duration(days: 3)),
    currentBid: 225000,
  ),
  ProductModel(
    id: 'a3',
    title: 'عملة نادرة قديمة',
    description: 'عملة يمنية نادرة من العهد المملوكي',
    price: 100000,
    images: [],
    category: 'تحف',
    city: 'تعز',
    sellerId: '7',
    sellerName: 'تحف فلكس',
    rating: 4.5,
    reviewCount: 32,
    createdAt: DateTime.now(),
    isAuction: true,
    auctionEndTime: DateTime.now().add(const Duration(days: 1)),
    currentBid: 115000,
  ),
];
