import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'category_products_screen.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'عقارات', 'icon': Icons.home, 'color': 0xFF4CAF50, 'route': 'real_estate'},
    {'name': 'سيارات', 'icon': Icons.directions_car, 'color': 0xFF2196F3, 'route': 'cars'},
    {'name': 'إلكترونيات', 'icon': Icons.devices, 'color': 0xFFFF9800, 'route': 'electronics'},
    {'name': 'أزياء', 'icon': Icons.checkroom, 'color': 0xFFE91E63, 'route': 'fashion'},
    {'name': 'أثاث', 'icon': Icons.chair, 'color': 0xFF795548, 'route': 'furniture'},
    {'name': 'مطاعم', 'icon': Icons.restaurant, 'color': 0xFF9C27B0, 'route': 'restaurants'},
    {'name': 'خدمات', 'icon': Icons.build, 'color': 0xFF00BCD4, 'route': 'services'},
    {'name': 'ألعاب', 'icon': Icons.sports_esports, 'color': 0xFFE74C3C, 'route': 'games'},
    {'name': 'صحة وجمال', 'icon': Icons.favorite, 'color': 0xFFE91E63, 'route': 'health_beauty'},
    {'name': 'تعليم', 'icon': Icons.school, 'color': 0xFF3F51B5, 'route': 'education'},
    {'name': 'حيوانات', 'icon': Icons.pets, 'color': 0xFF8D6E63, 'route': 'pets'},
    {'name': 'رياضة', 'icon': Icons.sports_soccer, 'color': 0xFF4CAF50, 'route': 'sports'},
    {'name': 'كتب', 'icon': Icons.menu_book, 'color': 0xFF607D8B, 'route': 'books'},
    {'name': 'موسيقى', 'icon': Icons.music_note, 'color': 0xFF9C27B0, 'route': 'music'},
    {'name': 'أفلام', 'icon': Icons.movie, 'color': 0xFFE74C3C, 'route': 'movies'},
    {'name': 'سفر', 'icon': Icons.flight, 'color': 0xFF2196F3, 'route': 'travel'},
    {'name': 'وظائف', 'icon': Icons.work, 'color': 0xFF795548, 'route': 'jobs'},
    {'name': 'خدمات منزلية', 'icon': Icons.handyman, 'color': 0xFFFF9800, 'route': 'home_services'},
    {'name': 'معدات', 'icon': Icons.construction, 'color': 0xFF607D8B, 'route': 'equipment'},
    {'name': 'هدايا', 'icon': Icons.card_giftcard, 'color': 0xFFE91E63, 'route': 'gifts'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'جميع الأقسام'),
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
          final cat = _categories[index];
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/category/${cat['route']}'),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(cat['color']).withOpacity(0.3)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(cat['color']).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(cat['icon'], color: Color(cat['color']), size: 28),
                  ),
                  const SizedBox(height: 8),
                  Text(cat['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

