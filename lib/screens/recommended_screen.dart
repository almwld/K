import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'product/product_detail_screen.dart';

class RecommendedScreen extends StatelessWidget {
  const RecommendedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(title: const Text('موصى به لك', style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11)),
      body: GridView.builder(padding: const EdgeInsets.all(16), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7), itemCount: 8, itemBuilder: (c, i) => GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductDetailScreen(productId: ''))),
        child: Container(decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: Container(decoration: BoxDecoration(color: const Color(0xFFD4AF37).withOpacity(0.1), borderRadius: const BorderRadius.vertical(top: Radius.circular(12))), child: const Center(child: Icon(Icons.shopping_bag, color: Color(0xFFD4AF37), size: 40)))), Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('منتج ${i+1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text('${(i+1)*100} ريال', style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold))]))])),
      )),
    );
  }
}
