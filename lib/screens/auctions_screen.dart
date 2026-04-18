import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'auction_detail_screen.dart';

class AuctionsScreen extends StatefulWidget {
  const AuctionsScreen({super.key});

  @override
  State<AuctionsScreen> createState() => _AuctionsScreenState();
}

class _AuctionsScreenState extends State<AuctionsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCategory = 'الكل';
  
  final List<String> _categories = ['الكل', 'سيارات', 'تحف', 'عقارات', 'إلكترونيات', 'مجوهرات'];
  
  final List<Map<String, dynamic>> _auctions = [
    {
      'id': '1',
      'title': 'تويوتا كامري 2024',
      'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=300',
      'currentBid': 4500000,
      'startingBid': 4000000,
      'endTime': DateTime.now().add(const Duration(days: 2)),
      'bids': 23,
      'category': 'سيارات',
      'status': 'نشط',
    },
    {
      'id': '2',
      'title': 'سيف يمني تراثي',
      'image': 'https://images.unsplash.com/photo-1606760227091-3dd870d97f1d?w=300',
      'currentBid': 250000,
      'startingBid': 200000,
      'endTime': DateTime.now().add(const Duration(hours: 12)),
      'bids': 15,
      'category': 'تحف',
      'status': 'نشط',
    },
    {
      'id': '3',
      'title': 'فيلا في صنعاء',
      'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=300',
      'currentBid': 35000000,
      'startingBid': 30000000,
      'endTime': DateTime.now().add(const Duration(days: 5)),
      'bids': 8,
      'category': 'عقارات',
      'status': 'نشط',
    },
    {
      'id': '4',
      'title': 'iPhone 15 Pro Max',
      'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=300',
      'currentBid': 320000,
      'startingBid': 300000,
      'endTime': DateTime.now().add(const Duration(hours: 6)),
      'bids': 45,
      'category': 'إلكترونيات',
      'status': 'ينتهي قريباً',
    },
    {
      'id': '5',
      'title': 'ساعة رولكس',
      'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=300',
      'currentBid': 850000,
      'startingBid': 700000,
      'endTime': DateTime.now().add(const Duration(days: 3)),
      'bids': 31,
      'category': 'مجوهرات',
      'status': 'نشط',
    },
    {
      'id': '6',
      'title': 'أرض سكنية في تعز',
      'image': 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=300',
      'currentBid': 12000000,
      'startingBid': 10000000,
      'endTime': DateTime.now().add(const Duration(days: 7)),
      'bids': 12,
      'category': 'عقارات',
      'status': 'جديد',
    },
  ];

  List<Map<String, dynamic>> get _filteredAuctions {
    if (_selectedCategory == 'الكل') return _auctions;
    return _auctions.where((a) => a['category'] == _selectedCategory).toList();
  }

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
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المزادات'),
      body: Column(
        children: [
          _buildCategoriesFilter(),
          _buildTabs(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAuctionsList(),
                _buildMyBids(),
                _buildEndedAuctions(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesFilter() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = selected ? category : 'الكل';
                });
              },
              selectedColor: AppTheme.gold,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : null,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: AppTheme.gold,
        unselectedLabelColor: Theme.of(context).textTheme.bodyMedium!.color,
        indicator: BoxDecoration(
          color: AppTheme.gold.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        tabs: const [
          Tab(text: 'المزادات النشطة'),
          Tab(text: 'مزايداتي'),
          Tab(text: 'المنتهية'),
        ],
      ),
    );
  }

  Widget _buildAuctionsList() {
    final auctions = _filteredAuctions;
    
    if (auctions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.gavel, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'لا توجد مزادات في هذا القسم',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: auctions.length,
      itemBuilder: (context, index) {
        final auction = auctions[index];
        return _buildAuctionCard(auction);
      },
    );
  }

  Widget _buildAuctionCard(Map<String, dynamic> auction) {
    final remaining = auction['endTime'].difference(DateTime.now());
    final days = remaining.inDays;
    final hours = remaining.inHours % 24;
    final minutes = remaining.inMinutes % 60;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AuctionDetailScreen(auction: auction),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
              child: Image.network(
                auction['image'],
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      auction['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.attach_money, size: 16, color: Colors.green),
                        Text(
                          '${auction['currentBid']} ريال',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.people, size: 14),
                        const SizedBox(width: 4),
                        Text('${auction['bids']} مزايد'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(auction['status']).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.timer,
                            size: 14,
                            color: _getStatusColor(auction['status']),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            days > 0
                                ? '${days}يوم ${hours}ساعة'
                                : hours > 0
                                    ? '${hours}ساعة ${minutes}دقيقة'
                                    : '${minutes}دقيقة',
                            style: TextStyle(
                              color: _getStatusColor(auction['status']),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyBids() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.gavel, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text('لم تشارك في أي مزاد بعد'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              _tabController.animateTo(0);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.gold,
            ),
            child: const Text('استكشف المزادات'),
          ),
        ],
      ),
    );
  }

  Widget _buildEndedAuctions() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text('لا توجد مزادات منتهية'),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'ينتهي قريباً':
        return Colors.orange;
      case 'جديد':
        return Colors.green;
      default:
        return AppTheme.gold;
    }
  }
}
