import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ConsultationScreen extends StatelessWidget {
  const ConsultationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final items = [
      {'title': 'استشارة قانونية', 'desc': 'كيف يمكنني تسجيل علامتي التجارية؟', 'city': 'صنعاء', 'replies': '24', 'views': '1.2K', 'hot': true},
      {'title': 'استشارة تقنية', 'desc': 'أفضل منصة لإنشاء متجر إلكتروني؟', 'city': 'عدن', 'replies': '12', 'views': '567', 'hot': false},
      {'title': 'استشارة تسويقية', 'desc': 'كيف أزيد مبيعاتي في رمضان؟', 'city': 'تعز', 'replies': '45', 'views': '3.4K', 'hot': true},
    ];
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(title: const Text('الاستشارات', style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11)),
      body: ListView.builder(padding: const EdgeInsets.all(16), itemCount: items.length, itemBuilder: (_, i) {
        final title = items[i]['title'] as String;
        final desc = items[i]['desc'] as String;
        final city = items[i]['city'] as String;
        final replies = items[i]['replies'] as String;
        final views = items[i]['views'] as String;
        final hot = items[i]['hot'] as bool;
        return Container(
          margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(16)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))), if (hot) Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: const Color(0xFFF6465D).withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: const Text('رائجة', style: TextStyle(color: Color(0xFFF6465D), fontSize: 10)))]),
            const SizedBox(height: 8), Text(desc, style: const TextStyle(color: Color(0xFF9CA3AF))),
            const SizedBox(height: 8), Row(children: [const Icon(Icons.location_on, color: Color(0xFFD4AF37), size: 14), const SizedBox(width: 4), Text(city, style: const TextStyle(color: Color(0xFF5E6673), fontSize: 11)), const SizedBox(width: 16), const Icon(Icons.chat_bubble, color: Color(0xFFD4AF37), size: 14), const SizedBox(width: 4), Text('$replies رد', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 11)), const SizedBox(width: 16), const Icon(Icons.visibility, color: Color(0xFFD4AF37), size: 14), const SizedBox(width: 4), Text('$views مشاهدة', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 11))]),
          ]),
        );
      }),
    );
  }
}
