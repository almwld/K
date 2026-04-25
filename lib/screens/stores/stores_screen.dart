import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/store_card.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCategory = 'الكل';

  final List<String> _categories = ['الكل', 'إلكترونيات', 'أزياء', 'سيارات', 'عقارات', 'أثاث', 'مطاعم'];

  final List<Map<String, dynamic>> _stores = [
    {'name': 'متجر التقنية', 'category': 'إلكترونيات', 'rating': 4.8, 'isOpen': true, 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200', 'products': 156},
    {'name': 'عالم الجوالات', 'category': 'إلكترونيات', 'rating': 4.7, 'isOpen': true, 'image': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=200', 'products': 234},
    {'name': 'الأزياء العصرية', 'category': 'أزياء', 'rating': 4.6, 'isOpen': true, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200', 'products': 456},
    {'name': 'معرض السيارات', 'category': 'سيارات', 'rating': 4.8, 'isOpen': true, 'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=200', 'products': 45},
    {'name': 'عقارات فلكس', 'category': 'عقارات', 'rating': 4.7, 'isOpen': true, 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=200', 'products': 45},
    {'name': 'أثاث المنزل', 'category': 'أثاث', 'rating': 4.5, 'isOpen': true, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200', 'products': 156},
    {'name': 'مطعم مندي الملكي', 'category': 'مطاعم', 'rating': 4.9, 'isOpen': true, 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200', 'products': 34},
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
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        backgroundColor: AppTheme.binanceDark,
        elevation: 0,
        title: const Text('المتاجر', style: TextStyle(color: Colors.white)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.binanceGold,
          unselectedLabelColor: const Color(0xFF9CA3AF),
          indicatorColor: AppTheme.binanceGold,
          tabs: const [
            Tab(text: 'جميع المتاجر'),
            Tab(text: 'الأعلى تقييماً'),
            Tab(text: 'مفتوحة الآن'),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _categories.length,
              itemBuilder: (_, i) {
                final cat = _categories[i];
                final selected = _selectedCategory == cat;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected ? AppTheme.binanceGold : AppTheme.binanceCard,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(cat, style: TextStyle(color: selected ? Colors.black : Colors.white, fontWeight: FontWeight.w500)),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _stores.length,
              itemBuilder: (_, i) => StoreCard(store: _stores[i], onTap: () {}),
            ),
          ),
        ],
      ),
    );
  }
}
