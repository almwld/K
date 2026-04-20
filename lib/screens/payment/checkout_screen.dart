import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import '../../providers/cart_provider.dart';
import '../../models/cart_model.dart';
import '../../models/payment_gateways_yemen.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  
  const CheckoutScreen({super.key, required this.cartItems});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();
  
  String _selectedPayment = 'cash';
  String _selectedDelivery = 'standard';
  bool _isLoading = false;
  
  final List<Map<String, dynamic>> _deliveryOptions = [
    {'id': 'standard', 'name': 'توصيل عادي', 'fee': 1000, 'time': '2-3 أيام'},
    {'id': 'express', 'name': 'توصيل سريع', 'fee': 2000, 'time': '24 ساعة'},
    {'id': 'same_day', 'name': 'توصيل نفس اليوم', 'fee': 3500, 'time': 'خلال ساعات'},
  ];

  double get subtotal => widget.cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  double get deliveryFee => _deliveryOptions.firstWhere((d) => d['id'] == _selectedDelivery)['fee'];
  double get total => subtotal + deliveryFee;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cartSummary = CartSummary(items: widget.cartItems);

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'إتمام الطلب'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildSection('ملخص الطلب'),
          const SizedBox(height: 12),
          ...cartSummary.itemsByStore.entries.map((entry) => _buildStoreSummary(entry.key, entry.value)),
          const SizedBox(height: 20),
          _buildSection('عنوان التوصيل'),
          const SizedBox(height: 12),
          _buildAddressForm(isDark),
          const SizedBox(height: 20),
          _buildSection('طريقة التوصيل'),
          const SizedBox(height: 12),
          _buildDeliveryOptions(isDark),
          const SizedBox(height: 20),
          _buildSection('طريقة الدفع'),
          const SizedBox(height: 12),
          _buildPaymentOptions(isDark),
          const SizedBox(height: 20),
          _buildOrderSummary(),
        ]),
      ),
      bottomNavigationBar: _buildBottomBar(isDark),
    );
  }

  Widget _buildSection(String title) {
    return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget _buildStoreSummary(String storeId, List<CartItem> items) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [const Icon(Icons.store, color: AppTheme.gold, size: 18), const SizedBox(width: 8), Text(items.first.storeName, style: const TextStyle(fontWeight: FontWeight.bold))]),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(children: [Text('${item.quantity}x', style: TextStyle(color: Colors.grey[600])), const SizedBox(width: 8), Expanded(child: Text(item.productName)), Text('${item.totalPrice.toStringAsFixed(2)} ريال')]))),
        const Divider(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('إجمالي المتجر'), Text('${items.fold(0.0, (sum, i) => sum + i.totalPrice).toStringAsFixed(2)} ريال', style: const TextStyle(fontWeight: FontWeight.bold))]),
      ]),
    );
  }

  Widget _buildAddressForm(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16)),
      child: Column(children: [
        TextFormField(controller: _addressController, decoration: InputDecoration(labelText: 'العنوان التفصيلي', prefixIcon: const Icon(Icons.location_on, color: AppTheme.gold), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), filled: true, fillColor: isDark ? AppTheme.nightCard : Colors.grey[50]), maxLines: 2, validator: (v) => v?.isEmpty == true ? 'مطلوب' : null),
        const SizedBox(height: 12),
        TextFormField(controller: _phoneController, decoration: InputDecoration(labelText: 'رقم الجوال', prefixIcon: const Icon(Icons.phone, color: AppTheme.gold), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), filled: true, fillColor: isDark ? AppTheme.nightCard : Colors.grey[50]), keyboardType: TextInputType.phone),
        const SizedBox(height: 12),
        TextFormField(controller: _notesController, decoration: InputDecoration(labelText: 'ملاحظات (اختياري)', prefixIcon: const Icon(Icons.note, color: AppTheme.gold), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), filled: true, fillColor: isDark ? AppTheme.nightCard : Colors.grey[50]), maxLines: 2),
      ]),
    );
  }

  Widget _buildDeliveryOptions(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: _deliveryOptions.map((option) {
          final isSelected = _selectedDelivery == option['id'];
          return GestureDetector(
            onTap: () => setState(() => _selectedDelivery = option['id']),
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(border: Border.all(color: isSelected ? AppTheme.gold : Colors.grey.withOpacity(0.3), width: isSelected ? 2 : 1), borderRadius: BorderRadius.circular(12), color: isSelected ? AppTheme.gold.withOpacity(0.1) : Colors.transparent),
              child: Row(children: [Radio(value: option['id'], groupValue: _selectedDelivery, onChanged: (v) => setState(() => _selectedDelivery = v!), activeColor: AppTheme.gold), const SizedBox(width: 8), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(option['name'], style: const TextStyle(fontWeight: FontWeight.bold)), Text(option['time'], style: TextStyle(fontSize: 12, color: Colors.grey[600]))])), Text('${option['fee']} ريال', style: const TextStyle(fontWeight: FontWeight.bold))]),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPaymentOptions(bool isDark) {
    final wallets = YemenWalletsData.getActiveWallets().take(4).toList();
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          _buildPaymentRadio('cash', 'نقداً عند الاستلام', Icons.money),
          ...wallets.map((w) => _buildPaymentRadio(w.id, w.nameAr, Icons.account_balance_wallet, subtitle: w.instructions)),
        ],
      ),
    );
  }

  Widget _buildPaymentRadio(String id, String name, IconData icon, {String? subtitle}) {
    final isSelected = _selectedPayment == id;
    return GestureDetector(
      onTap: () => setState(() => _selectedPayment = id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(border: Border.all(color: isSelected ? AppTheme.gold : Colors.grey.withOpacity(0.3), width: isSelected ? 2 : 1), borderRadius: BorderRadius.circular(12), color: isSelected ? AppTheme.gold.withOpacity(0.1) : Colors.transparent),
        child: Row(children: [Radio(value: id, groupValue: _selectedPayment, onChanged: (v) => setState(() => _selectedPayment = v!), activeColor: AppTheme.gold), const SizedBox(width: 8), Icon(icon, color: AppTheme.gold), const SizedBox(width: 8), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontWeight: FontWeight.bold)), if (subtitle != null) Text(subtitle, style: TextStyle(fontSize: 11, color: Colors.grey[600]))]))]),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16)),
      child: Column(children: [
        _buildSummaryRow('المجموع الفرعي', '$subtotal ريال'),
        _buildSummaryRow('رسوم التوصيل', '$deliveryFee ريال'),
        const Divider(),
        _buildSummaryRow('الإجمالي', '$total ريال', isTotal: true),
      ]),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: TextStyle(fontSize: isTotal ? 16 : 14, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        Text(value, style: TextStyle(fontSize: isTotal ? 18 : 14, fontWeight: FontWeight.bold, color: isTotal ? AppTheme.gold : null)),
      ]),
    );
  }

  Widget _buildBottomBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2))]),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: _isLoading ? null : _placeOrder,
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
          child: _isLoading ? const CircularProgressIndicator(color: Colors.black) : const Text('تأكيد الطلب', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
        ),
      ),
    );
  }

  Future<void> _placeOrder() async {
    if (_addressController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('الرجاء إدخال العنوان ورقم الجوال'), backgroundColor: Colors.red));
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    
    context.read<CartProvider>().clearCart();
    
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => OrderSuccessScreen(orderId: 'ORD${DateTime.now().millisecondsSinceEpoch}', totalAmount: total)));
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}

