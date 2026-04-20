import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class EnhancedMapScreen extends StatefulWidget {
  const EnhancedMapScreen({super.key});

  @override
  State<EnhancedMapScreen> createState() => _EnhancedMapScreenState();
}

class _EnhancedMapScreenState extends State<EnhancedMapScreen> {
  final MapController _mapController = MapController();
  LatLng _center = const LatLng(15.3694, 44.1910);
  double _zoom = 6;
  int _selectedCityIndex = -1;

  // بيانات المدن اليمنية مع معلومات تفصيلية
  final List<Map<String, dynamic>> _yemenCities = [
    {
      'id': 'sanaa',
      'name': 'صنعاء',
      'nameEn': 'Sanaa',
      'lat': 15.3694,
      'lng': 44.1910,
      'region': 'الوسطى',
      'population': '2,545,000',
      'description': 'العاصمة اليمنية، مدينة التاريخ والحضارة',
      'image': 'https://images.unsplash.com/photo-1595078475328-1ab05d0a6a0e?w=200',
      'places': ['باب اليمن', 'جامع الصالح', 'سوق الملح'],
    },
    {
      'id': 'aden',
      'name': 'عدن',
      'nameEn': 'Aden',
      'lat': 12.7855,
      'lng': 45.0187,
      'region': 'الجنوبية',
      'population': '1,050,000',
      'description': 'المدينة الساحلية الجميلة، عروس البحر',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=200',
      'places': ['كريتر', 'خور مكسر', 'شاطئ الذهب'],
    },
    {
      'id': 'taiz',
      'name': 'تعز',
      'nameEn': 'Taiz',
      'lat': 13.5776,
      'lng': 44.0179,
      'region': 'الجنوبية',
      'population': '615,000',
      'description': 'مدينة الثقافة والتاريخ، القلعة الشهيرة',
      'image': 'https://images.unsplash.com/photo-1595078475328-1ab05d0a6a0e?w=200',
      'places': ['قلعة القاهرة', 'سوق الجند', 'جامع المظفر'],
    },
    {
      'id': 'hodeidah',
      'name': 'الحديدة',
      'nameEn': 'Hodeidah',
      'lat': 14.7909,
      'lng': 42.9712,
      'region': 'الساحلية',
      'population': '700,000',
      'description': 'ميناء البحر الأحمر، بوابة اليمن الغربية',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=200',
      'places': ['ميناء الحديدة', 'سوق السمك', 'جزيرة كمران'],
    },
    {
      'id': 'mukalla',
      'name': 'المكلا',
      'nameEn': 'Mukalla',
      'lat': 14.5424,
      'lng': 49.1278,
      'region': 'الشرقية',
      'population': '550,000',
      'description': 'لؤلؤة البحر العربي، مدينة الجمال',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=200',
      'places': ['الكورنيش', 'شاطئ المكلا', 'مدينة الشحر'],
    },
    {
      'id': 'ibb',
      'name': 'إب',
      'nameEn': 'Ibb',
      'lat': 13.9677,
      'lng': 44.1535,
      'region': 'الوسطى',
      'population': '350,000',
      'description': 'الخضراء الجميلة، مدينة الجبال',
      'image': 'https://images.unsplash.com/photo-1595078475328-1ab05d0a6a0e?w=200',
      'places': ['جبل سبير', 'مدرجات إب', 'سوق إب'],
    },
    {
      'id': 'dhamar',
      'name': 'ذمار',
      'nameEn': 'Dhamar',
      'lat': 14.5550,
      'lng': 44.3930,
      'region': 'الوسطى',
      'population': '200,000',
      'description': 'مدينة الآثار والتاريخ',
      'image': 'https://images.unsplash.com/photo-1595078475328-1ab05d0a6a0e?w=200',
      'places': ['مدينة ذمار القديمة', 'سد ذمار'],
    },
    {
      'id': 'saadah',
      'name': 'صعدة',
      'nameEn': 'Saadah',
      'lat': 16.9406,
      'lng': 43.7590,
      'region': 'الشمالية',
      'population': '180,000',
      'description': 'شمال اليمن، مدينة التاريخ',
      'image': 'https://images.unsplash.com/photo-1595078475328-1ab05d0a6a0e?w=200',
      'places': ['قلعة صعدة', 'سوق صعدة'],
    },
  ];

  void _goToCity(int index) {
    final city = _yemenCities[index];
    setState(() {
      _selectedCityIndex = index;
      _center = LatLng(city['lat'], city['lng']);
      _zoom = 12;
    });
    _mapController.move(_center, _zoom);
  }

  void _showCityDetails(Map<String, dynamic> city) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.getDividerColor(context),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    city['image'],
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 80,
                      height: 80,
                      color: AppTheme.gold.withOpacity(0.1),
                      child: const Icon(Icons.image, color: AppTheme.gold),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        city['name'],
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        city['region'],
                        style: TextStyle(color: AppTheme.gold, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.people, size: 14),
                          const SizedBox(width: 4),
                          Text(city['population']),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              city['description'],
              style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
            ),
            const SizedBox(height: 16),
            const Text(
              'أهم المعالم',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: (city['places'] as List<dynamic>).map((place) {
                return Chip(
                  label: Text(place),
                  backgroundColor: AppTheme.gold.withOpacity(0.1),
                  labelStyle: const TextStyle(fontSize: 12),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _goToCity(_yemenCities.indexWhere((c) => c['id'] == city['id']));
                },
                icon: const Icon(Icons.map),
                label: const Text('عرض على الخريطة'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.gold,
                  foregroundColor: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'خريطة اليمن'),
      body: Stack(
        children: [
          // الخريطة
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: _zoom,
              onTap: (_, __) => setState(() => _selectedCityIndex = -1),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.flexyemen.app',
              ),
              MarkerLayer(
                markers: _yemenCities.asMap().entries.map((entry) {
                  final index = entry.key;
                  final city = entry.value;
                  final isSelected = _selectedCityIndex == index;
                  return Marker(
                    point: LatLng(city['lat'], city['lng']),
                    width: isSelected ? 60 : 50,
                    height: isSelected ? 60 : 50,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _selectedCityIndex = index);
                        _showCityDetails(city);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.all(isSelected ? 12 : 8),
                        decoration: BoxDecoration(
                          color: AppTheme.gold,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.gold.withOpacity(isSelected ? 0.6 : 0.3),
                              blurRadius: isSelected ? 15 : 8,
                              spreadRadius: isSelected ? 5 : 2,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: isSelected ? 28 : 20,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          
          // زر تصغير الخريطة
          Positioned(
            bottom: 80,
            right: 16,
            child: FloatingActionButton(
              mini: true,
              onPressed: () {
                setState(() {
                  _zoom = _zoom - 1;
                  _mapController.move(_center, _zoom);
                });
              },
              backgroundColor: AppTheme.gold,
              child: const Icon(Icons.zoom_out, color: Colors.black),
            ),
          ),
          
          // زر تكبير الخريطة
          Positioned(
            bottom: 140,
            right: 16,
            child: FloatingActionButton(
              mini: true,
              onPressed: () {
                setState(() {
                  _zoom = _zoom + 1;
                  _mapController.move(_center, _zoom);
                });
              },
              backgroundColor: AppTheme.gold,
              child: const Icon(Icons.zoom_in, color: Colors.black),
            ),
          ),
          
          // زر إعادة تعيين الخريطة
          Positioned(
            bottom: 200,
            right: 16,
            child: FloatingActionButton(
              mini: true,
              onPressed: () {
                setState(() {
                  _center = const LatLng(15.3694, 44.1910);
                  _zoom = 6;
                  _selectedCityIndex = -1;
                  _mapController.move(_center, _zoom);
                });
              },
              backgroundColor: AppTheme.gold,
              child: const Icon(Icons.center_focus_strong, color: Colors.black),
            ),
          ),
          
          // قائمة المدن السريعة
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: isDark ? AppTheme.nightCard : Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)],
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _yemenCities.length,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (context, index) {
                  final city = _yemenCities[index];
                  final isSelected = _selectedCityIndex == index;
                  return GestureDetector(
                    onTap: () => _goToCity(index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? const LinearGradient(
                                colors: [AppTheme.gold, AppTheme.goldLight],
                              )
                            : null,
                        color: isSelected ? null : (isDark ? AppTheme.nightCard : Colors.grey[200]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        city['name'],
                        style: TextStyle(
                          color: isSelected ? Colors.black : AppTheme.getTextColor(context),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // مؤشر التحميل
          if (_selectedCityIndex == -1 && _zoom == 6)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.touch_app, color: Colors.white, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'اضغط على أي مدينة لاستكشافها',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

