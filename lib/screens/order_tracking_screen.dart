import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تتبع الطلب'), centerTitle: true),
      body: const Center(child: Text('لا توجد طلبات للتتبع')),
    );
  }
}

