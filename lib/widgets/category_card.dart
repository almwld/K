import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';

class CategoryCard extends StatelessWidget {
  final Map<String, dynamic> category;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: category['image'] as String,
              height: 55,
              width: 55,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(height: 55, width: 55, color: AppTheme.binanceCard),
              errorWidget: (_, __, ___) => Container(
                height: 55, width: 55,
                color: (category['color'] as Color).withOpacity(0.2),
                child: Icon(category['icon'] as IconData, color: category['color'] as Color, size: 24),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            category['name'] as String,
            style: const TextStyle(color: Colors.white, fontSize: 10),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
