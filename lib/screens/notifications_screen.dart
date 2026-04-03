import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../services/notification_service.dart';
import '../models/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedFilter = 'all';
  
  final List<Map<String, dynamic>> _filters = [
    {'id': 'all', 'name': 'الكل', 'icon': Icons.list},
    {'id': 'transaction', 'name': 'معاملات', 'icon': Icons.swap_horiz},
    {'id': 'promo', 'name': 'عروض', 'icon': Icons.local_offer},
    {'id': 'system', 'name': 'نظام', 'icon': Icons.settings},
    {'id': 'update', 'name': 'تحديثات', 'icon': Icons.update},
  ];

  List<NotificationModel> get _filteredNotifications {
    final notifications = Provider.of<NotificationService>(context).notifications;
    if (_selectedFilter == 'all') return notifications;
    NotificationType type;
    switch (_selectedFilter) {
      case 'transaction':
        type = NotificationType.transaction;
        break;
      case 'promo':
        type = NotificationType.promo;
        break;
      case 'system':
        type = NotificationType.system;
        break;
      case 'update':
        type = NotificationType.update;
        break;
      default:
        return notifications;
    }
    return notifications.where((n) => n.type == type).toList();
  }

  @override
  Widget build(BuildContext context) {
    final notificationService = Provider.of<NotificationService>(context);
    final filtered = _filteredNotifications;
    final unreadCount = notificationService.unreadCount;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark 
          ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(
        title: 'الإشعارات',
        actions: [
          if (unreadCount > 0)
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.mark_chat_read_outlined),
                  onPressed: () => notificationService.markAllAsRead(),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text('$unreadCount', style: const TextStyle(color: Colors.white, fontSize: 10), textAlign: TextAlign.center),
                  ),
                ),
              ],
            ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'delete_all', child: Text('حذف الكل')),
            ],
            onSelected: (value) {
              if (value == 'delete_all') {
                _showDeleteAllDialog(notificationService);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_off, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text('لا توجد إشعارات', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) => _buildNotificationCard(filtered[index], notificationService),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _selectedFilter == filter['id'];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              label: Row(children: [Icon(filter['icon'], size: 16), const SizedBox(width: 4), Text(filter['name'])]),
              selected: isSelected,
              onSelected: (selected) => setState(() => _selectedFilter = selected ? filter['id'] : 'all'),
              selectedColor: AppTheme.goldColor,
              labelStyle: TextStyle(color: isSelected ? Colors.white : null),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationCard(NotificationModel notification, NotificationService service) {
    return GestureDetector(
      onTap: () => _showNotificationDetails(notification, service),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: notification.isRead 
              ? AppTheme.getCardColor(context)
              : AppTheme.goldColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: !notification.isRead ? Border.all(color: AppTheme.goldColor.withOpacity(0.3)) : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(notification.color).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(notification.icon, color: Color(notification.color), size: 20),
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
                          notification.title,
                          style: TextStyle(
                            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(notification.formattedDate, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.message,
                    style: TextStyle(
                      fontSize: 12,
                      color: notification.isRead ? Colors.grey[600] : null,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (!notification.isRead)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppTheme.goldColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationDetails(NotificationModel notification, NotificationService service) {
    if (!notification.isRead) {
      service.markAsRead(notification.id);
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(notification.color).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(notification.icon, color: Color(notification.color)),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(notification.title)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.message),
            const SizedBox(height: 12),
            Text(
              notification.formattedDate,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAllDialog(NotificationService service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('حذف جميع الإشعارات'),
        content: const Text('هل أنت متأكد من حذف جميع الإشعارات؟ هذا الإجراء لا يمكن التراجع عنه.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              service.deleteAllNotifications();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم حذف جميع الإشعارات'), backgroundColor: Colors.green),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('حذف الكل'),
          ),
        ],
      ),
    );
  }
}
