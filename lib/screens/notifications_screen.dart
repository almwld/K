import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  final List<Map<String, dynamic>> _notifications = const [
    {'title': 'عرض خاص!', 'message': 'خصم 50% على جميع المنتجات', 'time': 'منذ ساعة', 'isRead': false},
    {'title': 'تم تأكيد طلبك', 'message': 'طلبك رقم #12345 قيد التجهيز', 'time': 'منذ 3 ساعات', 'isRead': false},
    {'title': 'شحن الطلب', 'message': 'تم شحن طلبك وسيصل خلال 3 أيام', 'time': 'أمس', 'isRead': true},
    {'title': 'مرحباً بك', 'message': 'شكراً لانضمامك إلى فلكس يمن', 'time': 'الأحد', 'isRead': true},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الإشعارات'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: notification['isRead'] == false ? AppTheme.goldColor.withOpacity(0.1) : AppTheme.getCardColor(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 50, height: 50,
                  decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                  child: Icon(notification['isRead'] == false ? Icons.notifications_active : Icons.notifications, color: AppTheme.goldColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(notification['message'], style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 12)),
                    ],
                  ),
                ),
                Text(notification['time'], style: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[400], fontSize: 11)),
              ],
            ),
          );
        },
      ),
    );
  }
}
