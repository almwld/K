import 'package:flutter/material.dart';

class SocialProof extends StatelessWidget {
  final int buyersCount;
  final double rating;
  final int reviewsCount;
  final String? extraText;
  final bool compact;

  const SocialProof({
    super.key,
    this.buyersCount = 0,
    this.rating = 0,
    this.reviewsCount = 0,
    this.extraText,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (buyersCount > 0) ...[
            Icon(Icons.people, size: 14, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              '$buyersCount تم شراؤه',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
          if (rating > 0) ...[
            const SizedBox(width: 8),
            Icon(Icons.star, size: 14, color: const Color(0xFFF0B90B)),
            const SizedBox(width: 2),
            Text(
              '$rating',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              ' ($reviewsCount)',
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            ),
          ],
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2329),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0B90B).withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Buyers
          if (buyersCount > 0) ...[
            _buildPulseDot(),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                '$buyersCount شخص اشترى هذا اليوم',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF0ECB81),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          // Rating
          if (rating > 0) ...[
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFF0B90B).withOpacity(0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, size: 14, color: Color(0xFFF0B90B)),
                  const SizedBox(width: 4),
                  Text(
                    '$rating',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF0B90B),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '($reviewsCount+) تقييم',
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            ),
          ],
          // Extra text
          if (extraText != null) ...[
            const SizedBox(width: 8),
            Text(
              extraText!,
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPulseDot() {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: Color(0xFF0ECB81),
        shape: BoxShape.circle,
      ),
    );
  }
}
