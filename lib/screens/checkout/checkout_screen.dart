import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedPayment = 0;
  String _selectedAddress = 'المنزل';
  String _couponCode = '';

  final List<Map<String, dynamic>> _paymentMethods = [
    {'name': 'الدفع عند الاستلام', 'icon': 'cod'},
    {'name': 'بطاقة ائتمان', 'icon': 'payment_card'},
    {'name': 'محفظة إلكترونية', 'icon': 'wallet'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        title: const Text('إتمام الشراء', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // عنوان الشحن
          _buildSection('عنوان الشحن', Icons.location_on, () {}),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2329),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/svg/location.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)),
                const SizedBox(width: 12),
                const Expanded(child: Text('شارع الستين، صنعاء', style: TextStyle(color: Colors.white))),
                TextButton(onPressed: () {}, child: const Text('تغيير', style: TextStyle(color: Color(0xFFD4AF37)))),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // المنتجات
          _buildSection('المنتجات', Icons.shopping_bag, () {}),
          ...List.generate(2, (index) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(width: 50, height: 50, color: const Color(0xFFD4AF37).withOpacity(0.1)),
                const SizedBox(width: 12),
                const Expanded(child: Text('منتج ${1}', style: TextStyle(color: Colors.white))),
                Text('${100 + index * 50} ريال', style: const TextStyle(color: Color(0xFFD4AF37))),
              ],
            ),
          )),
          const SizedBox(height: 20),

          // كوبون خصم
          _buildSection('كوبون خصم', Icons.discount, () {}),
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (v) => _couponCode = v,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'أدخل الكود',
                    filled: true,
                    fillColor: const Color(0xFF1E2329),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
                child: const Text('تطبيق', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // طريقة الدفع
          _buildSection('طريقة الدفع', Icons.payment, () {}),
          ..._paymentMethods.asMap().entries.map((entry) {
            final index = entry.key;
            final method = entry.value;
            return RadioListTile(
              value: index,
              groupValue: _selectedPayment,
              onChanged: (v) => setState(() => _selectedPayment = v!),
              title: Text(method['name'], style: const TextStyle(color: Colors.white)),
              activeColor: const Color(0xFFD4AF37),
            );
          }),
          const SizedBox(height: 20),

          // الملخص
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                _buildSummaryRow('المجموع الفرعي', '250 ريال'),
                _buildSummaryRow('الشحن', '20 ريال'),
                _buildSummaryRow('الخصم', '- 10 ريال', color: const Color(0xFF0ECB81)),
                const Divider(color: Color(0xFF2B3139)),
                _buildSummaryRow('الإجمالي', '260 ريال', isTotal: true),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // زر الدفع
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('جاري تحويلك لبوابة الدفع...')));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('دفع الآن', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(children: [Icon(icon, color: const Color(0xFFD4AF37), size: 20), const SizedBox(width: 8), Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))]),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? color, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[400], fontSize: isTotal ? 16 : 14)),
          Text(value, style: TextStyle(color: color ?? Colors.white, fontSize: isTotal ? 18 : 14, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
