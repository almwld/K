import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<String, dynamic>> _favorites = [
    {'id': '1', 'name': 'iPhone 15 Pro', 'price': '350,000', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400', 'rating': 4.8, 'discount': 22, 'seller': 'متجر التقنية'},
    {'id': '2', 'name': 'ساعة أبل الترا', 'price': '45,000', 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400', 'rating': 4.8, 'discount': 15, 'seller': 'متجر التقنية'},
    {'id': '3', 'name': 'سماعات ايربودز', 'price': '35,000', 'image': 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=400', 'rating': 4.7, 'discount': 22, 'seller': 'عالم الجوالات'},
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
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        backgroundColor: AppTheme.binanceDark,
        elevation: 0,
        title: const Text('المفضلة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                  SvgPicture.asset('assets/icons/svg/favorite.svg', width: 80, height: 80, colorFilter: const ColorFilter.mode(AppTheme.binanceGold, BlendMode.srcIn)),
                  const SizedBox(height: 16),
                  const Text('لا توجد منتجات مفضلة', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('أضف منتجاتك المفضلة هنا', style: TextStyle(color: Color(0xFF9CA3AF))),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceGold, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
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
                    ProductCard(
                      product: product,
                      onTap: () {},
                      onAddToCart: () {},
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => _removeFavorite(product['id'] as String),
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
