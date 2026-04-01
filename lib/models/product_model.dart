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
  final String? condition; // new, used
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
