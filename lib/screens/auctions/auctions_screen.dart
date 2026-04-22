import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';

class AuctionsScreen extends StatefulWidget {
  const AuctionsScreen({super.key});
  @override
  State<AuctionsScreen> createState() => _AuctionsScreenState();
}

class _AuctionsScreenState extends State<AuctionsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _auctions = [
    {'title': 'ساعة رولكس', 'bid': '520,000', 'bids': 45, 'time': '2 أيام'},
    {'title': 'لوحة فنية', 'bid': '225,000', 'bids': 18, 'time': '3 أيام'},
    {'title': 'عملة قديمة', 'bid': '115,000', 'bids': 32, 'time': '1 يوم'},
    {'title': 'سيارة كلاسيكية', 'bid': '2,500,000', 'bids': 67, 'time': '5 أيام'},
  ];

  @override
  void initState() { super.initState(); _tabController = TabController(length: 3, vsync: this); }
  @override
  void dispose() { _tabController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(title: const Text('المزادات', style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11), bottom: TabBar(controller: _tabController, labelColor: const Color(0xFFD4AF37), unselectedLabelColor: const Color(0xFF9CA3AF), indicatorColor: const Color(0xFFD4AF37), tabs: const [Tab(text: 'نشطة'), Tab(text: 'قريباً'), Tab(text: 'منتهية')])),
      body: TabBarView(controller: _tabController, children: [_buildAuctionsList(_auctions), _buildAuctionsList([]), _buildAuctionsList([])]),
    );
  }

  Widget _buildAuctionsList(List<Map<String, dynamic>> auctions) {
    if (auctions.isEmpty) return const Center(child: Text('لا توجد مزادات', style: TextStyle(color: Color(0xFF9CA3AF))));
    return ListView.builder(padding: const EdgeInsets.all(16), itemCount: auctions.length, itemBuilder: (c, i) => Container(margin: const EdgeInsets.only(bottom: 16), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(16)), child: Column(children: [
      Row(children: [Container(width: 60, height: 60, decoration: BoxDecoration(color: const Color(0xFFD4AF37).withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: SvgPicture.asset('assets/icons/svg/auction.svg', width: 30, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn))), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(auctions[i]['title']!, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)), Text('${auctions[i]['bid']} ريال', style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 18, fontWeight: FontWeight.bold))])), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFF6465D).withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Row(children: [const Icon(Icons.timer, color: Color(0xFFF6465D), size: 14), const SizedBox(width: 4), Text(auctions[i]['time']!, style: const TextStyle(color: Color(0xFFF6465D), fontSize: 12))]))]),
      const SizedBox(height: 16),
      Row(children: [Row(children: [SvgPicture.asset('assets/icons/svg/users.svg', width: 16, colorFilter: const ColorFilter.mode(Color(0xFF9CA3AF), BlendMode.srcIn)), const SizedBox(width: 4), Text('${auctions[i]['bids']} مزايدة', style: const TextStyle(color: Color(0xFF9CA3AF)))]), const Spacer(), ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('زايد الآن', style: TextStyle(fontWeight: FontWeight.bold)))])])));
  }
}
