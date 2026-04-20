import 'package:flutter/material.dart';
import '../models/market_model.dart';
import '../theme/app_theme.dart';

class MarketTable extends StatelessWidget {
  final List<MarketModel> markets;
  final Function(MarketModel)? onMarketTap;

  const MarketTable({
    super.key,
    required this.markets,
    this.onMarketTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.nightCard
            : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFF0B90B).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF0B90B).withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                _headerText('السوق', flex: 3),
                _headerText('التغير', flex: 2),
                _headerText('الحجم', flex: 2),
                _headerText('المنتجات', flex: 2),
              ],
            ),
          ),
          // Rows
          ...markets.map((market) => _buildMarketRow(context, market)),
        ],
      ),
    );
  }

  Widget _headerText(String text, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Changa',
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Color(0xFF9CA3AF),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildMarketRow(BuildContext context, MarketModel market) {
    return InkWell(
      onTap: () => onMarketTap?.call(market),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor.withOpacity(0.1),
            ),
          ),
        ),
        child: Row(
          children: [
            // Market Name
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: market.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getIconData(market.icon),
                      color: market.color,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          market.nameAr,
                          style: const TextStyle(
                            fontFamily: 'Changa',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (market.isTrending)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0B90B).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'رائج',
                              style: TextStyle(
                                fontSize: 9,
                                color: Color(0xFFF0B90B),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Change
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: market.changeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  market.formattedChange,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Changa',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: market.changeColor,
                  ),
                ),
              ),
            ),
            // Volume
            Expanded(
              flex: 2,
              child: Text(
                market.volume,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 13,
                  color: Color(0xFF9CA3AF),
                ),
              ),
            ),
            // Items
            Expanded(
              flex: 2,
              child: Text(
                '${market.items}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
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
