import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NearbyScreen extends StatelessWidget {
  const NearbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nearby = [{'name': 'متجر الذهبية', 'distance': '0.3', 'rating': 4.5}, {'name': 'متجر الكس', 'distance': '0.8', 'rating': 4.8}, {'name': 'متجر السيم', 'distance': '1.2', 'rating': 4.3}, {'name': 'مطعم النور', 'distance': '0.5', 'rating': 4.6}, {'name': 'سوبر ماركت السعادة', 'distance': '0.7', 'rating': 4.4}, {'name': 'صيدلية الحياة', 'distance': '1.0', 'rating': 4.7}];
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(title: const Text('بالقرب منك', style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11)),
      body: ListView.builder(padding: const EdgeInsets.all(16), itemCount: nearby.length, itemBuilder: (c, i) => Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: Row(children: [Container(width: 50, height: 50, decoration: BoxDecoration(color: const Color(0xFFD4AF37).withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.location_on, color: Color(0xFFD4AF37))), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(nearby[i]['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Row(children: [Text('${nearby[i]['distance']} كم', style: const TextStyle(color: Color(0xFF9CA3AF))), const SizedBox(width: 12), const Icon(Icons.star, size: 14, color: Colors.amber), const SizedBox(width: 4), Text('${nearby[i]['rating']}', style: const TextStyle(color: Color(0xFF9CA3AF)))])])), const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 16)]))),
    );
  }
}
