import 'package:flutter/material.dart';
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
          _buildOfferCard(
            'خصم 50% على الإلكترونيات',
            'استخدم كود ELECTRO50',
            const Color(0xFF2196F3),
            Icons.devices,
          ),
          _buildOfferCard(
            'عرض VIP - خصم 25%',
            'للأعضاء الجدد فقط',
            const Color(0xFFD4AF37),
            Icons.workspace_premium,
          ),
          _buildOfferCard(
            'توصيل مجاني',
            'للطلبات فوق 500 ريال',
            const Color(0xFF0ECB81),
            Icons.local_shipping,
          ),
          _buildOfferCard(
            'عروض البرق',
            'خصومات تصل إلى 70%',
            const Color(0xFFF6465D),
            Icons.flash_on,
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCard(String title, String subtitle, Color color, IconData icon) {
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
            child: Icon(icon, color: color, size: 32),
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
          const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 16),
        ],
      ),
    );
  }
}
