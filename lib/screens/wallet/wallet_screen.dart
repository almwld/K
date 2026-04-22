import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        title: const Text('المحفظة', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // بطاقة الرصيد
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFD4AF37), Color(0xFFAA8C2C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text('رصيدك الحالي', style: TextStyle(color: Colors.black54, fontSize: 14)),
                  const SizedBox(height: 8),
                  const Text('12,500 ريال', style: TextStyle(color: Colors.black, fontSize: 36, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildActionButton(Icons.add, 'إيداع'),
                      const SizedBox(width: 24),
                      _buildActionButton(Icons.send, 'تحويل'),
                      const SizedBox(width: 24),
                      _buildActionButton(Icons.payment, 'دفع'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // الحركات الأخيرة
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2329),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('الحركات الأخيرة', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () {},
                        child: const Text('عرض الكل', style: TextStyle(color: Color(0xFFD4AF37))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildTransactionItem('شراء منتج', '- 350 ريال', Icons.shopping_cart, const Color(0xFFF6465D)),
                  _buildTransactionItem('إيداع', '+ 5,000 ريال', Icons.add_circle, const Color(0xFF0ECB81)),
                  _buildTransactionItem('تحويل', '- 1,000 ريال', Icons.send, const Color(0xFFF6465D)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.black, size: 24),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildTransactionItem(String title, String amount, IconData icon, Color color) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 18),
      ),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: Text(amount, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }
}
