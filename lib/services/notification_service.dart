import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationService extends ChangeNotifier {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  List<NotificationModel> _notifications = [];
  int _unreadCount = 0;

  List<NotificationModel> get notifications => _notifications;
  int get unreadCount => _unreadCount;

  // تهيئة الإشعارات
  void initNotifications() {
    _notifications = [
      NotificationModel(
        id: '1',
        title: 'مرحباً بك في فلكس يمن',
        message: 'نرحب بانضمامك إلى منصتنا. استمتع بتجربة فريدة',
        date: DateTime.now().subtract(const Duration(days: 1)),
        type: NotificationType.system,
        isRead: false,
        icon: Icons.waving_hand,
        color: 0xFFD4AF37,
      ),
      NotificationModel(
        id: '2',
        title: 'تم إيداع 10,000 ريال',
        message: 'تم إيداع مبلغ 10,000 ريال يمني في محفظتك بنجاح',
        date: DateTime.now().subtract(const Duration(hours: 5)),
        type: NotificationType.transaction,
        isRead: false,
        icon: Icons.arrow_downward,
        color: 0xFF4CAF50,
      ),
      NotificationModel(
        id: '3',
        title: 'عرض حصري',
        message: 'خصم 20% على جميع التحويلات باستخدام كود SAVE20',
        date: DateTime.now().subtract(const Duration(days: 2)),
        type: NotificationType.promo,
        isRead: true,
        icon: Icons.local_offer,
        color: 0xFFFF9800,
      ),
      NotificationModel(
        id: '4',
        title: 'تحديث التطبيق',
        message: 'يتوفر إصدار جديد من تطبيق فلكس يمن مع ميزات محسنة',
        date: DateTime.now().subtract(const Duration(days: 3)),
        type: NotificationType.update,
        isRead: true,
        icon: Icons.system_update,
        color: 0xFF2196F3,
      ),
      NotificationModel(
        id: '5',
        title: 'تم التحويل إلى جيب',
        message: 'تم تحويل 2,500 ريال يمني إلى محفظة جيب بنجاح',
        date: DateTime.now().subtract(const Duration(days: 4)),
        type: NotificationType.transaction,
        isRead: true,
        icon: Icons.swap_horiz,
        color: 0xFF2196F3,
      ),
    ];
    _updateUnreadCount();
  }

  // إضافة إشعار جديد
  void addNotification({
    required String title,
    required String message,
    required NotificationType type,
    IconData? icon,
    int? color,
  }) {
    final notification = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      message: message,
      date: DateTime.now(),
      type: type,
      isRead: false,
      icon: icon ?? _getDefaultIcon(type),
      color: color ?? _getDefaultColor(type),
    );
    _notifications.insert(0, notification);
    _updateUnreadCount();
    notifyListeners();
  }

  // إشعار من المحفظة
  void addWalletNotification(String title, String message, String type) {
    NotificationType notificationType;
    IconData icon;
    int color;

    switch (type) {
      case 'deposit':
        notificationType = NotificationType.transaction;
        icon = Icons.arrow_downward;
        color = 0xFF4CAF50;
        break;
      case 'withdraw':
        notificationType = NotificationType.transaction;
        icon = Icons.arrow_upward;
        color = 0xFFF44336;
        break;
      case 'transfer':
        notificationType = NotificationType.transaction;
        icon = Icons.swap_horiz;
        color = 0xFF2196F3;
        break;
      case 'payment':
        notificationType = NotificationType.transaction;
        icon = Icons.payment;
        color = 0xFFFF9800;
        break;
      default:
        notificationType = NotificationType.system;
        icon = Icons.notifications;
        color = 0xFF9C27B0;
    }

    addNotification(
      title: title,
      message: message,
      type: notificationType,
      icon: icon,
      color: color,
    );
  }

  // وضع علامة مقروء
  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1 && !_notifications[index].isRead) {
      _notifications[index].isRead = true;
      _updateUnreadCount();
      notifyListeners();
    }
  }

  // وضع علامة مقروء للجميع
  void markAllAsRead() {
    for (var notification in _notifications) {
      notification.isRead = true;
    }
    _updateUnreadCount();
    notifyListeners();
  }

  // حذف إشعار
  void deleteNotification(String id) {
    _notifications.removeWhere((n) => n.id == id);
    _updateUnreadCount();
    notifyListeners();
  }

  // حذف جميع الإشعارات
  void deleteAllNotifications() {
    _notifications.clear();
    _updateUnreadCount();
    notifyListeners();
  }

  void _updateUnreadCount() {
    _unreadCount = _notifications.where((n) => !n.isRead).length;
  }

  IconData _getDefaultIcon(NotificationType type) {
    switch (type) {
      case NotificationType.transaction:
        return Icons.swap_horiz;
      case NotificationType.promo:
        return Icons.local_offer;
      case NotificationType.update:
        return Icons.system_update;
      default:
        return Icons.notifications;
    }
  }

  int _getDefaultColor(NotificationType type) {
    switch (type) {
      case NotificationType.transaction:
        return 0xFF2196F3;
      case NotificationType.promo:
        return 0xFFFF9800;
      case NotificationType.update:
        return 0xFF4CAF50;
      default:
        return 0xFF9C27B0;
    }
  }
}
