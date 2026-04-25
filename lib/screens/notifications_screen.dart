import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {'title': 'تم شحن طلبك', 'message': 'طلبك #12345 في الطريق إليك', 'time': 'منذ 5 دقائق', 'icon': Icons.local_shipping, 'color': const Color(0xFF2196F3), 'read': false},
    {'title': 'عرض خاص', 'message': 'خصم 50% على جميع الإلكترونيات', 'time': 'منذ ساعة', 'icon': Icons.local_offer, 'color': const Color(0xFFF6465D), 'read': false},
    {'title': 'تم تأكيد طلبك', 'message': 'طلبك #12344 جاري تجهيزه', 'time': 'منذ 3 ساعات', 'icon': Icons.check_circle, 'color': const Color(0xFF0ECB81), 'read': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(title: const Text('الإشعارات', style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11)),
      body: _notifications.isEmpty ? Center(child: Text('لا توجد إشعارات', style: TextStyle(color: Color(0xFF9CA3AF)))) : ListView.builder(padding: const EdgeInsets.all(16), itemCount: _notifications.length, itemBuilder: (_, i) {
        final n = _notifications[i];
        return Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(16)), child: Row(children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: (n['color'] as Color).withOpacity(0.1), shape: BoxShape.circle), child: Icon(n['icon'] as IconData, color: n['color'] as Color, size: 22)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(n['title'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4), Text(n['message'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13)),
            const SizedBox(height: 6), Text(n['time'] as String, style: const TextStyle(color: Color(0xFF5E6673), fontSize: 11)),
          ])),
        ]));
      }),
    );
  }
}
