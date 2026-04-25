import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';

class StoreCard extends StatelessWidget {
  final Map<String, dynamic> store;
  final VoidCallback? onTap;

  const StoreCard({
    super.key,
    required this.store,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.binanceCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.binanceBorder),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: store['image'] as String,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppTheme.binanceCard),
                errorWidget: (_, __, ___) => Container(
                  width: 70, height: 70,
                  color: AppTheme.binanceGold.withOpacity(0.1),
                  child: Icon(Icons.store, color: AppTheme.binanceGold, size: 30),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(store['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: (store['isOpen'] as bool) ? AppTheme.binanceGreen.withOpacity(0.2) : AppTheme.binanceRed.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text((store['isOpen'] as bool) ? 'مفتوح' : 'مغلق', style: TextStyle(color: (store['isOpen'] as bool) ? AppTheme.binanceGreen : AppTheme.binanceRed, fontSize: 10)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(store['category'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text('${store['rating']}', style: const TextStyle(color: Colors.white, fontSize: 13)),
                      const SizedBox(width: 8),
                      Text('${store['products']} منتج', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 10)),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 16),
          ],
        ),
      ),
    );
  }
}
