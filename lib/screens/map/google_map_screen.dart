import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentLocation;
  bool _isLoading = true;
  String? _errorMessage;

  // مواقع حقيقية في اليمن مع إحداثيات دقيقة
  final Set<Marker> _markers = {};

  final List<Map<String, dynamic>> _locations = [
    {
      'id': 'sanaa',
      'name': 'صنعاء',
      'lat': 15.3694,
      'lng': 44.1910,
      'address': 'صنعاء، اليمن',
      'description': 'العاصمة اليمنية',
    },
    {
      'id': 'aden',
      'name': 'عدن',
      'lat': 12.7855,
      'lng': 45.0187,
      'address': 'عدن، اليمن',
      'description': 'المدينة الساحلية الجميلة',
    },
    {
      'id': 'taiz',
      'name': 'تعز',
      'lat': 13.5776,
      'lng': 44.0179,
      'address': 'تعز، اليمن',
      'description': 'مدينة الثقافة والتاريخ',
    },
    {
      'id': 'hodeidah',
      'name': 'الحديدة',
      'lat': 14.7909,
      'lng': 42.9712,
      'address': 'الحديدة، اليمن',
      'description': 'ميناء البحر الأحمر',
    },
    {
      'id': 'mukalla',
      'name': 'المكلا',
      'lat': 14.5424,
      'lng': 49.1278,
      'address': 'المكلا، اليمن',
      'description': 'لؤلؤة البحر العربي',
    },
    {
      'id': 'ibb',
      'name': 'إب',
      'lat': 13.9677,
      'lng': 44.1535,
      'address': 'إب، اليمن',
      'description': 'الخضراء الجميلة',
    },
    {
      'id': 'dhamar',
      'name': 'ذمار',
      'lat': 14.5550,
      'lng': 44.3930,
      'address': 'ذمار، اليمن',
      'description': 'مدينة الآثار',
    },
    {
      'id': 'saadah',
      'name': 'صعدة',
      'lat': 16.9406,
      'lng': 43.7590,
      'address': 'صعدة، اليمن',
      'description': 'شمال اليمن',
    },
  ];

  @override
  void initState() {
    super.initState();
    _addMarkers();
    _getCurrentLocation();
  }

  void _addMarkers() {
    for (var location in _locations) {
      _markers.add(
        Marker(
          markerId: MarkerId(location['id']),
          position: LatLng(location['lat'], location['lng']),
          infoWindow: InfoWindow(
            title: location['name'],
            snippet: location['description'],
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGold),
        ),
      );
    }
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
        _isLoading = false;
      });

      // إضافة علامة الموقع الحالي
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: _currentLocation!,
          infoWindow: const InfoWindow(title: 'موقعك الحالي'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );

      // تحريك الخريطة إلى الموقع الحالي
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _currentLocation!, zoom: 12),
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'تعذر الحصول على الموقع';
        _isLoading = false;
      });
    }
  }

  void _goToLocation(double lat, double lng) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'خرائط جوجل'),
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
          else
            GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(15.3694, 44.1910),
                zoom: 6,
              ),
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              compassEnabled: true,
              mapToolbarEnabled: true,
            ),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
          
          // قائمة المدن
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)],
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _locations.length,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (context, index) {
                  final location = _locations[index];
                  return GestureDetector(
                    onTap: () => _goToLocation(location['lat'], location['lng']),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.goldColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        location['name'],
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
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
        ],
      ),
    );
  }
}
