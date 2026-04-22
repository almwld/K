import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(title: const Text('استكشف أكثر', style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11)),
      body: GridView.builder(padding: const EdgeInsets.all(16), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.2), itemCount: 8, itemBuilder: (c, i) => Container(margin: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.explore, color: const Color(0xFFD4AF37), size: 40), const SizedBox(height: 8), Text('قسم ${i+1}', style: const TextStyle(color: Colors.white))]))),
    );
  }
}
