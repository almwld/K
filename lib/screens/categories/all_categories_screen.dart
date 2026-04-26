import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'إلكترونيات', 'icon': Icons.devices, 'color': Color(0xFF2196F3), 'count': '1,234'},
    {'name': 'أزياء', 'icon': Icons.checkroom, 'color': Color(0xFFE91E63), 'count': '2,456'},
    {'name': 'سيارات', 'icon': Icons.directions_car, 'color': Color(0xFFF6465D), 'count': '567'},
    {'name': 'عقارات', 'icon': Icons.home, 'color': Color(0xFF4CAF50), 'count': '345'},
    {'name': 'أثاث', 'icon': Icons.chair, 'color': Color(0xFFFF9800), 'count': '789'},
    {'name': 'مطاعم', 'icon': Icons.restaurant, 'color': Color(0xFF9C27B0), 'count': '456'},
    {'name': 'خدمات', 'icon': Icons.build, 'color': Color(0xFF00BCD4), 'count': '234'},
    {'name': 'صحة وجمال', 'icon': Icons.favorite, 'color': Color(0xFFE91E63), 'count': '567'},
    {'name': 'رياضة', 'icon': Icons.sports_soccer, 'color': Color(0xFF4CAF50), 'count': '345'},
    {'name': 'كتب', 'icon': Icons.menu_book, 'color': Color(0xFF795548), 'count': '1,234'},
    {'name': 'ألعاب', 'icon': Icons.sports_esports, 'color': Color(0xFF9C27B0), 'count': '456'},
    {'name': 'أطفال', 'icon': Icons.child_care, 'color': Color(0xFF2196F3), 'count': '789'},
    {'name': 'حيوانات', 'icon': Icons.pets, 'color': Color(0xFF8D6E63), 'count': '234'},
    {'name': 'مجوهرات', 'icon': Icons.diamond, 'color': Color(0xFFFFC107), 'count': '345'},
    {'name': 'ساعات', 'icon': Icons.watch, 'color': Color(0xFF607D8B), 'count': '456'},
    {'name': 'عطور', 'icon': Icons.emoji_emotions, 'color': Color(0xFFE91E63), 'count': '567'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        title: const Text('جميع الفئات', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.binanceDark,
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.binanceCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: (category['color'] as Color).withOpacity(0.3)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: (category['color'] as Color).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(category['icon'] as IconData, color: category['color'] as Color, size: 30),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    category['name'] as String,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${category['count']} منتج',
                    style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
