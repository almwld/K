import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../stores/store_detail_screen.dart';
import '../../data/stores_data.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  final String productName;
  final String? storeName;

  const ProductDetailScreen({
    super.key,
    required this.productId,
    required this.productName,
    this.storeName,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _quantity = 1;
  int _selectedImageIndex = 0;
  bool _isFavorite = false;

  final List<String> _images = [
    'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=800',
    'https://images.unsplash.com/photo-1592286927505-1def25115558?w=800',
    'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=800',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildImageGallery()),
                SliverToBoxAdapter(child: _buildProductInfo()),
                SliverToBoxAdapter(child: _buildStoreInfo()),
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
      ),
      bottomNavigationBar: _buildBottomBar(),
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
          Text('450.00 ريال', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.goldColor)),
        ],
      ),
    );
  }

  Widget _buildStoreInfo() {
    if (widget.storeName == null) return const SizedBox.shrink();
    
    final store = StoresData.getAllStores().firstWhere(
      (s) => s.name == widget.storeName,
      orElse: () => StoresData.getAllStores().first,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StoreDetailScreen(store: store))),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[300]!)),
          child: Row(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(store.imageUrl, width: 50, height: 50, fit: BoxFit.cover)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(store.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                        Text(' ${store.rating}'),
                        const SizedBox(width: 12),
                        Icon(store.isOpen ? Icons.check_circle : Icons.cancel, color: store.isOpen ? Colors.green : Colors.red, size: 14),
                        Text(store.isOpen ? ' مفتوح' : ' مغلق', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
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
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text('هذا المنتج من أفضل المنتجات في فئته. مصنوع من مواد عالية الجودة ويأتي مع ضمان لمدة سنة كاملة.'),
    );
  }

  Widget _buildSpecificationsTab() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text('المواصفات التقنية للمنتج...'),
    );
  }

  Widget _buildReviewsTab() {
    return const Center(child: Text('التقييمات'));
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تمت إضافة $_quantity قطعة إلى السلة'), backgroundColor: Colors.green, duration: const Duration(seconds: 2)),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
