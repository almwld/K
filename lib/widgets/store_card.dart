import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2329),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF2B3139)),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFD4AF37).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.store, color: Color(0xFFD4AF37), size: 28),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          store['name'] as String,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (store['isOpen'] as bool) ? const Color(0xFF0ECB81) : const Color(0xFFF6465D),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    store['category'] as String,
                    style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text('${store['rating']}', style: const TextStyle(color: Colors.white, fontSize: 13)),
                      const Spacer(),
                      Text(
                        (store['isOpen'] as bool) ? 'مفتوح' : 'مغلق',
                        style: TextStyle(
                          color: (store['isOpen'] as bool) ? const Color(0xFF0ECB81) : const Color(0xFFF6465D),
                          fontSize: 11,
                        ),
                      ),
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
