class CartItem {
  final String id;
  final String productId;
  final String productName;
  final String productImage;
  final String storeId;
  final String storeName;
  final double price;
  int quantity;
  final double? discountPrice;
  final String? variant;

  CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.storeId,
    required this.storeName,
    required this.price,
    this.quantity = 1,
    this.discountPrice,
    this.variant,
  });

  double get finalPrice => discountPrice ?? price;
  double get totalPrice => finalPrice * quantity;
  double get savings => discountPrice != null ? (price - discountPrice) * quantity : 0;

  Map<String, dynamic> toJson() => {
    'id': id, 'product_id': productId, 'product_name': productName, 'product_image': productImage,
    'store_id': storeId, 'store_name': storeName, 'price': price, 'quantity': quantity,
    'discount_price': discountPrice, 'variant': variant
  };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json['id'], productId: json['product_id'], productName: json['product_name'],
    productImage: json['product_image'], storeId: json['store_id'], storeName: json['store_name'],
    price: json['price'].toDouble(), quantity: json['quantity'] ?? 1,
    discountPrice: json['discount_price']?.toDouble(), variant: json['variant']
  );
}

class CartSummary {
  final List<CartItem> items;
  final double subtotal;
  final double discount;
  final double total;
  final int totalItems;
  final Map<String, List<CartItem>> itemsByStore;

  CartSummary({required this.items})
    : subtotal = items.fold(0, (sum, item) => sum + (item.price * item.quantity)),
      discount = items.fold(0, (sum, item) => sum + item.savings),
      total = items.fold(0, (sum, item) => sum + item.totalPrice),
      totalItems = items.fold(0, (sum, item) => sum + item.quantity),
      itemsByStore = _groupByStore(items);

  static Map<String, List<CartItem>> _groupByStore(List<CartItem> items) {
    final map = <String, List<CartItem>>{};
    for (var item in items) {
      map.putIfAbsent(item.storeId, () => []).add(item);
    }
    return map;
  }
}
