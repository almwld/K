import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class AuctionsScreen extends StatefulWidget {
  const AuctionsScreen({super.key});

  @override
  State<AuctionsScreen> createState() => _AuctionsScreenState();
}

class _AuctionsScreenState extends State<AuctionsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _auctions = [
    {'title': 'ساعة رولكس', 'bid': '520,000', 'bids': 45, 'time': '2 أيام', 'image': 'watch'},
    {'title': 'لوحة فنية', 'bid': '225,000', 'bids': 18, 'time': '3 أيام', 'image': 'art'},
    {'title': 'عملة قديمة', 'bid': '115,000', 'bids': 32, 'time': '1 يوم', 'image': 'coin'},
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
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFFD4AF37),
          unselectedLabelColor: const Color(0xFF9CA3AF),
          indicatorColor: const Color(0xFFD4AF37),
          tabs: const [Tab(text: 'نشطة'), Tab(text: 'قريباً'), Tab(text: 'منتهية')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAuctionsList(_auctions),
          _buildAuctionsList([]),
          _buildAuctionsList([]),
        ],
      ),
    );
  }

  Widget _buildAuctionsList(List<Map<String, dynamic>> auctions) {
    if (auctions.isEmpty) {
      return const Center(child: Text('لا توجد مزادات', style: TextStyle(color: Color(0xFF9CA3AF))));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: auctions.length,
      itemBuilder: (context, index) {
        final a = auctions[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2329),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4AF37).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.gavel, color: Color(0xFFD4AF37)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(a['title'], style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('${a['bid']} ريال', style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6465D).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.timer, color: Color(0xFFF6465D), size: 14),
                        const SizedBox(width: 4),
                        Text(a['time'], style: const TextStyle(color: Color(0xFFF6465D), fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('زايد الآن', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
