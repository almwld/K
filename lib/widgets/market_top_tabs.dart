import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

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
    'اكشف',
    'المتابعات',
    'رائج',
    'الاعلانات',
    'الاخبار',
    'الاكاديمية',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _tabs.map((tab) {
                  final isSelected = widget.selectedTab == tab;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: GestureDetector(
                      onTap: () => widget.onTabSelected(tab),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.goldColor.withOpacity(0.1) : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: isSelected ? AppTheme.goldColor : Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          tab,
                          style: TextStyle(
                            color: isSelected ? AppTheme.goldColor : Colors.grey.shade700,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.goldColor, AppTheme.goldDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.local_offer, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text('عروض حصرية', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
