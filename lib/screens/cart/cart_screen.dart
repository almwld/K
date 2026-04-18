import '../../models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/cart_provider.dart';
import '../../theme/app_theme.dart';
import '../checkout/checkout_screen.dart';
import '../product_detail_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
          ? _buildEmptyCart(theme)
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartProvider.items.length,
                    itemBuilder: (context, index) {
                      final item = cartProvider.items[index];
                      return _buildCartItem(context, item, isDark);
                    },
                  ),
                ),
                _buildCartSummary(context, cartProvider, theme, isDark),
              ],
            ),
    );
  }

  Widget _buildEmptyCart(ThemeData theme) {
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
              Navigator.of(context).pushNamed( '/marketplace');
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

  Widget _buildCartItem(BuildContext context, CartItem item, bool isDark) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    
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
            content: Text(
              'تم حذف ${item.productName}',
              style: const TextStyle(fontFamily: 'Changa'),
            ),
            action: SnackBarAction(
              label: 'تراجع',
              textColor: AppTheme.gold,
              onPressed: () {
                cartProvider.addItem(item);
              },
            ),
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(
                id: item.productId,
                title: item.productName,
                image: item.imageUrl,
                price: item.price,
                description: '',
                sellerName: item.vendorName,
                rating: 4.5,
                reviewCount: 100,
                images: [item.imageUrl],
                inStock: true,
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
                    Text(
                      item.productName,
                      style: const TextStyle(
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.vendorName,
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${item.price.toStringAsFixed(0)} ر.ي',
                          style: const TextStyle(
                            fontFamily: 'Changa',
                            color: AppTheme.gold,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildQuantityControl(context, item),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityControl(BuildContext context, CartItem item) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: item.quantity > 1
                ? () => cartProvider.updateQuantity(item.productId, item.quantity - 1)
                : null,
            icon: const Icon(Icons.remove, size: 18),
            color: AppTheme.gold,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32),
          ),
          Text(
            '${item.quantity}',
            style: const TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: item.quantity < item.stockQuantity
                ? () => cartProvider.updateQuantity(item.productId, item.quantity + 1)
                : null,
            icon: const Icon(Icons.add, size: 18),
            color: AppTheme.gold,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildCartSummary(BuildContext context, CartProvider cartProvider, ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            if (cartProvider.couponCode != null)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'تم تطبيق الكوبون: ${cartProvider.couponCode}',
                        style: const TextStyle(fontFamily: 'Changa', color: Colors.green),
                      ),
                    ),
                    Text(
                      '-${cartProvider.discount.toStringAsFixed(0)} ر.ي',
                      style: const TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => cartProvider.removeCoupon(),
                      icon: const Icon(Icons.close, size: 18),
                    ),
                  ],
                ),
              ),
            _buildCouponField(context, cartProvider, isDark),
            const SizedBox(height: 16),
            _buildSummaryRow('المجموع الفرعي', '${cartProvider.subtotal.toStringAsFixed(0)} ر.ي'),
            if (cartProvider.discount > 0)
              _buildSummaryRow('الخصم', '-${cartProvider.discount.toStringAsFixed(0)} ر.ي', color: Colors.green),
            const Divider(height: 24),
            _buildSummaryRow(
              'الإجمالي',
              '${cartProvider.total.toStringAsFixed(0)} ر.ي',
              isBold: true,
              fontSize: 18,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.gold,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'متابعة الشراء',
                style: TextStyle(fontFamily: 'Changa', fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponField(BuildContext context, CartProvider cartProvider, bool isDark) {
    final controller = TextEditingController();
    
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'أدخل كود الخصم',
              hintStyle: const TextStyle(fontFamily: 'Changa'),
              filled: true,
              fillColor: isDark ? AppTheme.nightCard : AppTheme.lightCard,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              final success = cartProvider.applyCoupon(controller.text.toUpperCase());
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم تطبيق الكوبون بنجاح', style: TextStyle(fontFamily: 'Changa')),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('الكوبون غير صالح', style: TextStyle(fontFamily: 'Changa')),
                    backgroundColor: AppTheme.error,
                  ),
                );
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? AppTheme.nightSurface : Colors.grey[200],
            foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('تطبيق', style: TextStyle(fontFamily: 'Changa')),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? color, bool isBold = false, double fontSize = 14}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: fontSize,
              color: color,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: fontSize,
              color: color,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
