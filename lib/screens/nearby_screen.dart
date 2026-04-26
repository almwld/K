import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';

class NearbyScreen extends StatelessWidget {
  const NearbyScreen({super.key});

  final List<Map<String, dynamic>> _nearbyStores = const [
    {'name': 'سوبر ماركت السعادة', 'distance': '0.3', 'rating': 4.5, 'type': 'سوبر ماركت', 'image': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=200', 'isOpen': true},
    {'name': 'مطعم البيت اليمني', 'distance': '0.8', 'rating': 4.8, 'type': 'مطعم', 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200', 'isOpen': true},
    {'name': 'صيدلية الحياة', 'distance': '1.2', 'rating': 4.3, 'type': 'صيدلية', 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=200', 'isOpen': true},
    {'name': 'مخبز الريف', 'distance': '1.5', 'rating': 4.6, 'type': 'مخبز', 'image': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=200', 'isOpen': false},
    {'name': 'محل العطور', 'distance': '2.0', 'rating': 4.4, 'type': 'عطور', 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=200', 'isOpen': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        title: const Text('بالقرب منك', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.binanceDark,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined, color: AppTheme.binanceGold),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // معلومات الموقع
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: AppTheme.goldGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.black),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('موقعي الحالي', style: TextStyle(color: Colors.black87, fontSize: 12)),
                      Text('صنعاء، الستين', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // العدد
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'تم العثور على ${_nearbyStores.length} متجر',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.binanceGold.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.sort, size: 14, color: AppTheme.binanceGold),
                      SizedBox(width: 4),
                      Text('الأقرب', style: TextStyle(color: AppTheme.binanceGold, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // القائمة
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _nearbyStores.length,
              itemBuilder: (context, index) => _buildStoreCard(_nearbyStores[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreCard(Map<String, dynamic> store) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.binanceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: store['isOpen'] ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              store['image'],
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 60,
                height: 60,
                color: AppTheme.binanceGold.withOpacity(0.1),
                child: Icon(Icons.store, color: AppTheme.binanceGold),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        store['name'],
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: store['isOpen'] ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        store['isOpen'] ? 'مفتوح' : 'مغلق',
                        style: TextStyle(
                          color: store['isOpen'] ? Colors.green : Colors.red,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  store['type'],
                  style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      store['rating'].toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.location_on, size: 12, color: AppTheme.binanceGold),
                    const SizedBox(width: 2),
                    Text(
                      '${store['distance']} كم',
                      style: const TextStyle(color: AppTheme.binanceGold, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
