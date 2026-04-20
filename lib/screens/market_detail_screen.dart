import 'package:flutter/material.dart';
import '../models/market_model.dart';
import '../models/market_model.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/market_table.dart';

class MarketDetailScreen extends StatelessWidget {
  final MarketModel market;

  const MarketDetailScreen({super.key, required this.market});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SimpleAppBar(title: market.nameAr),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          market.color.withOpacity(0.3),
                          market.color.withOpacity(0.1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: market.color.withOpacity(0.5)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: market.color.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                _getIconData(market.icon),
                                color: market.color,
                                size: 40,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    market.nameAr,
                                    style: const TextStyle(
                                      fontFamily: 'Changa',
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: market.changeColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      market.formattedChange,
                                      style: TextStyle(
                                        fontFamily: 'Changa',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: market.changeColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _statCard('المنتجات', '${market.items}'),
                            _statCard('البائعين', '${market.sellers}'),
                            _statCard('الحجم', market.volume),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Top Products
                  const Text(
                    'أفضل المنتجات',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: market.topProducts
                        .map((p) => _productChip(p))
                        .toList(),
                  ),
                  const SizedBox(height: 24),

                  // Other Markets
                  const Text(
                    'أسواق أخرى',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  MarketTable(
                    markets: mockMarkets.where((m) => m.id != market.id).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2329),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Changa',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF0B90B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF0B90B).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFF0B90B).withOpacity(0.3),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Changa',
          fontSize: 13,
          color: Color(0xFFF0B90B),
        ),
      ),
    );
  }

  IconData _getIconData(String icon) {
    switch (icon) {
      case 'store': return Icons.store;
      case 'shopping_bag': return Icons.shopping_bag;
      case 'restaurant': return Icons.restaurant;
      case 'hotel': return Icons.hotel;
      case 'devices': return Icons.devices;
      case 'apartment': return Icons.apartment;
      case 'directions_car': return Icons.directions_car;
      case 'checkroom': return Icons.checkroom;
      default: return Icons.store;
    }
  }
}
import '../models/market_model.dart';
