import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/cart_provider.dart';
import '../../models/cart_item.dart';
import '../../models/product_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/upgrade_card.dart';
import '../checkout/checkout_screen.dart';
import '../product_detail_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  // عروض "أضف مقابل X ريال"
  List<Map<String, dynamic>> get _addOnOffers {
    return [
      {
        'product': sampleProducts.length > 5 ? sampleProducts[5] : sampleProducts[0],
        'dealPrice': 5000,
        'originalPrice': 15000,
      },
      {
        'product': sampleProducts.length > 6 ? sampleProducts[6] : sampleProducts[1],
        'dealPrice': 2500,
        'originalPrice': 8000,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            const Text('سلة التسوق', style: TextStyle(fontFamily: 'Changa')),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppTheme.gold,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${cartProvider.itemCount}',
                style: const TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          if (cartProvider.items.isNotEmpty)
            TextButton(
              onPressed: () {
                cartProvider.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم تفريغ السلة', style: TextStyle(fontFamily: 'Changa')),
                    backgroundColor: AppTheme.error,
                  ),
                );
              },
              child: Text(
                'تفريغ السلة',
                style: TextStyle(fontFamily: 'Changa', color: theme.colorScheme.error),
              ),
            ),
        ],
      ),
      body: cartProvider.items.isEmpty
          ? _buildEmptyCart(context)
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // Cart Items
                      ...cartProvider.items.map((item) => _buildCartItem(context, item, isDark, cartProvider)),
                      
                      const SizedBox(height: 20),
                      
                      // Upgrade Card
                      UpgradeCard(
                        title: 'وفر أكثر مع Pro',
                        subtitle: 'احصل على شحن مجاني وخصم 10%',
                        savings: 'حتى 100K ر.ي',
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Add-on Offers
                      const Text(
                        'عروض إضافية لك',
                        style: TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ..._addOnOffers.map((offer) => _buildAddOnCard(context, offer)),
                      
                      const SizedBox(height: 20),
                      
                      // Free Shipping Progress
                      _buildShippingProgress(cartProvider),
                    ],
                  ),
                ),
                _buildCartSummary(context, cartProvider, theme),
              ],
            ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 120, color: Colors.grey[400]),
          const SizedBox(height: 24),
          Text(
            'سلة التسوق فارغة',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontFamily: 'Changa',
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'استعرض المنتجات وأضف ما يعجبك إلى السلة',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontFamily: 'Changa',
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/marketplace');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.gold,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'تسوق الآن',
              style: TextStyle(fontFamily: 'Changa', fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item, bool isDark, CartProvider cartProvider) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.error,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        cartProvider.removeItem(item.productId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم حذف ${item.productName}', style: const TextStyle(fontFamily: 'Changa')),
            action: SnackBarAction(
              label: 'تراجع',
              textColor: AppTheme.gold,
              onPressed: () => cartProvider.addItem(item),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.nightCard : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: item.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.productName, style: const TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold, fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text(item.vendorName, style: TextStyle(fontFamily: 'Changa', fontSize: 12, color: Colors.grey[600])),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${item.price.toStringAsFixed(0)} ر.ي', style: const TextStyle(fontFamily: 'Changa', color: AppTheme.gold, fontWeight: FontWeight.bold)),
                      _buildQuantityControl(context, item, cartProvider),
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

  Widget _buildQuantityControl(BuildContext context, CartItem item, CartProvider cartProvider) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.3)), borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          IconButton(
            onPressed: item.quantity > 1 ? () => cartProvider.updateQuantity(item.productId, item.quantity - 1) : null,
            icon: const Icon(Icons.remove, size: 18),
            color: AppTheme.gold,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32),
          ),
          Text('${item.quantity}', style: const TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold)),
          IconButton(
            onPressed: item.quantity < item.stockQuantity ? () => cartProvider.updateQuantity(item.productId, item.quantity + 1) : null,
            icon: const Icon(Icons.add, size: 18),
            color: AppTheme.gold,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildAddOnCard(BuildContext context, Map<String, dynamic> offer) {
    final product = offer['product'] as ProductModel;
    final dealPrice = offer['dealPrice'] as double;
    final originalPrice = offer['originalPrice'] as double;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0B90B).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0B90B).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.images.isNotEmpty ? product.images[0] : 'https://via.placeholder.com/100',
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0B90B),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${dealPrice.toStringAsFixed(0)} ر.ي',
                        style: const TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold, color: Colors.black, fontSize: 13),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${originalPrice.toStringAsFixed(0)} ر.ي',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.gold,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('أضف', style: TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingProgress(CartProvider cartProvider) {
    final freeShippingThreshold = 50000;
    final progress = (cartProvider.subtotal / freeShippingThreshold).clamp(0.0, 1.0);
    final remaining = freeShippingThreshold - cartProvider.subtotal;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2329),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.local_shipping, size: 20, color: Color(0xFF0ECB81)),
              const SizedBox(width: 8),
              if (remaining > 0)
                Expanded(
                  child: Text(
                    'أضف بقيمة ${remaining.toStringAsFixed(0)} ر.ي للحصول على شحن مجاني!',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                )
              else
                const Expanded(
                  child: Text(
                    'تهانينا! الشحن مجاني',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0ECB81)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[800],
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0ECB81)),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartSummary(BuildContext context, CartProvider cartProvider, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: theme.scaffoldBackgroundColor, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))]),
      child: SafeArea(
        child: Column(
          children: [
            _buildSummaryRow('المجموع الفرعي', '${cartProvider.subtotal.toStringAsFixed(0)} ر.ي'),
            if (cartProvider.discount > 0) _buildSummaryRow('الخصم', '-${cartProvider.discount.toStringAsFixed(0)} ر.ي', color: const Color(0xFF0ECB81)),
            const Divider(height: 24),
            _buildSummaryRow('الإجمالي', '${cartProvider.total.toStringAsFixed(0)} ر.ي', isBold: true, fontSize: 18),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutScreen())),
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold, foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 55), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              child: const Text('الدفع الآن', style: TextStyle(fontFamily: 'Changa', fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? color, bool isBold = false, double fontSize = 14}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontFamily: 'Changa', fontSize: fontSize, color: color, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontFamily: 'Changa', fontSize: fontSize, color: color, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
