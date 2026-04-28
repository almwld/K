import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';

class MallsSection extends StatelessWidget {
  final List<dynamic> malls;
  final dynamic selectedMall;
  final Function(dynamic) onMallSelected;
  final bool isDark;

  const MallsSection({
    super.key,
    required this.malls,
    required this.selectedMall,
    required this.onMallSelected,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'المعارض والمولات',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: malls.length,
            itemBuilder: (context, index) {
              final mall = malls[index];
              final isSelected = selectedMall?.id == mall.id;

              return GestureDetector(
                onTap: () => onMallSelected(isSelected ? null : mall),
                child: Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: isDark ? AppTheme.nightCard : AppTheme.lightCard,
                    borderRadius: BorderRadius.circular(16),
                    border: isSelected ? Border.all(color: AppTheme.gold, width: 2) : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: mall.imageUrl,
                        height: 40,
                        width: 40,
                        errorWidget: (_, __, ___) => const Icon(Icons.store, color: AppTheme.gold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        mall.name,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '${mall.storesCount} متجر',
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
