import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';

class InteractiveMapScreen extends StatefulWidget {
  const InteractiveMapScreen({super.key});

  @override
  State<InteractiveMapScreen> createState() => _InteractiveMapScreenState();
}

class _InteractiveMapScreenState extends State<InteractiveMapScreen> {
  late final MapController _mapController;
  
  // مركز اليمن - صنعاء
  static const LatLng yemenCenter = LatLng(15.3694, 44.1910);
  
  // مصادر خرائط متعددة (كلها مجانية)
  final Map<String, MapLayer> _mapLayers = {
    'CartoDB Voyager': MapLayer(
      url: 'https://a.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
      attribution: '© CartoDB, © OpenStreetMap',
      description: 'خرائط ملونة مع تضاريس وأسماء المدن',
    ),
    'CartoDB Light': MapLayer(
      url: 'https://a.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
      attribution: '© CartoDB, © OpenStreetMap',
      description: 'خرائط فاتحة مع تفاصيل الشوارع',
    ),
    'CartoDB Dark': MapLayer(
      url: 'https://a.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png',
      attribution: '© CartoDB, © OpenStreetMap',
      description: 'خرائط داكنة للمظهر الليلي',
    ),
    'Thunderforest Transport': MapLayer(
      url: 'https://tile.thunderforest.com/transport/{z}/{x}/{y}.png?apikey=6170aad10f1d40d8a05a1b6b4e5b3a2d',
      attribution: '© Thunderforest, © OpenStreetMap',
      description: 'شوارع وطرق نقل واضحة',
    ),
    'Thunderforest Landscape': MapLayer(
      url: 'https://tile.thunderforest.com/landscape/{z}/{x}/{y}.png?apikey=6170aad10f1d40d8a05a1b6b4e5b3a2d',
      attribution: '© Thunderforest, © OpenStreetMap',
      description: 'تضاريس ومناظر طبيعية',
    ),
    'Thunderforest Outdoors': MapLayer(
      url: 'https://tile.thunderforest.com/outdoors/{z}/{x}/{y}.png?apikey=6170aad10f1d40d8a05a1b6b4e5b3a2d',
      attribution: '© Thunderforest, © OpenStreetMap',
      description: 'خرائط خارجية مع مسارات',
    ),
    'Wikimedia': MapLayer(
      url: 'https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png',
      attribution: '© Wikimedia, © OpenStreetMap',
      description: 'خرائط ويكيميديا العالمية',
    ),
    'Stamen Terrain': MapLayer(
      url: 'http://tile.stamen.com/terrain/{z}/{x}/{y}.jpg',
      attribution: '© Stamen Design, © OpenStreetMap',
      description: 'تضاريس فقط - رائعة للجبال',
    ),
    'Stamen Toner': MapLayer(
      url: 'http://tile.stamen.com/toner/{z}/{x}/{y}.png',
      attribution: '© Stamen Design, © OpenStreetMap',
      description: 'أبيض وأسود - تصميم أنيق',
    ),
    'Stamen Watercolor': MapLayer(
      url: 'http://tile.stamen.com/watercolor/{z}/{x}/{y}.jpg',
      attribution: '© Stamen Design, © OpenStreetMap',
      description: 'تأثير ألوان مائية فنية',
    ),
  };
  
  String _selectedLayer = 'CartoDB Voyager';
  LatLng _currentCenter = yemenCenter;
  double _currentZoom = 7.5;
  Position? _currentPosition;
  bool _showCities = true;
  String? _selectedCity;

  // المدن اليمنية الرئيسية مع إحداثيات دقيقة
  final List<YemenCity> _yemenCities = [
    YemenCity(name: 'صنعاء', nameAr: 'صنعاء', governorate: 'أمانة العاصمة', lat: 15.3694, lng: 44.1910, population: '2,950,000', type: 'عاصمة'),
    YemenCity(name: 'عدن', nameAr: 'عدن', governorate: 'عدن', lat: 12.7855, lng: 45.0187, population: '865,000', type: 'مدينة ساحلية'),
    YemenCity(name: 'تعز', nameAr: 'تعز', governorate: 'تعز', lat: 13.5776, lng: 44.0179, population: '615,000', type: 'مدينة'),
    YemenCity(name: 'الحديدة', nameAr: 'الحديدة', governorate: 'الحديدة', lat: 14.7909, lng: 42.9712, population: '617,000', type: 'مدينة ساحلية'),
    YemenCity(name: 'إب', nameAr: 'إب', governorate: 'إب', lat: 13.9667, lng: 44.1833, population: '225,000', type: 'مدينة'),
    YemenCity(name: 'المكلا', nameAr: 'المكلا', governorate: 'حضرموت', lat: 14.5424, lng: 49.1278, population: '566,000', type: 'مدينة ساحلية'),
    YemenCity(name: 'سيئون', nameAr: 'سيئون', governorate: 'حضرموت', lat: 15.9500, lng: 48.7833, population: '120,000', type: 'مدينة تاريخية'),
    YemenCity(name: 'ذمار', nameAr: 'ذمار', governorate: 'ذمار', lat: 14.5500, lng: 44.4000, population: '160,000', type: 'مدينة'),
    YemenCity(name: 'عمران', nameAr: 'عمران', governorate: 'عمران', lat: 15.6667, lng: 43.9333, population: '90,000', type: 'مدينة'),
    YemenCity(name: 'صعدة', nameAr: 'صعدة', governorate: 'صعدة', lat: 16.9400, lng: 43.7600, population: '70,000', type: 'مدينة'),
    YemenCity(name: 'مأرب', nameAr: 'مأرب', governorate: 'مأرب', lat: 15.4667, lng: 45.3333, population: '35,000', type: 'مدينة أثرية'),
    YemenCity(name: 'البيضاء', nameAr: 'البيضاء', governorate: 'البيضاء', lat: 13.9833, lng: 45.5667, population: '40,000', type: 'مدينة'),
    YemenCity(name: 'الجوف', nameAr: 'الجوف', governorate: 'الجوف', lat: 16.7833, lng: 45.5000, population: '30,000', type: 'مدينة'),
    YemenCity(name: 'شبام', nameAr: 'شبام', governorate: 'حضرموت', lat: 15.9270, lng: 48.6267, population: '7,000', type: 'موقع تراثي'),
    YemenCity(name: 'تريم', nameAr: 'تريم', governorate: 'حضرموت', lat: 16.0667, lng: 49.0000, population: '105,000', type: 'مدينة دينية'),
    YemenCity(name: 'المخا', nameAr: 'المخا', governorate: 'تعز', lat: 13.3167, lng: 43.2500, population: '18,000', type: 'مدينة ساحلية'),
    YemenCity(name: 'زنجبار', nameAr: 'زنجبار', governorate: 'أبين', lat: 13.1333, lng: 45.3833, population: '25,000', type: 'مدينة ساحلية'),
    YemenCity(name: 'سقطرى', nameAr: 'سقطرى', governorate: 'سقطرى', lat: 12.5000, lng: 53.8333, population: '60,000', type: 'جزيرة'),
  ];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getCurrentLocation();
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
        });
      }
    } catch (e) {
      // تجاهل الخطأ
    }
  }

  void _goToCurrentLocation() {
    if (_currentPosition != null) {
      _mapController.move(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        14,
      );
    }
  }

  void _goToCity(YemenCity city) {
    _mapController.move(LatLng(city.lat, city.lng), 10);
    setState(() {
      _selectedCity = city.nameAr;
    });
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _getCityColor(city.type),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(_getCityIcon(city.type), color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(city.nameAr, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('${city.governorate} - ${city.type}', style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.people, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text('عدد السكان: ${city.population}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text('الإحداثيات: ${city.lat.toStringAsFixed(4)}, ${city.lng.toStringAsFixed(4)}'),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _navigateTo(city),
                    icon: const Icon(Icons.navigation),
                    label: const Text('توجيه'),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    label: const Text('إغلاق'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getCityColor(String type) {
    switch (type) {
      case 'عاصمة': return Colors.red;
      case 'مدينة ساحلية': return Colors.blue;
      case 'مدينة تاريخية': return Colors.orange;
      case 'موقع تراثي': return Colors.purple;
      case 'مدينة دينية': return Colors.teal;
      case 'جزيرة': return Colors.green;
      default: return AppTheme.gold;
    }
  }

  IconData _getCityIcon(String type) {
    switch (type) {
      case 'عاصمة': return Icons.star;
      case 'مدينة ساحلية': return Icons.water;
      case 'مدينة تاريخية': return Icons.account_balance;
      case 'موقع تراثي': return Icons.temple_buddhist;
      case 'مدينة دينية': return Icons.mosque;
      case 'جزيرة': return Icons.beach_access;
      default: return Icons.location_city;
    }
  }

  Future<void> _navigateTo(YemenCity city) async {
    final url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=${city.lat},${city.lng}'
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('خريطة اليمن'),
        backgroundColor: AppTheme.gold,
        foregroundColor: Colors.black,
        actions: [
          // اختيار طبقة الخريطة
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedLayer = value;
              });
            },
            itemBuilder: (context) => _mapLayers.keys.map((name) {
              return PopupMenuItem(
                value: name,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      _mapLayers[name]!.description,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }).toList(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: const Row(
                children: [
                  Icon(Icons.layers, color: Colors.black),
                  SizedBox(width: 4),
                  Text('الطبقات', style: TextStyle(color: Colors.black)),
                  Icon(Icons.arrow_drop_down, color: Colors.black),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // الخريطة
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentCenter,
              initialZoom: _currentZoom,
              onTap: (_, __) => setState(() => _selectedCity = null),
            ),
            children: [
              TileLayer(
                urlTemplate: _mapLayers[_selectedLayer]!.url,
                userAgentPackageName: 'com.flexyemen.app',
                maxZoom: 19,
                tileProvider: NetworkTileProvider(),
              ),
              
              // علامات المدن
              if (_showCities)
                MarkerLayer(
                  markers: _yemenCities.map((city) {
                    return Marker(
                      point: LatLng(city.lat, city.lng),
                      width: 60,
                      height: 60,
                      child: GestureDetector(
                        onTap: () => _goToCity(city),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: _getCityColor(city.type),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 5,
                                  ),
                                ],
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
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              
              // علامة موقع المستخدم
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
          
          // أزرار التحكم
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'zoom_in',
                  mini: true,
                  onPressed: () {
                    _mapController.move(_mapController.camera.center, _mapController.camera.zoom + 1);
                  },
                  backgroundColor: AppTheme.gold,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'zoom_out',
                  mini: true,
                  onPressed: () {
                    _mapController.move(_mapController.camera.center, _mapController.camera.zoom - 1);
                  },
                  backgroundColor: AppTheme.gold,
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ),
          
          // زر موقعي
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              heroTag: 'my_location',
              onPressed: _goToCurrentLocation,
              backgroundColor: AppTheme.gold,
              child: const Icon(Icons.my_location),
            ),
          ),
          
          // شريط المدن السريع
          Positioned(
            bottom: 90,
            left: 10,
            right: 10,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
                ],
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: _yemenCities.where((c) => c.type == 'عاصمة' || c.type == 'مدينة ساحلية').length,
                itemBuilder: (context, index) {
                  final city = _yemenCities.where((c) => c.type == 'عاصمة' || c.type == 'مدينة ساحلية').toList()[index];
                  return GestureDetector(
                    onTap: () => _goToCity(city),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      decoration: BoxDecoration(
                        color: _getCityColor(city.type).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: _getCityColor(city.type).withOpacity(0.5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(_getCityIcon(city.type), size: 16, color: _getCityColor(city.type)),
                          const SizedBox(width: 6),
                          Text(city.nameAr, style: TextStyle(color: _getCityColor(city.type), fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MapLayer {
  final String url;
  final String attribution;
  final String description;

  MapLayer({
    required this.url,
    required this.attribution,
    required this.description,
  });
}

class YemenCity {
  final String name;
  final String nameAr;
  final String governorate;
  final double lat;
  final double lng;
  final String population;
  final String type;

  YemenCity({
    required this.name,
    required this.nameAr,
    required this.governorate,
    required this.lat,
    required this.lng,
    required this.population,
    required this.type,
  });
}
