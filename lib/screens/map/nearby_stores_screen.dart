import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import '../store_detail_screen.dart';

class NearbyStoresScreen extends StatefulWidget {
  const NearbyStoresScreen({super.key});

  @override
  State<NearbyStoresScreen> createState() => _NearbyStoresScreenState();
}

class _NearbyStoresScreenState extends State<NearbyStoresScreen> {
  final List<Map<String, dynamic>> _stores = [
    {'name': 'متجر الإلكترونيات الحديثة', 'category': 'إلكترونيات', 'distance': '0.5 كم', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=400', 'isOpen': true},
    {'name': 'سوبر ماركت السعادة', 'category': 'بقالة', 'distance': '1.2 كم', 'rating': 4.5, 'image': 'https://images.unsplash.com/photo-1578916171728-46686eac8d58?w=400', 'isOpen': true},
    {'name': 'مطعم المندي اليمني', 'category': 'مطاعم', 'distance': '0.8 كم', 'rating': 4.9, 'image': 'https://images.unsplash.com/photo-1514933651103-005eec06c04b?w=400', 'isOpen': true},
    {'name': 'محلات الأزياء الفاخرة', 'category': 'أزياء', 'distance': '2.1 كم', 'rating': 4.3, 'image': 'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?w=400', 'isOpen': false},
    {'name': 'صيدلية الشفاء', 'category': 'صحة', 'distance': '0.3 كم', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=400', 'isOpen': true},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'متاجر قريبة منك'),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _stores.length,
              itemBuilder: (context, index) {
                final store = _stores[index];
                return _buildStoreCard(store);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(30)),
      child: const TextField(
        decoration: InputDecoration(hintText: 'ابحث عن متجر...', prefixIcon: Icon(Icons.search, color: AppTheme.goldColor), border: InputBorder.none),
      ),
    );
  }

  Widget _buildStoreCard(Map<String, dynamic> store) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StoreDetailScreen(storeName: store['name']))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(16)),
              child: Image.network(store['image'], width: 100, height: 100, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(width: 100, height: 100, color: Colors.grey[300], child: const Icon(Icons.store)))),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(store['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: store['isOpen'] ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Text(store['isOpen'] ? 'مفتوح' : 'مغلق', style: TextStyle(color: store['isOpen'] ? Colors.green : Colors.red, fontSize: 10))),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(store['category'], style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text('${store['rating']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        const SizedBox(width: 16),
                        const Icon(Icons.location_on, color: AppTheme.goldColor, size: 16),
                        const SizedBox(width: 4),
                        Text(store['distance'], style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
