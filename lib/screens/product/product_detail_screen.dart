import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../theme/app_theme.dart';
import '../cart/cart_screen.dart';
import '../chat/chat_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  int _currentImageIndex = 0;
  bool _isFavorite = false;
  int _selectedTab = 0;

  final Map<String, dynamic> _product = {
    'id': '1',
    'name': 'iPhone 15 Pro',
    'price': 350000,
    'oldPrice': 450000,
    'discount': 22,
    'rating': 4.8,
    'reviews': 128,
    'description': 'iPhone 15 Pro بشاشة 6.1 بوصة، كاميرا 48 ميجابكسل، شريحة A17 Pro',
    'seller': 'متجر التقنية',
    'sellerRating': 4.9,
    'sellerReviews': 1234,
    'inStock': true,
    'specs': ['الشاشة: 6.1 بوصة', 'المعالج: A17 Pro', 'الكاميرا: 48 ميجابكسل', 'البطارية: تدوم طوال اليوم'],
    'images': [
      'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400',
      'https://images.unsplash.com/photo-1695048133660-0cdd1c8c0a0a?w=400',
    ],
  };

  final List<Map<String, dynamic>> _reviews = [
    {'name': 'أحمد محمد', 'rating': 5, 'comment': 'منتج رائع جداً', 'date': '2024-04-20', 'avatar': 'https://randomuser.me/api/portraits/men/1.jpg'},
    {'name': 'سارة علي', 'rating': 4, 'comment': 'جيد ولكن السعر مرتفع', 'date': '2024-04-18', 'avatar': 'https://randomuser.me/api/portraits/women/1.jpg'},
  ];

  final List<Map<String, dynamic>> _relatedProducts = [
    {'id': '2', 'name': 'iPhone 15 Pro Max', 'price': 450000, 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=200', 'rating': 4.9},
    {'id': '3', 'name': 'ساعة أبل الترا', 'price': 45000, 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=200', 'rating': 4.8},
  ];

  void _addToCart() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تمت إضافة المنتج إلى السلة'), backgroundColor: AppTheme.binanceGreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(child: _buildProductImages()),
          SliverToBoxAdapter(child: _buildProductInfo()),
          SliverToBoxAdapter(child: _buildTabs()),
          SliverToBoxAdapter(child: _buildTabContent()),
          SliverToBoxAdapter(child: _buildRelatedProducts()),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: AppTheme.binanceDark,
      flexibleSpace: const FlexibleSpaceBar(background: SizedBox()),
      leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
      actions: [
        IconButton(icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border, color: AppTheme.binanceGold), onPressed: () => setState(() => _isFavorite = !_isFavorite)),
        IconButton(icon: const Icon(Icons.share, color: AppTheme.binanceGold), onPressed: () {}),
      ],
    );
  }

  Widget _buildProductImages() {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: (_product['images'] as List).length,
          options: CarouselOptions(height: 300, viewportFraction: 1.0, onPageChanged: (i, _) => setState(() => _currentImageIndex = i)),
          itemBuilder: (_, i, __) => CachedNetworkImage(imageUrl: (_product['images'] as List)[i], fit: BoxFit.cover, width: double.infinity),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate((_product['images'] as List).length, (i) => Container(
            width: 8, height: 8, margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(shape: BoxShape.circle, color: _currentImageIndex == i ? AppTheme.binanceGold : AppTheme.binanceBorder),
          )),
        ),
      ],
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_product['name'] as String, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text('${_product['rating']}', style: const TextStyle(color: Colors.white)),
              const SizedBox(width: 4),
              Text('(${_product['reviews']} تقييم)', style: const TextStyle(color: Color(0xFF9CA3AF))),
              const Spacer(),
              if (_product['discount'] != null)
                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: AppTheme.binanceRed, borderRadius: BorderRadius.circular(4)), child: Text('-${_product['discount']}%', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text('${_product['price']} ريال', style: TextStyle(color: AppTheme.binanceGold, fontSize: 28, fontWeight: FontWeight.bold)),
              if (_product['oldPrice'] != null) ...[
                const SizedBox(width: 8),
                Text('${_product['oldPrice']} ريال', style: const TextStyle(color: Color(0xFF5E6673), decoration: TextDecoration.lineThrough, fontSize: 16)),
              ],
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(width: 40, height: 40, decoration: BoxDecoration(color: AppTheme.binanceGold.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.store, color: AppTheme.binanceGold)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_product['seller'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 12, color: Colors.amber),
                          const SizedBox(width: 2),
                          Text('${_product['sellerRating']}', style: const TextStyle(color: Colors.white)),
                          const SizedBox(width: 4),
                          Text('(${_product['sellerReviews']})', style: const TextStyle(color: Color(0xFF9CA3AF))),
                        ],
                      ),
                    ],
                  ),
                ),
                OutlinedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen())), style: OutlinedButton.styleFrom(side: BorderSide(color: AppTheme.binanceGold)), child: const Text('تواصل', style: TextStyle(color: AppTheme.binanceGold))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('الكمية:', style: TextStyle(color: Colors.white)),
              const SizedBox(width: 16),
              Container(
                decoration: BoxDecoration(border: Border.all(color: AppTheme.binanceBorder), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    IconButton(icon: const Icon(Icons.remove, size: 18), onPressed: () => setState(() => _quantity > 1 ? _quantity-- : null)),
                    Container(width: 40, alignment: Alignment.center, child: Text('$_quantity', style: const TextStyle(color: Colors.white))),
                    IconButton(icon: const Icon(Icons.add, size: 18), onPressed: () => setState(() => _quantity++)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildTab('الوصف', 0),
          const SizedBox(width: 12),
          _buildTab('المواصفات', 1),
          const SizedBox(width: 12),
          _buildTab('التقييمات (${_reviews.length})', 2),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: _selectedTab == index ? AppTheme.binanceGold : AppTheme.binanceCard,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(child: Text(title, style: TextStyle(color: _selectedTab == index ? Colors.black : Colors.white, fontWeight: FontWeight.bold))),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0: return _buildDescriptionTab();
      case 1: return _buildSpecsTab();
      case 2: return _buildReviewsTab();
      default: return const SizedBox();
    }
  }

  Widget _buildDescriptionTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(_product['description'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), height: 1.5)),
    );
  }

  Widget _buildSpecsTab() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: (_product['specs'] as List).length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: AppTheme.binanceGold, size: 16),
            const SizedBox(width: 8),
            Text((_product['specs'] as List)[index], style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsTab() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: _reviews.length,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            CircleAvatar(radius: 20, backgroundImage: NetworkImage(_reviews[index]['avatar'])),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_reviews[index]['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Row(children: List.generate(5, (i) => Icon(i < _reviews[index]['rating'] ? Icons.star : Icons.star_border, color: Colors.amber, size: 14))),
                  Text(_reviews[index]['comment'], style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                  Text(_reviews[index]['date'], style: const TextStyle(color: Color(0xFF5E6673), fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('منتجات مشابهة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _relatedProducts.length,
            itemBuilder: (_, i) => GestureDetector(
              onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(productId: _relatedProducts[i]['id'] as String))),
              child: Container(
                width: 150,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.binanceBorder)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(12)), child: CachedNetworkImage(imageUrl: _relatedProducts[i]['image'], height: 120, width: double.infinity, fit: BoxFit.cover)),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_relatedProducts[i]['name'], style: const TextStyle(color: Colors.white, fontSize: 12), maxLines: 1),
                          const SizedBox(height: 4),
                          Text('${_relatedProducts[i]['price']} ريال', style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.binanceCard, border: Border(top: BorderSide(color: AppTheme.binanceBorder))),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _addToCart,
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceGold, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: Text('أضف للسلة - ${_quantity * (_product['price'] as int)} ريال', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
