import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(title: const Text('تتبع الطلب', style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStep('تم استلام الطلب', true),
            _buildStep('جاري التجهيز', true),
            _buildStep('تم الشحن', true),
            _buildStep('قيد التوصيل', true),
            _buildStep('تم التوصيل', false),
            const SizedBox(height: 20),
            Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: Column(children: [const Text('شركة التوصيل', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const SizedBox(height: 8), const Text('شركة النقل السريع', style: TextStyle(color: Color(0xFFD4AF37))), const SizedBox(height: 4), const Text('رقم الشحنة: YEM123456', style: TextStyle(color: Color(0xFF9CA3AF)))])),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String title, bool done) {
    return Row(children: [Container(width: 24, height: 24, decoration: BoxDecoration(shape: BoxShape.circle, color: done ? const Color(0xFF0ECB81) : Colors.grey[700]), child: done ? const Icon(Icons.check, color: Colors.white, size: 16) : null), const SizedBox(width: 12), Text(title, style: TextStyle(color: done ? Colors.white : Colors.grey[600]))]);
  }
}
