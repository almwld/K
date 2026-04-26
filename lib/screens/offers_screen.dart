import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  final List<Map<String, dynamic>> _offers = const [
    {'title': 'عروض الأسبوع', 'discount': '50%', 'color': 0xFF2196F3, 'products': 45},
    {'title': 'عروض البرق', 'discount': '30%', 'color': 0xFFF6465D, 'products': 23},
    {'title': 'صفقة اليوم', 'discount': '70%', 'color': 0xFFFF9800, 'products': 1},
    {'title': 'عروض VIP', 'discount': '25%', 'color': 0xFFD4AF37, 'products': 12},
  ];

  final List<Map<String, dynamic>> _products = const [
    {'name': 'iPhone 15 Pro', 'price': '350,000', 'oldPrice': '500,000', 'discount': 30, 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=200'},
    {'name': 'ساعة أبل الترا', 'price': '45,000', 'oldPrice': '70,000', 'discount': 35, 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=200'},
    {'name': 'سامسونج S24', 'price': '320,000', 'oldPrice': '450,000', 'discount': 28, 'image': 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=200'},
    {'name': 'ماك بوك برو', 'price': '1,500,000', 'oldPrice': '2,100,000', 'discount': 28, 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=200'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        title: const Text('العروض', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.binanceDark,
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildOfferCards()),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSectionHeader('🔥 عروض حصرية')),
          SliverPadding(padding: const EdgeInsets.all(16), sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 12, mainAxisSpacing: 12),
            delegate: SliverChildBuilderDelegate((context, index) => _buildProductCard(_products[index]), childCount: _products.length),
          )),
        ],
      ),
    );
  }

  Widget _buildOfferCards() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16),
        itemCount: _offers.length,
        itemBuilder: (context, index) => Container(
          width: 160,
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(_offers[index]['color'] as int).withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(_offers[index]['color'] as int).withOpacity(0.3)),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(_offers[index]['title'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('خصم ${_offers[index]['discount']}', style: TextStyle(color: Color(_offers[index]['color'] as int), fontSize: 24, fontWeight: FontWeight.bold)),
            Text('${_offers[index]['products']} منتج', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
          ]),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.binanceBorder)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(children: [
          ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(12)), child: CachedNetworkImage(imageUrl: product['image'], height: 120, width: double.infinity, fit: BoxFit.cover)),
          Positioned(top: 8, left: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppTheme.binanceRed, borderRadius: BorderRadius.circular(4)), child: Text('-${product['discount']}%', style: const TextStyle(color: Colors.white, fontSize: 10)))),
        ]),
        Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(product['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), maxLines: 1),
          const SizedBox(height: 4),
          Row(children: [Text(product['price'], style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold)), const SizedBox(width: 4), Text(product['oldPrice'], style: const TextStyle(color: Color(0xFF5E6673), decoration: TextDecoration.lineThrough, fontSize: 10))]),
        ])),
      ]),
    );
  }
}
