class StoreModel {
  final String id;
  final String name;
  final double lat;
  final double lng;
  final String address;
  final double rating;
  final String? imageUrl;
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
    this.imageUrl,
    required this.category,
    required this.isOpen,
    required this.distance,
    this.phone,
    this.description,
    this.reviewCount,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
      address: json['address'] ?? '',
      rating: (json['rating'] ?? 4.0).toDouble(),
      imageUrl: json['image_url'],
      category: json['category'] ?? 'أخرى',
      isOpen: json['is_open'] ?? false,
      distance: (json['distance'] ?? 0).toDouble(),
      phone: json['phone'],
      description: json['description'],
      reviewCount: json['review_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lat': lat,
      'lng': lng,
      'address': address,
      'rating': rating,
      'image_url': imageUrl,
      'category': category,
      'is_open': isOpen,
      'distance': distance,
      'phone': phone,
      'description': description,
      'review_count': reviewCount,
    };
  }
}

// Sample stores data
final List<StoreModel> sampleStores = [
  StoreModel(
    id: '1',
    name: 'متجر التقنية',
    lat: 15.3694,
    lng: 44.1910,
    address: 'شارع التحرير، صنعاء',
    rating: 4.5,
    category: 'إلكترونيات',
    isOpen: true,
    distance: 250,
    phone: '777123456',
    description: 'أفضل متجر إلكترونيات في صنعاء',
    reviewCount: 128,
  ),
  StoreModel(
    id: '2',
    name: 'سوق السيارات',
    lat: 15.3650,
    lng: 44.1950,
    address: 'شارع الستين، صنعاء',
    rating: 4.2,
    category: 'سيارات',
    isOpen: true,
    distance: 500,
    phone: '777234567',
    description: 'بيع وشراء السيارات الجديدة والمستعملة',
    reviewCount: 85,
  ),
  StoreModel(
    id: '3',
    name: 'مطعم فلكس',
    lat: 15.3700,
    lng: 44.1880,
    address: 'شارع حدة، صنعاء',
    rating: 4.8,
    category: 'مطاعم',
    isOpen: true,
    distance: 150,
    phone: '777345678',
    description: 'أشهى المأكولات اليمنية والعالمية',
    reviewCount: 256,
  ),
  StoreModel(
    id: '4',
    name: 'مكتبة العلم',
    lat: 15.3680,
    lng: 44.1930,
    address: 'شارع الجامعة، صنعاء',
    rating: 4.6,
    category: 'أزياء',
    isOpen: false,
    distance: 350,
    phone: '777456789',
    description: 'كتب ومستلزمات مدرسية',
    reviewCount: 92,
  ),
  StoreModel(
    id: '5',
    name: 'عقارات فلكس',
    lat: 15.3720,
    lng: 44.1960,
    address: 'شارع الزراعة، صنعاء',
    rating: 4.3,
    category: 'عقارات',
    isOpen: true,
    distance: 750,
    phone: '777567890',
    description: 'بيع وإيجار العقارات',
    reviewCount: 67,
  ),
];
