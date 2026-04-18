import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import '../../providers/cart_provider.dart';
import '../../models/cart_model.dart';
import '../payment/checkout_screen.dart';
import '../product/product_detail_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.lightBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(
        title: 'سلة التسوق (${cartProvider.itemCount})',
        actions: cartProvider.isEmpty ? null : [IconButton(onPressed: () => cartProvider.clearCart(), icon: const Icon(Icons.delete_outline))],
      ),
      body: cartProvider.isEmpty ? _buildEmptyCart() : _buildCartContent(cartProvider),
      bottomNavigationBar: cartProvider.isEmpty ? null : _buildBottomBar(context, cartProvider),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey[400]),
        const SizedBox(height: 20),
        const Text('سلة التسوق فارغة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('ابدأ التسوق وأضف منتجاتك المفضلة', style: TextStyle(color: Colors.grey[600])),
      ]),
    );
  }

  Widget _buildCartContent(CartProvider cartProvider) {
    final summary = cartProvider.summary;
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: summary.itemsByStore.length,
      itemBuilder: (context, storeIndex) {
        final storeId = summary.itemsByStore.keys.elementAt(storeIndex);
        final storeItems = summary.itemsByStore[storeId]!;
        final storeName = storeItems.first.storeName;
        
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(20)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [const Icon(Icons.store, color: AppTheme.gold), const SizedBox(width: 8), Text(storeName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))]),
            const SizedBox(height: 12),
            ...storeItems.map((item) => _buildCartItem(item, cartProvider, context)),
            const Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('إجمالي المتجر'), Text('${storeItems.fold(0.0, (sum, i) => sum + i.totalPrice).toStringAsFixed(2)} ريال', style: const TextStyle(fontWeight: FontWeight.bold))]),
          ]),
        );
      },
    );
  }

  Widget _buildCartItem(CartItem item, CartProvider cartProvider, BuildContext context) {
    return Dismissible(
      key: Key(item.productId),
      direction: DismissDirection.endToStart,
      background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), child: const Icon(Icons.delete, color: Colors.white)),
      onDismissed: (_) => cartProvider.removeItem(item.productId),
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(productId: item.productId, productName: item.productName, storeName: item.storeName))),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(children: [
            ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(item.productImage, width: 70, height: 70, fit: BoxFit.cover)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(item.productName, style: const TextStyle(fontWeight: FontWeight.w500), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text('${item.finalPrice.toStringAsFixed(2)} ريال', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.gold)),
              ]),
            ),
            Row(children: [
              IconButton(onPressed: () => cartProvider.updateQuantity(item.productId, item.quantity - 1), icon: const Icon(Icons.remove_circle_outline, color: AppTheme.gold)),
              Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              IconButton(onPressed: () => cartProvider.updateQuantity(item.productId, item.quantity + 1), icon: const Icon(Icons.add_circle_outline, color: AppTheme.gold)),
            ]),
          ]),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, CartProvider cartProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2))]),
      child: SafeArea(
        child: Row(children: [
          Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [Text('الإجمالي', style: TextStyle(color: Colors.grey[600])), Text('${cartProvider.total.toStringAsFixed(2)} ريال', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.gold))]),
          const SizedBox(width: 20),
          Expanded(child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutScreen(cartItems: cartProvider.items))), style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: const Text('متابعة الشراء', style: TextStyle(fontSize: 16, color: Colors.black)))),
        ]),
      ),
    );
  }
}
