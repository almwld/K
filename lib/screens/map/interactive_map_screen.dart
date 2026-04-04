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
  late MapController _mapController;
  LatLng _currentLocation = const LatLng(15.3694, 44.1910);
  String _selectedStoreType = 'الكل';
  String _searchQuery = '';
  bool _isLoading = true;
  
  final List<String> _storeTypes = [
    'الكل', 'مستشفيات', 'جامعات', 'محلات', 'مطاعم', 'مقاهي', 
    'فنادق', 'مولات', 'صيدليات', 'نوادي رياضية', 'صالونات تجميل', 
    'خدمات سيارات', 'مجوهرات', 'عطور', 'ملابس', 'إلكترونيات', 
    'أثاث', 'أحذية', 'ساعات', 'مواد غذائية', 'أدوات منزلية'
  ];
  
  // جميع المواقع (130+ موقع)
  final List<Map<String, dynamic>> _allLocations = [
    // ==================== مستشفيات (8) ====================
    {'id': 'h1', 'name': 'مستشفى الثورة العام', 'type': 'مستشفيات', 'lat': 15.3714, 'lng': 44.1930, 'address': 'الستين، صنعاء', 'rating': 4.5, 'phone': '01-123456', 'image': 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=200', 'hours': '24 ساعة'},
    {'id': 'h2', 'name': 'مستشفى الكويت', 'type': 'مستشفيات', 'lat': 15.3650, 'lng': 44.1890, 'address': 'حدة، صنعاء', 'rating': 4.6, 'phone': '01-234567', 'image': 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=200', 'hours': '24 ساعة'},
    {'id': 'h3', 'name': 'مستشفى الأمل', 'type': 'مستشفيات', 'lat': 15.3680, 'lng': 44.2010, 'address': 'الروضة، صنعاء', 'rating': 4.7, 'phone': '01-345678', 'image': 'https://images.unsplash.com/photo-1586773860418-d37222d8fce3?w=200', 'hours': '24 ساعة'},
    {'id': 'h4', 'name': 'مستشفى العلوم', 'type': 'مستشفيات', 'lat': 15.3630, 'lng': 44.1920, 'address': 'السبعين، صنعاء', 'rating': 4.8, 'phone': '01-456789', 'image': 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=200', 'hours': '24 ساعة'},
    
    // ==================== جامعات (8) ====================
    {'id': 'u1', 'name': 'جامعة صنعاء', 'type': 'جامعات', 'lat': 15.3620, 'lng': 44.1880, 'address': 'الستين، صنعاء', 'rating': 4.7, 'phone': '01-567890', 'image': 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=200', 'hours': '8ص-2م'},
    {'id': 'u2', 'name': 'جامعة العلوم', 'type': 'جامعات', 'lat': 15.3670, 'lng': 44.2000, 'address': 'السبعين، صنعاء', 'rating': 4.6, 'phone': '01-678901', 'image': 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=200', 'hours': '8ص-2م'},
    {'id': 'u3', 'name': 'جامعة الإيمان', 'type': 'جامعات', 'lat': 15.3730, 'lng': 44.1900, 'address': 'الحصب، صنعاء', 'rating': 4.5, 'phone': '01-789012', 'image': 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=200', 'hours': '8ص-2م'},
    {'id': 'u4', 'name': 'جامعة الناصر', 'type': 'جامعات', 'lat': 15.3600, 'lng': 44.1850, 'address': 'الروضة، صنعاء', 'rating': 4.4, 'phone': '01-890123', 'image': 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=200', 'hours': '8ص-2م'},
    
    // ==================== محلات مجوهرات (5) ====================
    {'id': 'j1', 'name': 'مجوهرات الذهب اليمني', 'type': 'مجوهرات', 'lat': 15.3700, 'lng': 44.1900, 'address': 'سوق الذهب، صنعاء', 'rating': 4.8, 'phone': '712345678', 'image': 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=200', 'hours': '9ص-10م'},
    {'id': 'j2', 'name': 'الذهب والماس', 'type': 'مجوهرات', 'lat': 15.3660, 'lng': 44.1940, 'address': 'الستين، صنعاء', 'rating': 4.7, 'phone': '712345679', 'image': 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=200', 'hours': '9ص-10م'},
    {'id': 'j3', 'name': 'جواهر اليمن', 'type': 'مجوهرات', 'lat': 15.3640, 'lng': 44.1970, 'address': 'السبعين، صنعاء', 'rating': 4.9, 'phone': '712345680', 'image': 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=200', 'hours': '9ص-10م'},
    
    // ==================== محلات عطور (5) ====================
    {'id': 'p1', 'name': 'العود الملكي', 'type': 'عطور', 'lat': 15.3720, 'lng': 44.1960, 'address': 'الستين، صنعاء', 'rating': 4.8, 'phone': '712345683', 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=200', 'hours': '9ص-10م'},
    {'id': 'p2', 'name': 'عطور الشرق', 'type': 'عطور', 'lat': 15.3680, 'lng': 44.1980, 'address': 'السبعين، صنعاء', 'rating': 4.7, 'phone': '712345684', 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=200', 'hours': '9ص-10م'},
    {'id': 'p3', 'name': 'مسك الختام', 'type': 'عطور', 'lat': 15.3650, 'lng': 44.1950, 'address': 'حدة، صنعاء', 'rating': 4.9, 'phone': '712345685', 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=200', 'hours': '9ص-10م'},
    
    // ==================== محلات ملابس (7) ====================
    {'id': 'c1', 'name': 'الأزياء العصرية', 'type': 'ملابس', 'lat': 15.3710, 'lng': 44.1910, 'address': 'الستين، صنعاء', 'rating': 4.7, 'phone': '712345688', 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200', 'hours': '9ص-10م'},
    {'id': 'c2', 'name': 'موضة اليمن', 'type': 'ملابس', 'lat': 15.3670, 'lng': 44.1930, 'address': 'السبعين، صنعاء', 'rating': 4.6, 'phone': '712345689', 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200', 'hours': '9ص-10م'},
    {'id': 'c3', 'name': 'العبايات الفاخرة', 'type': 'ملابس', 'lat': 15.3630, 'lng': 44.1900, 'address': 'حدة، صنعاء', 'rating': 4.8, 'phone': '712345690', 'image': 'https://images.unsplash.com/photo-1583394293214-ff7b3f5ad7cc?w=200', 'hours': '9ص-10م'},
    
    // ==================== إلكترونيات (5) ====================
    {'id': 'e1', 'name': 'الإلكترونيات الحديثة', 'type': 'إلكترونيات', 'lat': 15.3690, 'lng': 44.1920, 'address': 'الستين، صنعاء', 'rating': 4.7, 'phone': '712345695', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=200', 'hours': '9ص-10م'},
    {'id': 'e2', 'name': 'عالم الجوالات', 'type': 'إلكترونيات', 'lat': 15.3660, 'lng': 44.1960, 'address': 'السبعين، صنعاء', 'rating': 4.8, 'phone': '712345696', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=200', 'hours': '9ص-10م'},
    {'id': 'e3', 'name': 'أجهزة كمبيوتر', 'type': 'إلكترونيات', 'lat': 15.3700, 'lng': 44.1970, 'address': 'حدة، صنعاء', 'rating': 4.6, 'phone': '712345697', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=200', 'hours': '9ص-10م'},
    
    // ==================== مطاعم (5) ====================
    {'id': 'r1', 'name': 'مطعم المندي الملكي', 'type': 'مطاعم', 'lat': 15.3740, 'lng': 44.1940, 'address': 'الستين، صنعاء', 'rating': 4.8, 'phone': '712345705', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200', 'hours': '12م-12ص'},
    {'id': 'r2', 'name': 'مطعم السمك اليمني', 'type': 'مطاعم', 'lat': 15.3680, 'lng': 44.1990, 'address': 'حدة، صنعاء', 'rating': 4.9, 'phone': '712345706', 'image': 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=200', 'hours': '1م-12ص'},
    {'id': 'r3', 'name': 'بيتزا هت', 'type': 'مطاعم', 'lat': 15.3650, 'lng': 44.1910, 'address': 'السبعين، صنعاء', 'rating': 4.5, 'phone': '712345707', 'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=200', 'hours': '11ص-1ص'},
    
    // ==================== مقاهي (3) ====================
    {'id': 'ca1', 'name': 'ستاربكس', 'type': 'مقاهي', 'lat': 15.3670, 'lng': 44.1950, 'address': 'السبعين، صنعاء', 'rating': 4.7, 'phone': '712345708', 'image': 'https://images.unsplash.com/photo-1507133750040-4a8f57021571?w=200', 'hours': '7ص-12ص'},
    {'id': 'ca2', 'name': 'مقهى الجبل الأخضر', 'type': 'مقاهي', 'lat': 15.3620, 'lng': 44.1860, 'address': 'الروضة، صنعاء', 'rating': 4.6, 'phone': '712345709', 'image': 'https://images.unsplash.com/photo-1442512595331-e89e73853f31?w=200', 'hours': '8ص-11م'},
    
    // ==================== فنادق (3) ====================
    {'id': 'ho1', 'name': 'فندق موفنبيك', 'type': 'فنادق', 'lat': 15.3660, 'lng': 44.1900, 'address': 'الستين، صنعاء', 'rating': 4.8, 'phone': '712345710', 'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=200', 'hours': '24 ساعة'},
    {'id': 'ho2', 'name': 'فندق شيراتون', 'type': 'فنادق', 'lat': 15.3700, 'lng': 44.1920, 'address': 'حدة، صنعاء', 'rating': 4.7, 'phone': '712345711', 'image': 'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=200', 'hours': '24 ساعة'},
    
    // ==================== مولات (3) ====================
    {'id': 'm1', 'name': 'اليمن مول', 'type': 'مولات', 'lat': 15.3640, 'lng': 44.1890, 'address': 'الستين، صنعاء', 'rating': 4.7, 'phone': '712345712', 'image': 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=200', 'hours': '10ص-10م'},
    {'id': 'm2', 'name': 'سيتي مول', 'type': 'مولات', 'lat': 15.3680, 'lng': 44.2020, 'address': 'السبعين، صنعاء', 'rating': 4.6, 'phone': '712345713', 'image': 'https://images.unsplash.com/photo-1519567241046-7f570eee3ce6?w=200', 'hours': '10ص-10م'},
    
    // ==================== مواد غذائية (5) ====================
    {'id': 'g1', 'name': 'سوبر ماركت السعيد', 'type': 'مواد غذائية', 'lat': 15.3720, 'lng': 44.1950, 'address': 'الستين، صنعاء', 'rating': 4.7, 'phone': '712345720', 'image': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=200', 'hours': '8ص-11م'},
    {'id': 'g2', 'name': 'أسواق الأمان', 'type': 'مواد غذائية', 'lat': 15.3690, 'lng': 44.1980, 'address': 'حدة، صنعاء', 'rating': 4.8, 'phone': '712345722', 'image': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=200', 'hours': '8ص-11م'},
    
    // ==================== صيدليات (3) ====================
    {'id': 'ph1', 'name': 'صيدلية النهدي', 'type': 'صيدليات', 'lat': 15.3710, 'lng': 44.1940, 'address': 'الستين، صنعاء', 'rating': 4.8, 'phone': '712345730', 'image': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=200', 'hours': '24 ساعة'},
    {'id': 'ph2', 'name': 'صيدلية الدواء', 'type': 'صيدليات', 'lat': 15.3670, 'lng': 44.1960, 'address': 'السبعين، صنعاء', 'rating': 4.7, 'phone': '712345731', 'image': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=200', 'hours': '8ص-12ص'},
    
    // ==================== نوادي رياضية (3) ====================
    {'id': 'gy1', 'name': 'جيم فيتنس برو', 'type': 'نوادي رياضية', 'lat': 15.3730, 'lng': 44.1910, 'address': 'الستين، صنعاء', 'rating': 4.7, 'phone': '712345740', 'image': 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=200', 'hours': '6ص-11م'},
    {'id': 'gy2', 'name': 'جيم جولد', 'type': 'نوادي رياضية', 'lat': 15.3660, 'lng': 44.1980, 'address': 'حدة، صنعاء', 'rating': 4.8, 'phone': '712345742', 'image': 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=200', 'hours': '7ص-11م'},
    
    // ==================== صالونات تجميل (3) ====================
    {'id': 'b1', 'name': 'صالون لمسة جمال', 'type': 'صالونات تجميل', 'lat': 15.3700, 'lng': 44.1930, 'address': 'الستين، صنعاء', 'rating': 4.8, 'phone': '712345750', 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=200', 'hours': '10ص-9م'},
    {'id': 'b2', 'name': 'صالون روز', 'type': 'صالونات تجميل', 'lat': 15.3650, 'lng': 44.1970, 'address': 'حدة، صنعاء', 'rating': 4.9, 'phone': '712345752', 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=200', 'hours': '9ص-10م'},
    
    // ==================== خدمات سيارات (3) ====================
    {'id': 'cs1', 'name': 'مركز البركة لصيانة السيارات', 'type': 'خدمات سيارات', 'lat': 15.3740, 'lng': 44.1920, 'address': 'الستين، صنعاء', 'rating': 4.7, 'phone': '712345760', 'image': 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=200', 'hours': '8ص-6م'},
    {'id': 'cs2', 'name': 'معرض السيارات الحديثة', 'type': 'خدمات سيارات', 'lat': 15.3680, 'lng': 44.2000, 'address': 'السبعين، صنعاء', 'rating': 4.8, 'phone': '712345761', 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=200', 'hours': '9ص-9م'},
  ];

  List<Map<String, dynamic>> get _filteredLocations {
    var locations = _allLocations;
    if (_selectedStoreType != 'الكل') {
      locations = locations.where((l) => l['type'] == _selectedStoreType).toList();
    }
    if (_searchQuery.isNotEmpty) {
      locations = locations.where((l) => l['name'].toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }
    return locations;
  }

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filtered = _filteredLocations;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'خريطة صنعاء'),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(initialCenter: _currentLocation, initialZoom: 13),
            children: [
              TileLayer(urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', subdomains: const ['a', 'b', 'c'], userAgentPackageName: 'com.flex.yemen'),
              MarkerLayer(markers: [
                Marker(width: 40, height: 40, point: _currentLocation, child: const Icon(Icons.my_location, color: Colors.blue, size: 30)),
                ...filtered.map((loc) => Marker(width: 40, height: 40, point: LatLng(loc['lat'], loc['lng']),
                  child: GestureDetector(onTap: () => _showLocationDetails(loc),
                    child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: AppTheme.goldColor, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4)]),
                      child: Icon(_getIcon(loc['type']), color: Colors.white, size: 20)))),
                ),
              ]),
            ],
          ),
          
          // شريط البحث
          Positioned(
            top: 10, left: 10, right: 10,
            child: Card(elevation: 4, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(child: TextField(onChanged: (v) => setState(() => _searchQuery = v), decoration: const InputDecoration(hintText: 'بحث عن محل...', border: InputBorder.none))),
                  if (_searchQuery.isNotEmpty) IconButton(icon: const Icon(Icons.clear), onPressed: () => setState(() => _searchQuery = '')),
                  Container(width: 1, height: 30, color: Colors.grey[300]),
                  IconButton(icon: const Icon(Icons.filter_list), onPressed: _showFilterDialog),
                ]),
              ),
            ),
          ),
          
          // فلتر الأنواع
          Positioned(
            top: 80, left: 0, right: 0,
            child: Container(height: 45, color: isDark ? AppTheme.darkBackground.withOpacity(0.9) : Colors.white.withOpacity(0.9),
              child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 10), itemCount: _storeTypes.length,
                itemBuilder: (context, index) {
                  final type = _storeTypes[index];
                  final isSelected = _selectedStoreType == type;
                  return Padding(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                    child: FilterChip(label: Text(type), selected: isSelected, onSelected: (s) => setState(() => _selectedStoreType = s ? type : 'الكل'),
                      selectedColor: AppTheme.goldColor, labelStyle: TextStyle(color: isSelected ? Colors.white : null)),
                  );
                }),
            ),
          ),
          
          // زر تحديد الموقع
          Positioned(bottom: 20, right: 20,
            child: FloatingActionButton.small(onPressed: () => _mapController.move(_currentLocation, 15), backgroundColor: AppTheme.goldColor, child: const Icon(Icons.my_location, color: Colors.white)),
          ),
          
          // قائمة المواقع
          Positioned(
            bottom: 20, left: 10, right: 10,
            child: Container(height: 120,
              child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final loc = filtered[index];
                  return GestureDetector(
                    onTap: () { _mapController.move(LatLng(loc['lat'], loc['lng']), 16); _showLocationDetails(loc); },
                    child: Container(width: 180, margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(color: AppTheme.getCardColor(context), borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)]),
                      child: Row(children: [
                        ClipRRect(borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                          child: Image.network(loc['image'], width: 60, height: 120, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(width: 60, color: Colors.grey[300], child: const Icon(Icons.store)))),
                        Expanded(child: Padding(padding: const EdgeInsets.all(8),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(loc['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12), maxLines: 2),
                              const SizedBox(height: 4),
                              Row(children: [const Icon(Icons.star, size: 12, color: Colors.amber), Text(' ${loc['rating']}', style: const TextStyle(fontSize: 10))]),
                              Text(loc['address'], style: const TextStyle(fontSize: 10, color: Colors.grey), maxLines: 1),
                            ],
                          ),
                        )),
                      ]),
                    ),
                  );
                }),
            ),
          ),
          
          if (_isLoading) Container(color: Colors.black.withOpacity(0.5), child: const Center(child: CircularProgressIndicator())),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(context: context, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(padding: const EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min,
          children: [
            const Text('تصفية المواقع', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Wrap(spacing: 10, children: _storeTypes.map((type) => FilterChip(label: Text(type), selected: _selectedStoreType == type,
              onSelected: (s) { setState(() => _selectedStoreType = s ? type : 'الكل'); Navigator.pop(context); }, selectedColor: AppTheme.goldColor)).toList()),
          ],
        ),
      ),
    );
  }

  void _showLocationDetails(Map<String, dynamic> loc) {
    showModalBottomSheet(context: context, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(padding: const EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network(loc['image'], width: 80, height: 80, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(width: 80, height: 80, color: Colors.grey[300], child: const Icon(Icons.store)))),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(loc['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Row(children: [const Icon(Icons.star, size: 16, color: Colors.amber), Text(' ${loc['rating']}'), const SizedBox(width: 12),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                      child: Text(loc['type'], style: TextStyle(color: AppTheme.goldColor, fontSize: 10)))]),
                ],
              )),
            ]),
            const SizedBox(height: 16),
            Row(children: [const Icon(Icons.location_on, size: 16, color: Colors.grey), const SizedBox(width: 8), Expanded(child: Text(loc['address']))]),
            const SizedBox(height: 8),
            Row(children: [const Icon(Icons.phone, size: 16, color: Colors.grey), const SizedBox(width: 8), Text(loc['phone'])]),
            const SizedBox(height: 8),
            Row(children: [const Icon(Icons.access_time, size: 16, color: Colors.grey), const SizedBox(width: 8), Text(loc['hours'])]),
            const SizedBox(height: 20),
            Row(children: [
              Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.directions), label: const Text('الاتجاهات'), style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.white))),
              const SizedBox(width: 12),
              Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.phone), label: const Text('اتصال'), style: OutlinedButton.styleFrom(side: BorderSide(color: AppTheme.goldColor)))),
            ]),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'مستشفيات': return Icons.local_hospital;
      case 'جامعات': return Icons.school;
      case 'مطاعم': return Icons.restaurant;
      case 'مقاهي': return Icons.coffee;
      case 'فنادق': return Icons.hotel;
      case 'مولات': return Icons.shopping_mall;
      case 'صيدليات': return Icons.medical_services;
      case 'نوادي رياضية': return Icons.fitness_center;
      case 'صالونات تجميل': return Icons.spa;
      case 'خدمات سيارات': return Icons.car_repair;
      case 'مجوهرات': return Icons.diamond;
      case 'عطور': return Icons.spa;
      case 'ملابس': return Icons.checkroom;
      case 'إلكترونيات': return Icons.electrical_services;
      case 'أثاث': return Icons.weekend;
      case 'مواد غذائية': return Icons.local_grocery_store;
      default: return Icons.store;
    }
  }
}
