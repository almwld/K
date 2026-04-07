class StoreModel {
  final String id;
  final String name;
  final double lat;
  final double lng;
  final String address;
  final double rating;
  final String category;
  final bool isOpen;
  final double distance;
  final String? phone;
  final String? description;
  final int? reviewCount;

  StoreModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.address,
    required this.rating,
    required this.category,
    required this.isOpen,
    required this.distance,
    this.phone,
    this.description,
    this.reviewCount,
  });
}
