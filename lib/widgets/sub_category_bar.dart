import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SubCategoryBar extends StatelessWidget {
  final List<dynamic> subCategories;
  final dynamic selectedSubCategory;
  final Function(dynamic) onSubCategorySelected;
  final bool isDark;

  const SubCategoryBar({
    super.key,
    required this.subCategories,
    required this.selectedSubCategory,
    required this.onSubCategorySelected,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    if (subCategories.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 50,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: subCategories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            final isSelected = selectedSubCategory == null;
            return _buildChip('الكل', isSelected, () => onSubCategorySelected(null));
          }

          final sub = subCategories[index - 1];
          final isSelected = selectedSubCategory?.id == sub.id;
          return _buildChip(sub.name, isSelected, () => onSubCategorySelected(sub));
        },
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.gold.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.gold : Colors.grey.withOpacity(0.3),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? AppTheme.gold : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
