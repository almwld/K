class AdModel {
  final String id;
  final String userId;
  final String userName;
  final String? userAvatar;
  final String title;
  final String? description;
  final double price;
  final double? oldPrice;
  final String category;
  final String? condition;
  final String? location;
  final String phone;
  final String? whatsapp;
  final List<String> images;
  final String? videoUrl;
  final int views;
  final int likes;
  final bool isFeatured;
  final bool isActive;
  final String status;
  final DateTime createdAt;
  final DateTime? expiresAt;

  AdModel({
    required this.id,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.title,
    this.description,
    required this.price,
    this.oldPrice,
    required this.category,
    this.condition,
    this.location,
    required this.phone,
    this.whatsapp,
    required this.images,
    this.videoUrl,
    this.views = 0,
    this.likes = 0,
    this.isFeatured = false,
    this.isActive = true,
    this.status = 'active',
    required this.createdAt,
    this.expiresAt,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['id'],
      userId: json['user_id'],
      userName: json['user']?['name'] ?? json['seller_name'] ?? 'مستخدم',
      userAvatar: json['user']?['avatar_url'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] ?? 0).toDouble(),
      oldPrice: json['old_price']?.toDouble(),
      category: json['category'],
      condition: json['condition'],
      location: json['location'],
      phone: json['phone'] ?? '',
      whatsapp: json['whatsapp'],
      images: List<String>.from(json['images'] ?? []),
      videoUrl: json['video_url'],
      views: json['views'] ?? 0,
      likes: json['likes'] ?? 0,
      isFeatured: json['is_featured'] ?? false,
      isActive: json['is_active'] ?? true,
      status: json['status'] ?? 'active',
      createdAt: DateTime.parse(json['created_at']),
      expiresAt: json['expires_at'] != null ? DateTime.parse(json['expires_at']) : null,
    );
  }

  double get discountPercentage {
    if (oldPrice != null && oldPrice! > 0) {
      return ((oldPrice! - price) / oldPrice!) * 100;
    }
    return 0;
  }

  String get formattedPrice {
    return '${price.toStringAsFixed(0)} ريال';
  }

  String get formattedOldPrice {
    if (oldPrice != null) {
      return '${oldPrice!.toStringAsFixed(0)} ريال';
    }
    return '';
  }
}
