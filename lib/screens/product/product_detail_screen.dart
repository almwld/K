import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  final String? heroTag;
  const ProductDetailScreen({super.key, required this.productId, this.heroTag});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: const Color(0xFF0B0E11),
                leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
                actions: [IconButton(icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border, color: _isFavorite ? Colors.red : Colors.white), onPressed: () => setState(() => _isFavorite = !_isFavorite))],
                flexibleSpace: FlexibleSpaceBar(background: Container(color: const Color(0xFFD4AF37).withOpacity(0.1), child: Center(child: SvgPicture.asset('assets/icons/svg/product.svg', width: 100, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn))))),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [Expanded(child: const Text('iPhone 15 Pro', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))), Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFF6465D), Color(0xFFE53935)]), borderRadius: BorderRadius.circular(8)), child: const Text('-22%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))]),
                      const SizedBox(height: 8),
                      Row(children: [...List.generate(5, (i) => Icon(i < 4 ? Icons.star : Icons.star_border, color: Colors.amber, size: 20)), const SizedBox(width: 8), const Text('(128 تقييم)', style: TextStyle(color: Color(0xFF9CA3AF)))]),
                      const SizedBox(height: 16),
                      Row(children: [const Text('350,000 ريال', style: TextStyle(color: Color(0xFFF0B90B), fontSize: 28, fontWeight: FontWeight.bold)), const SizedBox(width: 12), const Text('450,000 ريال', style: TextStyle(color: Color(0xFF5E6673), decoration: TextDecoration.lineThrough, fontSize: 16))]),
                      const SizedBox(height: 20),
                      Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: Row(children: [Container(width: 40, height: 40, decoration: BoxDecoration(color: const Color(0xFFD4AF37).withOpacity(0.1), shape: BoxShape.circle), child: SvgPicture.asset('assets/icons/svg/store.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn))), const SizedBox(width: 12), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('متجر التقنية', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), Row(children: [SvgPicture.asset('assets/icons/svg/verified.svg', width: 14), const SizedBox(width: 4), const Text('بائع موثوق', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 11))])])), OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFD4AF37))), child: const Text('عرض المتجر', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 11)))])),
                      const SizedBox(height: 20),
                      const Text('الوصف', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text('هذا المنتج يأتي بمواصفات عالية الجودة.', style: TextStyle(color: Color(0xFF9CA3AF))),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF0B0E11), border: Border(top: BorderSide(color: const Color(0xFF2B3139)))), child: SafeArea(child: Row(children: [
              Container(decoration: BoxDecoration(border: Border.all(color: const Color(0xFF2B3139)), borderRadius: BorderRadius.circular(12)), child: Row(children: [IconButton(onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null, icon: const Icon(Icons.remove, color: Color(0xFFD4AF37))), Container(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text('$_quantity', style: const TextStyle(color: Colors.white))), IconButton(onPressed: () => setState(() => _quantity++), icon: const Icon(Icons.add, color: Color(0xFFD4AF37)))])),
              const SizedBox(width: 12),
              Expanded(child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), padding: const EdgeInsets.symmetric(vertical: 16)), child: const Text('أضف للسلة', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)))),
            ]))),
          ),
        ],
      ),
    );
  }
}
