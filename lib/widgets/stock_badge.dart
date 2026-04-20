import 'package:flutter/material.dart';

class StockBadge extends StatelessWidget {
  final int stock;
  final int? soldCount;

  const StockBadge({
    super.key,
    required this.stock,
    this.soldCount,
  });

  @override
  Widget build(BuildContext context) {
    if (stock <= 0) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFF6465D).withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.remove_circle, size: 14, color: Color(0xFFF6465D)),
            SizedBox(width: 4),
            Text(
              'نفذت الكمية',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF6465D),
              ),
            ),
          ],
        ),
      );
    }

    if (stock <= 5) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFF6465D).withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFF6465D).withOpacity(0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.warning, size: 14, color: Color(0xFFF6465D)),
            const SizedBox(width: 4),
            Text(
              'باقي $stock فقط!',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF6465D),
              ),
            ),
          ],
        ),
      );
    }

    if (soldCount != null && soldCount! > 50) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFF0ECB81).withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.local_fire_department, size: 14, color: Color(0xFFFF9800)),
            const SizedBox(width: 4),
            Text(
              'مبيعات ساخنة: $soldCount+',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF9800),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF0ECB81).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, size: 14, color: Colors.green[600]),
          const SizedBox(width: 4),
          Text(
            'متوفر ($stock)',
            style: TextStyle(
              fontSize: 12,
              color: Colors.green[600],
            ),
          ),
        ],
      ),
    );
  }
}
