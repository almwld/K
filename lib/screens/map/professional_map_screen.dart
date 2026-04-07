import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import '../../models/store_model.dart';

class ProfessionalMapScreen extends StatefulWidget {
  const ProfessionalMapScreen({super.key});

  @override
  State<ProfessionalMapScreen> createState() => _ProfessionalMapScreenState();
}

class _ProfessionalMapScreenState extends State<ProfessionalMapScreen> with SingleTickerProviderStateMixin {
  final MapController _mapController = MapController();
  LatLng? _currentLocation;
  List<Marker> _storeMarkers = [];
  List<StoreModel> _nearbyStores = [];
  bool _isLoading = true;
  String _selectedFilter = 'all';
  StoreModel? _selectedStore;
  
  late AnimationController _animationController;

  final List<Map<String, dynamic>> _filters = [
    {'value': 'all', 'label': 'الكل', 'icon': Icons.store, 'color': 0xFF9C27B0},
    {'value': 'electronics', 'label': 'إلكترونيات', 'icon': Icons.devices, 'color': 0xFFFF9800},
    {'value': 'restaurants', 'label': 'مطاعم', 'icon': Icons.restaurant, 'color': 0xFFE74C3C},
    {'value': 'fashion', 'label': 'أزياء', 'icon': Icons.checkroom, 'color': 0xFFE91E63},
    {'value': 'furniture', 'label': 'أثاث', 'icon': Icons.chair, 'color': 0xFF795548},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
        );
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
          _mapController.move(_currentLocation!, 15);
        });
        _loadNearbyStores();
      } else {
        setState(() => _isLoading = false);
        _showLocationPermissionDialog();
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
          address: 'شارع حدة، صنعاء', rating: 4.5, category: 'electronics', isOpen: true, distance: 250,
          phone: '777123456', description: 'أفضل متجر إلكترونيات في صنعاء',
        ),
        StoreModel(
          id: '2', name: 'مطعم الأصيل', lat: _currentLocation!.latitude - 0.001, lng: _currentLocation!.longitude - 0.002,
          address: 'شارع التحرير، صنعاء', rating: 4.8, category: 'restaurants', isOpen: true, distance: 180,
          phone: '777234567', description: 'أشهى المأكولات اليمنية والعالمية',
        ),
        StoreModel(
          id: '3', name: 'أزياء فلكس', lat: _currentLocation!.latitude + 0.001, lng: _currentLocation!.longitude - 0.001,
          address: 'شارع الزراعة، صنعاء', rating: 4.3, category: 'fashion', isOpen: false, distance: 320,
          phone: '777345678', description: 'تشكيلة رائعة من الملابس العصرية',
        ),
        StoreModel(
          id: '4', name: 'متجر الأثاث', lat: _currentLocation!.latitude - 0.002, lng: _currentLocation!.longitude + 0.001,
          address: 'شارع الستين، صنعاء', rating: 4.6, category: 'furniture', isOpen: true, distance: 450,
          phone: '777456789', description: 'أثاث منزلي فاخر بأسعار منافسة',
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
        width: 60,
        height: 60,
        child: GestureDetector(
          onTap: () => _showStoreDetails(store),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _selectedStore?.id == store.id ? AppTheme.goldColor : (store.isOpen ? Colors.green : Colors.grey),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: (_selectedStore?.id == store.id ? AppTheme.goldColor : (store.isOpen ? Colors.green : Colors.grey)).withOpacity(0.5),
                      blurRadius: _selectedStore?.id == store.id ? 15 : 5,
                      spreadRadius: _selectedStore?.id == store.id ? 5 : 2,
                    ),
                  ],
                ),
                child: Icon(
                  _getCategoryIcon(store.category),
                  color: Colors.white,
                  size: _selectedStore?.id == store.id ? 28 : 20,
                ),
              );
            },
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

  Future<void> _showStoreDetails(StoreModel store) async {
    setState(() {
      _selectedStore = store;
    });
    _animationController.forward();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.getDividerColor(context),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 60, height: 60,
                  decoration: BoxDecoration(
                    color: _getCategoryColor(store.category).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(_getCategoryIcon(store.category), color: _getCategoryColor(store.category), size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(store.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(store.address, style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text('${store.rating}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(width: 12),
                          Container(
                            width: 8, height: 8,
                            decoration: BoxDecoration(
                              color: store.isOpen ? Colors.green : Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(store.isOpen ? 'مفتوح الآن' : 'مغلق', style: const TextStyle(fontSize: 12)),
                          const SizedBox(width: 12),
                          Text('${store.distance.toInt()} م', style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (store.description != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(store.description!, style: const TextStyle(height: 1.5)),
              ),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _openDirections(store),
                    icon: const Icon(Icons.directions),
                    label: const Text('الاتجاهات'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.goldColor,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _makePhoneCall(store.phone ?? ''),
                    icon: const Icon(Icons.phone),
                    label: const Text('اتصال'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.goldColor),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'electronics': return const Color(0xFFFF9800);
      case 'restaurants': return const Color(0xFFE74C3C);
      case 'fashion': return const Color(0xFFE91E63);
      case 'furniture': return const Color(0xFF795548);
      default: return AppTheme.goldColor;
    }
  }

  Future<void> _openDirections(StoreModel store) async {
    final url = 'https://www.google.com/maps/dir/?api=1&origin=${_currentLocation!.latitude},${_currentLocation!.longitude}&destination=${store.lat},${store.lng}&travelmode=driving';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  void _showLocationPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('الموقع'),
        content: const Text('يرجى السماح للتطبيق بالوصول إلى موقعك لعرض المتاجر القريبة'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _getCurrentLocation();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
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
                            boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.5), blurRadius: 10)],
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
