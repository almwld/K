import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../models/order_model.dart';
import 'track_order_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  final OrderModel order;
  const OrderSuccessScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'تم الطلب'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle, color: Colors.green, size: 60),
              ),
              const SizedBox(height: 24),
              const Text('تم استلام طلبك بنجاح!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text('رقم الطلب: ${order.id}', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
              const SizedBox(height: 8),
              Text('رقم التتبع: ${order.trackingNumber}', style: TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('شركة الشحن: ${order.shippingCompany}', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => TrackOrderScreen(order: order)),
                        );
                      },
                      icon: const Icon(Icons.track_changes),
                      label: const Text('تتبع الطلب'),
                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false),
                      icon: const Icon(Icons.home),
                      label: const Text('الرئيسية'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
