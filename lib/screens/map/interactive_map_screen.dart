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
  LatLng _center = const LatLng(15.3694, 44.1910); // صنعاء
  double _zoom = 13.0;

  // مواقع في اليمن
  final List<Map<String, dynamic>> _locations = [
    {'name': 'صنعاء', 'lat': 15.3694, 'lng': 44.1910, 'type': 'عاصمة'},
    {'name': 'عدن', 'lat': 12.7855, 'lng': 45.0187, 'type': 'مدينة ساحلية'},
    {'name': 'تعز', 'lat': 13.5776, 'lng': 44.0179, 'type': 'مدينة تاريخية'},
    {'name': 'الحديدة', 'lat': 14.7909, 'lng': 42.9712, 'type': 'ميناء'},
    {'name': 'المكلا', 'lat': 14.5424, 'lng': 49.1278, 'type': 'ساحلية'},
    {'name': 'إب', 'lat': 13.9677, 'lng': 44.1535, 'type': 'جبال خضراء'},
    {'name': 'ذمار', 'lat': 14.5550, 'lng': 44.3930, 'type': 'أثرية'},
    {'name': 'صعدة', 'lat': 16.9406, 'lng': 43.7590, 'type': 'شمالية'},
  ];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  void _goToLocation(double lat, double lng) {
    setState(() {
      _center = LatLng(lat, lng);
      _zoom = 14;
    });
    _mapController.move(_center, _zoom);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'خريطة اليمن'),
      body: Stack(
        children: [
          // الخريطة
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: _zoom,
              onTap: (tapPosition, point) {
                // يمكن إضافة منطق عند النقر
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.flexyemen.app',
              ),
              // علامات المواقع
              MarkerLayer(
                markers: _locations.map((location) {
                  return Marker(
                    point: LatLng(location['lat'], location['lng']),
                    width: 40,
                    height: 40,
                    child: GestureDetector(
                      onTap: () => _showLocationDialog(location),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppTheme.goldColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.location_on, color: Colors.white, size: 20),
                      ),
                    ),
                  );
                }).toList(),
              ),
              // علامة الموقع الحالي (مركز الخريطة)
              MarkerLayer(
                markers: [
                  Marker(
                    point: _center,
                    width: 50,
                    height: 50,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                      child: const Icon(Icons.my_location, color: Colors.blue, size: 24),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // قائمة المدن السريعة
          Positioned(
            top: 16,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _locations.length,
                itemBuilder: (context, index) {
                  final location = _locations[index];
                  return GestureDetector(
                    onTap: () => _goToLocation(location['lat'], location['lng']),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[800] : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Text(
                        location['name'],
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // أزرار التحكم
          Positioned(
            bottom: 16,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    setState(() {
                      _zoom = _zoom + 1;
                      _mapController.move(_center, _zoom);
                    });
                  },
                  backgroundColor: AppTheme.goldColor,
                  child: const Icon(Icons.zoom_in, color: Colors.black),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    setState(() {
                      _zoom = _zoom - 1;
                      _mapController.move(_center, _zoom);
                    });
                  },
                  backgroundColor: AppTheme.goldColor,
                  child: const Icon(Icons.zoom_out, color: Colors.black),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    setState(() {
                      _center = const LatLng(15.3694, 44.1910);
                      _zoom = 13;
                      _mapController.move(_center, _zoom);
                    });
                  },
                  backgroundColor: AppTheme.goldColor,
                  child: const Icon(Icons.center_focus_strong, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLocationDialog(Map<String, dynamic> location) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_on, size: 50, color: AppTheme.goldColor),
            const SizedBox(height: 12),
            Text(
              location['name'],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(location['type']),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _goToLocation(location['lat'], location['lng']),
                    icon: const Icon(Icons.navigation),
                    label: const Text('الاتجاهات'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.goldColor,
                      foregroundColor: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
