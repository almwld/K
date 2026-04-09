import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/notification_service.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final notificationService = Provider.of<NotificationService>(context);

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(
        title: 'الإشعارات',
        actions: [
          if (notificationService.unreadCount > 0)
            TextButton(
              onPressed: () => notificationService.markAllAsRead(),
              child: Text('تحديد الكل كمقروء', style: TextStyle(color: AppTheme.goldColor)),
            ),
        ],
      ),
      body: notificationService.isLoading
          ? const Center(child: CircularProgressIndicator())
          : notificationService.notifications.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_none, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text('لا توجد إشعارات', style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text('ستظهر الإشعارات هنا', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: notificationService.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notificationService.notifications[index];
                    final isRead = notification['is_read'] == true;

                    return GestureDetector(
                      onTap: () => notificationService.markAsRead(notification['id']),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isRead
                              ? AppTheme.getCardColor(context)
                              : AppTheme.goldColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 45, height: 45,
                              decoration: BoxDecoration(
                                color: AppTheme.goldColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                _getIcon(notification['type']),
                                color: AppTheme.goldColor,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notification['title'],
                                    style: TextStyle(
                                      fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    notification['body'],
                                    style: TextStyle(fontSize: 13, color: Colors.grey),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _formatDate(notification['created_at']),
                                    style: TextStyle(fontSize: 11, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            if (!isRead)
                              Container(
                                width: 8, height: 8,
                                decoration: const BoxDecoration(
                                  color: AppTheme.goldColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'order': return Icons.shopping_bag;
      case 'payment': return Icons.payment;
      case 'promotion': return Icons.local_offer;
      default: return Icons.notifications;
    }
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays > 0) {
      return 'منذ ${diff.inDays} يوم';
    } else if (diff.inHours > 0) {
      return 'منذ ${diff.inHours} ساعة';
    } else if (diff.inMinutes > 0) {
      return 'منذ ${diff.inMinutes} دقيقة';
    } else {
      return 'الآن';
    }
  }
}
