import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تأكيد الطلب'),
        backgroundColor: const Color(0xFFD4AF37),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ملخص الطلب',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(),
                          _buildOrderItem('منتج 1', 1, 50.0),
                          _buildOrderItem('منتج 2', 2, 30.0),
                          const Divider(),
                          _buildTotalRow(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'عنوان التوصيل',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text('صنعاء، اليمن'),
                          const Text('شارع التعاون، مبنى ١٢'),
                          const Text('هاتف: 777777777'),
                        ],
                      ),
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
                onPressed: () async {
                  // عرض شعار متحرك عند الدفع
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => Dialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark 
                              ? Colors.grey[900] 
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Lottie.asset(
                              'assets/animations/loading_logo.json',
                              width: 120,
                              height: 120,
                              repeat: true,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'جاري تأكيد الطلب...',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                  // محاكاة معالجة الدفع
                  await Future.delayed(const Duration(seconds: 2));

                  if (context.mounted) {
                    Navigator.pop(context); // إغلاق الشعار
                    
                    // الانتقال لصفحة النجاح
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const OrderSuccessScreen()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'تأكيد الطلب',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(String name, int quantity, double price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$name x $quantity'),
          Text('${(price * quantity).toStringAsFixed(2)} ر.ي'),
        ],
      ),
    );
  }

  Widget _buildTotalRow() {
    double total = 50.0 + (2 * 30.0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'المجموع',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          '${total.toStringAsFixed(2)} ر.ي',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
