import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';

class AuctionsScreen extends StatefulWidget {
  const AuctionsScreen({super.key});

  @override
  State<AuctionsScreen> createState() => _AuctionsScreenState();
}

class _AuctionsScreenState extends State<AuctionsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _activeAuctions = [
    {
      'id': '1',
      'name': 'iPhone 15 Pro Max',
      'currentBid': '425,000',
      'startingBid': '350,000',
      'bids': 28,
      'endTime': DateTime.now().add(const Duration(hours: 2, minutes: 30, seconds: 45)),
      'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400',
      'seller': 'متجر التقنية',
      'rating': 4.9,
    },
    {
      'id': '2',
      'name': 'ساعة رولكس الفاخرة',
      'currentBid': '1,250,000',
      'startingBid': '850,000',
      'bids': 45,
      'endTime': DateTime.now().add(const Duration(hours: 5, minutes: 15, seconds: 20)),
      'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400',
      'seller': 'مجوهرات فلكس',
      'rating': 4.9,
    },
    {
      'id': '3',
      'name': 'لوحة فنية نادرة',
      'currentBid': '180,000',
      'startingBid': '120,000',
      'bids': 23,
      'endTime': DateTime.now().add(const Duration(hours: 1, minutes: 15, seconds: 10)),
      'image': 'https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?w=400',
      'seller': 'معرض الفن',
      'rating': 4.8,
    },
    {
      'id': '4',
      'name': 'عملة نادرة',
      'currentBid': '95,000',
      'startingBid': '50,000',
      'bids': 56,
      'endTime': DateTime.now().add(const Duration(hours: 8, minutes: 45, seconds: 30)),
      'image': 'https://images.unsplash.com/photo-1603119317534-81c56cd2c4b8?w=400',
      'seller': 'تحف فلكس',
      'rating': 4.7,
    },
  ];

  final List<Map<String, dynamic>> _upcomingAuctions = [
    {'name': 'ماك بوك برو M3', 'startingBid': '1,500,000', 'startDate': '2024-05-01', 'time': '10:00 ص', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400', 'seller': 'كمبيوتر مول'},
    {'name': 'كاميرا احترافية', 'startingBid': '350,000', 'startDate': '2024-05-05', 'time': '2:00 م', 'image': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=400', 'seller': 'كاميرات العالم'},
    {'name': 'سامسونج فولدر 5', 'startingBid': '600,000', 'startDate': '2024-05-08', 'time': '8:00 م', 'image': 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=400', 'seller': 'عالم الجوالات'},
  ];

  final List<Map<String, dynamic>> _endedAuctions = [
    {'name': 'سامسونج S24 Ultra', 'finalBid': '420,000', 'winner': 'أحمد محمد', 'date': '2024-04-20', 'image': 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=400', 'bids': 34},
    {'name': 'كنبة فاخرة', 'finalBid': '180,000', 'winner': 'خالد علي', 'date': '2024-04-18', 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400', 'bids': 23},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _animationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    _animationController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    
    if (days > 0) return '${days}d ${twoDigits(hours)}h';
    if (hours > 0) return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        backgroundColor: AppTheme.binanceDark,
        elevation: 0,
        title: const Text('المزادات', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: AppTheme.binanceGold),
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
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildActiveAuctions(),
            _buildUpcomingAuctions(),
            _buildEndedAuctions(),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveAuctions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _activeAuctions.length,
      itemBuilder: (context, index) => _buildAuctionCard(_activeAuctions[index]),
    );
  }

  Widget _buildAuctionCard(Map<String, dynamic> auction) {
    final endTime = auction['endTime'] as DateTime;
    final remaining = endTime.difference(DateTime.now());
    final isUrgent = remaining.inHours < 1;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF1E2329), Color(0xFF16213E)]),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isUrgent ? AppTheme.binanceRed.withOpacity(0.3) : AppTheme.binanceBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة المنتج
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: auction['image'] as String,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(height: 180, color: AppTheme.binanceCard),
                ),
              ),
              // شارة مزاد حي
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.binanceRed,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 4)],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 6),
                      const Text('مزاد حي', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              // مؤقت العد التنازلي
              Positioned(
                bottom: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.timer, color: AppTheme.binanceGold, size: 14),
                      const SizedBox(width: 6),
                      Text(
                        _formatDuration(remaining),
                        style: TextStyle(
                          color: isUrgent ? AppTheme.binanceRed : AppTheme.binanceGold,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  auction['name'] as String,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                
                // معلومات البائع
                Row(
                  children: [
                    const Icon(Icons.store, size: 12, color: AppTheme.binanceGold),
                    const SizedBox(width: 4),
                    Text(auction['seller'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
                    const Spacer(),
                    const Icon(Icons.star, size: 12, color: Colors.amber),
                    const SizedBox(width: 2),
                    Text('${auction['rating']}', style: const TextStyle(color: Colors.white, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 12),
                
                // السعر الحالي وعدد المزايدات
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('السعر الحالي', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
                          Text(
                            '${auction['currentBid']} ريال',
                            style: const TextStyle(color: AppTheme.binanceGold, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('المزايدات', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
                          Row(
                            children: [
                              const Icon(Icons.gavel, size: 14, color: AppTheme.binanceGold),
                              const SizedBox(width: 4),
                              Text('${auction['bids']}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('السعر المبدئي', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
                          Text('${auction['startingBid']} ريال', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // شريط التقدم
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${((int.parse(auction['currentBid'].toString().replaceAll(',', '')) - int.parse(auction['startingBid'].toString().replaceAll(',', ''))) / int.parse(auction['startingBid'].toString().replaceAll(',', '')) * 100).toStringAsFixed(0)}% من السعر المتوقع',
                          style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10),
                        ),
                        Text('${auction['startingBid']} ← ${auction['currentBid']}', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 10)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: (int.parse(auction['currentBid'].toString().replaceAll(',', '')) - int.parse(auction['startingBid'].toString().replaceAll(',', ''))) / int.parse(auction['startingBid'].toString().replaceAll(',', '')) / 2,
                        backgroundColor: AppTheme.binanceBorder,
                        color: AppTheme.binanceGold,
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // زر المزايدة
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _showBidDialog(auction),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.binanceGold,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('زايد الآن', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingAuctions() {
    if (_upcomingAuctions.isEmpty) {
      return _buildEmptyState('لا توجد مزادات قادمة', Icons.calendar_today);
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _upcomingAuctions.length,
      itemBuilder: (context, index) {
        final auction = _upcomingAuctions[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.binanceCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.binanceBorder),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: auction['image'] as String,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(auction['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('يبدأ من ${auction['startingBid']} ريال', style: const TextStyle(color: AppTheme.binanceGold)),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 12, color: Color(0xFF9CA3AF)),
                        const SizedBox(width: 4),
                        Text('${auction['startDate']} - ${auction['time']}', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
                      ],
                    ),
                    Text(auction['seller'] as String, style: const TextStyle(color: Color(0xFF5E6673), fontSize: 10)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.binanceGold.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('تذكير', style: TextStyle(color: AppTheme.binanceGold, fontSize: 12)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEndedAuctions() {
    if (_endedAuctions.isEmpty) {
      return _buildEmptyState('لا توجد مزادات منتهية', Icons.history);
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _endedAuctions.length,
      itemBuilder: (context, index) {
        final auction = _endedAuctions[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.binanceCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.binanceBorder),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: auction['image'] as String,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(auction['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('تم البيع بـ ${auction['finalBid']} ريال', style: const TextStyle(color: AppTheme.binanceGold, fontSize: 13)),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.emoji_events, size: 12, color: AppTheme.binanceGold),
                        const SizedBox(width: 4),
                        Text('الفائز: ${auction['winner']}', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
                      ],
                    ),
                    Text('${auction['bids']} مزايده - ${auction['date']}', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 10)),
                  ],
                ),
              ),
              const Icon(Icons.check_circle, color: AppTheme.binanceGreen, size: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: AppTheme.binanceGold.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text(message, style: const TextStyle(color: Color(0xFF9CA3AF))),
        ],
      ),
    );
  }

  void _showBidDialog(Map<String, dynamic> auction) {
    final TextEditingController bidController = TextEditingController();
    final currentBid = int.parse(auction['currentBid'].toString().replaceAll(',', ''));
    final minNextBid = currentBid + 5000;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.binanceCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppTheme.binanceBorder,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'المزايدة على المنتج',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    auction['name'] as String,
                    style: const TextStyle(color: AppTheme.binanceGold),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.binanceDark,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('السعر الحالي:', style: TextStyle(color: Color(0xFF9CA3AF))),
                        Text(
                          '${auction['currentBid']} ريال',
                          style: const TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.binanceDark,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('الحد الأدنى للمزايدة:', style: TextStyle(color: Color(0xFF9CA3AF))),
                        Text(
                          '$minNextBid ريال',
                          style: const TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: bidController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'أدخل قيمة المزايدة',
                      hintStyle: const TextStyle(color: Color(0xFF5E6673)),
                      prefixIcon: Icon(Icons.attach_money, color: AppTheme.binanceGold),
                      filled: true,
                      fillColor: AppTheme.binanceDark,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final bidValue = int.tryParse(bidController.text.replaceAll(',', '')) ?? 0;
                        if (bidValue >= minNextBid) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تم تقديم المزايدة بنجاح!'), backgroundColor: AppTheme.binanceGreen),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('يجب أن تكون المزايدة $minNextBid ريال على الأقل'),
                              backgroundColor: AppTheme.binanceRed,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.binanceGold,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('تأكيد المزايدة', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
