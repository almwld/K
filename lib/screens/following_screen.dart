import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _followingStores = [
    {'id': '1', 'name': 'متجر التقنية', 'category': 'إلكترونيات', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200', 'newProducts': 3, 'lastUpdate': 'منذ ساعة'},
    {'id': '2', 'name': 'مطعم مندي الملكي', 'category': 'مطاعم', 'rating': 4.9, 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200', 'newProducts': 1, 'lastUpdate': 'منذ 3 ساعات'},
    {'id': '3', 'name': 'الأزياء العصرية', 'category': 'أزياء', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200', 'newProducts': 5, 'lastUpdate': 'اليوم'},
    {'id': '4', 'name': 'عطور الشرق', 'category': 'عطور', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=200', 'newProducts': 2, 'lastUpdate': 'منذ يوم'},
  ];

  final List<Map<String, dynamic>> _recommendedStores = [
    {'id': '5', 'name': 'كمبيوتر مول', 'category': 'إلكترونيات', 'rating': 4.9, 'image': 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=200', 'followers': '1.2K'},
    {'id': '6', 'name': 'صيدلية الحياة', 'category': 'صحة', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=200', 'followers': '890'},
    {'id': '7', 'name': 'سوبر ماركت السعادة', 'category': 'مواد غذائية', 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=200', 'followers': '2.3K'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        title: const Text('المتابعات', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.binanceDark,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'المتابَعة (4)'),
            Tab(text: 'اقتراحات لك'),
          ],
          labelColor: AppTheme.binanceGold,
          unselectedLabelColor: const Color(0xFF9CA3AF),
          indicatorColor: AppTheme.binanceGold,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFollowingList(),
          _buildRecommendationsList(),
        ],
      ),
    );
  }

  Widget _buildFollowingList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _followingStores.length,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.binanceCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.binanceBorder),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: _followingStores[index]['image'] as String,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppTheme.binanceCard),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _followingStores[index]['name'] as String,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      if (_followingStores[index]['newProducts'] as int > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: AppTheme.binanceRed, borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            '+${_followingStores[index]['newProducts']}',
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _followingStores[index]['category'] as String,
                    style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 2),
                      Text('${_followingStores[index]['rating']}', style: const TextStyle(color: Colors.white, fontSize: 12)),
                      const SizedBox(width: 12),
                      const Icon(Icons.access_time, size: 12, color: Color(0xFF5E6673)),
                      const SizedBox(width: 2),
                      Text(_followingStores[index]['lastUpdate'] as String, style: const TextStyle(color: Color(0xFF5E6673), fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  _followingStores.removeAt(index);
                });
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.binanceRed),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('إلغاء', style: TextStyle(color: AppTheme.binanceRed, fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _recommendedStores.length,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.binanceCard, const Color(0xFF1A2A44)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.binanceBorder),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: _recommendedStores[index]['image'] as String,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_recommendedStores[index]['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(_recommendedStores[index]['category'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 12, color: Colors.amber),
                      const SizedBox(width: 2),
                      Text('${_recommendedStores[index]['rating']}', style: const TextStyle(color: Colors.white, fontSize: 11)),
                      const SizedBox(width: 12),
                      const Icon(Icons.people, size: 12, color: Color(0xFF5E6673)),
                      const SizedBox(width: 2),
                      Text('${_recommendedStores[index]['followers']}', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تمت المتابعة'), backgroundColor: AppTheme.binanceGreen),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.binanceGold,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('متابعة', style: TextStyle(color: Colors.black, fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}
