class StoreModel {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final String description;
  final String address;
  final String phone;
  final double rating;
  final int totalProducts;
  final bool isOpen;
  final String workingHours;
  final List<String> tags;

  StoreModel({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.address,
    required this.phone,
    this.rating = 0.0,
    this.totalProducts = 0,
    this.isOpen = true,
    this.workingHours = '9:00 ص - 10:00 م',
    this.tags = const [],
  });
}

