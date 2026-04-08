class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String categoryId;
  final String categoryName;
  final String seller;
  final double rating;
  final int reviewCount;
  final bool inStock;
  final int? discountPercent;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    required this.categoryName,
    required this.seller,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.inStock = true,
    this.discountPercent,
  });

  double get discountedPrice {
    if (discountPercent == null) return price;
    return price - (price * discountPercent! / 100);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'seller': seller,
      'rating': rating,
      'reviewCount': reviewCount,
      'inStock': inStock,
      'discountPercent': discountPercent,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      seller: json['seller'],
      rating: json['rating']?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      inStock: json['inStock'] ?? true,
      discountPercent: json['discountPercent'],
    );
  }
}
