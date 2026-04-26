import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../checkout/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> _cartItems = [
    CartItem(id: '1', name: 'iPhone 15 Pro', price: 350000, quantity: 1, image: 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=200', seller: 'متجر التقنية', discount: 22),
    CartItem(id: '2', name: 'ساعة أبل الترا', price: 45000, quantity: 2, image: 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=200', seller: 'متجر التقنية', discount: 15),
    CartItem(id: '3', name: 'سماعات ايربودز برو', price: 35000, quantity: 1, image: 'https://images.unsplash.com/photo-1605464315542-bda3e2f4e605?w=200', seller: 'عالم الجوالات', discount: 22),
  ];

  bool _couponApplied = false;

  int get _subtotal => _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  int get _discount => _couponApplied ? _subtotal * 10 ~/ 100 : 0;
  int get _deliveryFee => _subtotal > 200000 ? 0 : 1500;
  int get _total => _subtotal - _discount + _deliveryFee;

  void _updateQuantity(String id, int delta) {
    setState(() {
      final index = _cartItems.indexWhere((item) => item.id == id);
      if (index != -1) {
        final newQuantity = _cartItems[index].quantity + delta;
        if (newQuantity > 0 && newQuantity <= 99) _cartItems[index].quantity = newQuantity;
      }
    });
  }

  void _removeItem(String id) {
    setState(() => _cartItems.removeWhere((item) => item.id == id));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم حذف المنتج من السلة'), backgroundColor: AppTheme.binanceGreen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        title: Row(children: [const Text('سلة التسوق', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const SizedBox(width: 8), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: AppTheme.binanceGold, borderRadius: BorderRadius.circular(12)), child: Text('${_cartItems.length}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)))]),
        backgroundColor: AppTheme.binanceDark,
        centerTitle: true,
        actions: [if (_cartItems.isNotEmpty) TextButton(onPressed: () => setState(() => _cartItems.clear()), child: const Text('مسح الكل', style: TextStyle(color: AppTheme.binanceRed)))],
      ),
      body: _cartItems.isEmpty ? _buildEmptyCart() : Column(children: [Expanded(child: ListView.builder(padding: const EdgeInsets.all(16), itemCount: _cartItems.length, itemBuilder: (context, index) => _buildCartItem(_cartItems[index]))), _buildOrderSummary()]),
    );
  }

  Widget _buildEmptyCart() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SvgPicture.asset('assets/icons/svg/cart.svg', width: 100, height: 100, colorFilter: const ColorFilter.mode(AppTheme.binanceGold, BlendMode.srcIn)),
      const SizedBox(height: 16),
      const Text('سلة التسوق فارغة', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      const Text('أضف منتجاتك المفضلة الآن', style: TextStyle(color: Color(0xFF9CA3AF))),
      const SizedBox(height: 24),
      ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceGold, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))), child: const Text('تسوق الآن', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
    ]));
  }

  Widget _buildCartItem(CartItem item) {
    return Dismissible(
      key: Key(item.id), direction: DismissDirection.endToStart,
      background: Container(margin: const EdgeInsets.only(bottom: 12), decoration: BoxDecoration(color: AppTheme.binanceRed, borderRadius: BorderRadius.circular(16)), alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), child: const Icon(Icons.delete, color: Colors.white)),
      onDismissed: (_) => _removeItem(item.id),
      child: Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.binanceBorder)), child: Row(children: [
        ClipRRect(borderRadius: BorderRadius.circular(12), child: CachedNetworkImage(imageUrl: item.image, width: 80, height: 80, fit: BoxFit.cover)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(item.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14), maxLines: 2),
          const SizedBox(height: 4),
          Text(item.seller, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
          const SizedBox(height: 8),
          Row(children: [
            if (item.discount > 0) ...[Text('${(item.price * (100 - item.discount) ~/ 100).toString()} ريال', style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold, fontSize: 14)), const SizedBox(width: 6), Text('${item.price} ريال', style: const TextStyle(color: Color(0xFF5E6673), decoration: TextDecoration.lineThrough, fontSize: 11))],
            else Text('${item.price} ريال', style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold, fontSize: 14)),
          ]),
        ])),
        Column(children: [
          Row(children: [
            _buildQuantityButton(Icons.remove, () => _updateQuantity(item.id, -1)), Container(width: 35, alignment: Alignment.center, child: Text('${item.quantity}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))), _buildQuantityButton(Icons.add, () => _updateQuantity(item.id, 1)),
          ]),
          const SizedBox(height: 8),
          Text('${item.price * item.quantity} ريال', style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold, fontSize: 12)),
        ]),
      ])),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: Container(width: 28, height: 28, decoration: BoxDecoration(color: AppTheme.binanceCard, border: Border.all(color: AppTheme.binanceBorder), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: AppTheme.binanceGold, size: 16)));
  }

  Widget _buildOrderSummary() {
    return Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: const BorderRadius.vertical(top: Radius.circular(20)), border: Border(top: BorderSide(color: AppTheme.binanceBorder))), child: Column(children: [
      const Text('📋 ملخص الطلب', style: TextStyle(color: AppTheme.binanceGold, fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      _buildSummaryRow('المجموع الفرعي', '$_subtotal ريال'),
      _buildSummaryRow('التوصيل', _deliveryFee == 0 ? 'مجاني' : '$_deliveryFee ريال', color: _deliveryFee == 0 ? AppTheme.binanceGreen : null),
      if (_couponApplied) _buildSummaryRow('الخصم (10%)', '- $_discount ريال', color: AppTheme.binanceGreen),
      const Divider(color: AppTheme.binanceBorder),
      _buildSummaryRow('الإجمالي', '$_total ريال', isTotal: true),
      const SizedBox(height: 16),
      Row(children: [
        Expanded(child: TextField(style: const TextStyle(color: Colors.white), decoration: InputDecoration(hintText: 'أدخل كود الخصم', hintStyle: const TextStyle(color: Color(0xFF5E6673)), filled: true, fillColor: AppTheme.binanceDark, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12)))),
        const SizedBox(width: 8),
        ElevatedButton(onPressed: () => setState(() => _couponApplied = true), style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceGold, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('تطبيق', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      ]),
      const SizedBox(height: 16),
      SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutScreen())), style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceGold, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Text('متابعة الشراء', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)), const SizedBox(width: 8), Text('$_total ريال', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16))]))),
    ]));
  }

  Widget _buildSummaryRow(String label, String value, {Color? color, bool isTotal = false}) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: TextStyle(color: isTotal ? Colors.white : Colors.grey[400], fontSize: isTotal ? 16 : 14)), Text(value, style: TextStyle(color: color ?? Colors.white, fontSize: isTotal ? 18 : 14, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal))]));
  }
}

class CartItem {
  final String id, name, image, seller;
  final int price, discount;
  int quantity;
  CartItem({required this.id, required this.name, required this.price, required this.quantity, required this.image, required this.seller, required this.discount});
}
