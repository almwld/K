import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class AllAdsScreen extends StatelessWidget {
  const AllAdsScreen({super.key});

  final List<Map<String, dynamic>> _ads = const [
    {'id': '1', 'title': 'آيفون 15 برو للبيع', 'price': 450000, 'category': 'إلكترونيات', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400', 'location': 'صنعاء'},
    {'id': '2', 'title': 'سامسونج S24 الترا', 'price': 380000, 'category': 'إلكترونيات', 'image': 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400', 'location': 'عدن'},
    {'id': '3', 'title': 'فيلا فاخرة للبيع', 'price': 45000000, 'category': 'عقارات', 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400', 'location': 'صنعاء'},
    {'id': '4', 'title': 'تويوتا كامري 2024', 'price': 8500000, 'category': 'سيارات', 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400', 'location': 'تعز'},
    {'id': '5', 'title': 'مندي يمني', 'price': 3500, 'category': 'مطاعم', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400', 'location': 'الحديدة'},
    {'id': '6', 'title': 'ماك بوك برو M3', 'price': 1800000, 'category': 'إلكترونيات', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400', 'location': 'صنعاء'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'جميع الإعلانات'),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _ads.length,
        itemBuilder: (context, index) {
          final ad = _ads[index];
          return _buildAdCard(context, ad);
        },
      ),
    );
  }

  Widget _buildAdCard(BuildContext context, Map<String, dynamic> ad) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: CachedNetworkImage(
              imageUrl: ad['image'],
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 140,
                color: isDark ? Colors.grey[800] : Colors.grey[200],
                child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
              ),
              errorWidget: (context, url, error) => Container(
                height: 140,
                color: isDark ? Colors.grey[800] : Colors.grey[200],
                child: const Icon(Icons.image_not_supported),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ad['title'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  '${ad['price']} ريال',
                  style: TextStyle(
                    color: AppTheme.goldPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 12, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        ad['location'],
                        style: const TextStyle(fontSize: 11, color: Colors.grey),
                        maxLines: 1,
                      ),
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
