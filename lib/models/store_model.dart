class StoreModel {
  final String id;
  final String name;
  final String category;
  final String address;
  final double lat;
  final double lng;
  final double rating;
  final String image;
  final String phone;
  final String openingHours;
  final bool isOpen;

  StoreModel({
    required this.id,
    required this.name,
    required this.category,
    required this.address,
    required this.lat,
    required this.lng,
    required this.rating,
    required this.image,
    required this.phone,
    required this.openingHours,
    required this.isOpen,
  });

  double distanceTo(double userLat, double userLng) {
    const double earthRadius = 6371;
    double dLat = _toRadians(lat - userLat);
    double dLng = _toRadians(lng - userLng);
    double a = (dLat / 2).sin() * (dLat / 2).sin() +
               _toRadians(userLat).cos() * _toRadians(lat).cos() *
               (dLng / 2).sin() * (dLng / 2).sin();
    double c = 2 * a.asin();
    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * 3.14159 / 180;
  }
}

// قائمة المتاجر القريبة (بيانات تجريبية)
final List<StoreModel> nearbyStores = [
  StoreModel(
    id: '1',
    name: 'سوبرماركت السعيد',
    category: 'بقالة',
    address: 'شارع الستين، صنعاء',
    lat: 15.3714,
    lng: 44.1930,
    rating: 4.8,
    image: 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=200',
    phone: '777000001',
    openingHours: '8:00 ص - 11:00 م',
    isOpen: true,
  ),
  StoreModel(
    id: '2',
    name: 'أسواق الأمان',
    category: 'بقالة',
    address: 'شارع حدة، صنعاء',
    lat: 15.3690,
    lng: 44.1980,
    rating: 4.7,
    image: 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=200',
    phone: '777000002',
    openingHours: '9:00 ص - 10:00 م',
    isOpen: true,
  ),
  StoreModel(
    id: '3',
    name: 'بقالة اليمن',
    category: 'بقالة',
    address: 'شارع الزراعة، صنعاء',
    lat: 15.3670,
    lng: 44.1900,
    rating: 4.6,
    image: 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=200',
    phone: '777000003',
    openingHours: '7:00 ص - 12:00 م',
    isOpen: true,
  ),
  StoreModel(
    id: '4',
    name: 'بقالة الخير',
    category: 'بقالة',
    address: 'شارع السبعين، صنعاء',
    lat: 15.3740,
    lng: 44.1910,
    rating: 4.9,
    image: 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=200',
    phone: '777000004',
    openingHours: '8:00 ص - 11:00 م',
    isOpen: true,
  ),
  StoreModel(
    id: '5',
    name: 'سوبرماركت اليمن',
    category: 'سوبرماركت',
    address: 'شارع التحرير، صنعاء',
    lat: 15.3660,
    lng: 44.1950,
    rating: 4.5,
    image: 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=200',
    phone: '777000005',
    openingHours: '9:00 ص - 9:00 م',
    isOpen: false,
  ),
];
