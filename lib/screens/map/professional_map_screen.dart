import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import '../../models/store_model.dart';

class ProfessionalMapScreen extends StatefulWidget {
  const ProfessionalMapScreen({super.key});

  @override
  State<ProfessionalMapScreen> createState() => _ProfessionalMapScreenState();
}

class _ProfessionalMapScreenState extends State<ProfessionalMapScreen> {
  final MapController _mapController = MapController();
  LatLng? _currentLocation;
  List<Marker> _storeMarkers = [];
  List<StoreModel> _nearbyStores = [];
  bool _isLoading = true;
  String _selectedFilter = 'all';

  final List<Map<String, dynamic>> _filters = [
    {'value': 'all', 'label': 'الكل', 'icon': Icons.store},
    {'value': 'electronics', 'label': 'إلكترونيات', 'icon': Icons.devices},
    {'value': 'restaurants', 'label': 'مطاعم', 'icon': Icons.restaurant},
    {'value': 'fashion', 'label': 'أزياء', 'icon': Icons.checkroom},
    {'value': 'furniture', 'label': 'أثاث', 'icon': Icons.chair},
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition();
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
          _mapController.move(_currentLocation!, 15);
        });
        _loadNearbyStores();
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadNearbyStores() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _nearbyStores = [
        StoreModel(
          id: '1', name: 'متجر التقنية', lat: _currentLocation!.latitude + 0.002, lng: _currentLocation!.longitude + 0.003,
          address: 'شارع حدة', rating: 4.5, category: 'electronics', isOpen: true, distance: 250,
        ),
        StoreModel(
          id: '2', name: 'مطعم الأصيل', lat: _currentLocation!.latitude - 0.001, lng: _currentLocation!.longitude - 0.002,
          address: 'شارع التحرير', rating: 4.8, category: 'restaurants', isOpen: true, distance: 180,
        ),
        StoreModel(
          id: '3', name: 'أزياء فلكس', lat: _currentLocation!.latitude + 0.001, lng: _currentLocation!.longitude - 0.001,
          address: 'شارع الزراعة', rating: 4.3, category: 'fashion', isOpen: false, distance: 320,
        ),
      ];
      _updateMarkers();
      _isLoading = false;
    });
  }

  void _updateMarkers() {
    final filteredStores = _selectedFilter == 'all'
        ? _nearbyStores
        : _nearbyStores.where((s) => s.category == _selectedFilter).toList();

    _storeMarkers = filteredStores.map((store) {
      return Marker(
        point: LatLng(store.lat, store.lng),
        width: 50,
        height: 50,
        child: GestureDetector(
          onTap: () => _showStoreDetails(store),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: store.isOpen ? AppTheme.goldColor : Colors.grey,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 5)],
            ),
            child: Icon(
              _getCategoryIcon(store.category),
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      );
    }).toList();
    setState(() {});
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'electronics': return Icons.devices;
      case 'restaurants': return Icons.restaurant;
      case 'fashion': return Icons.checkroom;
      case 'furniture': return Icons.chair;
      default: return Icons.store;
    }
  }

  void _showStoreDetails(StoreModel store) {
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
                  width: 60, height: 60,
                  decoration: BoxDecoration(
                    color: AppTheme.goldColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(_getCategoryIcon(store.category), color: AppTheme.goldColor, size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(store.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(store.address, style: const TextStyle(color: Colors.grey)),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text('${store.rating}'),
                          const SizedBox(width: 12),
                          Container(
                            width: 8, height: 8,
                            decoration: BoxDecoration(
                              color: store.isOpen ? Colors.green : Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(store.isOpen ? 'مفتوح' : 'مغلق'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
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
      appBar: const SimpleAppBar(title: 'الخريطة'),
      body: Stack(
        children: [
          if (_currentLocation != null)
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentLocation!,
                initialZoom: 14,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.flexyemen.app',
                ),
                MarkerLayer(markers: _storeMarkers),
                if (_currentLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _currentLocation!,
                        width: 40,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.my_location, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          
          // فلتر المحلات
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _filters.map((filter) {
                    final isSelected = _selectedFilter == filter['value'];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FilterChip(
                        label: Text(filter['label']),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() => _selectedFilter = filter['value'] as String);
                          _updateMarkers();
                        },
                        avatar: Icon(filter['icon'] as IconData, size: 18),
                        selectedColor: AppTheme.goldColor,
                        backgroundColor: isDark ? AppTheme.darkCard : Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          
          // زر تحديد الموقع
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: _getCurrentLocation,
              backgroundColor: AppTheme.goldColor,
              child: const Icon(Icons.my_location, color: Colors.black),
            ),
          ),
          
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
