import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'تم شحن طلبك',
      'message': 'طلبك #12345 في الطريق إليك',
      'time': 'منذ 5 دقائق',
      'type': 'order',
      'read': false,
      'icon': Icons.local_shipping,
      'color': const Color(0xFF2196F3),
    },
    {
      'id': '2',
      'title': 'عرض خاص',
      'message': 'خصم 50% على جميع الإلكترونيات',
      'time': 'منذ ساعة',
      'type': 'promo',
      'read': false,
      'icon': Icons.local_offer,
      'color': const Color(0xFFF6465D),
    },
    {
      'id': '3',
      'title': 'تم تأكيد طلبك',
      'message': 'طلبك #12344 جاري تجهيزه',
      'time': 'منذ 3 ساعات',
      'type': 'order',
      'read': true,
      'icon': Icons.check_circle,
      'color': const Color(0xFF0ECB81),
    },
    {
      'id': '4',
      'title': 'وصل حديثاً',
      'message': 'منتجات جديدة في متجر التقنية',
      'time': 'منذ يوم',
      'type': 'new',
      'read': true,
      'icon': Icons.fiber_new,
      'color': const Color(0xFFFF9800),
    },
    {
      'id': '5',
      'title': 'تذكير بالمزاد',
      'message': 'مزاد ساعة رولكس ينتهي خلال ساعتين',
      'time': 'منذ يومين',
      'type': 'auction',
      'read': true,
      'icon': Icons.gavel,
      'color': const Color(0xFF9C27B0),
    },
  ];

  void _markAsRead(int index) {
    setState(() {
      _notifications[index]['read'] = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['read'] = true;
      }
    });
  }

  void _clearAll() {
    setState(() {
      _notifications.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notifications.where((n) => !(n['read'] as bool)).length;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        title: Row(
          children: [
            const Text('الإشعارات', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            if (unreadCount > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6465D),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$unreadCount',
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ],
        ),
        centerTitle: false,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Color(0xFFD4AF37)),
            color: const Color(0xFF1E2329),
            onSelected: (value) {
              if (value == 'read') _markAllAsRead();
              if (value == 'clear') _clearAll();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'read',
                child: Text('تعليم الكل كمقروء', style: TextStyle(color: Colors.white)),
              ),
              const PopupMenuItem(
                value: 'clear',
                child: Text('مسح الكل', style: TextStyle(color: Color(0xFFF6465D))),
              ),
            ],
          ),
        ],
      ),
      body: _notifications.isEmpty ? _buildEmptyState() : _buildNotificationsList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.notifications_none, color: Color(0xFFD4AF37), size: 80),
          ),
          const SizedBox(height: 24),
          const Text(
            'لا توجد إشعارات',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'سنخبرك بكل جديد هنا',
            style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _notifications.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final notification = _notifications[index];
        final isRead = notification['read'] as bool;
        
        return GestureDetector(
          onTap: () => _markAsRead(index),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isRead ? const Color(0xFF1E2329) : const Color(0xFF1A2A44),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF2B3139)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (notification['color'] as Color).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    notification['icon'] as IconData,
                    color: notification['color'] as Color,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification['title'] as String,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                              ),
                            ),
                          ),
                          if (!isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD4AF37),
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification['message'] as String,
                        style: TextStyle(color: isRead ? const Color(0xFF9CA3AF) : Colors.white70, fontSize: 13),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notification['time'] as String,
                        style: const TextStyle(color: Color(0xFF5E6673), fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
