import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/shimmer_image.dart';
import 'product/product_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _favorites = [
        {'id': '1', 'name': 'آيفون 15 برو', 'price': '4,500', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400', 'category': 'إلكترونيات', 'store': 'إلكترونيات الحديثة'},
        {'id': '2', 'name': 'تويوتا كامري 2024', 'price': '95,000', 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400', 'category': 'سيارات', 'store': 'معارض النخبة'},
        {'id': '3', 'name': 'فيلا فاخرة', 'price': '2,500,000', 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400', 'category': 'عقارات', 'store': 'عقارات الماسة'},
        {'id': '4', 'name': 'ثوب سعودي', 'price': '350', 'image': 'https://images.unsplash.com/photo-1593032465175-4810b1975170?w=400', 'category': 'أزياء', 'store': 'الأصيل للأزياء'},
        {'id': '5', 'name': 'مندي لحم', 'price': '75', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400', 'category': 'مطاعم', 'store': 'مطعم اليمن'},
      ];
      _isLoading = false;
    });
  }

  void _removeFavorite(String id) {
    setState(() {
      _favorites.removeWhere((item) => item['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تمت إزالة المنتج من المفضلة'), backgroundColor: Colors.orange),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المفضلة'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.gold))
          : _favorites.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border, size: 80, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text('لا توجد منتجات في المفضلة', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                      const SizedBox(height: 8),
                      Text('أضف منتجاتك المفضلة من خلال التصفح', style: TextStyle(fontSize: 14, color: Colors.grey[500])),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: _favorites.length,
                  itemBuilder: (context, index) {
                    final product = _favorites[index];
                    return _buildFavoriteCard(product);
                  },
                ),
    );
  }

  Widget _buildFavoriteCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
              productId: product['id'],
              productName: product['name'],
              storeName: product['store'],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: ShimmerImage(
                    imageUrl: product['image'],
                    height: 130,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => _removeFavorite(product['id']),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)],
                      ),
                      child: const Icon(Icons.favorite, color: Colors.red, size: 18),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['price'],
                    style: TextStyle(
                      color: AppTheme.gold,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.gold.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      product['category'],
                      style: TextStyle(color: AppTheme.gold, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

