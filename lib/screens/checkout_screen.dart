import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import '../services/escrow_service.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final EscrowService _escrowService = EscrowService();
  bool _isProcessing = false;

  Future<void> _processPayment() async {
    setState(() => _isProcessing = true);

    final authProvider = context.read<AuthProvider>();
    final cartProvider = context.read<CartProvider>();
    final buyerId = authProvider.user?.id;
    final sellerId = cartProvider.items.first['seller_id']; // تبسيط

    if (buyerId == null) {
      _showError('يجب تسجيل الدخول أولاً');
      setState(() => _isProcessing = false);
      return;
    }

    // 1. إنشاء طلب
    final orderId = DateTime.now().millisecondsSinceEpoch.toString();

    // 2. إنشاء معاملة محتجزة
    await _escrowService.createEscrowTransaction(
      orderId: orderId,
      buyerId: buyerId,
      sellerId: sellerId,
      amount: cartProvider.totalPrice,
    );

    // 3. خصم المبلغ من محفظة المشتري (محاكاة)
    // await _walletService.deductBalance(buyerId, cartProvider.totalPrice);

    // 4. إفراغ السلة
    cartProvider.clearCart();

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OrderSuccessScreen()),
      );
    }

    setState(() => _isProcessing = false);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('تأكيد الطلب'),
        backgroundColor: AppTheme.goldColor,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartProvider.items.length,
              itemBuilder: (context, index) {
                final item = cartProvider.items[index];
                return Card(
                  child: ListTile(
                    title: Text(item['name']),
                    subtitle: Text('${item['price']} ريال × ${item['quantity']}'),
                    trailing: Text('${item['price'] * item['quantity']} ريال'),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkSurface : Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('المجموع:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('${cartProvider.totalPrice} ريال', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.goldColor)),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.security, size: 16, color: Colors.green),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'المبلغ محتجز لحين تأكيد استلام المنتج',
                          style: TextStyle(fontSize: 12, color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isProcessing ? null : _processPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.goldColor,
                      foregroundColor: Colors.black,
                    ),
                    child: _isProcessing
                        ? const CircularProgressIndicator(strokeWidth: 2)
                        : const Text('تأكيد الدفع', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
