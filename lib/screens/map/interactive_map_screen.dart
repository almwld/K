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
  final MapController _mapController = MapController();
  final LatLng _yemenCenter = const LatLng(15.3694, 44.1910); // صنعاء

  // مواقع المتاجر في اليمن
  final List<Map<String, dynamic>> _stores = [
    {'name': 'متجر التقنية - صنعاء', 'lat': 15.3694, 'lng': 44.1910, 'icon': Icons.store, 'color': 0xFFFF9800},
    {'name': 'معرض السيارات - صنعاء', 'lat': 15.3650, 'lng': 44.1950, 'icon': Icons.directions_car, 'color': 0xFF2196F3},
    {'name': 'مطعم الأصيل - صنعاء', 'lat': 15.3675, 'lng': 44.1895, 'icon': Icons.restaurant, 'color': 0xFFE74C3C},
    {'name': 'أزياء فلكس - عدن', 'lat': 12.7855, 'lng': 45.0187, 'icon': Icons.checkroom, 'color': 0xFFE91E63},
    {'name': 'متجر الأثاث - تعز', 'lat': 13.5776, 'lng': 44.0179, 'icon': Icons.chair, 'color': 0xFF795548},
  ];

  List<Marker> _getMarkers() {
    return _stores.map((store) {
      return Marker(
        point: LatLng(store['lat'], store['lng']),
        width: 40,
        height: 40,
        child: GestureDetector(
          onTap: () => _showStoreDetails(store),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Color(store['color']),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 5)],
            ),
            child: Icon(store['icon'], color: Colors.white, size: 20),
          ),
        ),
      );
    }).toList();
  }

  void _showStoreDetails(Map<String, dynamic> store) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 50, height: 50,
                  decoration: BoxDecoration(
                    color: Color(store['color']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(store['icon'], color: Color(store['color']), size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    store['name'],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.directions),
                label: const Text('الاتجاهات'),
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الخريطة'),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _yemenCenter,
          initialZoom: 7,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.flexyemen.app',
          ),
          MarkerLayer(markers: _getMarkers()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mapController.move(_yemenCenter, 7);
        },
        backgroundColor: AppTheme.goldColor,
        child: const Icon(Icons.my_location, color: Colors.black),
      ),
    );
  }
}
