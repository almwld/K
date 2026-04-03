import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class InteractiveMapScreen extends StatefulWidget {
  const InteractiveMapScreen({super.key});

  @override
  State<InteractiveMapScreen> createState() => _InteractiveMapScreenState();
}

class _InteractiveMapScreenState extends State<InteractiveMapScreen> {
  late MapController _mapController;
  LatLng _currentLocation = const LatLng(15.3694, 44.1910); // صنعاء
  String _selectedStoreType = 'الكل';
  bool _isLoading = true;
  
  // أنواع المتاجر
  final List<String> _storeTypes = ['الكل', 'مطاعم', 'مقاهي', 'محلات', 'خدمات', 'مولات'];
  
  // المتاجر القريبة
  final List<Map<String, dynamic>> _stores = [
    {
      'id': '1',
      'name': 'مطعم المندي الملكي',
      'type': 'مطاعم',
      'lat': 15.3714,
      'lng': 44.1930,
      'address': 'شارع حدة، صنعاء',
      'rating': 4.8,
      'phone': '+967712345678',
      'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200',
      'distance': '0.3 كم',
    },
    {
      'id': '2',
      'name': 'مقهى ستاربكس',
      'type': 'مقاهي',
      'lat': 15.3650,
      'lng': 44.1950,
      'address': 'شارع الزراعة، صنعاء',
      'rating': 4.5,
      'phone': '+967712345679',
      'image': 'https://images.unsplash.com/photo-1507133750040-4a8f57021571?w=200',
      'distance': '0.5 كم',
    },
    {
      'id': '3',
      'name': 'سوق اليمن مول',
      'type': 'مولات',
      'lat': 15.3620,
      'lng': 44.1880,
      'address': 'شارع الستين، صنعاء',
      'rating': 4.7,
      'phone': '+967712345680',
      'image': 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=200',
      'distance': '0.8 كم',
    },
    {
      'id': '4',
      'name': 'محل العود الفاخر',
      'type': 'محلات',
      'lat': 15.3670,
      'lng': 44.2000,
      'address': 'شارع تعز، صنعاء',
      'rating': 4.6,
      'phone': '+967712345681',
      'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=200',
      'distance': '0.6 كم',
    },
    {
      'id': '5',
      'name': 'خدمة توصيل سريع',
      'type': 'خدمات',
      'lat': 15.3730,
      'lng': 44.1900,
      'address': 'شارع الرباط، صنعاء',
      'rating': 4.4,
      'phone': '+967712345682',
      'image': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=200',
      'distance': '0.4 كم',
    },
    {
      'id': '6',
      'name': 'مطعم السمك اليمني',
      'type': 'مطاعم',
      'lat': 15.3750,
      'lng': 44.1980,
      'address': 'شارع المطار، صنعاء',
      'rating': 4.9,
      'phone': '+967712345683',
      'image': 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=200',
      'distance': '0.7 كم',
    },
    {
      'id': '7',
      'name': 'مقهى الجبل الأخضر',
      'type': 'مقاهي',
      'lat': 15.3600,
      'lng': 44.1850,
      'address': 'شارع الخمسين، صنعاء',
      'rating': 4.3,
      'phone': '+967712345684',
      'image': 'https://images.unsplash.com/photo-1442512595331-e89e73853f31?w=200',
      'distance': '1.0 كم',
    },
    {
      'id': '8',
      'name': 'مجمع فاميلي مول',
      'type': 'مولات',
      'lat': 15.3680,
      'lng': 44.2030,
      'address': 'شارع الحديدة، صنعاء',
      'rating': 4.6,
      'phone': '+967712345685',
      'image': 'https://images.unsplash.com/photo-1491637639811-60e2756cc1c7?w=200',
      'distance': '0.9 كم',
    },
  ];

  List<Map<String, dynamic>> get _filteredStores {
    if (_selectedStoreType == 'الكل') return _stores;
    return _stores.where((store) => store['type'] == _selectedStoreType).toList();
  }

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filteredStores = _filteredStores;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الخريطة التفاعلية'),
      body: Stack(
        children: [
          // الخريطة
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLocation,
              initialZoom: 14,
              interactionOptions: const InteractionOptions(
                enableMultiFingerGestureZoom: true,
                enablePinchZoom: true,
                enableScrollWheelZoom: true,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.flex.yemen',
              ),
              // علامة الموقع الحالي
              MarkerLayer(
                markers: [
                  Marker(
                    width: 40,
                    height: 40,
                    point: _currentLocation,
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                  // علامات المتاجر
                  ...filteredStores.map((store) => Marker(
                    width: 40,
                    height: 40,
                    point: LatLng(store['lat'], store['lng']),
                    child: GestureDetector(
                      onTap: () {
                        _showStoreDetails(store);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppTheme.goldColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          _getStoreIcon(store['type']),
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ],
          ),
          
          // شريط البحث والفلتر
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'بحث عن متجر...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: Colors.grey[300],
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: () {
                        _showFilterDialog();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // فلتر الأنواع
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Container(
              height: 45,
              color: isDark ? AppTheme.darkBackground.withOpacity(0.9) : Colors.white.withOpacity(0.9),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: _storeTypes.length,
                itemBuilder: (context, index) {
                  final type = _storeTypes[index];
                  final isSelected = _selectedStoreType == type;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                    child: FilterChip(
                      label: Text(type),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedStoreType = selected ? type : 'الكل';
                        });
                      },
                      selectedColor: AppTheme.goldColor,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // زر تحديد الموقع
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton.small(
              onPressed: () {
                _mapController.move(_currentLocation, 15);
              },
              backgroundColor: AppTheme.goldColor,
              child: const Icon(Icons.my_location, color: Colors.white),
            ),
          ),
          
          // قائمة المتاجر الجانبية
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filteredStores.length,
                itemBuilder: (context, index) {
                  final store = filteredStores[index];
                  return GestureDetector(
                    onTap: () {
                      _mapController.move(LatLng(store['lat'], store['lng']), 16);
                      _showStoreDetails(store);
                    },
                    child: Container(
                      width: 180,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.getCardColor(context),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                            child: Image.network(
                              store['image'],
                              width: 60,
                              height: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 60,
                                color: Colors.grey[300],
                                child: const Icon(Icons.store),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    store['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, size: 12, color: Colors.amber),
                                      Text(' ${store['rating']}', style: const TextStyle(fontSize: 10)),
                                    ],
                                  ),
                                  Text(
                                    store['distance'],
                                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // مؤشر التحميل
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'تصفية المتاجر',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                children: _storeTypes.map((type) {
                  return FilterChip(
                    label: Text(type),
                    selected: _selectedStoreType == type,
                    onSelected: (selected) {
                      setState(() {
                        _selectedStoreType = selected ? type : 'الكل';
                      });
                      Navigator.pop(context);
                    },
                    selectedColor: AppTheme.goldColor,
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showStoreDetails(Map<String, dynamic> store) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      store['image'],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[300],
                        child: const Icon(Icons.store),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          store['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 16, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text('${store['rating']}'),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.goldColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                store['type'],
                                style: TextStyle(
                                  color: AppTheme.goldColor,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(child: Text(store['address'])),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.phone, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(store['phone']),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.directions),
                      label: const Text('الاتجاهات'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.goldColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.phone),
                      label: const Text('اتصال'),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppTheme.goldColor),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _getStoreIcon(String type) {
    switch (type) {
      case 'مطاعم':
        return Icons.restaurant;
      case 'مقاهي':
        return Icons.coffee;
      case 'محلات':
        return Icons.store;
      case 'خدمات':
        return Icons.build;
      case 'مولات':
        return Icons.shopping_mall;
      default:
        return Icons.place;
    }
  }
}
