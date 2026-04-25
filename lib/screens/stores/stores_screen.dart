import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';
import 'store_detail_screen.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCategory = 'الكل';

  final List<String> _categories = ['الكل', 'إلكترونيات', 'مطاعم', 'أزياء', 'عقارات', 'خدمات'];

  final List<Map<String, dynamic>> _stores = [
    {'name': 'متجر التقنية', 'category': 'إلكترونيات', 'rating': 4.8, 'isOpen': true, 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200'},
    {'name': 'عالم الجوالات', 'category': 'إلكترونيات', 'rating': 4.7, 'isOpen': true, 'image': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=200'},
    {'name': 'كمبيوتر مول', 'category': 'إلكترونيات', 'rating': 4.9, 'isOpen': false, 'image': 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=200'},
    {'name': 'الأزياء العصرية', 'category': 'أزياء', 'rating': 4.6, 'isOpen': true, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200'},
    {'name': 'مطعم مندي الملكي', 'category': 'مطاعم', 'rating': 4.9, 'isOpen': true, 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200'},
    {'name': 'عقارات فلكس', 'category': 'عقارات', 'rating': 4.7, 'isOpen': true, 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=200'},
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
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        title: const Text('المتاجر', style: TextStyle(color: Colors.white)),
        actions: [IconButton(icon: SvgPicture.asset('assets/icons/svg/search.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)), onPressed: () {}), IconButton(icon: const Icon(Icons.filter_list, color: Color(0xFFD4AF37)), onPressed: () {})],
        bottom: TabBar(controller: _tabController, labelColor: const Color(0xFFD4AF37), unselectedLabelColor: const Color(0xFF9CA3AF), indicatorColor: const Color(0xFFD4AF37), tabs: const [Tab(text: 'جميع المتاجر'), Tab(text: 'الأعلى تقييماً'), Tab(text: 'مفتوحة الآن')]),
      ),
      body: Column(
        children: [
          Container(height: 50, margin: const EdgeInsets.symmetric(vertical: 8), child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: _categories.length, itemBuilder: (_, i) {
            final cat = _categories[i];
            final selected = _selectedCategory == cat;
            return GestureDetector(
              onTap: () => setState(() => _selectedCategory = cat),
              child: Container(margin: const EdgeInsets.only(right: 8), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: selected ? const Color(0xFFD4AF37) : const Color(0xFF1E2329), borderRadius: BorderRadius.circular(25)), child: Text(cat, style: TextStyle(color: selected ? Colors.black : Colors.white, fontWeight: FontWeight.w500))),
            );
          })),
          Expanded(
            child: ListView.builder(padding: const EdgeInsets.all(16), itemCount: _stores.length, itemBuilder: (_, i) {
              final store = _stores[i];
              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StoreDetailScreen(storeId: '$i'))),
                child: Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF2B3139))), child: Row(children: [
                  ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(store['image']!, width: 60, height: 60, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(width: 60, height: 60, color: const Color(0xFFD4AF37).withOpacity(0.1), child: SvgPicture.asset('assets/icons/svg/store.svg', width: 30, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn))))),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [Expanded(child: Text(store['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15))), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: (store['isOpen'] as bool) ? const Color(0xFF0ECB81).withOpacity(0.2) : const Color(0xFFF6465D).withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: Text((store['isOpen'] as bool) ? 'مفتوح' : 'مغلق', style: TextStyle(color: (store['isOpen'] as bool) ? const Color(0xFF0ECB81) : const Color(0xFFF6465D), fontSize: 10)))]),
                    const SizedBox(height: 4), Text(store['category']!, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                    const SizedBox(height: 6), Row(children: [const Icon(Icons.star, color: Colors.amber, size: 14), const SizedBox(width: 4), Text('${store['rating']}', style: const TextStyle(color: Colors.white, fontSize: 13)), const SizedBox(width: 8), Text('(${100 + i * 50}+ تقييم)', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 10))]),
                  ])),
                  const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 16),
                ])),
              );
            }),
          ),
        ],
      ),
    );
  }
}
