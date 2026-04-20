import "../utils/navigation_extensions.dart";
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/stock_badge.dart';

class NewArrivalsScreen extends StatelessWidget {
  const NewArrivalsScreen({super.key});

  List<ProductModel> get _newProducts => sampleProducts.where((p) => DateTime.now().difference(p.createdAt).inDays <= 3).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const SimpleAppBar(title: 'وصل حديثاً'),
      body: _newProducts.isEmpty
          ? const Center(child: Text('لا توجد منتجات جديدة'))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.65, crossAxisSpacing: 12, mainAxisSpacing: 12),
              itemCount: _newProducts.length,
              itemBuilder: (context, index) {
                final product = _newProducts[index];
                return GestureDetector(
                  onTap: () => Navigator.push(context, product.toDetailScreen()),
                  child: Container(decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(16)), child: Column(children: [Text(product.title)])),
                );
              },
            ),
    );
  }
}
