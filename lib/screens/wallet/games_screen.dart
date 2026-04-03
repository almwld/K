import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'الكل';
  final TextEditingController _searchController = TextEditingController();
  
  final List<String> _categories = ['الكل', 'شحن', 'بطاقات', 'عروض'];
  
  final List<Map<String, dynamic>> _games = [
    // PUBG Mobile
    {'name': 'ببجي - 60 UC', 'game': 'PUBG Mobile', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '1,200', 'currency': 'UC', 'category': 'شحن', 'discount': '0'},
    {'name': 'ببجي - 125 UC', 'game': 'PUBG Mobile', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '2,400', 'currency': 'UC', 'category': 'شحن', 'discount': '0'},
    {'name': 'ببجي - 325 UC', 'game': 'PUBG Mobile', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '6,000', 'currency': 'UC', 'category': 'شحن', 'discount': '5%'},
    {'name': 'ببجي - 660 UC', 'game': 'PUBG Mobile', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '12,000', 'currency': 'UC', 'category': 'شحن', 'discount': '10%'},
    {'name': 'ببجي - 1800 UC', 'game': 'PUBG Mobile', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '30,000', 'currency': 'UC', 'category': 'شحن', 'discount': '15%'},
    
    // Free Fire
    {'name': 'فري فاير - 100 دايموند', 'game': 'Free Fire', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '1,500', 'currency': 'دايموند', 'category': 'شحن', 'discount': '0'},
    {'name': 'فري فاير - 200 دايموند', 'game': 'Free Fire', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '3,000', 'currency': 'دايموند', 'category': 'شحن', 'discount': '0'},
    {'name': 'فري فاير - 500 دايموند', 'game': 'Free Fire', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '7,000', 'currency': 'دايموند', 'category': 'شحن', 'discount': '5%'},
    {'name': 'فري فاير - 1000 دايموند', 'game': 'Free Fire', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '13,500', 'currency': 'دايموند', 'category': 'شحن', 'discount': '10%'},
    {'name': 'فري فاير - 2000 دايموند', 'game': 'Free Fire', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '26,000', 'currency': 'دايموند', 'category': 'شحن', 'discount': '12%'},
    
    // Call of Duty
    {'name': 'كول أوف ديوتي - 80 CP', 'game': 'Call of Duty', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '1,800', 'currency': 'CP', 'category': 'شحن', 'discount': '0'},
    {'name': 'كول أوف ديوتي - 200 CP', 'game': 'Call of Duty', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '4,000', 'currency': 'CP', 'category': 'شحن', 'discount': '0'},
    {'name': 'كول أوف ديوتي - 500 CP', 'game': 'Call of Duty', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '9,500', 'currency': 'CP', 'category': 'شحن', 'discount': '5%'},
    {'name': 'كول أوف ديوتي - 1000 CP', 'game': 'Call of Duty', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '18,000', 'currency': 'CP', 'category': 'شحن', 'discount': '8%'},
    
    // Garena
    {'name': 'جارينا شل - 50', 'game': 'Garena', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '1,200', 'currency': 'شل', 'category': 'شحن', 'discount': '0'},
    {'name': 'جارينا شل - 100', 'game': 'Garena', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '2,200', 'currency': 'شل', 'category': 'شحن', 'discount': '0'},
    {'name': 'جارينا شل - 200', 'game': 'Garena', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '4,000', 'currency': 'شل', 'category': 'شحن', 'discount': '5%'},
    
    // Roblox
    {'name': 'روبلكس - 400', 'game': 'Roblox', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '2,500', 'currency': 'روبكس', 'category': 'شحن', 'discount': '0'},
    {'name': 'روبلكس - 800', 'game': 'Roblox', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '5,000', 'currency': 'روبكس', 'category': 'شحن', 'discount': '0'},
    {'name': 'روبلكس - 2000', 'game': 'Roblox', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '12,000', 'currency': 'روبكس', 'category': 'شحن', 'discount': '10%'},
    {'name': 'روبلكس - 4500', 'game': 'Roblox', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '25,000', 'currency': 'روبكس', 'category': 'شحن', 'discount': '12%'},
    
    // Minecraft
    {'name': 'ماينكرافت - نسخة جافا', 'game': 'Minecraft', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '15,000', 'currency': 'ريال', 'category': 'بطاقات', 'discount': '0'},
    {'name': 'ماينكرافت - نسخة بيدروك', 'game': 'Minecraft', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '12,000', 'currency': 'ريال', 'category': 'بطاقات', 'discount': '0'},
    
    // PlayStation
    {'name': 'بلاي ستيشن - 10$', 'game': 'PlayStation', 'image': 'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=200', 'price': '5,500', 'currency': 'ريال', 'category': 'بطاقات', 'discount': '0'},
    {'name': 'بلاي ستيشن - 20$', 'game': 'PlayStation', 'image': 'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=200', 'price': '10,500', 'currency': 'ريال', 'category': 'بطاقات', 'discount': '5%'},
    {'name': 'بلاي ستيشن - 50$', 'game': 'PlayStation', 'image': 'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=200', 'price': '25,000', 'currency': 'ريال', 'category': 'بطاقات', 'discount': '8%'},
    {'name': 'بلاي ستيشن - 100$', 'game': 'PlayStation', 'image': 'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=200', 'price': '48,000', 'currency': 'ريال', 'category': 'بطاقات', 'discount': '10%'},
    
    // Xbox
    {'name': 'إكس بوكس - 10$', 'game': 'Xbox', 'image': 'https://images.unsplash.com/photo-1621259182978-fbf93132d53d?w=200', 'price': '5,500', 'currency': 'ريال', 'category': 'بطاقات', 'discount': '0'},
    {'name': 'إكس بوكس - 25$', 'game': 'Xbox', 'image': 'https://images.unsplash.com/photo-1621259182978-fbf93132d53d?w=200', 'price': '13,000', 'currency': 'ريال', 'category': 'بطاقات', 'discount': '5%'},
    {'name': 'إكس بوكس - 50$', 'game': 'Xbox', 'image': 'https://images.unsplash.com/photo-1621259182978-fbf93132d53d?w=200', 'price': '25,000', 'currency': 'ريال', 'category': 'بطاقات', 'discount': '8%'},
    
    // Steam
    {'name': 'ستيم - 10$', 'game': 'Steam', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '5,500', 'currency': 'ريال', 'category': 'بطاقات', 'discount': '0'},
    {'name': 'ستيم - 20$', 'game': 'Steam', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '10,500', 'currency': 'ريال', 'category': 'بطاقات', 'discount': '5%'},
    {'name': 'ستيم - 50$', 'game': 'Steam', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '25,000', 'currency': 'ريال', 'category': 'بطاقات', 'discount': '8%'},
    {'name': 'ستيم - 100$', 'game': 'Steam', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '48,000', 'currency': 'ريال', 'category': 'بطاقات', 'discount': '10%'},
    
    // Nintendo
    {'name': 'ننتندو - 20$', 'game': 'Nintendo', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '11,000', 'currency': 'ريال', 'category': 'بطاقات', 'discount': '0'},
    {'name': 'ننتندو - 50$', 'game': 'Nintendo', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '26,000', 'currency': 'ريال', 'category': 'بطاقات', 'discount': '5%'},
    
    // League of Legends
    {'name': 'ليج أوف ليجندز - 1380 RP', 'game': 'League of Legends', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '3,000', 'currency': 'RP', 'category': 'شحن', 'discount': '0'},
    {'name': 'ليج أوف ليجندز - 2650 RP', 'game': 'League of Legends', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '5,500', 'currency': 'RP', 'category': 'شحن', 'discount': '5%'},
    {'name': 'ليج أوف ليجندز - 5350 RP', 'game': 'League of Legends', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '10,500', 'currency': 'RP', 'category': 'شحن', 'discount': '8%'},
    
    // Valorant
    {'name': 'فالورانت - 475 VP', 'game': 'Valorant', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '3,500', 'currency': 'VP', 'category': 'شحن', 'discount': '0'},
    {'name': 'فالورانت - 1000 VP', 'game': 'Valorant', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '7,000', 'currency': 'VP', 'category': 'شحن', 'discount': '5%'},
    {'name': 'فالورانت - 2050 VP', 'game': 'Valorant', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '13,500', 'currency': 'VP', 'category': 'شحن', 'discount': '8%'},
    
    // Fortnite
    {'name': 'فورتنايت - 1000 V-Bucks', 'game': 'Fortnite', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '4,000', 'currency': 'V-Bucks', 'category': 'شحن', 'discount': '0'},
    {'name': 'فورتنايت - 2800 V-Bucks', 'game': 'Fortnite', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '10,000', 'currency': 'V-Bucks', 'category': 'شحن', 'discount': '5%'},
    {'name': 'فورتنايت - 5000 V-Bucks', 'game': 'Fortnite', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '17,000', 'currency': 'V-Bucks', 'category': 'شحن', 'discount': '10%'},
    
    // Mobile Legends
    {'name': 'موبايل ليجندز - 50 دايموند', 'game': 'Mobile Legends', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '1,200', 'currency': 'دايموند', 'category': 'شحن', 'discount': '0'},
    {'name': 'موبايل ليجندز - 100 دايموند', 'game': 'Mobile Legends', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '2,200', 'currency': 'دايموند', 'category': 'شحن', 'discount': '0'},
    {'name': 'موبايل ليجندز - 250 دايموند', 'game': 'Mobile Legends', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '5,000', 'currency': 'دايموند', 'category': 'شحن', 'discount': '5%'},
    {'name': 'موبايل ليجندز - 500 دايموند', 'game': 'Mobile Legends', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '9,500', 'currency': 'دايموند', 'category': 'شحن', 'discount': '8%'},
    
    // Clash of Clans
    {'name': 'كلاش أوف كلانس - 500 جواهر', 'game': 'Clash of Clans', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '2,000', 'currency': 'جواهر', 'category': 'شحن', 'discount': '0'},
    {'name': 'كلاش أوف كلانس - 1200 جواهر', 'game': 'Clash of Clans', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '4,500', 'currency': 'جواهر', 'category': 'شحن', 'discount': '5%'},
    {'name': 'كلاش أوف كلانس - 2500 جواهر', 'game': 'Clash of Clans', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '8,500', 'currency': 'جواهر', 'category': 'شحن', 'discount': '8%'},
    {'name': 'كلاش أوف كلانس - 5000 جواهر', 'game': 'Clash of Clans', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '16,000', 'currency': 'جواهر', 'category': 'شحن', 'discount': '10%'},
    
    // Brawl Stars
    {'name': 'براول ستارز - 60 جواهر', 'game': 'Brawl Stars', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '1,000', 'currency': 'جواهر', 'category': 'شحن', 'discount': '0'},
    {'name': 'براول ستارز - 170 جواهر', 'game': 'Brawl Stars', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '2,500', 'currency': 'جواهر', 'category': 'شحن', 'discount': '5%'},
    {'name': 'براول ستارز - 360 جواهر', 'game': 'Brawl Stars', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '5,000', 'currency': 'جواهر', 'category': 'شحن', 'discount': '8%'},
    
    // عروض خاصة
    {'name': 'باقة الألعاب الشاملة', 'game': 'عرض خاص', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '50,000', 'currency': 'ريال', 'category': 'عروض', 'discount': '25%'},
    {'name': 'باقة ببجي الشهرية', 'game': 'عرض خاص', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '15,000', 'currency': 'ريال', 'category': 'عروض', 'discount': '20%'},
    {'name': 'باقة فري فاير الشهرية', 'game': 'عرض خاص', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '12,000', 'currency': 'ريال', 'category': 'عروض', 'discount': '15%'},
  ];

  List<Map<String, dynamic>> get _filteredGames {
    var games = _games;
    
    if (_selectedCategory != 'الكل') {
      games = games.where((g) => g['category'] == _selectedCategory).toList();
    }
    
    if (_searchQuery.isNotEmpty) {
      games = games.where((g) => 
        g['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
        g['game'].toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }
    
    return games;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final games = _filteredGames;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الألعاب'),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategories(),
          Expanded(
            child: games.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.games, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text('لا توجد ألعاب', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      final game = games[index];
                      return _buildGameCard(game);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'بحث عن لعبة...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchQuery = '';
                      _searchController.clear();
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppTheme.goldColor.withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppTheme.goldColor.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppTheme.goldColor, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric(vertical: 4),
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
              selectedColor: AppTheme.goldColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : null,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGameCard(Map<String, dynamic> game) {
    final discount = game['discount'] != '0' ? game['discount'] : null;
    final originalPrice = game['price'];
    int? discountedPrice;
    
    if (discount != null) {
      final discountPercent = int.parse(discount.replaceAll('%', ''));
      discountedPrice = int.parse(originalPrice) * (100 - discountPercent) ~/ 100;
    }

    return GestureDetector(
      onTap: () {
        _showPurchaseDialog(game);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getCardColor(context),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    game['image'],
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 120,
                      color: Colors.grey[300],
                      child: const Icon(Icons.games, size: 40),
                    ),
                  ),
                ),
                if (discount != null)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'خصم $discount',
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (discountedPrice != null) ...[
                        Text(
                          '$discountedPrice ${game['currency']}',
                          style: TextStyle(
                            color: AppTheme.goldColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${game['price']} ${game['currency']}',
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ] else ...[
                        Text(
                          '${game['price']} ${game['currency']}',
                          style: TextStyle(
                            color: AppTheme.goldColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.goldColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      game['game'],
                      style: TextStyle(color: AppTheme.goldColor, fontSize: 9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPurchaseDialog(Map<String, dynamic> game) {
    final discount = game['discount'] != '0' ? game['discount'] : null;
    final originalPrice = game['price'];
    int? discountedPrice;
    
    if (discount != null) {
      final discountPercent = int.parse(discount.replaceAll('%', ''));
      discountedPrice = int.parse(originalPrice) * (100 - discountPercent) ~/ 100;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('شحن ${game['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.games, size: 50, color: Colors.green),
            const SizedBox(height: 16),
            Text('اللعبة: ${game['game']}'),
            const SizedBox(height: 8),
            if (discountedPrice != null) ...[
              Text(
                'السعر الأصلي: ${game['price']} ${game['currency']}',
                style: const TextStyle(decoration: TextDecoration.lineThrough),
              ),
              Text(
                'السعر بعد الخصم: $discountedPrice ${game['currency']}',
                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ] else ...[
              Text('السعر: ${game['price']} ${game['currency']}'),
            ],
            const SizedBox(height: 16),
            const Text('سيتم إضافة الرصيد فوراً', style: TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog(game);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
            child: const Text('شحن الآن'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(Map<String, dynamic> game) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تم الشحن بنجاح'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('تم شحن ${game['name']}'),
            Text('بمبلغ ${game['price']} ${game['currency']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }
}
