import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../order_tracking_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedPayment = 0;
  int _selectedDelivery = 0;
  bool _couponApplied = false;
  final TextEditingController _couponController = TextEditingController();

  final List<Map<String, dynamic>> _paymentMethods = [
    {'name': 'الدفع عند الاستلام', 'icon': Icons.handshake, 'desc': 'ادفع عند استلام طلبك', 'color': AppTheme.binanceGreen},
    {'name': 'بطاقة ائتمان', 'icon': Icons.credit_card, 'desc': 'فيزا، ماستركارد', 'color': AppTheme.serviceBlue},
    {'name': 'محفظة كاش', 'icon': Icons.account_balance_wallet, 'desc': 'محفظة كاش الإلكترونية', 'color': AppTheme.binanceGold},
    {'name': 'جوالي', 'icon': Icons.phone_android, 'desc': 'خدمات جوالي - يمن موبايل', 'color': const Color(0xFFE31E24)},
  ];

  final List<Map<String, dynamic>> _deliveryServices = [
    {'name': 'توصيل فلكس', 'price': 1500, 'time': '24-48 ساعة', 'icon': Icons.local_shipping, 'color': AppTheme.binanceGold},
    {'name': 'اطلبني', 'price': 2000, 'time': '1-3 ساعات', 'icon': Icons.flash_on, 'color': const Color(0xFFE91E63)},
    {'name': 'ناس', 'price': 1800, 'time': '2-4 ساعات', 'icon': Icons.motorcycle, 'color': const Color(0xFF4CAF50)},
  ];

  int get _subtotal => 250;
  int get _deliveryFee => _deliveryServices[_selectedDelivery]['price'] as int;
  int get _discount => _couponApplied ? 50 : 0;
  int get _total => _subtotal + _deliveryFee - _discount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        title: const Text('إتمام الشراء', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.binanceDark,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection('📍 عنوان الشحن'),
          _buildAddressCard(),
          const SizedBox(height: 20),
          _buildSection('🛍️ المنتجات'),
          _buildProductItem('iPhone 15 Pro', 1, 350000),
          _buildProductItem('ساعة أبل الترا', 2, 90000),
          const SizedBox(height: 20),
          _buildSection('🚚 خدمات التوصيل'),
          ..._buildDeliveryList(),
          const SizedBox(height: 20),
          _buildSection('💳 طريقة الدفع'),
          ..._buildPaymentList(),
          const SizedBox(height: 20),
          _buildSection('🎫 كوبون خصم'),
          _buildCouponRow(),
          const SizedBox(height: 20),
          _buildInvoice(),
          const SizedBox(height: 20),
          _buildPayButton(),
        ],
      ),
    );
  }

  Widget _buildSection(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
  );

  Widget _buildAddressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: AppTheme.binanceGold),
          const SizedBox(width: 12),
          const Expanded(child: Text('شارع الستين، صنعاء', style: TextStyle(color: Colors.white))),
          TextButton(onPressed: () {}, child: const Text('تغيير', style: TextStyle(color: AppTheme.binanceGold))),
        ],
      ),
    );
  }

  Widget _buildProductItem(String name, int quantity, int price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(width: 50, height: 50, decoration: BoxDecoration(color: AppTheme.binanceGold.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.shopping_bag, color: AppTheme.binanceGold)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text('الكمية: $quantity', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
          ])),
          Text('$price ريال', style: const TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  List<Widget> _buildDeliveryList() {
    return List.generate(_deliveryServices.length, (i) {
      final service = _deliveryServices[i];
      return GestureDetector(
        onTap: () => setState(() => _selectedDelivery = i),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.binanceCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _selectedDelivery == i ? service['color'] as Color : AppTheme.binanceBorder, width: _selectedDelivery == i ? 2 : 1),
          ),
          child: Row(
            children: [
              Container(width: 45, height: 45, decoration: BoxDecoration(color: (service['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(22)), child: Icon(service['icon'] as IconData, color: service['color'] as Color)),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(service['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text('${service['price']} ريال - ${service['time']}', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
              ])),
              if (_selectedDelivery == i) const Icon(Icons.check_circle, color: AppTheme.binanceGold),
            ],
          ),
        ),
      );
    });
  }

  List<Widget> _buildPaymentList() {
    return List.generate(_paymentMethods.length, (i) {
      final method = _paymentMethods[i];
      return GestureDetector(
        onTap: () => setState(() => _selectedPayment = i),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.binanceCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _selectedPayment == i ? method['color'] as Color : AppTheme.binanceBorder, width: _selectedPayment == i ? 2 : 1),
          ),
          child: Row(
            children: [
              Icon(method['icon'] as IconData, color: method['color'] as Color, size: 24),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(method['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text(method['desc'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
              ])),
              if (_selectedPayment == i) const Icon(Icons.check_circle, color: AppTheme.binanceGold),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildCouponRow() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _couponController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'أدخل كود الخصم',
              hintStyle: const TextStyle(color: Color(0xFF5E6673)),
              filled: true,
              fillColor: AppTheme.binanceCard,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {
            if (_couponController.text.toUpperCase() == 'FLEX10') {
              setState(() => _couponApplied = true);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم تطبيق الخصم!'), backgroundColor: AppTheme.binanceGreen));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('الكوبون غير صالح'), backgroundColor: AppTheme.binanceRed));
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceGold, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
          child: const Text('تطبيق', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }

  Widget _buildInvoice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.binanceGold.withOpacity(0.3))),
      child: Column(
        children: [
          const Text('📋 فاتورة الدفع', style: TextStyle(color: AppTheme.binanceGold, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildRow('المجموع الفرعي', '$_subtotal ريال'),
          _buildRow('التوصيل', '$_deliveryFee ريال'),
          if (_couponApplied) _buildRow('الخصم', '- $_discount ريال', color: AppTheme.binanceGreen),
          const Divider(color: AppTheme.binanceBorder),
          _buildRow('الإجمالي', '$_total ريال', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {Color? color, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[400], fontSize: isTotal ? 16 : 14)),
          Text(value, style: TextStyle(color: color ?? Colors.white, fontSize: isTotal ? 20 : 14, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildPayButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('جاري معالجة الدفع...'), backgroundColor: AppTheme.binanceGreen));
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OrderTrackingScreen()));
          });
        },
        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceGold, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        child: const Text('💳 دفع الآن', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
    );
  }
}
