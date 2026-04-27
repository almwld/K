import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../data/full_market_data.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<String, dynamic>> _favorites = [
    {'id': '1', 'name': 'iPhone 15 Pro', 'price': '350,000', 'oldPrice': '450,000', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=200', 'rating': 4.8, 'discount': 22},
    {'id': '2', 'name': 'ساعة أبل الترا', 'price': '45,000', 'oldPrice': '60,000', 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=200', 'rating': 4.8, 'discount': 25},
    {'id': '3', 'name': 'ماك بوك برو', 'price': '1,800,000', 'oldPrice': '2,100,000', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=200', 'rating': 4.9, 'discount': 14},
  ];

  void _removeFavorite(String id) {
    setState(() {
      _favorites.removeWhere((item) => item['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تمت إزالة المنتج من المفضلة'), backgroundColor: AppTheme.binanceGreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('المفضلة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
        centerTitle: true,
        actions: [
          if (_favorites.isNotEmpty)
            TextButton(
              onPressed: () => setState(() => _favorites.clear()),
              child: const Text('مسح الكل', style: TextStyle(color: AppTheme.binanceRed)),
            ),
        ],
      ),
      body: _favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/svg/favorite.svg', width: 80, height: 80),
                  const SizedBox(height: 16),
                  const Text('لا توجد منتجات مفضلة', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('أضف منتجاتك المفضلة هنا', style: TextStyle(color: Color(0xFF9CA3AF))),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.binanceGold,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('تسوق الآن', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final product = _favorites[index];
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.binanceCard : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.binanceBorder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                  child: CachedNetworkImage(
                                    imageUrl: product['image'],
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  left: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(color: AppTheme.binanceRed, borderRadius: BorderRadius.circular(4)),
                                    child: Text('-${product['discount']}%', style: const TextStyle(color: Colors.white, fontSize: 10)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), maxLines: 1),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(product['price'], style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold, fontSize: 12)),
                                    const SizedBox(width: 4),
                                    Text(product['oldPrice'], style: const TextStyle(color: Color(0xFF5E6673), decoration: TextDecoration.lineThrough, fontSize: 10)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.star, size: 12, color: Colors.amber),
                                    const SizedBox(width: 2),
                                    Text('${product['rating']}', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => _removeFavorite(product['id']),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), shape: BoxShape.circle),
                          child: const Icon(Icons.close, color: Colors.white, size: 16),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
