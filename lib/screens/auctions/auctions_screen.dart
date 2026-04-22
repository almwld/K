import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class AuctionsScreen extends StatefulWidget {
  const AuctionsScreen({super.key});

  @override
  State<AuctionsScreen> createState() => _AuctionsScreenState();
}

class _AuctionsScreenState extends State<AuctionsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _activeAuctions = [
    {'title': 'ساعة رولكس أصلية', 'currentBid': '520,000', 'bids': 45, 'endTime': '2 أيام', 'image': 'watch'},
    {'title': 'لوحة فنية نادرة', 'currentBid': '225,000', 'bids': 18, 'endTime': '3 أيام', 'image': 'art'},
    {'title': 'عملة قديمة', 'currentBid': '115,000', 'bids': 32, 'endTime': '1 يوم', 'image': 'coin'},
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
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        backgroundColor: AppTheme.binanceDark,
        elevation: 0,
        title: const Text('المزادات', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppTheme.binanceGold),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: AppTheme.binanceGold),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.binanceGold,
          unselectedLabelColor: const Color(0xFF9CA3AF),
          indicatorColor: AppTheme.binanceGold,
          tabs: const [
            Tab(text: 'نشطة'),
            Tab(text: 'قريباً'),
            Tab(text: 'منتهية'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAuctionsList(_activeAuctions),
          _buildAuctionsList([]),
          _buildAuctionsList([]),
        ],
      ),
    );
  }

  Widget _buildAuctionsList(List<Map<String, dynamic>> auctions) {
    if (auctions.isEmpty) {
      return const Center(
        child: Text('لا توجد مزادات حالياً', style: TextStyle(color: Color(0xFF9CA3AF))),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: auctions.length,
      itemBuilder: (context, index) {
        final auction = auctions[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: AppTheme.binanceCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.binanceBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(
                  height: 180,
                  color: AppTheme.binanceGold.withOpacity(0.1),
                  child: Center(
                    child: Icon(Icons.gavel, color: AppTheme.binanceGold, size: 60),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            auction['title'],
                            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.binanceRed.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppTheme.binanceRed),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.timer, color: AppTheme.binanceRed, size: 14),
                              const SizedBox(width: 4),
                              Text(auction['endTime'], style: const TextStyle(color: AppTheme.binanceRed, fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('السعر الحالي', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                            Text(
                              '${auction['currentBid']} ريال',
                              style: const TextStyle(color: AppTheme.binanceGold, fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('عدد المزايدات', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                            Text(
                              '${auction['bids']}',
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.binanceGold,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('زايد الآن', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
