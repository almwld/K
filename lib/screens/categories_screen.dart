import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  final List<String> categories = const ['إلكترونيات', 'منزل', 'أزياء', 'سيارات', 'العقارات', 'وظائف'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الفئات'),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.9, crossAxisSpacing: 12, mainAxisSpacing: 12),
        itemCount: categories.length,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/category', arguments: categories[i]),
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
              child: Center(child: Text(categories[i], textAlign: TextAlign.center)),
            ),
          );
        },
      ),
    );
  }
}
