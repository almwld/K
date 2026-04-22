import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'الكل';

  final List<String> _categories = ['الكل', 'إلكترونيات', 'مطاعم', 'أزياء', 'عقارات', 'خدمات'];

  // بيانات مؤقتة للمتاجر
  final List<Map<String, dynamic>> _stores = [
    {'name': 'متجر التقنية', 'category': 'إلكترونيات', 'rating': 4.8, 'isOpen': true, 'image': 'tech'},
    {'name': 'عالم الجوالات', 'category': 'إلكترونيات', 'rating': 4.7, 'isOpen': true, 'image': 'mobile'},
    {'name': 'كمبيوتر مول', 'category': 'إلكترونيات', 'rating': 4.9, 'isOpen': false, 'image': 'pc'},
    {'name': 'الأزياء العصرية', 'category': 'أزياء', 'rating': 4.6, 'isOpen': true, 'image': 'fashion'},
    {'name': 'موضة اليمن', 'category': 'أزياء', 'rating': 4.8, 'isOpen': true, 'image': 'fashion2'},
    {'name': 'مطعم مندي الملكي', 'category': 'مطاعم', 'rating': 4.9, 'isOpen': true, 'image': 'food'},
    {'name': 'عقارات فلكس', 'category': 'عقارات', 'rating': 4.7, 'isOpen': true, 'image': 'realestate'},
    {'name': 'أثاث المنزل', 'category': 'أثاث', 'rating': 4.5, 'isOpen': false, 'image': 'furniture'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredStores {
    if (_selectedCategory == 'الكل') return _stores;
    return _stores.where((s) => s['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        title: Container(
          height: 45,
          decoration: BoxDecoration(
            color: const Color(0xFF1E2329),
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'ابحث عن متجر...',
              hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
              prefixIcon: const Icon(Icons.search, color: Color(0xFFD4AF37)),
              border: InputBorder.none,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Color(0xFFD4AF37)),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFFD4AF37),
          unselectedLabelColor: const Color(0xFF9CA3AF),
          indicatorColor: const Color(0xFFD4AF37),
          tabs: const [
            Tab(text: 'جميع المتاجر'),
            Tab(text: 'الأعلى تقييماً'),
            Tab(text: 'مفتوحة الآن'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildStoresList(_filteredStores),
          _buildStoresList(_stores..sort((a, b) => (b['rating'] as double).compareTo(a['rating'] as double))),
          _buildStoresList(_stores.where((s) => s['isOpen'] == true).toList()),
        ],
      ),
    );
  }

  Widget _buildStoresList(List<Map<String, dynamic>> stores) {
    return Column(
      children: [
        // شريط الفئات الأفقي
        Container(
          height: 50,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = _selectedCategory == category;
              return GestureDetector(
                onTap: () => setState(() => _selectedCategory = category),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFD4AF37) : const Color(0xFF1E2329),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // قائمة المتاجر
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: stores.length,
            itemBuilder: (context, index) {
              final store = stores[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2329),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF2B3139)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4AF37).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.store, color: Color(0xFFD4AF37), size: 28),
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
                                  store['name'] as String,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                              ),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (store['isOpen'] as bool) ? const Color(0xFF0ECB81) : const Color(0xFFF6465D),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            store['category'] as String,
                            style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 14),
                              const SizedBox(width: 4),
                              Text('${store['rating']}', style: const TextStyle(color: Colors.white, fontSize: 13)),
                              const SizedBox(width: 8),
                              Text(
                                (store['isOpen'] as bool) ? 'مفتوح' : 'مغلق',
                                style: TextStyle(
                                  color: (store['isOpen'] as bool) ? const Color(0xFF0ECB81) : const Color(0xFFF6465D),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 16),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
