import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        title: const Text('تتبع الطلب', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/svg/orders.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)),
                      const SizedBox(width: 8),
                      const Text('طلب #12345', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0xFF2196F3).withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: const Text('قيد التوصيل', style: TextStyle(color: Color(0xFF2196F3)))),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTimelineItem('تم استلام الطلب', '2024-01-15 10:00', true),
                  _buildTimelineItem('جاري التجهيز', '2024-01-15 14:00', true),
                  _buildTimelineItem('تم الشحن', '2024-01-16 09:00', true),
                  _buildTimelineItem('قيد التوصيل', '2024-01-16 15:00', true),
                  _buildTimelineItem('تم التوصيل', 'متوقع اليوم', false),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/svg/location.svg', width: 20, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)),
                      const SizedBox(width: 8),
                      const Text('عنوان التوصيل', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('شارع الستين، صنعاء', style: TextStyle(color: Color(0xFF9CA3AF))),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/svg/chat.svg', width: 20, colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
                label: const Text('تواصل مع المندوب', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), padding: const EdgeInsets.symmetric(vertical: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(String title, String time, bool isCompleted) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? const Color(0xFF0ECB81) : Colors.grey[700],
          ),
          child: isCompleted ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(title, style: TextStyle(color: isCompleted ? Colors.white : Colors.grey[600]))),
        Text(time, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
      ],
    );
  }
}
