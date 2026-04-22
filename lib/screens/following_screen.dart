import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'stores/store_detail_screen.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(title: const Text('المتابعات', style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11)),
      body: ListView.builder(padding: const EdgeInsets.all(16), itemCount: 10, itemBuilder: (c, i) => GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StoreDetailScreen(storeId: '$i'))),
        child: Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: Row(children: [Container(width: 50, height: 50, decoration: BoxDecoration(color: const Color(0xFFD4AF37).withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.store, color: Color(0xFFD4AF37))), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('متجر ${i+1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text('آخر تحديث: منتج جديد', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12))])), const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 16)])),
      )),
    );
  }
}
