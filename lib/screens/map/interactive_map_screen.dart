import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';

class InteractiveMapScreen extends StatefulWidget {
  const InteractiveMapScreen({super.key});

  @override
  State<InteractiveMapScreen> createState() => _InteractiveMapScreenState();
}

class _InteractiveMapScreenState extends State<InteractiveMapScreen> {
  late final MapController _mapController;
  static const LatLng yemenCenter = LatLng(15.3694, 44.1910);
  LatLng _currentCenter = yemenCenter;
  double _currentZoom = 7.5;
  Position? _currentPosition;
  String? _selectedCity;

  // الفئات (Categories)
  final List<Map<String, dynamic>> _categories = [
    {'id': 'c1', 'name': 'إلكترونيات', 'icon': Icons.devices, 'color': 0xFF2196F3, 'stores': 45},
    {'id': 'c2', 'name': 'أزياء', 'icon': Icons.checkroom, 'color': 0xFFE91E63, 'stores': 67},
    {'id': 'c3', 'name': 'سيارات', 'icon': Icons.directions_car, 'color': 0xFFF6465D, 'stores': 23},
    {'id': 'c4', 'name': 'عقارات', 'icon': Icons.home, 'color': 0xFF4CAF50, 'stores': 34},
    {'id': 'c5', 'name': 'أثاث', 'icon': Icons.chair, 'color': 0xFFFF9800, 'stores': 56},
    {'id': 'c6', 'name': 'مطاعم', 'icon': Icons.restaurant, 'color': 0xFF9C27B0, 'stores': 89},
    {'id': 'c7', 'name': 'مقاهي', 'icon': Icons.coffee, 'color': 0xFF795548, 'stores': 45},
    {'id': 'c8', 'name': 'مستشفيات', 'icon': Icons.local_hospital, 'color': 0xFF00BCD4, 'stores': 12},
    {'id': 'c9', 'name': 'جامعات', 'icon': Icons.school, 'color': 0xFF3F51B5, 'stores': 8},
    {'id': 'c10', 'name': 'صيدليات', 'icon': Icons.medical_services, 'color': 0xFF4CAF50, 'stores': 34},
  ];

  // المولات (Malls)
  final List<Map<String, dynamic>> _malls = [
    {'id': 'm1', 'name': 'اليمن مول', 'type': 'مول', 'lat': 15.3640, 'lng': 44.1890, 'address': 'الستين، صنعاء', 'rating': 4.7, 'stores': 250, 'image': 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=200', 'hours': '10ص-10م'},
    {'id': 'm2', 'name': 'سيتي مول', 'type': 'مول', 'lat': 15.3680, 'lng': 44.2020, 'address': 'السبعين، صنعاء', 'rating': 4.6, 'stores': 180, 'image': 'https://images.unsplash.com/photo-1519567241046-7f570eee3ce6?w=200', 'hours': '9ص-11م'},
    {'id': 'm3', 'name': 'غاليري مول', 'type': 'مول', 'lat': 15.3700, 'lng': 44.1950, 'address': 'حدة، صنعاء', 'rating': 4.8, 'stores': 120, 'image': 'https://images.unsplash.com/photo-1519567241046-7f570eee3ce6?w=200', 'hours': '10ص-10م'},
    {'id': 'm4', 'name': 'الموج مول', 'type': 'مول', 'lat': 12.7850, 'lng': 45.0190, 'address': 'كريتر، عدن', 'rating': 4.5, 'stores': 95, 'image': 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=200', 'hours': '9ص-11م'},
  ];

  // المتاجر (Stores - خدمات المنصة)
  final List<Map<String, dynamic>> _platformStores = [
    // متاجر إلكترونيات
    {'id': 's1', 'name': 'متجر التقنية', 'type': 'electronics', 'category': 'إلكترونيات', 'lat': 15.3694, 'lng': 44.1910, 'address': 'الستين، صنعاء', 'isOpen': true, 'rating': 4.8, 'verified': true, 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200'},
    {'id': 's2', 'name': 'عالم الجوالات', 'type': 'electronics', 'category': 'إلكترونيات', 'lat': 15.3660, 'lng': 44.1960, 'address': 'السبعين، صنعاء', 'isOpen': true, 'rating': 4.7, 'verified': true, 'image': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=200'},
    {'id': 's3', 'name': 'كمبيوتر مول', 'type': 'electronics', 'category': 'إلكترونيات', 'lat': 15.3720, 'lng': 44.1930, 'address': 'حدة، صنعاء', 'isOpen': true, 'rating': 4.9, 'verified': true, 'image': 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=200'},
    
    // متاجر أزياء
    {'id': 's4', 'name': 'الأزياء العصرية', 'type': 'fashion', 'category': 'أزياء', 'lat': 15.3710, 'lng': 44.1910, 'address': 'الستين، صنعاء', 'isOpen': true, 'rating': 4.6, 'verified': true, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200'},
    {'id': 's5', 'name': 'موضة اليمن', 'type': 'fashion', 'category': 'أزياء', 'lat': 15.3670, 'lng': 44.1930, 'address': 'السبعين، صنعاء', 'isOpen': false, 'rating': 4.5, 'verified': false, 'image': 'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=200'},
    
    // متاجر مطاعم
    {'id': 's6', 'name': 'مطعم المندي الملكي', 'type': 'restaurant', 'category': 'مطاعم', 'lat': 15.3740, 'lng': 44.1940, 'address': 'الستين، صنعاء', 'isOpen': true, 'rating': 4.8, 'verified': true, 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200'},
    {'id': 's7', 'name': 'مطعم فلكس', 'type': 'restaurant', 'category': 'مطاعم', 'lat': 15.3700, 'lng': 44.1880, 'address': 'حدة، صنعاء', 'isOpen': true, 'rating': 4.7, 'verified': true, 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200'},
    
    // متاجر مقاهي
    {'id': 's8', 'name': 'ستاربكس', 'type': 'cafe', 'category': 'مقاهي', 'lat': 15.3670, 'lng': 44.1950, 'address': 'السبعين، صنعاء', 'isOpen': true, 'rating': 4.7, 'verified': true, 'image': 'https://images.unsplash.com/photo-1507133750040-4a8f57021571?w=200'},
    {'id': 's9', 'name': 'مقهى الجبل الأخضر', 'type': 'cafe', 'category': 'مقاهي', 'lat': 15.3620, 'lng': 44.1860, 'address': 'الروضة، صنعاء', 'isOpen': true, 'rating': 4.6, 'verified': false, 'image': 'https://images.unsplash.com/photo-1442512595331-e89e73853f31?w=200'},
    
    // متاجر عقارات
    {'id': 's10', 'name': 'عقارات فلكس', 'type': 'realestate', 'category': 'عقارات', 'lat': 15.3680, 'lng': 44.1900, 'address': 'الستين، صنعاء', 'isOpen': true, 'rating': 4.8, 'verified': true, 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=200'},
    
    // متاجر سيارات
    {'id': 's11', 'name': 'معرض السيارات الحديثة', 'type': 'cars', 'category': 'سيارات', 'lat': 15.3680, 'lng': 44.2000, 'address': 'السبعين، صنعاء', 'isOpen': true, 'rating': 4.8, 'verified': true, 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=200'},
    
    // متاجر أثاث
    {'id': 's12', 'name': 'أثاث المنزل', 'type': 'furniture', 'category': 'أثاث', 'lat': 15.3650, 'lng': 44.1920, 'address': 'الستين، صنعاء', 'isOpen': true, 'rating': 4.5, 'verified': false, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200'},
  ];

  // المدن اليمنية
  final List<YemenCity> _yemenCities = [
    YemenCity(name: 'صنعاء', nameAr: 'صنعاء', governorate: 'أمانة العاصمة', lat: 15.3694, lng: 44.1910, population: '2,950,000', type: 'عاصمة'),
    YemenCity(name: 'عدن', nameAr: 'عدن', governorate: 'عدن', lat: 12.7855, lng: 45.0187, population: '865,000', type: 'مدينة ساحلية'),
    YemenCity(name: 'تعز', nameAr: 'تعز', governorate: 'تعز', lat: 13.5776, lng: 44.0179, population: '615,000', type: 'مدينة'),
    YemenCity(name: 'الحديدة', nameAr: 'الحديدة', governorate: 'الحديدة', lat: 14.7909, lng: 42.9712, population: '617,000', type: 'مدينة ساحلية'),
    YemenCity(name: 'المكلا', nameAr: 'المكلا', governorate: 'حضرموت', lat: 14.5424, lng: 49.1278, population: '566,000', type: 'مدينة ساحلية'),
  ];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        final position = await Geolocator.getCurrentPosition();
        setState(() {
          _currentPosition = position;
        });
      }
    } catch (e) {}
  }

  void _goToCurrentLocation() {
    if (_currentPosition != null) {
      _mapController.move(LatLng(_currentPosition!.latitude, _currentPosition!.longitude), 14);
    }
  }

  void _goToCity(YemenCity city) {
    _mapController.move(LatLng(city.lat, city.lng), 10);
    setState(() => _selectedCity = city.nameAr);
  }

  Widget _buildPlatformBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        gradient: AppTheme.goldGradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset('assets/icons/svg/platform_logo.svg', width: 14, height: 14),
          const SizedBox(width: 4),
          const Text('Flex', style: TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('خريطة الخدمات', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: isDark ? AppTheme.nightSurface : AppTheme.lightSurface,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(initialCenter: yemenCenter, initialZoom: _currentZoom),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.flexyemen.app',
              ),
              // علامات المدن
              MarkerLayer(
                markers: _yemenCities.map((city) => Marker(
                  point: LatLng(city.lat, city.lng),
                  width: 50, height: 50,
                  child: GestureDetector(
                    onTap: () => _goToCity(city),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppTheme.gold,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 5)],
                          ),
                          child: const Icon(Icons.location_on, color: Colors.white, size: 16),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(city.nameAr, style: const TextStyle(color: Colors.white, fontSize: 10)),
                        ),
                      ],
                    ),
                  ),
                )).toList(),
              ),
              // علامات المولات (مع شعار المنصة)
              MarkerLayer(
                markers: _malls.map((mall) => Marker(
                  point: LatLng(mall['lat'], mall['lng']),
                  width: 60, height: 60,
                  child: GestureDetector(
                    onTap: () => _showDetails(mall),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.gold,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: AppTheme.gold.withOpacity(0.5), blurRadius: 8)],
                          ),
                          child: const Icon(Icons.storefront, color: Colors.black, size: 24),
                        ),
                        Positioned(
                          top: -8,
                          right: -8,
                          child: SvgPicture.asset('assets/icons/svg/platform_logo.svg', width: 18, height: 18),
                        ),
                      ],
                    ),
                  ),
                )).toList(),
              ),
              // علامات المتاجر (مع شعار المنصة)
              MarkerLayer(
                markers: _platformStores.map((store) => Marker(
                  point: LatLng(store['lat'], store['lng']),
                  width: 50, height: 50,
                  child: GestureDetector(
                    onTap: () => _showDetails(store),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: store['isOpen'] ? AppTheme.green : Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4)],
                          ),
                          child: Icon(_getCategoryIcon(store['type']), color: Colors.white, size: 20),
                        ),
                        Positioned(
                          top: -6,
                          right: -6,
                          child: SvgPicture.asset('assets/icons/svg/platform_logo.svg', width: 14, height: 14),
                        ),
                      ],
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
          // زر الموقع
          Positioned(
            bottom: 20, right: 20,
            child: FloatingActionButton.small(
              onPressed: _goToCurrentLocation,
              backgroundColor: AppTheme.gold,
              child: const Icon(Icons.my_location, color: Colors.black),
            ),
          ),
          // قائمة المدن السريعة
          Positioned(
            top: 60, left: 16, right: 16,
            child: Container(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _yemenCities.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => _goToCity(_yemenCities[index]),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.nightCard : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.gold.withOpacity(0.5)),
                    ),
                    child: Text(_yemenCities[index].nameAr, style: const TextStyle(fontSize: 12)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDetails(Map<String, dynamic> item) {
    final isStore = item.containsKey('type') && !item.containsKey('stores');
    final isMall = item.containsKey('stores');
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(item['image'], width: 60, height: 60, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(width: 60, height: 60, color: AppTheme.gold.withOpacity(0.2), child: Icon(Icons.store, color: AppTheme.gold))),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(item['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 8),
                          if (item['verified'] == true)
                            _buildPlatformBadge(),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(children: [
                        const Icon(Icons.star, size: 12, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text('${item['rating']}', style: const TextStyle(fontSize: 12)),
                        const SizedBox(width: 12),
                        Icon(Icons.location_on, size: 12, color: AppTheme.gold),
                        const SizedBox(width: 2),
                        Text(item['address'], style: const TextStyle(fontSize: 11)),
                      ]),
                      if (isStore && item.containsKey('isOpen'))
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: (item['isOpen'] as bool) ? AppTheme.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text((item['isOpen'] as bool) ? 'مفتوح الآن' : 'مغلق', style: TextStyle(color: (item['isOpen'] as bool) ? AppTheme.green : Colors.red, fontSize: 10)),
                        ),
                      if (isMall)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: AppTheme.gold.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                          child: Text('${item['stores']} متجر', style: TextStyle(color: AppTheme.gold, fontSize: 10)),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.directions, size: 18),
                    label: const Text('الاتجاهات'),
                    style: OutlinedButton.styleFrom(side: BorderSide(color: AppTheme.gold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.store, size: 18),
                    label: const Text('زيارة المتجر'),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold, foregroundColor: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String? type) {
    switch (type) {
      case 'electronics': return Icons.devices;
      case 'fashion': return Icons.checkroom;
      case 'restaurant': return Icons.restaurant;
      case 'cafe': return Icons.coffee;
      case 'realestate': return Icons.home;
      case 'cars': return Icons.directions_car;
      case 'furniture': return Icons.chair;
      default: return Icons.store;
    }
  }
}

class YemenCity {
  final String name, nameAr, governorate, population, type;
  final double lat, lng;
  YemenCity({required this.name, required this.nameAr, required this.governorate, required this.lat, required this.lng, required this.population, required this.type});
}

// إضافة دالة لإنشاء شارة المنصة على الخريطة
Widget _buildFlexBadge(double size) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      gradient: AppTheme.goldGradient,
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 1),
    ),
    child: const Center(
      child: Text('F', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: size * 0.5)),
    ),
  );
}
