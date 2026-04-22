import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // بيانات تجريبية للسلة
  final List<Map<String, dynamic>> _cartItems = [
    {
      'id': '1',
      'name': 'iPhone 15 Pro',
      'price': 350000,
      'quantity': 1,
      'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=100',
      'store': 'متجر التقنية',
    },
    {
      'id': '2',
      'name': 'ثوب يمني فاخر',
      'price': 35000,
      'quantity': 2,
      'image': 'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=100',
      'store': 'الأزياء العصرية',
    },
    {
      'id': '3',
      'name': 'مندي يمني',
      'price': 3500,
      'quantity': 3,
      'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=100',
      'store': 'مطعم مندي الملكي',
    },
  ];

  int get _totalItems => _cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));
  int get _totalPrice => _cartItems.fold(0, (sum, item) => sum + (item['price'] as int) * (item['quantity'] as int));

  void _updateQuantity(int index, int change) {
    setState(() {
      _cartItems[index]['quantity'] += change;
      if (_cartItems[index]['quantity'] <= 0) {
        _cartItems.removeAt(index);
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم حذف المنتج من السلة'),
        backgroundColor: Color(0xFFF6465D),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        title: Row(
          children: [
            const Text('سلة التسوق', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFD4AF37),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$_totalItems',
                style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          if (_cartItems.isNotEmpty)
            TextButton(
              onPressed: () {
                setState(() => _cartItems.clear());
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم مسح السلة')),
                );
              },
              child: const Text('مسح الكل', style: TextStyle(color: Color(0xFFF6465D))),
            ),
        ],
      ),
      body: _cartItems.isEmpty ? _buildEmptyCart() : _buildCartList(),
      bottomNavigationBar: _cartItems.isNotEmpty ? _buildBottomBar() : null,
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.shopping_cart_outlined, color: Color(0xFFD4AF37), size: 80),
          ),
          const SizedBox(height: 24),
          const Text(
            'سلتك فارغة',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'استكشف المنتجات وأضف ما يعجبك',
            style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text('تصفح المنتجات', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildCartList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _cartItems.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = _cartItems[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2329),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF2B3139)),
          ),
          child: Row(
            children: [
              // صورة المنتج
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item['image'] as String,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 70,
                    height: 70,
                    color: const Color(0xFF2B3139),
                    child: const Icon(Icons.image, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              
              // معلومات المنتج
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] as String,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['store'] as String,
                      style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${item['price']} ريال',
                      style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ),
              
              // عداد الكمية
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF2B3139)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _updateQuantity(index, -1),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        child: const Icon(Icons.remove, color: Color(0xFFD4AF37), size: 16),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '${item['quantity']}',
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _updateQuantity(index, 1),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        child: const Icon(Icons.add, color: Color(0xFFD4AF37), size: 16),
                      ),
                    ),
                  ],
                ),
              ),
              
              // زر الحذف
              GestureDetector(
                onTap: () => _removeItem(index),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(left: 4),
                  child: const Icon(Icons.delete_outline, color: Color(0xFFF6465D), size: 20),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0B0E11),
        border: Border(top: BorderSide(color: const Color(0xFF2B3139))),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('المجموع', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14)),
                Text(
                  '$_totalPrice ريال',
                  style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('جاري إضافة كوبون...')),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFD4AF37)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('كوبون خصم', style: TextStyle(color: Color(0xFFD4AF37))),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('جاري تحويلك لصفحة الدفع...'),
                          backgroundColor: Color(0xFF0ECB81),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD4AF37),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('متابعة الشراء', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
