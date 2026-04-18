import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../models/market_item.dart';

class MarketGridTable extends StatelessWidget {
  final List<MarketItem> items;
  final String filterType;
  final Function(MarketItem) onFavoriteToggle;

  const MarketGridTable({
    super.key,
    required this.items,
    required this.filterType,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('لا توجد بيانات'));
    }

    return Column(
      children: [
        _buildFilterTabs(),
        const SizedBox(height: 8),
        _buildTableHeader(),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildTableRow(item, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterTabs() {
    final filters = ['المفضلات', 'رائج', 'VIP', 'جديدة', 'الاعلى مبيعا'];
    
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final isSelected = filterType == filters[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              label: Text(filters[index], style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : Colors.black87)),
              selected: isSelected,
              onSelected: (_) {},
              backgroundColor: Colors.grey.shade100,
              selectedColor: AppTheme.gold,
              checkmarkColor: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: const Row(
        children: [
          Expanded(flex: 2, child: Text('الفئة / القسم', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          Expanded(flex: 2, child: Text('الاسم', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          Expanded(flex: 2, child: Text('% التغير 24س', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          Expanded(flex: 1, child: Text('اخر سعر', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildTableRow(MarketItem item, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: index.isEven ? Colors.white : Colors.grey.shade50,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(item.category, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12))),
          Expanded(flex: 2, child: Text(item.name, style: const TextStyle(fontSize: 12))),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Icon(
                  item.isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 14,
                  color: item.isPositive ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 4),
                Text(
                  item.formattedChange,
                  style: TextStyle(
                    color: item.isPositive ? Colors.green : Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              item.formattedPrice,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          IconButton(
            icon: Icon(
              item.isFavorite ? Icons.star : Icons.star_border,
              color: item.isFavorite ? Colors.amber : Colors.grey,
              size: 20,
            ),
            onPressed: () => onFavoriteToggle(item),
          ),
        ],
      ),
    );
  }
}
