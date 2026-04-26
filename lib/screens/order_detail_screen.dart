import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';

class OrderDetailScreen extends StatelessWidget {
  final String orderId;
  const OrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        title: Text('تفاصيل الطلب #$orderId', style: const TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.binanceDark,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.binanceGold),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusCard(),
            const SizedBox(height: 16),
            _buildInfoCard(),
            const SizedBox(height: 16),
            _buildProductsCard(),
            const SizedBox(height: 16),
            _buildPaymentCard(),
            const SizedBox(height: 16),
            _buildDeliveryCard(),
            const SizedBox(height: 20),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF1E2329), Color(0xFF16213E)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle, color: AppTheme.binanceGreen, size: 24),
              const SizedBox(width: 12),
              const Expanded(child: Text('تم تأكيد الطلب', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
              Text('2024-04-26', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
            ],
          ),
          const SizedBox(height: 16),
          _buildTimeline(),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    final steps = [
      {'label': 'تم الطلب', 'time': '2024-04-26 10:30', 'completed': true},
      {'label': 'تم التجهيز', 'time': '2024-04-27 14:20', 'completed': true},
      {'label': 'تم الشحن', 'time': '2024-04-28 09:15', 'completed': false},
      {'label': 'تم التوصيل', 'time': 'متوقع 2024-04-30', 'completed': false},
    ];

    return Column(
      children: List.generate(steps.length, (index) {
        final step = steps[index];
        final isLast = index == steps.length - 1;
        return Row(
          children: [
            Column(
              children: [
                Icon(step['completed'] as bool ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: step['completed'] as bool ? AppTheme.binanceGreen : Color(0xFF5E6673), size: 20),
                if (!isLast) Container(width: 2, height: 40, color: step['completed'] as bool ? AppTheme.binanceGreen : Color(0xFF2B3139)),
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
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('معلومات الطلب', style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildInfoRow('رقم الطلب', '#$orderId'),
          _buildInfoRow('تاريخ الطلب', '2024-04-26'),
          _buildInfoRow('حالة الطلب', 'قيد التجهيز', color: AppTheme.serviceOrange),
        ],
      ),
    );
  }

  Widget _buildProductsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('المنتجات', style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildProductItem('iPhone 15 Pro', 1, 350000),
          const Divider(color: AppTheme.binanceBorder),
          _buildProductItem('ساعة أبل الترا', 2, 90000),
          const Divider(color: AppTheme.binanceBorder),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
            Text('المجموع', style: TextStyle(color: Colors.white)),
            Text('440,000 ريال', style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold)),
          ]),
        ],
      ),
    );
  }

  Widget _buildProductItem(String name, int quantity, int total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text('$quantity x', style: const TextStyle(color: Color(0xFF9CA3AF))),
          const SizedBox(width: 8),
          Expanded(child: Text(name, style: const TextStyle(color: Colors.white))),
          Text('$total ريال', style: const TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildPaymentCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('معلومات الدفع', style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildInfoRow('طريقة الدفع', 'الدفع عند الاستلام'),
          _buildInfoRow('حالة الدفع', 'قيد الانتظار', color: AppTheme.serviceOrange),
        ],
      ),
    );
  }

  Widget _buildDeliveryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('معلومات التوصيل', style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildInfoRow('العنوان', 'شارع الستين، صنعاء'),
          _buildInfoRow('رقم الهاتف', '777123456'),
          _buildInfoRow('شركة التوصيل', 'توصيل فلكس'),
          _buildInfoRow('رقم التتبع', 'TRK-2024-001', color: AppTheme.binanceGreen),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF9CA3AF))),
          Text(value, style: TextStyle(color: color ?? Colors.white, fontWeight: color != null ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(side: BorderSide(color: AppTheme.binanceGold), padding: const EdgeInsets.symmetric(vertical: 12)),
            child: const Text('تتبع الطلب', style: TextStyle(color: AppTheme.binanceGold)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceGold, padding: const EdgeInsets.symmetric(vertical: 12)),
            child: const Text('تواصل مع البائع', style: TextStyle(color: Colors.black)),
          ),
        ),
      ],
    );
  }
}
