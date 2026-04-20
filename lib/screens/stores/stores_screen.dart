import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/market_model.dart';
import '../../widgets/simple_app_bar.dart';
import '../../widgets/market_table.dart';
import '../../data/stores_data.dart';
import '../../models/store_model.dart';
import 'store_detail_screen.dart';
import '../market_detail_screen.dart';

class StoresScreen extends StatefulWidget {
  final String? category;
  const StoresScreen({super.key, this.category});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<StoreModel> _stores = [];
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadStores();
  }

  void _loadStores() {
    if (widget.category != null) {
      _stores = StoresData.getStoresByCategory(widget.category!);
    } else {
      _stores = StoresData.getAllStores();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          widget.category ?? 'المتاجر والأسواق',
          style: const TextStyle(fontFamily: 'Changa'),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelStyle: const TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Changa'),
          indicatorColor: AppTheme.gold,
          labelColor: AppTheme.gold,
          tabs: const [
            Tab(text: 'المتاجر', icon: Icon(Icons.store)),
            Tab(text: 'الأسواق', icon: Icon(Icons.trending_up)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Stores Tab
          _buildStoresTab(),
          // Markets Tab
          _buildMarketsTab(),
        ],
      ),
    );
  }

  Widget _buildStoresTab() {
    return Column(
      children: [
        // Filter Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _filterChip('الكل', 'all'),
                const SizedBox(width: 8),
                _filterChip('الأكثر زيارة', 'popular'),
                const SizedBox(width: 8),
                _filterChip('الأعلى تقييماً', 'rating'),
                const SizedBox(width: 8),
                _filterChip('جديد', 'new'),
              ],
            ),
          ),
        ),
        // Stores List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: _stores.length,
            itemBuilder: (context, index) {
              final store = _stores[index];
              return _buildStoreCard(context, store);
            },
          ),
        ),
      ],
    );
  }

  Widget _filterChip(String label, String value) {
    final isSelected = _selectedFilter == value;
    return ChoiceChip(
      label: Text(label, style: const TextStyle(fontFamily: 'Changa', fontSize: 13)),
      selected: isSelected,
      onSelected: (_) => setState(() => _selectedFilter = value),
      selectedColor: AppTheme.gold,
      labelStyle: TextStyle(
        color: isSelected ? Colors.black : Colors.white,
        fontFamily: 'Changa',
      ),
    );
  }

  Widget _buildStoreCard(BuildContext context, StoreModel store) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.nightCard
            : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => StoreDetailScreen(store: store)),
        ),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  store.imageUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 70,
                    height: 70,
                    color: Colors.grey[800],
                    child: const Icon(Icons.store, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store.name,
                      style: const TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      store.address,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Color(0xFFF0B90B)),
                        const SizedBox(width: 4),
                        Text(
                          '${store.rating}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0ECB81).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'مفتوح',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF0ECB81),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF9CA3AF)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMarketsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Markets Overview
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF0B90B), Color(0xFFFFA000)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.trending_up, color: Colors.white, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'السوق اليمني',
                        style: TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        '+2.5% هذا الأسبوع',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Market Table
          MarketTable(
            markets: mockMarkets,
            onMarketTap: (market) => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MarketDetailScreen(market: market)),
            ),
          ),
        ],
      ),
    );
  }
}
