import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  final String productName;

  const ProductDetailScreen({
    super.key,
    required this.productId,
    required this.productName,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _quantity = 1;
  int _selectedImageIndex = 0;
  bool _isFavorite = false;
  bool _isLoading = true;

  final List<String> _images = [
    'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=800',
    'https://images.unsplash.com/photo-1592286927505-1def25115558?w=800',
    'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=800',
  ];

  final List<Map<String, dynamic>> _reviews = [
    {'user': 'أحمد محمد', 'rating': 5, 'comment': 'منتج ممتاز وجودة عالية، أنصح به بشدة', 'date': 'منذ يومين'},
    {'user': 'فاطمة علي', 'rating': 4, 'comment': 'جيد جداً لكن الشحن تأخر قليلاً', 'date': 'منذ أسبوع'},
    {'user': 'عمر خالد', 'rating': 5, 'comment': 'سعر مناسب وجودة ممتازة، شكراً فلكس يمن', 'date': 'منذ أسبوعين'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: AppBar(
        title: Text(widget.productName),
        backgroundColor: AppTheme.goldColor,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () => setState(() => _isFavorite = !_isFavorite),
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border, color: _isFavorite ? Colors.red : Colors.black),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.share, color: Colors.black)),
        ],
      ),
      body: _isLoading ? _buildLoadingState() : _buildContent(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildLoadingState() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(height: 300, color: Colors.grey[300]),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 24, width: 200, color: Colors.grey[300]),
                const SizedBox(height: 12),
                Container(height: 20, width: 150, color: Colors.grey[300]),
                const SizedBox(height: 20),
                Container(height: 60, width: double.infinity, color: Colors.grey[300]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildImageGallery()),
              SliverToBoxAdapter(child: _buildProductInfo()),
              SliverToBoxAdapter(child: _buildTabBar()),
              SliverFillRemaining(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildDescriptionTab(),
                    _buildSpecificationsTab(),
                    _buildReviewsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageGallery() {
    return Column(
      children: [
        Container(
          height: 300,
          color: Colors.grey[100],
          child: PageView.builder(
            onPageChanged: (index) => setState(() => _selectedImageIndex = index),
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: _images[index],
                fit: BoxFit.contain,
                placeholder: (_, __) => Container(color: Colors.grey[200]),
                errorWidget: (_, __, ___) => const Icon(Icons.image_not_supported, size: 50),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_images.length, (index) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _selectedImageIndex == index ? AppTheme.goldColor : Colors.grey[400],
              ),
            );
          }),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(widget.productName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: AppTheme.goldColor, borderRadius: BorderRadius.circular(20)),
                child: const Text('جديد', style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              const Text('4.8', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(width: 4),
              Text('(245 تقييم)', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
              const Spacer(),
              const Icon(Icons.location_on, color: AppTheme.goldColor, size: 18),
              const SizedBox(width: 4),
              Text('صنعاء', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
            ],
          ),
          const SizedBox(height: 16),
          Text('450,000 ريال', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.goldColor)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: const Row(
              children: [
                Icon(Icons.local_shipping, color: Colors.green),
                SizedBox(width: 8),
                Text('توصيل مجاني للطلبات فوق 10,000 ريال'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Theme.of(context).cardColor,
      child: TabBar(
        controller: _tabController,
        labelColor: AppTheme.goldColor,
        unselectedLabelColor: Colors.grey,
        indicatorColor: AppTheme.goldColor,
        tabs: const [
          Tab(text: 'الوصف'),
          Tab(text: 'المواصفات'),
          Tab(text: 'التقييمات'),
        ],
      ),
    );
  }

  Widget _buildDescriptionTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('وصف المنتج', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text('هذا المنتج من أفضل المنتجات في فئته. مصنوع من مواد عالية الجودة ويأتي مع ضمان لمدة سنة كاملة.', style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.6)),
        ],
      ),
    );
  }

  Widget _buildSpecificationsTab() {
    final specs = {
      'الماركة': 'Apple',
      'الموديل': 'iPhone 15 Pro',
      'اللون': 'أسود تيتانيوم',
      'السعة': '256 جيجابايت',
    };

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('المواصفات التقنية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ...specs.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  SizedBox(width: 120, child: Text(entry.key, style: TextStyle(color: Colors.grey[600]))),
                  Expanded(child: Text(entry.value, style: const TextStyle(fontWeight: FontWeight.w500))),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _reviews.length,
      itemBuilder: (context, index) {
        final review = _reviews[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(radius: 20, backgroundColor: AppTheme.goldColor.withOpacity(0.2), child: Text(review['user'][0], style: const TextStyle(color: AppTheme.goldColor))),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(review['user'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            ...List.generate(5, (i) => Icon(i < review['rating'] ? Icons.star : Icons.star_border, color: Colors.amber, size: 14)),
                            const SizedBox(width: 8),
                            Text(review['date'], style: TextStyle(color: Colors.grey[500], fontSize: 11)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(review['comment'], style: const TextStyle(fontSize: 14)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, -2))]),
      child: Row(
        children: [
          _buildQuantitySelector(),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: _addToCart,
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: const Text('أضف إلى السلة', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          IconButton(onPressed: () => setState(() { if (_quantity > 1) _quantity--; }), icon: const Icon(Icons.remove, size: 20)),
          Text('$_quantity', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          IconButton(onPressed: () => setState(() => _quantity++), icon: const Icon(Icons.add, size: 20)),
        ],
      ),
    );
  }

  void _addToCart() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تمت إضافة $_quantity قطعة إلى السلة'), backgroundColor: Colors.green, duration: const Duration(seconds: 2)));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
