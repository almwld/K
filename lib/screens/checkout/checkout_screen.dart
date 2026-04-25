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

  final List<Map<String, String>> _paymentMethods = [
    {'name': 'الدفع عند الاستلام', 'icon': 'cod'},
    {'name': 'بطاقة ائتمان', 'icon': 'payment_card'},
    {'name': 'محفظة إلكترونية', 'icon': 'wallet'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(title: const Text('إتمام الشراء', style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11)),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        _buildSection('عنوان الشحن'),
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: Row(children: [SvgPicture.asset('assets/icons/svg/location.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)), const SizedBox(width: 12), const Expanded(child: Text('شارع الستين، صنعاء', style: TextStyle(color: Colors.white))), TextButton(onPressed: () {}, child: const Text('تغيير', style: TextStyle(color: Color(0xFFD4AF37))))])),
        const SizedBox(height: 20),
        _buildSection('المنتجات'),
        ...List.generate(2, (i) => Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: Row(children: [Container(width: 50, height: 50, decoration: BoxDecoration(color: const Color(0xFFD4AF37).withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: SvgPicture.asset('assets/icons/svg/product.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn))), const SizedBox(width: 12), const Expanded(child: Text('منتج ${1}', style: TextStyle(color: Colors.white))), Text('${100 + i * 50} ريال', style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold))]))),
        const SizedBox(height: 20),
        _buildSection('كوبون خصم'),
        Row(children: [Expanded(child: TextField(style: const TextStyle(color: Colors.white), decoration: InputDecoration(hintText: 'أدخل الكود', hintStyle: const TextStyle(color: Color(0xFF9CA3AF)), filled: true, fillColor: const Color(0xFF1E2329), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)))), const SizedBox(width: 12), ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)), child: const Text('تطبيق', style: TextStyle(color: Colors.black)))]),
        const SizedBox(height: 20),
        _buildSection('طريقة الدفع'),
        ...List.generate(_paymentMethods.length, (i) => RadioListTile(value: i, groupValue: _selectedPayment, onChanged: (v) => setState(() => _selectedPayment = v!), title: Text(_paymentMethods[i]['name']!, style: const TextStyle(color: Colors.white)), activeColor: const Color(0xFFD4AF37))),
        const SizedBox(height: 20),
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: Column(children: [_buildRow('المجموع الفرعي', '250 ريال'), _buildRow('الشحن', '20 ريال'), _buildRow('الخصم', '- 10 ريال', color: const Color(0xFF0ECB81)), const Divider(color: Color(0xFF2B3139)), _buildRow('الإجمالي', '260 ريال', isTotal: true)])),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('جاري تحويلك لبوابة الدفع...'))), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('دفع الآن', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16))),
        const SizedBox(height: 20),
      ]),
    );
  }

  Widget _buildSection(String title) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)));
  Widget _buildRow(String label, String value, {Color? color, bool isTotal = false}) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: TextStyle(color: Colors.grey[400], fontSize: isTotal ? 16 : 14)), Text(value, style: TextStyle(color: color ?? Colors.white, fontSize: isTotal ? 18 : 14, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal))]));
}
