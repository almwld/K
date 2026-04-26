import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        title: const Text('تتبع الطلب', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.binanceDark,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.binanceGold),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF1E2329), Color(0xFF16213E)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(Icons.check_circle, color: AppTheme.binanceGreen, size: 48),
                  const SizedBox(height: 12),
                  const Text('تم تأكيد طلبك', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('رقم الطلب: #ORD-001', style: const TextStyle(color: AppTheme.binanceGold, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildTrackingTimeline(),
            const SizedBox(height: 20),
            _buildDeliveryInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingTimeline() {
    final steps = [
      {'label': 'تم الطلب', 'time': '2024-04-26 10:30', 'completed': true},
      {'label': 'تم التجهيز', 'time': '2024-04-27 14:20', 'completed': true},
      {'label': 'تم الشحن', 'time': '2024-04-28 09:15', 'completed': false},
      {'label': 'تم التوصيل', 'time': 'متوقع 2024-04-30', 'completed': false},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: List.generate(steps.length, (index) {
          final step = steps[index];
          final isLast = index == steps.length - 1;
          return Row(
            children: [
              Column(
                children: [
                  Icon(step['completed'] as bool ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: step['completed'] as bool ? AppTheme.binanceGreen : Color(0xFF5E6673), size: 20),
                  if (!isLast) Container(width: 2, height: 50, color: step['completed'] as bool ? AppTheme.binanceGreen : AppTheme.binanceBorder),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(step['label'] as String, style: TextStyle(color: step['completed'] as bool ? Colors.white : Color(0xFF9CA3AF), fontWeight: FontWeight.w500)),
                    Text(step['time'] as String, style: const TextStyle(color: Color(0xFF5E6673), fontSize: 11)),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildDeliveryInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('معلومات التوصيل', style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildInfoRow('شركة التوصيل', 'توصيل فلكس'),
          _buildInfoRow('رقم التتبع', 'TRK-2024-001'),
          _buildInfoRow('رقم المندوب', '+967 777 123 456'),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceGold, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Text('اتصل بالمندوب', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF9CA3AF))),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
