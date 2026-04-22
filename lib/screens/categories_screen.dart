import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = ['إلكترونيات', 'أزياء', 'سيارات', 'عقارات', 'أثاث', 'مطاعم', 'صحة وجمال', 'رياضة', 'كتب', 'ألعاب'];
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(title: const Text('الفئات', style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11)),
      body: GridView.builder(padding: const EdgeInsets.all(16), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.2), itemCount: categories.length, itemBuilder: (c, i) => Container(margin: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.category, color: const Color(0xFFD4AF37), size: 40), const SizedBox(height: 8), Text(categories[i], style: const TextStyle(color: Colors.white))]))),
    );
  }
}
