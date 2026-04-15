import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';
import '../../models/store_model.dart';
import '../../data/market_data.dart';
import '../../models/market_item.dart';
import '../product/product_detail_screen.dart';

class StoreDetailScreen extends StatefulWidget {
  final StoreModel store;

  const StoreDetailScreen({super.key, required this.store});

  @override
  State<StoreDetailScreen> createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<MarketItem> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      _products = MarketData.getAllItemsComplete().where((item) => item.store == widget.store.name).toList();
      if (_products.isEmpty) {
        _products = MarketData.getAllItemsComplete().take(10).toList();
      }
      _isLoading = false;
    });
  }

  Future<void> _callStore() async {
    final url = Uri.parse('tel:${widget.store.phone}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppTheme.goldColor,
            foregroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(widget.store.imageUrl, fit: BoxFit.cover),
            ),
            actions: [
              IconButton(onPressed: _callStore, icon: const Icon(Icons.call, color: Colors.black)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.share, color: Colors.black)),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).cardColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(widget.store.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: AppTheme.goldColor, borderRadius: BorderRadius.circular(20)),
                        child: Text(widget.store.category, style: const TextStyle(color: Colors.white, fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text('${widget.store.rating}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(width: 16),
                      Icon(widget.store.isOpen ? Icons.check_circle : Icons.cancel, color: widget.store.isOpen ? Colors.green : Colors.red, size: 18),
                      const SizedBox(width: 4),
                      Text(widget.store.isOpen ? 'مفتوح' : 'مغلق', style: TextStyle(color: widget.store.isOpen ? Colors.green : Colors.red)),
                      const Spacer(),
                      Text(widget.store.workingHours, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(widget.store.description, style: TextStyle(color: Colors.grey[600], fontSize: 14, height: 1.5)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: AppTheme.goldColor, size: 18),
                      const SizedBox(width: 4),
                      Expanded(child: Text(widget.store.address, style: const TextStyle(fontSize: 14))),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).cardColor,
              child: TabBar(
                controller: _tabController,
                labelColor: AppTheme.goldColor,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppTheme.goldColor,
                tabs: const [
                  Tab(text: 'المنتجات'),
                  Tab(text: 'التقييمات'),
                  Tab(text: 'معلومات'),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildProductsTab(),
                _buildReviewsTab(),
                _buildInfoTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: AppTheme.goldColor));
    }
    if (_products.isEmpty) {
      return const Center(child: Text('لا توجد منتجات حالياً'));
    }
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.75, crossAxisSpacing: 12, mainAxisSpacing: 12),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return _buildProductCard(product);
      },
    );
  }

  Widget _buildProductCard(MarketItem product) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(productId: product.name, productName: product.name))),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(12)), child: Image.network(product.imageUrl, height: 120, width: double.infinity, fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 2),
                  const SizedBox(height: 4),
                  Text(product.formattedPrice, style: TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star, size: 60, color: Colors.amber),
          const SizedBox(height: 16),
          Text('${widget.store.rating}', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('بناءً على ${widget.store.totalProducts} تقييم', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildInfoTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(Icons.store, 'اسم المتجر', widget.store.name),
          _buildInfoRow(Icons.category, 'الفئة', widget.store.category),
          _buildInfoRow(Icons.location_on, 'العنوان', widget.store.address),
          _buildInfoRow(Icons.phone, 'الهاتف', widget.store.phone),
          _buildInfoRow(Icons.access_time, 'ساعات العمل', widget.store.workingHours),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.goldColor, size: 20),
          const SizedBox(width: 12),
          SizedBox(width: 100, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
