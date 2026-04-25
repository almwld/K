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
    {'title': 'ساعة رولكس أصلية', 'bid': '520,000', 'bids': 45, 'time': 'ينتهي خلال 2 أيام', 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400'},
    {'title': 'لوحة فنية نادرة', 'bid': '225,000', 'bids': 18, 'time': 'ينتهي خلال 3 أيام', 'image': 'https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?w=400'},
    {'title': 'عملة قديمة', 'bid': '115,000', 'bids': 32, 'time': 'ينتهي خلال 1 يوم', 'image': 'https://images.unsplash.com/photo-1610375461246-83df859d849d?w=400'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        title: const Text('المزادات', style: TextStyle(color: Colors.white)),
        actions: [IconButton(icon: SvgPicture.asset('assets/icons/svg/search.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)), onPressed: () {}), IconButton(icon: SvgPicture.asset('assets/icons/svg/notification.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)), onPressed: () {})],
        bottom: TabBar(controller: _tabController, labelColor: const Color(0xFFD4AF37), unselectedLabelColor: const Color(0xFF9CA3AF), indicatorColor: const Color(0xFFD4AF37), tabs: const [Tab(text: 'نشطة'), Tab(text: 'قريباً'), Tab(text: 'منتهية')]),
      ),
      body: TabBarView(controller: _tabController, children: [
        _buildAuctionsList(),
        const Center(child: Text('لا توجد مزادات قادمة', style: TextStyle(color: Color(0xFF9CA3AF)))),
        const Center(child: Text('لا توجد مزادات منتهية', style: TextStyle(color: Color(0xFF9CA3AF)))),
      ]),
    );
  }

  Widget _buildAuctionsList() {
    return ListView.builder(padding: const EdgeInsets.all(16), itemCount: _auctions.length, itemBuilder: (_, i) {
      final a = _auctions[i];
      return Container(
        margin: const EdgeInsets.only(bottom: 16), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(16)), child: Image.network(a['image']!, height: 180, width: double.infinity, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(height: 180, color: const Color(0xFFD4AF37).withOpacity(0.1), child: Center(child: SvgPicture.asset('assets/icons/svg/auction.svg', width: 60, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)))))),
          Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [Expanded(child: Text(a['title']!, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFF6465D).withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: Row(children: [const Icon(Icons.timer, color: Color(0xFFF6465D), size: 14), const SizedBox(width: 4), Text(a['time']!, style: const TextStyle(color: Color(0xFFF6465D), fontSize: 12))]))]),
            const SizedBox(height: 12),
            Row(children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('السعر الحالي', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)), Text('${a['bid']} ريال', style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 22, fontWeight: FontWeight.bold))]), const Spacer(), Column(crossAxisAlignment: CrossAxisAlignment.end, children: [const Text('عدد المزايدات', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)), Text('${a['bids']}', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))])]),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('جاري المزايدة...'), backgroundColor: Color(0xFF0ECB81))), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('زايد الآن', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)))),
          ])),
        ]),
      );
    });
  }
}
