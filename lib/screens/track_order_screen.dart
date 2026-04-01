import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../models/order_model.dart';

class TrackOrderScreen extends StatefulWidget {
  final OrderModel order;
  const TrackOrderScreen({super.key, required this.order});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  int _getCurrentStep() {
    switch (widget.order.status) {
      case 'pending': return 0;
      case 'processing': return 1;
      case 'shipped': return 2;
      case 'delivered': return 3;
      default: return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = _getCurrentStep();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final order = widget.order;

    return Scaffold(
      appBar: const SimpleAppBar(title: 'تتبع الطلب'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // معلومات الطلب
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildInfoRow('رقم الطلب', order.id),
                  _buildInfoRow('رقم التتبع', order.trackingNumber),
                  _buildInfoRow('شركة الشحن', order.shippingCompany),
                  _buildInfoRow('الحالة', order.statusText, isStatus: true),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // مسار الطلب
            const Text('مسار الطلب', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildStep('طلب قيد المراجعة', _formatDate(order.orderDate), currentStep >= 0, currentStep == 0),
                  _buildDivider(currentStep >= 1),
                  _buildStep('جاري التجهيز', currentStep >= 1 ? 'تم التجهيز' : 'قريباً', currentStep >= 1, currentStep == 1),
                  _buildDivider(currentStep >= 2),
                  _buildStep('تم الشحن', currentStep >= 2 ? 'تم الشحن' : 'قريباً', currentStep >= 2, currentStep == 2),
                  _buildDivider(currentStep >= 3),
                  _buildStep('تم التوصيل', currentStep >= 3 ? 'تم التوصيل' : 'قريباً', currentStep >= 3, currentStep == 3),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // معلومات العميل
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('معلومات العميل', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildInfoRow('الاسم', order.customerName),
                  _buildInfoRow('رقم الجوال', order.customerPhone),
                  _buildInfoRow('العنوان', '${order.city} - ${order.address}'),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // زر مساعدة
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.support_agent),
                label: const Text('تواصل مع الدعم'),
              ),
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          if (isStatus)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: widget.order.statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(value, style: TextStyle(color: widget.order.statusColor)),
            )
          else
            Text(value),
        ],
      ),
    );
  }
  
  Widget _buildStep(String title, String time, bool isCompleted, bool isActive) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isCompleted ? AppTheme.goldColor : Colors.grey.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCompleted ? Icons.check : Icons.pending,
            color: isCompleted ? Colors.white : Colors.grey,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isCompleted ? AppTheme.getTextColor(context) : Colors.grey,
                ),
              ),
              Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildDivider(bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Container(
        height: 30,
        width: 2,
        color: isCompleted ? AppTheme.goldColor : Colors.grey.withOpacity(0.3),
      ),
    );
  }
  
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
