import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class AuctionsScreen extends StatefulWidget {
  const AuctionsScreen({super.key});

  @override
  State<AuctionsScreen> createState() => _AuctionsScreenState();
}

class _AuctionsScreenState extends State<AuctionsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> auctions = [
    {
      'title': 'ساعة رولكس أصلية',
      'image': 'assets/images/watch.jpg',
      'currentPrice': 520000,
      'bids': 12,
      'timeLeft': '02:45:30',
      'seller': 'محمد علي',
      'isLive': true,
    },
    {
      'title': 'لوحة فنية نادرة',
      'image': 'assets/images/art.jpg',
      'currentPrice': 225000,
      'bids': 8,
      'timeLeft': '05:20:15',
      'seller': 'أحمد حسن',
      'isLive': false,
    },
    {
      'title': 'عملة قديمة نادرة',
      'image': 'assets/images/coin.jpg',
      'currentPrice': 5000,
      'bids': 25,
      'timeLeft': '23:59:59',
      'seller': 'خالد محمود',
      'isLive': true,
    },
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المزادات'),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: AppTheme.getCardColor(context),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppTheme.goldColor,
              labelColor: AppTheme.goldColor,
              unselectedLabelColor: AppTheme.getSecondaryTextColor(context),
              tabs: const [
                Tab(text: 'الجارية', icon: Icon(Icons.gavel)),
                Tab(text: 'القادمة', icon: Icon(Icons.schedule)),
                Tab(text: 'المكتملة', icon: Icon(Icons.check_circle)),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAuctionsList(),
                _buildUpcomingAuctions(),
                _buildCompletedAuctions(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createAuction(),
        backgroundColor: AppTheme.goldColor,
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text('إنشاء مزاد', style: TextStyle(color: Colors.black)),
      ),
    );
  }

  Widget _buildAuctionsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: auctions.length,
      itemBuilder: (context, index) {
        final auction = auctions[index];
        return _buildAuctionCard(auction);
      },
    );
  }

  Widget _buildAuctionCard(Map<String, dynamic> auction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Live Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  color: AppTheme.goldColor.withOpacity(0.1),
                  child: const Icon(Icons.image, size: 80, color: AppTheme.goldColor),
                ),
              ),
              if (auction['isLive'])
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ).animate(onPlay: (c) => c.repeat()).fadeIn(duration: 500.ms).fadeOut(duration: 500.ms),
                        const SizedBox(width: 6),
                        const Text(
                          'مباشر',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite_border, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        auction['title'],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.goldColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${auction['bids']} مزايد',
                        style: const TextStyle(color: AppTheme.goldColor, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'البائع: ${auction['seller']}',
                  style: TextStyle(color: AppTheme.getSecondaryTextColor(context)),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'السعر الحالي',
                            style: TextStyle(color: AppTheme.getSecondaryTextColor(context), fontSize: 12),
                          ),
                          Text(
                            '${auction['currentPrice']} ر.ي',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.goldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.timer, color: Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            auction['timeLeft'],
                            style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _showBidDialog(auction),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.goldColor,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('مزايدة الآن', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2, end: 0);
  }

  Widget _buildUpcomingAuctions() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.schedule, size: 80, color: AppTheme.goldColor.withOpacity(0.5)),
          const SizedBox(height: 16),
          const Text('المزادات القادمة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('سيتم إضافة المزادات قريباً', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
        ],
      ),
    );
  }

  Widget _buildCompletedAuctions() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, size: 80, color: AppTheme.goldColor.withOpacity(0.5)),
          const SizedBox(height: 16),
          const Text('المزادات المكتملة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('لا توجد مزادات مكتملة حالياً', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
        ],
      ),
    );
  }

  void _showBidDialog(Map<String, dynamic> auction) {
    final TextEditingController bidController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تقديم مزايدة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('السعر الحالي: ${auction['currentPrice']} ر.ي'),
            const SizedBox(height: 16),
            TextField(
              controller: bidController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'سعر المزايدة',
                suffixText: 'ر.ي',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم تقديم المزايدة بنجاح')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  void _createAuction() {
    // Navigate to create auction
  }
}
