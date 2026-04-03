import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/custom_button.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> _cartItems = [];
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadCart();
  }
  
  void _loadCart() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _cartItems = [
          {'id': '1', 'name': 'آيفون 15 برو ماكس', 'price': 450000, 'quantity': 1, 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400', 'seller': 'متجر التقنية'},
          {'id': '2', 'name': 'سامسونج S24 الترا', 'price': 380000, 'quantity': 2, 'image': 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400', 'seller': 'متجر التقنية'},
        ];
        _isLoading = false;
      });
    });
  }
  
  double get _subtotal {
    return _cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
  }
  
  double get _shipping => _subtotal > 500000 ? 0 : 5000;
  double get _total => _subtotal + _shipping;
  
  void _updateQuantity(int index, int delta) {
    setState(() {
      int newQuantity = _cartItems[index]['quantity'] + delta;
      if (newQuantity >= 1) {
        _cartItems[index]['quantity'] = newQuantity;
      }
    });
  }
  
  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إزالة المنتج من السلة'), backgroundColor: Colors.green),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'سلة التسوق'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _cartItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_outlined, size: 100, color: AppTheme.goldColor.withOpacity(0.5)),
                      const SizedBox(height: 16),
                      const Text('السلة فارغة', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('أضف بعض المنتجات إلى سلتك', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/all_ads'),
                        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black),
                        child: const Text('تصفح المنتجات'),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _cartItems.length,
                        itemBuilder: (context, index) {
                          final item = _cartItems[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.getCardColor(context),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 80, height: 80,
                                  decoration: BoxDecoration(
                                    color: AppTheme.goldColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(item['image'], fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 4),
                                      Text('${item['price']} ر.ي', style: const TextStyle(color: AppTheme.goldColor)),
                                      const SizedBox(height: 4),
                                      Text('البائع: ${item['seller']}', style: const TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove_circle_outline, size: 24),
                                          onPressed: () => _updateQuantity(index, -1),
                                          color: AppTheme.goldColor,
                                        ),
                                        Text('${item['quantity']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                        IconButton(
                                          icon: const Icon(Icons.add_circle_outline, size: 24),
                                          onPressed: () => _updateQuantity(index, 1),
                                          color: AppTheme.goldColor,
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                                      onPressed: () => _removeItem(index),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.getCardColor(context),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))],
                      ),
                      child: Column(
                        children: [
                          _buildPriceRow('المجموع الفرعي', _subtotal),
                          _buildPriceRow('الشحن', _shipping),
                          const Divider(height: 24),
                          _buildPriceRow('الإجمالي', _total, isTotal: true),
                          const SizedBox(height: 16),
                          CustomButton(
                            text: 'إتمام الشراء',
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutScreen())),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
  
  Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(
            '${amount.toStringAsFixed(0)} ر.ي',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppTheme.goldColor : null,
            ),
          ),
        ],
      ),
    );
  }
}
