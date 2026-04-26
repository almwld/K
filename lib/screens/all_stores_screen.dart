import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';

class AllStoresScreen extends StatefulWidget {
  const AllStoresScreen({super.key});

  @override
  State<AllStoresScreen> createState() => _AllStoresScreenState();
}

class _AllStoresScreenState extends State<AllStoresScreen> {
  List<Map<String, dynamic>> _stores = [
    {'id': '1', 'name': 'متجر التقنية', 'category': 'إلكترونيات', 'rating': 4.8, 'isFollowing': true, 'image': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200', 'products': 156},
    {'id': '2', 'name': 'مطعم مندي الملكي', 'category': 'مطاعم', 'rating': 4.9, 'isFollowing': true, 'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200', 'products': 34},
    {'id': '3', 'name': 'الأزياء العصرية', 'category': 'أزياء', 'rating': 4.6, 'isFollowing': true, 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200', 'products': 456},
    {'id': '4', 'name': 'عطور الشرق', 'category': 'عطور', 'rating': 4.8, 'isFollowing': true, 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=200', 'products': 89},
    {'id': '5', 'name': 'عقارات فلكس', 'category': 'عقارات', 'rating': 4.7, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=200', 'products': 45},
    {'id': '6', 'name': 'أثاث المنزل', 'category': 'أثاث', 'rating': 4.5, 'isFollowing': false, 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200', 'products': 156},
  ];

  void _toggleFollow(int index) {
    setState(() {
      _stores[index]['isFollowing'] = !_stores[index]['isFollowing'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_stores[index]['isFollowing'] ? 'تمت المتابعة' : 'تم إلغاء المتابعة'), backgroundColor: AppTheme.binanceGreen),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('جميع المتاجر', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _stores.length,
        itemBuilder: (context, index) => Container(
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
                  imageUrl: _stores[index]['image'],
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
                    Text(_stores[index]['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text(_stores[index]['category'], style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/svg/star_gold.svg', width: 12, height: 12),
                        const SizedBox(width: 2),
                        Text('${_stores[index]['rating']}', style: const TextStyle(color: Colors.white, fontSize: 11)),
                        const SizedBox(width: 12),
                        Text('${_stores[index]['products']} منتج', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => _toggleFollow(index),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _stores[index]['isFollowing'] ? AppTheme.binanceCard : AppTheme.binanceGold,
                  foregroundColor: _stores[index]['isFollowing'] ? AppTheme.binanceGold : Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: Text(_stores[index]['isFollowing'] ? 'متابع' : 'متابعة'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
