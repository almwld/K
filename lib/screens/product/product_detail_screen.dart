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
  int _selectedImage = 0;

  final List<String> _images = [
    'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400',
    'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400',
    'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400',
  ];

  final List<String> _sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  String? _selectedSize;

  final List<String> _colors = ['أسود', 'أبيض', 'ذهبي', 'فضي'];
  String? _selectedColor;

  @override
  Widget build(BuildContext context) {
    final heroTag = widget.heroTag ?? 'product_${widget.productId}';

    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                backgroundColor: const Color(0xFF0B0E11),
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(margin: const EdgeInsets.all(8), padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), shape: BoxShape.circle), child: const Icon(Icons.arrow_back, color: Colors.white)),
                ),
                actions: [
                  GestureDetector(
                    onTap: () => setState(() => _isFavorite = !_isFavorite),
                    child: Container(margin: const EdgeInsets.all(8), padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), shape: BoxShape.circle), child: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border, color: _isFavorite ? const Color(0xFFF6465D) : Colors.white)),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(margin: const EdgeInsets.all(8), padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), shape: BoxShape.circle), child: SvgPicture.asset('assets/icons/svg/share.svg', width: 24, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn))),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: [
                      Expanded(
                        child: Hero(
                          tag: heroTag,
                          child: PageView.builder(
                            onPageChanged: (index) => setState(() => _selectedImage = index),
                            itemCount: _images.length,
                            itemBuilder: (context, index) => Container(color: const Color(0xFF1A2A44), child: Image.network(_images[index], fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                      Container(height: 40, color: const Color(0xFF0B0E11), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(_images.length, (i) => Container(width: 8, height: 8, margin: const EdgeInsets.symmetric(horizontal: 4), decoration: BoxDecoration(shape: BoxShape.circle, color: _selectedImage == i ? const Color(0xFFD4AF37) : Colors.grey.shade700))))),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Expanded(child: Text('iPhone 15 Pro', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFF6465D), Color(0xFFE53935)]), borderRadius: BorderRadius.circular(8)), child: const Text('-22%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                    ]),
                    const SizedBox(height: 8),
                    Row(children: [...List.generate(5, (i) => Icon(i < 4 ? Icons.star : Icons.star_border, color: const Color(0xFFF0B90B), size: 20)), const SizedBox(width: 8), const Text('(128 تقييم)', style: TextStyle(color: Color(0xFF9CA3AF)))]),
                    const SizedBox(height: 16),
                    Row(children: [Text('350,000 ريال', style: const TextStyle(color: Color(0xFFF0B90B), fontSize: 28, fontWeight: FontWeight.bold)), const SizedBox(width: 12), Text('450,000 ريال', style: const TextStyle(color: Color(0xFF5E6673), decoration: TextDecoration.lineThrough, fontSize: 16))]),
                    const SizedBox(height: 20),
                    Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: Row(children: [Container(width: 40, height: 40, decoration: BoxDecoration(color: const Color(0xFFD4AF37).withOpacity(0.1), shape: BoxShape.circle), child: const Icon(Icons.store, color: Color(0xFFD4AF37))), const SizedBox(width: 12), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('متجر التقنية', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), Row(children: [SvgPicture.asset('assets/icons/svg/verified.svg', width: 14), const SizedBox(width: 4), const Text('بائع موثوق', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 11))])])), OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFD4AF37)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), child: const Text('عرض المتجر', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 11)))])),
                    const SizedBox(height: 20),
                    const Text('المقاس', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(spacing: 8, children: _sizes.map((s) => GestureDetector(onTap: () => setState(() => _selectedSize = s), child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: _selectedSize == s ? const Color(0xFFD4AF37) : const Color(0xFF1E2329), borderRadius: BorderRadius.circular(8), border: Border.all(color: _selectedSize == s ? const Color(0xFFD4AF37) : const Color(0xFF2B3139))), child: Text(s, style: TextStyle(color: _selectedSize == s ? Colors.black : Colors.white))))).toList()),
                    const SizedBox(height: 16),
                    const Text('اللون', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(spacing: 8, children: _colors.map((c) => GestureDetector(onTap: () => setState(() => _selectedColor = c), child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: _selectedColor == c ? const Color(0xFFD4AF37) : const Color(0xFF1E2329), borderRadius: BorderRadius.circular(8), border: Border.all(color: _selectedColor == c ? const Color(0xFFD4AF37) : const Color(0xFF2B3139))), child: Text(c, style: TextStyle(color: _selectedColor == c ? Colors.black : Colors.white))))).toList()),
                    const SizedBox(height: 20),
                    const Text('الوصف', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('هاتف ذكي متطور مع شاشة 6.1 بوصة، معالج A17 Pro، كاميرا 48 ميجابكسل.', style: TextStyle(color: Color(0xFF9CA3AF), height: 1.6)),
                    const SizedBox(height: 100),
                  ]),
                ),
              ),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF0B0E11), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10)], border: Border(top: BorderSide(color: const Color(0xFF2B3139)))), child: SafeArea(child: Row(children: [
            Container(decoration: BoxDecoration(border: Border.all(color: const Color(0xFF2B3139)), borderRadius: BorderRadius.circular(12)), child: Row(children: [
              IconButton(onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null, icon: const Icon(Icons.remove, color: Color(0xFFD4AF37))),
              Container(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text('$_quantity', style: const TextStyle(color: Colors.white, fontSize: 16))),
              IconButton(onPressed: () => setState(() => _quantity++), icon: const Icon(Icons.add, color: Color(0xFFD4AF37))),
            ])),
            const SizedBox(width: 12),
            Expanded(child: ElevatedButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إضافة المنتج إلى السلة'))), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('أضف للسلة', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)))),
          ])))),
        ],
      ),
    );
  }
}
