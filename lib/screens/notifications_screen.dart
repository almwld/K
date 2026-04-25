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

  int get _unreadCount => _notifications.where((n) => !(n['read'] as bool)).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(backgroundColor: const Color(0xFF0B0E11), elevation: 0, title: Row(children: [const Text('الإشعارات', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), if (_unreadCount > 0) ...[const SizedBox(width: 8), Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: const Color(0xFFF6465D), borderRadius: BorderRadius.circular(12)), child: Text('$_unreadCount', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)))]]), actions: [PopupMenuButton<String>(icon: const Icon(Icons.more_vert, color: Color(0xFFD4AF37)), color: const Color(0xFF1E2329), onSelected: (v) { if (v == 'read') setState(() { for (var n in _notifications) { n['read'] = true; } }); if (v == 'clear') setState(() => _notifications.clear()); }, itemBuilder: (_) => [const PopupMenuItem(value: 'read', child: Text('تعليم الكل كمقروء', style: TextStyle(color: Colors.white))), const PopupMenuItem(value: 'clear', child: Text('مسح الكل', style: TextStyle(color: Color(0xFFF6465D))))])]),
      body: _notifications.isEmpty ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(padding: const EdgeInsets.all(30), decoration: BoxDecoration(color: const Color(0xFFD4AF37).withOpacity(0.1), shape: BoxShape.circle), child: SvgPicture.asset('assets/icons/svg/notification.svg', width: 80, height: 80, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn))), const SizedBox(height: 24), const Text('لا توجد إشعارات', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))])) : ListView.separated(padding: const EdgeInsets.all(16), itemCount: _notifications.length, separatorBuilder: (_, __) => const SizedBox(height: 8), itemBuilder: (_, i) {
        final n = _notifications[i];
        final isRead = n['read'] as bool;
        return GestureDetector(
          onTap: () => setState(() => n['read'] = true),
          child: Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: isRead ? const Color(0xFF1E2329) : const Color(0xFF1A2A44), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF2B3139))), child: Row(children: [
            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: (n['color'] as Color).withOpacity(0.1), shape: BoxShape.circle), child: Icon(n['icon'] as IconData, color: n['color'] as Color, size: 22)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Expanded(child: Text(n['title']!, style: TextStyle(color: Colors.white, fontWeight: isRead ? FontWeight.normal : FontWeight.bold))), if (!isRead) Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFD4AF37), shape: BoxShape.circle))]]), const SizedBox(height: 4), Text(n['message']!, style: TextStyle(color: isRead ? const Color(0xFF9CA3AF) : Colors.white70, fontSize: 13)), const SizedBox(height: 6), Text(n['time']!, style: const TextStyle(color: Color(0xFF5E6673), fontSize: 11))])),
          ])),
        );
      }),
    );
  }
}
