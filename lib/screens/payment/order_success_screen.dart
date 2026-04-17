import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../theme/app_theme.dart';
import '../home/main_navigation.dart';

class OrderSuccessScreen extends StatelessWidget {
  final String orderId;
  final double totalAmount;

  const OrderSuccessScreen({super.key, required this.orderId, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.network('https://assets10.lottiefiles.com/packages/lf20_kkflmtur.json', width: 200, height: 200, repeat: false),
                const SizedBox(height: 20),
                const Text('تم تقديم طلبك بنجاح!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),
                Text('رقم الطلب: #$orderId', style: TextStyle(fontSize: 16, color: Colors.grey[400])),
                const SizedBox(height: 8),
                Text('إجمالي الطلب: ${totalAmount.toStringAsFixed(2)} ريال', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.goldPrimary)),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppTheme.goldPrimary.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
                  child: const Text('سيتم توصيل طلبك خلال 2-3 أيام عمل', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const MainNavigation()), (route) => false),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldPrimary, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    child: const Text('العودة للتسوق', style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(onPressed: () {}, child: const Text('تتبع الطلب', style: TextStyle(color: AppTheme.goldPrimary))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
