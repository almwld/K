import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  final _recent = ['iPhone 15', 'ثوب يمني', 'ساعة رولكس', 'مندي'];
  final _popular = ['سيارات 2025', 'إلكترونيات', 'عقارات صنعاء', 'مطاعم'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        title: Container(
          height: 45,
          decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(25)),
          child: TextField(
            controller: _controller,
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'ابحث عن منتجات، متاجر...',
              hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
              prefixIcon: const Icon(Icons.search, color: Color(0xFFD4AF37)),
              border: InputBorder.none,
              suffixIcon: _controller.text.isNotEmpty ? IconButton(icon: const Icon(Icons.clear, color: Color(0xFF9CA3AF)), onPressed: () { _controller.clear(); setState(() {}); }) : null,
            ),
            onChanged: (_) => setState(() {}),
          ),
        ),
        actions: [IconButton(icon: const Icon(Icons.tune, color: Color(0xFFD4AF37)), onPressed: () {})],
      ),
      body: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('عمليات البحث الأخيرة', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(spacing: 8, children: _recent.map((s) => Chip(label: Text(s, style: const TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF1E2329), deleteIcon: const Icon(Icons.close, size: 16, color: Color(0xFF9CA3AF)), onDeleted: () { setState(() => _recent.remove(s)); })).toList()),
        const SizedBox(height: 24),
        Text('البحث الشائع', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(spacing: 8, children: _popular.map((s) => ActionChip(label: Text(s, style: const TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF1E2329), onPressed: () { _controller.text = s; setState(() {}); })).toList()),
      ])),
    );
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }
}
