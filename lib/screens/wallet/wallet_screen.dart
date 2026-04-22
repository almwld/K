import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/icons/svg/qr.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)),
            onPressed: () {},
          ),
        ],
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
                      _buildActionButton('deposit', 'إيداع'),
                      const SizedBox(width: 24),
                      _buildActionButton('transfer', 'تحويل'),
                      const SizedBox(width: 24),
                      _buildActionButton('withdraw', 'سحب'),
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
                      TextButton(onPressed: () {}, child: const Text('عرض الكل', style: TextStyle(color: Color(0xFFD4AF37)))),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildTransactionItem('شراء منتج', '- 350 ريال', 'cart', const Color(0xFFF6465D)),
                  _buildTransactionItem('إيداع', '+ 5,000 ريال', 'deposit', const Color(0xFF0ECB81)),
                  _buildTransactionItem('تحويل', '- 1,000 ريال', 'transfer', const Color(0xFFF6465D)),
                  _buildTransactionItem('استرداد', '+ 200 ريال', 'receive', const Color(0xFF0ECB81)),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // خدمات المحفظة
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2329),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('خدمات المحفظة', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.2,
                    children: [
                      _buildServiceItem('qr', 'مسح QR'),
                      _buildServiceItem('send', 'إرسال'),
                      _buildServiceItem('receive', 'استلام'),
                      _buildServiceItem('bill', 'فواتير'),
                      _buildServiceItem('card', 'بطاقات'),
                      _buildServiceItem('more', 'المزيد'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset('assets/icons/svg/$icon.svg', width: 24, colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildTransactionItem(String title, String amount, String icon, Color color) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset('assets/icons/svg/$icon.svg', width: 18, colorFilter: ColorFilter.mode(color, BlendMode.srcIn)),
      ),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: Text(amount, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildServiceItem(String icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFD4AF37).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset('assets/icons/svg/$icon.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
