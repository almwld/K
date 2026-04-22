import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';
import '../search_screen.dart';
import '../notifications_screen.dart';
import '../categories_screen.dart';
import '../auctions/auctions_screen.dart';
import '../offers_screen.dart';
import '../stores/stores_screen.dart';
import '../stores/store_detail_screen.dart';
import '../product/product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('FLEX', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
            const SizedBox(width: 6),
            Text('YEMEN', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: const Color(0xFFD4AF37).withOpacity(0.8))),
          ],
        ),
        actions: [
          IconButton(icon: SvgPicture.asset('assets/icons/svg/search.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen()))),
          IconButton(icon: SvgPicture.asset('assets/icons/svg/notification.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()))),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: 8,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductDetailScreen(productId: ''))),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E2329),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4AF37).withOpacity(0.1),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      ),
                      child: const Center(child: Icon(Icons.shopping_bag, color: Color(0xFFD4AF37), size: 40)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('منتج ${index + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('${(index + 1) * 100} ريال', style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
