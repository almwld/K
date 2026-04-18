class MainCategory {
  final int id;
  final String name;
  final String iconUrl;
  final List<SubCategory> subCategories;
  final List<Mall> malls;
  final List<Vendor> vendors;
  final List<Product> products;

  MainCategory({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.subCategories,
    required this.malls,
    required this.vendors,
    required this.products,
  });
}

class SubCategory {
  final int id;
  final String name;
  final int mainCategoryId;

  SubCategory({required this.id, required this.name, required this.mainCategoryId});
}

class Mall {
  final int id;
  final String name;
  final String imageUrl;
  final int storesCount;
  final int mainCategoryId;

  Mall({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.storesCount,
    required this.mainCategoryId,
  });
}

class Vendor {
  final String id;
  final String name;
  final String logoUrl;
  final int productsCount;
  final double rating;
  final bool isVerified;

  Vendor({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.productsCount,
    required this.rating,
    required this.isVerified,
  });
}

class Product {
  final String id;
  final String name;
  final double price;
  final double? oldPrice;
  final String imageUrl;
  final String vendorName;
  final String vendorId;
  final double rating;
  final int reviewsCount;
  final bool isOnSale;
  final int stockQuantity;
  final List<String> badges;
  final String categoryKey;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.oldPrice,
    required this.imageUrl,
    required this.vendorName,
    required this.vendorId,
    required this.rating,
    required this.reviewsCount,
    this.isOnSale = false,
    required this.stockQuantity,
    this.badges = const [],
    required this.categoryKey,
  });

  bool get inStock => stockQuantity > 0;
  String get formattedPrice => '${price.toStringAsFixed(0)} ر.ي';
  String? get formattedOldPrice => oldPrice != null ? '${oldPrice!.toStringAsFixed(0)} ر.ي' : null;
  int get discountPercentage => oldPrice != null ? ((oldPrice! - price) / oldPrice! * 100).round() : 0;
}
