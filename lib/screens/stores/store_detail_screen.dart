import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';
import '../product/product_detail_screen.dart';
import '../chat/chat_screen.dart';

class StoreDetailScreen extends StatefulWidget {
  final String storeId;
  const StoreDetailScreen({super.key, required this.storeId});

  @override
  State<StoreDetailScreen> createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isFollowing = false;
  
  final Map<String, dynamic> _store = {
    'id': '1',
    'name': 'متجر التقنية',
    'category': 'إلكترونيات',
    'rating': 4.8,
    'reviews': 128,
    'followers': 1234,
    'products': 156,
    'isOpen': true,
    'address': 'شارع الستين، صنعاء',
    'phone': '777123456',
    'description': 'أفضل متجر إلكترونيات في اليمن، نقدم أحدث الأجهزة الإلكترونية والجوالات والكمبيوترات بأفضل الأسعار.',
    'coverImage': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=600',
    'logo': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200',
  };
  
  final List<Map<String, dynamic>> _products = [
    {'id': '1', 'name': 'iPhone 15 Pro', 'price': '350,000', 'oldPrice': '450,000', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=200', 'rating': 4.8, 'sales': 1250},
    {'id': '2', 'name': 'ساعة أبل الترا', 'price': '45,000', 'oldPrice': '60,000', 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=200', 'rating': 4.8, 'sales': 890},
    {'id': '3', 'name': 'ماك بوك برو', 'price': '1,800,000', 'oldPrice': '2,100,000', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=200', 'rating': 4.9, 'sales': 567},
    {'id': '4', 'name': 'سماعات ايربودز', 'price': '35,000', 'oldPrice': '50,000', 'image': 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=200', 'rating': 4.7, 'sales': 2340},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(child: _buildStoreInfo()),
          SliverToBoxAdapter(child: _buildStats()),
          SliverToBoxAdapter(child: _buildTabs()),
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

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: AppTheme.binanceDark,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: _store['coverImage'],
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: AppTheme.binanceCard),
            ),
            Container(color: Colors.black.withOpacity(0.3)),
          ],
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildStoreInfo() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.binanceGold, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: CachedNetworkImage(
                imageUrl: _store['logo'],
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppTheme.binanceCard),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _store['name'],
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  _store['category'],
                  style: const TextStyle(color: AppTheme.binanceGold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() => _isFollowing = !_isFollowing);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(_isFollowing ? 'تمت المتابعة' : 'تم إلغاء المتابعة'), backgroundColor: AppTheme.binanceGreen),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isFollowing ? AppTheme.binanceCard : AppTheme.binanceGold,
                        foregroundColor: _isFollowing ? AppTheme.binanceGold : Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text(_isFollowing ? 'متابع' : 'متابعة'),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen())),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.binanceGold),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text('تواصل', style: TextStyle(color: AppTheme.binanceGold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppTheme.cardGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('المنتجات', '${_store['products']}', AppTheme.binanceGold),
          _buildStatItem('المتابعون', '${_store['followers']}', AppTheme.binanceGreen),
          _buildStatItem('التقييم', '${_store['rating']}', Colors.amber),
          _buildStatItem('المراجعات', '${_store['reviews']}', AppTheme.serviceBlue),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: TabBar(
        controller: _tabController,
        labelColor: AppTheme.binanceGold,
        unselectedLabelColor: const Color(0xFF9CA3AF),
        indicatorColor: AppTheme.binanceGold,
        tabs: const [
          Tab(text: 'المنتجات'),
          Tab(text: 'التقييمات'),
          Tab(text: 'معلومات'),
        ],
      ),
    );
  }

  Widget _buildProductsTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(productId: _products[index]['id'] as String))),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.binanceCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.binanceBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: CachedNetworkImage(
                        imageUrl: _products[index]['image'],
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: AppTheme.binanceRed, borderRadius: BorderRadius.circular(4)),
                        child: Text('${((double.parse(_products[index]['price'].replaceAll(',', '')) - double.parse(_products[index]['oldPrice'].replaceAll(',', ''))) / double.parse(_products[index]['oldPrice'].replaceAll(',', '')) * 100).toStringAsFixed(0)}%', style: const TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_products[index]['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), maxLines: 1),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(_products[index]['price'], style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold, fontSize: 12)),
                        const SizedBox(width: 4),
                        Text(_products[index]['oldPrice'], style: const TextStyle(color: Color(0xFF5E6673), decoration: TextDecoration.lineThrough, fontSize: 10)),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 10, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text('${_products[index]['rating']}', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10)),
                        const Spacer(),
                        Text('${_products[index]['sales']}', style: const TextStyle(color: AppTheme.binanceGold, fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.binanceCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.binanceBorder),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/1.jpg'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('أحمد محمد', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Row(
                        children: List.generate(5, (i) => Icon(
                          i < 5 ? Icons.star : Icons.star_border,
                          size: 12,
                          color: Colors.amber,
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text('منتج رائع جداً وجودة ممتازة، أنصح به بشدة', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                  const SizedBox(height: 4),
                  const Text('منذ 3 أيام', style: TextStyle(color: Color(0xFF5E6673), fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('العنوان', _store['address'], Icons.location_on),
          _buildInfoRow('رقم الهاتف', _store['phone'], Icons.phone),
          _buildInfoRow('البريد الإلكتروني', 'info@store.com', Icons.email),
          _buildInfoRow('ساعات العمل', '9 صباحاً - 10 مساءً', Icons.access_time),
          const SizedBox(height: 16),
          const Text('عن المتجر', style: TextStyle(color: AppTheme.binanceGold, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(_store['description'], style: const TextStyle(color: Color(0xFF9CA3AF), height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.binanceGold, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                Text(value, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
