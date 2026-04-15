class MarketItem {
  final String category;
  final String name;
  final String imageUrl;
  final double price;
  final double change24h;
  final String store;
  bool isFavorite;

  MarketItem({
    required this.category,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.change24h,
    required this.store,
    this.isFavorite = false,
  });

  bool get isPositive => change24h >= 0;
  String get formattedPrice => '${price.toStringAsFixed(2)}';
  String get formattedChange => '${isPositive ? '+' : ''}${change24h.toStringAsFixed(1)}%';
}
