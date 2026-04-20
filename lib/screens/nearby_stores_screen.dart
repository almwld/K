import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../theme/app_theme.dart';
import '../services/location_service.dart';

class NearbyStoresScreen extends StatefulWidget {
  const NearbyStoresScreen({super.key});

  @override
  State<NearbyStoresScreen> createState() => _NearbyStoresScreenState();
}

class _NearbyStoresScreenState extends State<NearbyStoresScreen> {
  Position? _currentPosition;
  bool _isLoading = true;
  String? _error;
  
  final List<Map<String, dynamic>> _nearbyStores = [
    {
      'name': 'سوبر ماركت السعادة',
      'type': 'سوبر ماركت',
      'distance': 0.3,
      'address': 'شارع الستين، صنعاء',
      'rating': 4.5,
      'image': '🏪',
      'isOpen': true,
      'phone': '01-234567',
    },
    {
      'name': 'مطعم البيت اليمني',
      'type': 'مطعم',
      'distance': 0.8,
      'address': 'شارع الزبيري، صنعاء',
      'rating': 4.8,
      'image': '🍽️',
      'isOpen': true,
      'phone': '01-345678',
    },
    {
      'name': 'صيدلية الحياة',
      'type': 'صيدلية',
      'distance': 1.2,
      'address': 'شارع العدين، صنعاء',
      'rating': 4.3,
      'image': '💊',
      'isOpen': true,
      'phone': '01-456789',
    },
    {
      'name': 'مخبز الريف',
      'type': 'مخبز',
      'distance': 1.5,
      'address': 'شارع القاهرة، صنعاء',
      'rating': 4.6,
      'image': '🥖',
      'isOpen': false,
      'phone': '01-567890',
    },
    {
      'name': 'ملابس الأناقة',
      'type': 'أزياء',
      'distance': 2.0,
      'address': 'شارع حدة، صنعاء',
      'rating': 4.2,
      'image': '👕',
      'isOpen': true,
      'phone': '01-678901',
    },
    {
      'name': 'إلكترونيات المستقبل',
      'type': 'إلكترونيات',
      'distance': 2.3,
      'address': 'شارع خولان، صنعاء',
      'rating': 4.4,
      'image': '📱',
      'isOpen': true,
      'phone': '01-789012',
    },
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final position = await LocationService.getCurrentLocation();
      setState(() {
        _currentPosition = position;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('متاجر قريبة منك'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined),
            onPressed: () {
              Navigator.pushNamed(context, '/map');
            },
            tooltip: 'عرض الخريطة',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: AppTheme.gold),
                  SizedBox(height: 16),
                  Text('جاري تحديد موقعك...', style: TextStyle(fontFamily: 'Changa')),
                ],
              ),
            )
          : _error != null
              ? _buildErrorView(isDark)
              : _buildStoreList(isDark),
    );
  }

  Widget _buildErrorView(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.nightCard : AppTheme.lightCard,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.location_off, size: 60, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              'تعذر تحديد موقعك',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.getPrimaryTextColor(context),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _error ?? 'حدث خطأ غير معروف',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Changa',
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.refresh),
              label: const Text('إعادة المحاولة', style: TextStyle(fontFamily: 'Changa')),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.gold,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreList(bool isDark) {
    return Column(
      children: [
        // معلومات الموقع
        if (_currentPosition != null)
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: AppTheme.goldGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.black, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'موقعك الحالي',
                        style: TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'خط العرض: ${_currentPosition!.latitude.toStringAsFixed(4)}',
                        style: const TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'خط الطول: ${_currentPosition!.longitude.toStringAsFixed(4)}',
                        style: const TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        // معلومات العدد
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'تم العثور على ${_nearbyStores.length} متجر',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getPrimaryTextColor(context),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.gold.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.sort, size: 16, color: AppTheme.gold),
                    const SizedBox(width: 4),
                    Text(
                      'الأقرب',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 12,
                        color: AppTheme.gold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // قائمة المتاجر
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _nearbyStores.length,
            itemBuilder: (context, index) {
              final store = _nearbyStores[index];
              return _buildStoreCard(context, store, isDark);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStoreCard(BuildContext context, Map<String, dynamic> store, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.nightCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: store['isOpen'] ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // صورة المتجر
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppTheme.gold.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    store['image'],
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
              // معلومات المتجر
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            store['name'],
                            style: TextStyle(
                              fontFamily: 'Changa',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.getPrimaryTextColor(context),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: store['isOpen'] ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                store['isOpen'] ? Icons.check_circle : Icons.access_time,
                                size: 12,
                                color: store['isOpen'] ? Colors.green : Colors.red,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                store['isOpen'] ? 'مفتوح' : 'مغلق',
                                style: TextStyle(
                                  fontFamily: 'Changa',
                                  fontSize: 10,
                                  color: store['isOpen'] ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      store['type'],
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '${store['rating']}',
                          style: const TextStyle(
                            fontFamily: 'Changa',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.location_on, size: 12, color: AppTheme.gold),
                        const SizedBox(width: 2),
                        Text(
                          '${store['distance']} كم',
                          style: const TextStyle(
                            fontFamily: 'Changa',
                            fontSize: 11,
                            color: AppTheme.gold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),
          
          // أزرار الإجراءات
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                icon: Icons.phone_outlined,
                label: 'اتصال',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('جاري الاتصال بـ ${store['phone']}')),
                  );
                },
              ),
              _buildActionButton(
                icon: Icons.directions_outlined,
                label: 'اتجاهات',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('جاري فتح الخريطة...')),
                  );
                },
              ),
              _buildActionButton(
                icon: Icons.store_outlined,
                label: 'زيارة',
                onTap: () {
                  Navigator.pushNamed(context, '/store/${store['name']}');
                },
                isPrimary: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isPrimary ? AppTheme.gold : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: isPrimary ? null : Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isPrimary ? Colors.black : Colors.grey[600],
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isPrimary ? Colors.black : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
