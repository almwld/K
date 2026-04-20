import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class VipBanner extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isCompact;

  const VipBanner({
    super.key,
    this.onTap,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isCompact) {
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFF0B90B), Color(0xFFFFD700)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.diamond, size: 18, color: Colors.black),
              const SizedBox(width: 8),
              const Text(
                'ترقية إلى VIP',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black),
            ],
          ),
        ),
      );
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFF0B90B),
              Color(0xFFFFA000),
              Color(0xFFF0B90B),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 0.5, 1],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFF0B90B).withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.diamond, size: 28, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Flex Yemen VIP',
                        style: TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'وفر حتى 25% على مشترياتك',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _featureChip('خصم 25%'),
                const SizedBox(width: 8),
                _featureChip('شحن مجاني'),
                const SizedBox(width: 8),
                _featureChip('دعم VIP'),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'ترقية الآن - \$49.99/شهر',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF0B90B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
