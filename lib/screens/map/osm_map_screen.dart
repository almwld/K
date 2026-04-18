import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class OSMmapScreen extends StatelessWidget {
  const OSMmapScreen({super.key});

  final List<Map<String, dynamic>> _locations = const [
    {'name': 'صنعاء', 'lat': 15.3694, 'lng': 44.1910},
    {'name': 'عدن', 'lat': 12.7855, 'lng': 45.0187},
    {'name': 'تعز', 'lat': 13.5776, 'lng': 44.0179},
    {'name': 'الحديدة', 'lat': 14.7909, 'lng': 42.9712},
    {'name': 'المكلا', 'lat': 14.5424, 'lng': 49.1278},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'خريطة اليمن'),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: const LatLng(15.3694, 44.1910),
          initialZoom: 6,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.flexyemen.app',
          ),
          MarkerLayer(
            markers: _locations.map((location) => Marker(
              point: LatLng(location['lat'], location['lng']),
              width: 40,
              height: 40,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppTheme.gold,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 5)],
                ),
                child: const Icon(Icons.location_on, color: Colors.white, size: 20),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
