import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  bool _isFavorite = false;

  // بيانات مؤقتة للمنتج
  final Map<String, dynamic> _product = {
    'name': 'iPhone 15 Pro',
    'price': 350000,
    'oldPrice': 450000,
    'discount': 22,
    'rating': 4.8,
    'reviews': 128,
    'store': 'متجر التقنية الحديثة',
    'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=300',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 350,
                pinned: true,
                backgroundColor: const Color(0xFF0B0E11),
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () => setState(() => _isFavorite = !_isFavorite),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? const Color(0xFFF6465D) : Colors.white,
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: const Color(0xFFD4AF37).withOpacity(0.1),
                    child: Center(
                      child: Icon(Icons.smartphone, color: const Color(0xFFD4AF37), size: 100),
                    ),
                  ),
                ),
              ),
              
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _product['name'] as String,
                              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          if (_product['discount'] > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFF6465D), Color(0xFFE53935)],
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text('-${_product['discount']}%', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          ...List.generate(5, (index) => Icon(
                            index < (_product['rating'] as double).floor() ? Icons.star : Icons.star_border,
                            color: const Color(0xFFF0B90B),
                            size: 20,
                          )),
                          const SizedBox(width: 8),
                          Text('(${_product['reviews']}+ تقييم)', style: const TextStyle(color: Color(0xFF9CA3AF))),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            '${_product['price']} ريال',
                            style: const TextStyle(color: Color(0xFFF0B90B), fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 12),
                          if (_product['oldPrice'] != null)
                            Text(
                              '${_product['oldPrice']} ريال',
                              style: const TextStyle(color: Color(0xFF5E6673), decoration: TextDecoration.lineThrough, fontSize: 16),
                            ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E2329),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF2B3139)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD4AF37).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.store, color: Color(0xFFD4AF37)),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_product['store'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  const Row(
                                    children: [
                                      Icon(Icons.verified, color: Color(0xFFD4AF37), size: 14),
                                      SizedBox(width: 4),
                                      Text('بائع موثوق', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFFD4AF37)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                              child: const Text('عرض المتجر', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 11)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('الوصف', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text(
                        'هذا المنتج يأتي بمواصفات عالية الجودة ومناسب لجميع الاستخدامات.',
                        style: TextStyle(color: Color(0xFF9CA3AF), height: 1.6),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0B0E11),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10)],
                border: Border(top: BorderSide(color: const Color(0xFF2B3139))),
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF2B3139)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
                            icon: const Icon(Icons.remove, color: Color(0xFFD4AF37)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text('$_quantity', style: const TextStyle(color: Colors.white, fontSize: 16)),
                          ),
                          IconButton(
                            onPressed: () => setState(() => _quantity++),
                            icon: const Icon(Icons.add, color: Color(0xFFD4AF37)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تم إضافة المنتج إلى السلة')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4AF37),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('أضف للسلة', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
