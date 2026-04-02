import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class InteractiveMapScreen extends StatefulWidget {
  const InteractiveMapScreen({super.key});

  @override
  State<InteractiveMapScreen> createState() => _InteractiveMapScreenState();
}

class _InteractiveMapScreenState extends State<InteractiveMapScreen> {
  final MapController _mapController = MapController();
  LatLng? _currentLocation;
  List<Marker> _markers = [];
  bool _isLoading = true;
  String? _errorMessage;

  // مواقع حقيقية في اليمن
  final List<Map<String, dynamic>> _locations = [
    {
      'name': 'سوق الملح - صنعاء القديمة',
      'lat': 15.3517,
      'lng': 44.2075,
      'address': 'صنعاء القديمة، اليمن',
      'type': 'معلم سياحي',
      'description': 'أحد أقدم الأسواق التاريخية في صنعاء',
      'phone': '+967712345678',
    },
    {
      'name': 'جامع الصالح',
      'lat': 15.3322,
      'lng': 44.2105,
      'address': 'شارع الجامع الكبير، صنعاء',
      'type': 'مسجد',
      'description': 'أكبر مسجد في اليمن',
      'phone': '+967712345679',
    },
    {
      'name': 'باب اليمن',
      'lat': 15.3539,
      'lng': 44.2089,
      'address': 'صنعاء القديمة',
      'type': 'معلم تاريخي',
      'description': 'بوابة تاريخية لدخول صنعاء القديمة',
      'phone': null,
    },
    {
      'name': 'كريتر مول',
      'lat': 12.7855,
      'lng': 45.0187,
      'address': 'كريتر، عدن',
      'type': 'مركز تجاري',
      'description': 'أكبر مركز تجاري في عدن',
      'phone': '+967723456789',
    },
    {
      'name': 'شاطئ الذهب',
      'lat': 12.7700,
      'lng': 45.0300,
      'address': 'خور مكسر، عدن',
      'type': 'شاطئ',
      'description': 'أجمل شواطئ عدن',
      'phone': null,
    },
    {
      'name': 'سوق الجند',
      'lat': 13.5800,
      'lng': 44.0200,
      'address': 'الجند، تعز',
      'type': 'سوق',
      'description': 'سوق شعبي تاريخي في تعز',
      'phone': null,
    },
    {
      'name': 'شاطئ المكلا',
      'lat': 14.5424,
      'lng': 49.1278,
      'address': 'الكورنيش، المكلا',
      'type': 'شاطئ',
      'description': 'منتجع سياحي جميل',
      'phone': null,
    },
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);
    _errorMessage = null;

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _errorMessage = 'يرجى السماح للتطبيق بالوصول إلى موقعك';
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _errorMessage = 'تم رفض الوصول إلى الموقع نهائياً';
          _isLoading = false;
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );
      
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _addMarkers();
        _mapController.move(_currentLocation!, 13);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'تعذر الحصول على الموقع';
        _isLoading = false;
      });
    }
  }

  void _addMarkers() {
    _markers = [];
    
    // إضافة علامة الموقع الحالي
    if (_currentLocation != null) {
      _markers.add(
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
      );
    }

    // إضافة علامات المواقع
    for (var location in _locations) {
      _markers.add(
        Marker(
          point: LatLng(location['lat'], location['lng']),
          width: 50,
          height: 50,
          child: GestureDetector(
            onTap: () => _showLocationDetails(location),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.goldColor,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 5)],
              ),
              child: Icon(_getTypeIcon(location['type']), color: Colors.white, size: 20),
            ),
          ),
        ),
      );
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'مسجد':
        return Icons.mosque;
      case 'معلم سياحي':
      case 'معلم تاريخي':
        return Icons.landmark;
      case 'مركز تجاري':
      case 'سوق':
        return Icons.store;
      case 'شاطئ':
        return Icons.beach_access;
      default:
        return Icons.location_on;
    }
  }

  void _showLocationDetails(Map<String, dynamic> location) {
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
                  child: Icon(_getTypeIcon(location['type']), color: AppTheme.goldColor, size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(location['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(location['address'], style: const TextStyle(color: Colors.grey)),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.goldColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(location['type'], style: const TextStyle(fontSize: 10, color: AppTheme.goldColor)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (location['description'] != null) ...[
              const SizedBox(height: 12),
              Text(location['description'], style: const TextStyle(height: 1.5)),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _openDirections(location['lat'], location['lng']);
                    },
                    icon: const Icon(Icons.directions),
                    label: const Text('الاتجاهات'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.goldColor,
                      foregroundColor: Colors.black,
                    ),
                  ),
                ),
                if (location['phone'] != null) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _makePhoneCall(location['phone']),
                      icon: const Icon(Icons.phone),
                      label: const Text('اتصال'),
                      style: OutlinedButton.styleFrom(side: const BorderSide(color: AppTheme.goldColor)),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _openDirections(double lat, double lng) async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving';
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

  void _showPermissionDialog() {
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
          if (_errorMessage != null)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_off, size: 80, color: AppTheme.goldColor.withOpacity(0.5)),
                  const SizedBox(height: 16),
                  Text(_errorMessage!, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _getCurrentLocation,
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            )
          else if (_currentLocation != null)
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentLocation!,
                initialZoom: 13,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.flexyemen.app',
                ),
                MarkerLayer(markers: _markers),
              ],
            ),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: _getCurrentLocation,
              backgroundColor: AppTheme.goldColor,
              child: const Icon(Icons.my_location, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
