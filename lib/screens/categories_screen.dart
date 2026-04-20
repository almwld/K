import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, dynamic>> categories = [
      {'icon': Icons.devices, 'name': 'إلكترونيات', 'color': Colors.blue},
      {'icon': Icons.checkroom, 'name': 'أزياء', 'color': Colors.pink},
      {'icon': Icons.directions_car, 'name': 'سيارات', 'color': Colors.red},
      {'icon': Icons.home, 'name': 'عقارات', 'color': Colors.green},
      {'icon': Icons.chair, 'name': 'أثاث', 'color': Colors.orange},
      {'icon': Icons.phone_android, 'name': 'جوالات', 'color': Colors.purple},
      {'icon': Icons.computer, 'name': 'كمبيوتر', 'color': Colors.teal},
      {'icon': Icons.watch, 'name': 'ساعات', 'color': Colors.amber},
      {'icon': Icons.menu_book, 'name': 'كتب', 'color': Colors.brown},
      {'icon': Icons.sports_soccer, 'name': 'رياضة', 'color': Colors.indigo},
      {'icon': Icons.toys, 'name': 'ألعاب', 'color': Colors.cyan},
      {'icon': Icons.pets, 'name': 'حيوانات', 'color': Colors.deepOrange},
      {'icon': Icons.restaurant, 'name': 'مطاعم', 'color': Colors.redAccent},
      {'icon': Icons.local_grocery_store, 'name': 'بقالة', 'color': Colors.lightGreen},
      {'icon': Icons.health_and_safety, 'name': 'صحة', 'color': Colors.greenAccent.shade700},
      {'icon': Icons.spa, 'name': 'تجميل', 'color': Colors.pinkAccent},
      {'icon': Icons.card_giftcard, 'name': 'هدايا', 'color': Colors.purpleAccent},
      {'icon': Icons.handyman, 'name': 'خدمات', 'color': Colors.blueGrey},
      {'icon': Icons.flight, 'name': 'سياحة', 'color': Colors.lightBlue},
      {'icon': Icons.school, 'name': 'تعليم', 'color': Colors.indigoAccent},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('جميع الفئات'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.9,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final color = category['color'] as Color;
          
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('فتح فئة: ${category['name']}'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppTheme.nightCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: color.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      size: 32,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    category['name'] as String,
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.getTextColor(context),
                    ),
                    textAlign: TextAlign.center,
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

