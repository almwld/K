import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../../theme/app_theme.dart';
import '../../data/yemen_cities_data.dart';
import '../../data/stores_data.dart';

class InteractiveMapScreen extends StatefulWidget {
  const InteractiveMapScreen({super.key});

  @override
  State<InteractiveMapScreen> createState() => _InteractiveMapScreenState();
}

class _InteractiveMapScreenState extends State<InteractiveMapScreen> {
  late final MapController _mapController;
  LatLng _currentCenter = const LatLng(15.3694, 44.1910);
  double _currentZoom = 6.5;
  String _selectedLayer = 'standard';
  YemenCity? _selectedCity;

  final Map<String, String> _tileLayers = {
    'standard': 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    'satellite': 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
  };

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
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(initialCenter: _currentCenter, initialZoom: _currentZoom),
            children: [
              TileLayer(urlTemplate: _tileLayers[_selectedLayer]!, userAgentPackageName: 'com.flexyemen.app'),
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
          Positioned(
            top: 10, left: 10, right: 10,
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: TextField(
                decoration: InputDecoration(hintText: 'ابحث عن مدينة...', prefixIcon: const Icon(Icons.search), border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none)),
                onSubmitted: _searchCity,
              ),
            ),
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
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.navigation),
                    label: const Text('توجيه'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _searchCity(String query) {
    final city = YemenCitiesData.getAllCities().firstWhere(
      (c) => c.nameAr.contains(query),
      orElse: () => YemenCitiesData.getAllCities().first,
    );
    _mapController.move(city.coordinates, 10);
    _showCityDetails(city);
  }
}
