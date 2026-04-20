import 'package:flutter/material.dart';
import '../../extensions/product_extensions.dart';
import '../../extensions/product_extensions.dart';
import '../../theme/app_theme.dart';
import '../../models/market_model.dart';
import '../../models/product_model.dart';
import '../../widgets/market_table.dart';
import '../../widgets/vip_banner.dart';
import '../../widgets/countdown_timer.dart';
import '../../widgets/stock_badge.dart';
import '../market_detail_screen.dart';
import '../vip_subscription_screen.dart';
import '../flash_sale_screen.dart';
import '../new_arrivals_screen.dart';
import '../product_detail_screen.dart';
import '../search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'FLEX',
                  style: TextStyle(
                    fontFamily: 'Changa',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.gold,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'YEMEN',
                  style: TextStyle(
                    fontFamily: 'Changa',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.goldLight,
                  ),
                ),
              ],
            ),
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: AppTheme.gold),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SearchScreen()),
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // =================== VIP BANNER ===================
                VipBanner(
                  isCompact: true,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const VipSubscriptionScreen()),
                  ),
                ),
                const SizedBox(height: 20),

                // =================== MARKETS TABLE (Binance Style) ===================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الأسواق',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.getPrimaryTextColor(context),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0ECB81).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.trending_up, size: 14, color: Color(0xFF0ECB81)),
                          SizedBox(width: 4),
                          Text(
                            '+2.5%',
                            style: TextStyle(
                              fontFamily: 'Changa',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0ECB81),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                MarketTable(
                  markets: mockMarkets.take(5).toList(),
                  onMarketTap: (market) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MarketDetailScreen(market: market)),
                  ),
                ),
                const SizedBox(height: 24),

                // =================== FLASH SALE ===================
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FlashSaleScreen()),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF6465D), Color(0xFFFF6B6B)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.flash_on, color: Colors.white, size: 32),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'عروض البرق',
                                style: TextStyle(
                                  fontFamily: 'Changa',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                'خصومات تصل إلى 50%',
                                style: TextStyle(color: Colors.white70, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        const CountdownTimer(
                          duration: Duration(hours: 6),
                          showLabel: false,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // =================== NEW ARRIVALS ===================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'وصل حديثاً',
                          style: TextStyle(
                            fontFamily: 'Changa',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.getPrimaryTextColor(context),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF6465D),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'NEW',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const NewArrivalsScreen()),
                      ),
                      child: const Text(
                        'عرض الكل',
                        style: TextStyle(fontFamily: 'Changa', color: AppTheme.gold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: sampleProducts.take(5).length,
                    itemBuilder: (context, index) {
                      final product = sampleProducts[index];
                      return _buildNewArrivalCard(context, product);
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // =================== CATEGORIES ===================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الفئات',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.getPrimaryTextColor(context),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'عرض الكل',
                        style: TextStyle(fontFamily: 'Changa', color: AppTheme.gold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      _CategoryChip(label: 'الإلكترونيات', icon: Icons.devices),
                      _CategoryChip(label: 'الأزياء', icon: Icons.checkroom),
                      _CategoryChip(label: 'السيارات', icon: Icons.directions_car),
                      _CategoryChip(label: 'العقارات', icon: Icons.apartment),
                      _CategoryChip(label: 'المطاعم', icon: Icons.restaurant),
                      _CategoryChip(label: 'الفنادق', icon: Icons.hotel),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // =================== FEATURED PRODUCTS ===================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'منتجات مميزة',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.getPrimaryTextColor(context),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'عرض الكل',
                        style: TextStyle(fontFamily: 'Changa', color: AppTheme.gold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final product = sampleProducts[index % sampleProducts.length];
                    return _buildFeaturedProductCard(context, product);
                  },
                ),

                // =================== SAVE MORE ===================
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF0ECB81).withOpacity(0.3),
                        const Color(0xFF00C853).withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF0ECB81).withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0ECB81).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.savings,
                          color: Color(0xFF0ECB81),
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'وفر أكثر مع الجملة!',
                              style: TextStyle(
                                fontFamily: 'Changa',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'وفر 30%+ عند الشراء بكميات كبيرة',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          size: 16, color: Color(0xFF0ECB81)),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewArrivalCard(BuildContext context, ProductModel product) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen.fromProduct(product))),
      ),
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.nightCard
              : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    product.images.isNotEmpty ? product.images[0] : 'https://via.placeholder.com/300',
                    height: 110,
                    width: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6465D),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'جديد',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Changa',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.formattedPrice,
                    style: const TextStyle(
                      fontFamily: 'Changa',
                      color: AppTheme.gold,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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

  Widget _buildFeaturedProductCard(BuildContext context, ProductModel product) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen.fromProduct(product))),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.nightCard
              : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  product.images.isNotEmpty ? product.images[0] : 'https://via.placeholder.com/300',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Changa',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.formattedPrice,
                        style: const TextStyle(
                          fontFamily: 'Changa',
                          color: AppTheme.gold,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      StockBadge(stock: product.stock),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _CategoryChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: AppTheme.goldGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.black, size: 28),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Changa',
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
