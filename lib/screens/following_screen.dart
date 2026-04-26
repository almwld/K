import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  String _selectedCategory = 'الكل';
  
  final List<String> _categories = ['الكل', 'إلكترونيات', 'مطاعم', 'أزياء', 'عطور', 'عقارات', 'أثاث', 'سيارات'];
  
  // متاجر متخصصة لكل فئة
  final List<Map<String, dynamic>> _allStores = [
    // إلكترونيات (5 متاجر)
    {'id': '1', 'name': 'متجر التقنية', 'category': 'إلكترونيات', 'rating': 4.8, 'isFollowing': true, 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200', 'products': 156, 'description': 'أحدث الأجهزة الإلكترونية'},
    {'id': '2', 'name': 'عالم الجوالات', 'category': 'إلكترونيات', 'rating': 4.7, 'isFollowing': true, 'image': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=200', 'products': 234, 'description': 'جوالات حديثة'},
    {'id': '3', 'name': 'كمبيوتر مول', 'category': 'إلكترونيات', 'rating': 4.9, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=200', 'products': 89, 'description': 'أجهزة كمبيوتر'},
    {'id': '4', 'name': 'سماعات العالم', 'category': 'إلكترونيات', 'rating': 4.6, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=200', 'products': 45, 'description': 'سماعات احترافية'},
    {'id': '5', 'name': 'كاميرات ديجيتال', 'category': 'إلكترونيات', 'rating': 4.8, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=200', 'products': 67, 'description': 'كاميرات تصوير'},
    
    // مطاعم (5 متاجر)
    {'id': '6', 'name': 'مطعم مندي الملكي', 'category': 'مطاعم', 'rating': 4.9, 'isFollowing': true, 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200', 'products': 34, 'description': 'أشهى المأكولات اليمنية'},
    {'id': '7', 'name': 'مطعم فلكس', 'category': 'مطاعم', 'rating': 4.7, 'isFollowing': true, 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200', 'products': 56, 'description': 'مأكولات عالمية'},
    {'id': '8', 'name': 'بيتزا هت', 'category': 'مطاعم', 'rating': 4.5, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=200', 'products': 23, 'description': 'بيتزا إيطالية'},
    {'id': '9', 'name': 'مطعم السمك اليمني', 'category': 'مطاعم', 'rating': 4.8, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=200', 'products': 45, 'description': 'مأكولات بحرية طازجة'},
    {'id': '10', 'name': 'مطعم البخاري', 'category': 'مطاعم', 'rating': 4.6, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1589302168068-964664d4f9a8?w=200', 'products': 34, 'description': 'أطباق بخارية'},
    
    // أزياء (5 متاجر)
    {'id': '11', 'name': 'الأزياء العصرية', 'category': 'أزياء', 'rating': 4.6, 'isFollowing': true, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200', 'products': 456, 'description': 'أحدث صيحات الموضة'},
    {'id': '12', 'name': 'موضة اليمن', 'category': 'أزياء', 'rating': 4.8, 'isFollowing': true, 'image': 'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=200', 'products': 234, 'description': 'ملابس يمنية تقليدية'},
    {'id': '13', 'name': 'العبايات الفاخرة', 'category': 'أزياء', 'rating': 4.7, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1583394293214-ff7b3f5ad7cc?w=200', 'products': 89, 'description': 'عبايات راقية'},
    {'id': '14', 'name': 'أحذية كلاسيك', 'category': 'أزياء', 'rating': 4.5, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=200', 'products': 123, 'description': 'أحذية فاخرة'},
    {'id': '15', 'name': 'شنط ماركات', 'category': 'أزياء', 'rating': 4.7, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=200', 'products': 67, 'description': 'شنط أصلية'},
    
    // عطور (5 متاجر)
    {'id': '16', 'name': 'عطور الشرق', 'category': 'عطور', 'rating': 4.8, 'isFollowing': true, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=200', 'products': 89, 'description': 'عطور عربية فاخرة'},
    {'id': '17', 'name': 'العود الملكي', 'category': 'عطور', 'rating': 4.9, 'isFollowing': true, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=200', 'products': 45, 'description': 'دهن عود أصلي'},
    {'id': '18', 'name': 'مسك الختام', 'category': 'عطور', 'rating': 4.7, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=200', 'products': 34, 'description': 'عطور مسكية'},
    {'id': '19', 'name': 'عطور فرنسية', 'category': 'عطور', 'rating': 4.6, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=200', 'products': 56, 'description': 'ماركات عالمية'},
    {'id': '20', 'name': 'بخور وعود', 'category': 'عطور', 'rating': 4.8, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=200', 'products': 78, 'description': 'بخور فاخر'},
    
    // عقارات (5 متاجر)
    {'id': '21', 'name': 'عقارات فلكس', 'category': 'عقارات', 'rating': 4.7, 'isFollowing': true, 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=200', 'products': 45, 'description': 'عقارات مميزة'},
    {'id': '22', 'name': 'البيت السعيد', 'category': 'عقارات', 'rating': 4.6, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=200', 'products': 34, 'description': 'شقق سكنية'},
    {'id': '23', 'name': 'أراضي اليمن', 'category': 'عقارات', 'rating': 4.5, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=200', 'products': 23, 'description': 'أراضي للبيع'},
    {'id': '24', 'name': 'فلل فاخرة', 'category': 'عقارات', 'rating': 4.8, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=200', 'products': 12, 'description': 'فلل راقية'},
    {'id': '25', 'name': 'مكاتب تجارية', 'category': 'عقارات', 'rating': 4.7, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=200', 'products': 34, 'description': 'مساحات مكتبية'},
    
    // أثاث (5 متاجر)
    {'id': '26', 'name': 'أثاث المنزل', 'category': 'أثاث', 'rating': 4.5, 'isFollowing': true, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200', 'products': 156, 'description': 'أثاث منزلي'},
    {'id': '27', 'name': 'مجالس عربية', 'category': 'أثاث', 'rating': 4.8, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200', 'products': 45, 'description': 'مجالس تقليدية'},
    {'id': '28', 'name': 'غرف نوم فاخرة', 'category': 'أثاث', 'rating': 4.7, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=200', 'products': 34, 'description': 'غرف نوم راقية'},
    {'id': '29', 'name': 'مطابخ حديثة', 'category': 'أثاث', 'rating': 4.6, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1556909114-44e3ef1e0d71?w=200', 'products': 56, 'description': 'مطابخ عصرية'},
    {'id': '30', 'name': 'إضاءة ديكور', 'category': 'أثاث', 'rating': 4.5, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1565814636199-ae8133055c1c?w=200', 'products': 78, 'description': 'ثريات وإضاءة'},
    
    // سيارات (5 متاجر)
    {'id': '31', 'name': 'معرض السيارات الحديثة', 'category': 'سيارات', 'rating': 4.8, 'isFollowing': true, 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=200', 'products': 45, 'description': 'سيارات جديدة'},
    {'id': '32', 'name': 'قطع غيار السيارات', 'category': 'سيارات', 'rating': 4.6, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=200', 'products': 234, 'description': 'قطع غيار أصلية'},
    {'id': '33', 'name': 'اطارات وباترية', 'category': 'سيارات', 'rating': 4.5, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=200', 'products': 89, 'description': 'إطارات وبطاريات'},
    {'id': '34', 'name': 'زيت وتشحيم', 'category': 'سيارات', 'rating': 4.7, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=200', 'products': 45, 'description': 'زيوت محركات'},
    {'id': '35', 'name': 'سيارات مستعملة', 'category': 'سيارات', 'rating': 4.5, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=200', 'products': 67, 'description': 'سيارات بأسعار منافسة'},
  ];

  List<Map<String, dynamic>> get _filteredStores {
    if (_selectedCategory == 'الكل') {
      return _allStores;
    }
    return _allStores.where((s) => s['category'] == _selectedCategory).toList();
  }

  void _toggleFollow(int index) {
    setState(() {
      _allStores[index]['isFollowing'] = !_allStores[index]['isFollowing'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_allStores[index]['isFollowing'] ? 'تمت المتابعة' : 'تم إلغاء المتابعة'), backgroundColor: AppTheme.binanceGreen),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filteredStores = _filteredStores;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('المتابعات', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      ),
      body: Column(
        children: [
          // فلتر الفئات
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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: isSelected ? AppTheme.goldGradient : null,
                      color: isSelected ? null : AppTheme.binanceCard,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: isSelected ? Colors.transparent : AppTheme.binanceBorder),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
              itemCount: filteredStores.length,
              itemBuilder: (context, index) {
                final store = filteredStores[index];
                final originalIndex = _allStores.indexWhere((s) => s['id'] == store['id']);
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? AppTheme.binanceCard : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.binanceBorder),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: store['image'],
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
                            Text(store['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            Text(store['description'], style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                SvgPicture.asset('assets/icons/svg/star_gold.svg', width: 12, height: 12),
                                const SizedBox(width: 2),
                                Text('${store['rating']}', style: const TextStyle(color: Colors.white, fontSize: 11)),
                                const SizedBox(width: 12),
                                Text('${store['products']} منتج', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 10)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _toggleFollow(originalIndex),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: store['isFollowing'] ? AppTheme.binanceCard : AppTheme.binanceGold,
                          foregroundColor: store['isFollowing'] ? AppTheme.binanceGold : Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text(store['isFollowing'] ? 'متابع' : 'متابعة'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
