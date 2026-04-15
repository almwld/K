import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';
import '../../data/yemen_cities_data.dart';
import '../../data/stores_data.dart';

class InteractiveMapScreen extends StatefulWidget {
  const InteractiveMapScreen({super.key});

  @override
  State<InteractiveMapScreen> createState() => _InteractiveMapScreenState();
}

class _InteractiveMapScreenState extends State<InteractiveMapScreen> with SingleTickerProviderStateMixin {
  late final MapController _mapController;
  late TabController _tabController;
  
  LatLng _currentCenter = LatLng(15.3694, 44.1910); // صنعاء
  double _currentZoom = 6.5;
  Position? _currentPosition;
  bool _isLoading = true;
  String _selectedLayer = 'standard';
  String _searchQuery = '';
  List<Marker> _markers = [];
  YemenCity? _selectedCity;
  bool _showCities = true;
  bool _showStores = true;

  // طبقات الخريطة المجانية
  final Map<String, String> _tileLayers = {
    'standard': 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    'topo': 'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png',
    'satellite': 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
    'dark': 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
  };

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _tabController = TabController(length: 3, vsync: this);
    _getCurrentLocation();
    _loadMarkers();
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
          _currentCenter = LatLng(position.latitude, position.longitude);
          _currentZoom = 12;
          _isLoading = false;
        });
        _mapController.move(_currentCenter, _currentZoom);
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _loadMarkers() {
    final cities = YemenCitiesData.getAllCities();
    final stores = StoresData.getAllStores();
    
    _markers = [];
    
    // إضافة علامات المدن
    if (_showCities) {
      for (var city in cities) {
        _markers.add(
          Marker(
            point: city.coordinates,
            width: 80,
            height: 80,
            child: GestureDetector(
              onTap: () => _showCityDetails(city),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: _getCityColor(city.type),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 5)],
                    ),
                    child: Icon(_getCityIcon(city.type), color: Colors.white, size: 16),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      city.nameAr,
                      style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
    
    // إضافة علامات المتاجر
    if (_showStores) {
      for (var store in stores) {
        // محاكاة إحداثيات للمتاجر
        final randomLat = 12.0 + (store.name.hashCode % 600) / 100.0;
        final randomLng = 43.0 + (store.name.hashCode % 1000) / 100.0;
        
        _markers.add(
          Marker(
            point: LatLng(randomLat, randomLng),
            width: 40,
            height: 40,
            child: GestureDetector(
              onTap: () => _showStoreDetails(store),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppTheme.goldColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.store, color: Colors.white, size: 14),
              ),
            ),
          ),
        );
      }
    }
    
    setState(() {});
  }

  Color _getCityColor(String type) {
    switch (type) {
      case 'عاصمة': return Colors.red;
      case 'مدينة ساحلية': return Colors.blue;
      case 'مدينة تاريخية': return Colors.orange;
      case 'موقع تراث عالمي': return Colors.purple;
      case 'جزيرة': return Colors.teal;
      default: return Colors.green;
    }
  }

  IconData _getCityIcon(String type) {
    switch (type) {
      case 'عاصمة': return Icons.star;
      case 'مدينة ساحلية': return Icons.water;
      case 'مدينة تاريخية': return Icons.account_balance;
      case 'موقع تراث عالمي': return Icons.public;
      case 'جزيرة': return Icons.beach_access;
      default: return Icons.location_city;
    }
  }

  void _showCityDetails(YemenCity city) {
    setState(() => _selectedCity = city);
    _mapController.move(city.coordinates, 10);
    
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
                  child: Image.network(city.imageUrl, width: 80, height: 80, fit: BoxFit.cover),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(city.nameAr, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(city.governorate, style: TextStyle(color: Colors.grey[600])),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: AppTheme.goldColor, borderRadius: BorderRadius.circular(12)),
                        child: Text(city.type, style: const TextStyle(color: Colors.white, fontSize: 11)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(city.description, style: const TextStyle(fontSize: 14, height: 1.5)),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.people, size: 16, color: AppTheme.goldColor),
                const SizedBox(width: 8),
                Text('عدد السكان: ${city.population.toString().replaceAllMapped(RegExp(r'\d{1,3}(?=(\d{3})+(?!\d))'), (m) => '${m[0]},')}'),
              ],
            ),
            const SizedBox(height": 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _navigateTo(city.coordinates),
                    icon: const Icon(Icons.navigation),
                    label: const Text('توجيه'),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showNearbyStores(city),
                    icon: const Icon(Icons.store),
                    label: const Text('متاجر قريبة'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showStoreDetails(store) {
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
                  child: Image.network(store.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(store.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(store.category, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          Text(' ${store.rating}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: AppTheme.goldColor),
                const SizedBox(width: 8),
                Expanded(child: Text(store.address, style: const TextStyle(fontSize: 13))),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/store_detail', arguments: store);
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
                child: const Text('عرض المتجر'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateTo(LatLng destination) async {
    final url = Uri.parse('https://www.openstreetmap.org/directions?route=${_currentCenter.latitude},${_currentCenter.longitude};${destination.latitude},${destination.longitude}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _showNearbyStores(YemenCity city) {
    Navigator.pop(context);
    setState(() {
      _showStores = true;
      _showCities = true;
      _loadMarkers();
      _mapController.move(city.coordinates, 11);
    });
  }

  void _goToCurrentLocation() async {
    if (_currentPosition != null) {
      _mapController.move(LatLng(_currentPosition!.latitude, _currentPosition!.longitude), 14);
    } else {
      await _getCurrentLocation();
    }
  }

  void _searchCity(String query) {
    setState(() => _searchQuery = query);
    if (query.isEmpty) return;
    
    final city = YemenCitiesData.getAllCities().firstWhere(
      (c) => c.nameAr.toLowerCase().contains(query.toLowerCase()),
      orElse: () => YemenCitiesData.getAllCities().first,
    );
    
    _mapController.move(city.coordinates, 10);
    _showCityDetails(city);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('خريطة اليمن التفاعلية'),
        backgroundColor: AppTheme.goldColor,
        foregroundColor: Colors.black,
        actions: [
          IconButton(onPressed: _goToCurrentLocation, icon: const Icon(Icons.my_location)),
          PopupMenuButton<String>(
            onSelected: (value) => setState(() {
              _selectedLayer = value;
            }),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'standard', child: Text('خريطة عادية')),
              const PopupMenuItem(value: 'topo', child: Text('تضاريس')),
              const PopupMenuItem(value: 'satellite', child: Text('قمر صناعي')),
              const PopupMenuItem(value: 'dark', child: Text('داكن')),
            ],
            child: const Icon(Icons.layers),
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentCenter,
              initialZoom: _currentZoom,
              onTap: (_, __) => setState(() => _selectedCity = null),
            ),
            children: [
              TileLayer(
                urlTemplate: _tileLayers[_selectedLayer]!,
                userAgentPackageName: 'com.flexyemen.app',
                maxZoom: 19,
              ),
              MarkerLayer(markers: _markers),
              if (_currentPosition != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                      width: 40,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.my_location, color: Colors.blue, size: 20),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          
          // شريط البحث
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
              ),
              child: TextField(
                onSubmitted: _searchCity,
                decoration: InputDecoration(
                  hintText: 'ابحث عن مدينة...',
                  prefixIcon: const Icon(Icons.search, color: AppTheme.goldColor),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
          
          // أزرار التحكم
          Positioned(
            bottom: 10,
            right: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'zoom_in',
                  mini: true,
                  onPressed: () => _mapController.move(_mapController.camera.center, _mapController.camera.zoom + 1),
                  backgroundColor: AppTheme.goldColor,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'zoom_out',
                  mini: true,
                  onPressed: () => _mapController.move(_mapController.camera.center, _mapController.camera.zoom - 1),
                  backgroundColor: AppTheme.goldColor,
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ),
          
          // أزرار الفلاتر
          Positioned(
            bottom: 10,
            left: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'cities',
                  mini: true,
                  onPressed: () {
                    setState(() {
                      _showCities = !_showCities;
                      _loadMarkers();
                    });
                  },
                  backgroundColor: _showCities ? AppTheme.goldColor : Colors.grey,
                  child: const Icon(Icons.location_city),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'stores',
                  mini: true,
                  onPressed: () {
                    setState(() {
                      _showStores = !_showStores;
                      _loadMarkers();
                    });
                  },
                  backgroundColor: _showStores ? AppTheme.goldColor : Colors.grey,
                  child: const Icon(Icons.store),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _selectedCity != null ? null : _buildCitiesList(),
    );
  }

  Widget _buildCitiesList() {
    return Container(
      height: 100,
      color: Theme.of(context).cardColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: YemenCitiesData.getMajorCities().length,
        itemBuilder: (context, index) {
          final city = YemenCitiesData.getMajorCities()[index];
          return GestureDetector(
            onTap: () {
              _mapController.move(city.coordinates, 10);
              _showCityDetails(city);
            },
            child: Container(
              width: 120,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: AppTheme.goldColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_getCityIcon(city.type), color: AppTheme.goldColor, size: 24),
                  const SizedBox(height: 4),
                  Text(city.nameAr, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  Text(city.governorate, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
