import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = [
      {'name': 'iPhone 15 Pro', 'price': '350,000', 'store': 'متجر التقنية', 'rating': 4.8},
      {'name': 'MacBook Pro M3', 'price': '1,800,000', 'store': 'كمبيوتر مول', 'rating': 4.9},
      {'name': 'ثوب يمني فاخر', 'price': '35,000', 'store': 'الأزياء العصرية', 'rating': 4.6},
      {'name': 'مندي يمني', 'price': '3,500', 'store': 'مطعم مندي الملكي', 'rating': 4.8},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        title: const Text('المفضلة', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/icons/svg/delete.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)),
            onPressed: () {},
          ),
        ],
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/svg/favorite.svg', width: 80, height: 80, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)),
                  const SizedBox(height: 16),
                  const Text('لا توجد منتجات في المفضلة', style: TextStyle(color: Color(0xFF9CA3AF))),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final name = favorites[index]['name'] as String;
                final price = favorites[index]['price'] as String;
                final store = favorites[index]['store'] as String;
                final rating = favorites[index]['rating'] as double;
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2329),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60, height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4AF37).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SvgPicture.asset('assets/icons/svg/product.svg', width: 30, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(store, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text('$price ريال', style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                                const SizedBox(width: 12),
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/svg/star_gold.svg', width: 12),
                                    const SizedBox(width: 4),
                                    Text('$rating', style: const TextStyle(color: Color(0xFF9CA3AF))),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: SvgPicture.asset('assets/icons/svg/favorite.svg', width: 20, colorFilter: const ColorFilter.mode(Color(0xFFF6465D), BlendMode.srcIn)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
