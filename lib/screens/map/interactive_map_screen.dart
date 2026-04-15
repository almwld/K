import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../theme/app_theme.dart';
import '../../data/yemen_cities_data.dart';

class InteractiveMapScreen extends StatefulWidget {
  const InteractiveMapScreen({super.key});

  @override
  State<InteractiveMapScreen> createState() => _InteractiveMapScreenState();
}

class _InteractiveMapScreenState extends State<InteractiveMapScreen> {
  late final MapController _mapController;
  LatLng _currentCenter = const LatLng(15.3694, 44.1910);
  double _currentZoom = 6.5;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    final cities = YemenCitiesData.getAllCities();
    
    return Scaffold(
      appBar: AppBar(title: const Text('خريطة اليمن'), backgroundColor: AppTheme.goldColor),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(initialCenter: _currentCenter, initialZoom: _currentZoom),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.flexyemen.app',
          ),
          MarkerLayer(
            markers: cities.map((city) => Marker(
              point: city.coordinates,
              width: 60,
              height: 60,
              child: GestureDetector(
                onTap: () => _showCityDetails(city),
                child: Column(
                  children: [
                    Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle), child: const Icon(Icons.location_city, color: Colors.white, size: 16)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 4), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(10)), child: Text(city.nameAr, style: const TextStyle(color: Colors.white, fontSize: 10))),
                  ],
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  void _showCityDetails(YemenCity city) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(city.nameAr, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(city.governorate),
            const SizedBox(height: 10),
            Text(city.description),
          ],
        ),
      ),
    );
  }
}
