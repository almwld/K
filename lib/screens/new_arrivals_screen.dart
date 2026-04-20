import 'package:flutter/material.dart';
import '../utils/navigation_extensions.dart';
import '../models/product_model.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class NewArrivalsScreen extends StatelessWidget {
  const NewArrivalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const SimpleAppBar(title: 'وصل حديثاً'),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: sampleProducts.take(6).length,
        itemBuilder: (context, index) {
          final product = sampleProducts[index];
          return GestureDetector(
            onTap: () => product.navigateToDetail(context),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E2329),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.network(
                        product.images.isNotEmpty ? product.images[0] : '',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
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
