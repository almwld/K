class CartItem {
  final String id;
  final String productId;
  final String productName;
  final String imageUrl;
  final double price;
  final int quantity;
  final String vendorId;
  final String vendorName;
  final int stockQuantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.vendorId,
    required this.vendorName,
    required this.stockQuantity,
  });

  double get totalPrice => price * quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      productId: productId,
      productName: productName,
      imageUrl: imageUrl,
      price: price,
      quantity: quantity ?? this.quantity,
      vendorId: vendorId,
      vendorName: vendorName,
      stockQuantity: stockQuantity,
    );
  }
}
