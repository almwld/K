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
  final _recentSearches = ['iPhone 15', 'ثوب يمني', 'ساعة رولكس', 'مندي'];
  final _popularSearches = ['سيارات 2025', 'إلكترونيات', 'عقارات صنعاء', 'مطاعم', 'ملابس'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(backgroundColor: const Color(0xFF0B0E11), elevation: 0, title: Container(height: 45, decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(25)), child: TextField(controller: _controller, autofocus: true, style: const TextStyle(color: Colors.white), decoration: InputDecoration(hintText: 'ابحث عن منتجات، متاجر...', hintStyle: const TextStyle(color: Color(0xFF9CA3AF)), prefixIcon: SvgPicture.asset('assets/icons/svg/search.svg', width: 20, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)), border: InputBorder.none, suffixIcon: _controller.text.isNotEmpty ? IconButton(icon: const Icon(Icons.clear, color: Color(0xFF9CA3AF)), onPressed: () { _controller.clear(); setState(() {}); }) : null)), onChanged: (_) => setState(() {}))), actions: [IconButton(icon: const Icon(Icons.tune, color: Color(0xFFD4AF37)), onPressed: () {})]),
      body: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (_recentSearches.isNotEmpty) ...[Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('عمليات البحث الأخيرة', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)), TextButton(onPressed: () => setState(() => _recentSearches.clear()), child: const Text('مسح', style: TextStyle(color: Color(0xFFF6465D))))]), const SizedBox(height: 8), Wrap(spacing: 8, runSpacing: 8, children: _recentSearches.map((s) => GestureDetector(onTap: () { _controller.text = s; setState(() {}); }, child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(25), border: Border.all(color: const Color(0xFF2B3139))), child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.history, color: Color(0xFF9CA3AF), size: 16), const SizedBox(width: 8), Text(s, style: const TextStyle(color: Colors.white))])))).toList()), const SizedBox(height: 24)],
        const Text('البحث الشائع', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)), const SizedBox(height: 12), Wrap(spacing: 8, runSpacing: 8, children: _popularSearches.map((s) => GestureDetector(onTap: () { _controller.text = s; setState(() {}); }, child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(25), border: Border.all(color: const Color(0xFF2B3139))), child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.trending_up, color: Color(0xFFD4AF37), size: 16), const SizedBox(width: 8), Text(s, style: const TextStyle(color: Colors.white))])))).toList()),
      ])),
    );
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }
}
