import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        title: const Text('العروض والتخفيضات', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildOfferCard('خصم 50% على الإلكترونيات', 'استخدم كود ELECTRO50', const Color(0xFF2196F3), 'electronics'),
          _buildOfferCard('عرض VIP - خصم 25%', 'للأعضاء الجدد فقط', const Color(0xFFD4AF37), 'vip'),
          _buildOfferCard('توصيل مجاني', 'للطلبات فوق 500 ريال', const Color(0xFF0ECB81), 'shipping'),
          _buildOfferCard('عروض البرق', 'خصومات تصل إلى 70%', const Color(0xFFF6465D), 'discount'),
          _buildOfferCard('خصم 30% على المطاعم', 'استخدم كود FOOD30', const Color(0xFFFF9800), 'restaurants'),
          _buildOfferCard('عروض الجمعة', 'خصومات خاصة نهاية الأسبوع', const Color(0xFF9C27B0), 'sale'),
        ],
      ),
    );
  }

  Widget _buildOfferCard(String title, String subtitle, Color color, String icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.3), const Color(0xFF1E2329)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/icons/svg/$icon.svg',
              width: 32,
              height: 32,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('نسخ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
