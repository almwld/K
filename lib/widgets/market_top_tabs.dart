import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';

class MarketTopTabs extends StatefulWidget {
  final Function(String) onTabSelected;
  final String selectedTab;

  const MarketTopTabs({
    super.key,
    required this.onTabSelected,
    required this.selectedTab,
  });

  @override
  State<MarketTopTabs> createState() => _MarketTopTabsState();
}

class _MarketTopTabsState extends State<MarketTopTabs> {
  final List<String> _tabs = [
    'اكتشف',
    'المتابعات',
    'رائج',
    'الاعلانات',
    'الاخبار',
    'مولات',
    'بقالة',
    'مزادات',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _tabs.map((tab) {
            final isSelected = widget.selectedTab == tab;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: GestureDetector(
                onTap: () => widget.onTabSelected(tab),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.gold.withOpacity(0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: isSelected ? AppTheme.gold : Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tab,
                    style: TextStyle(
                      color: isSelected ? AppTheme.gold : Colors.grey.shade700,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
