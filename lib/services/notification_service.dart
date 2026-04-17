import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  static const String _oneSignalAppId = 'YOUR_ONESIGNAL_APP_ID';
  
  String? _userId;
  bool _isInitialized = false;
  final List<NotificationModel> _notifications = [];
  
  List<NotificationModel> get notifications => _notifications;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  // تهيئة OneSignal
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    OneSignal.initialize(_oneSignalAppId);
    OneSignal.Notifications.requestPermission(true);
    
    // الحصول على Player ID
    final deviceState = await OneSignal.User.getDeviceState();
    final playerId = deviceState?.userId;
    
    if (playerId != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('onesignal_player_id', playerId);
    }
    
    // إعداد معرف المستخدم
    if (_userId != null) {
      OneSignal.login(_userId!);
    }
    
    // الاستماع للإشعارات
    OneSignal.Notifications.addClickListener((event) {
      _handleNotificationClick(event.notification);
    });
    
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      _addNotification(event.notification);
      event.preventDefault();
    });
    
    _isInitialized = true;
    _loadSavedNotifications();
  }

  // تعيين معرف المستخدم (لربط الإشعارات بالمستخدم)
  void setUserId(String userId) {
    _userId = userId;
    if (_isInitialized) {
      OneSignal.login(userId);
    }
  }

  // إرسال إشعار لمستخدم محدد
  Future<bool> sendNotification({
    required String userId,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      // يتم الإرسال عبر Supabase Edge Function أو OneSignal API
      return true;
    } catch (e) {
      return false;
    }
  }

  // إرسال إشعار لجميع المستخدمين
  Future<bool> sendBroadcastNotification({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      // يتم الإرسال عبر OneSignal Dashboard أو API
      return true;
    } catch (e) {
      return false;
    }
  }

  // إضافة إشعار محلياً
  void _addNotification(OSNotification? notification) {
    if (notification == null) return;
    
    _notifications.insert(0, NotificationModel(
      id: notification.notificationId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: notification.title ?? 'إشعار',
      body: notification.body ?? '',
      type: notification.additionalData?['type'] ?? 'general',
      data: notification.additionalData ?? {},
      createdAt: DateTime.now(),
    ));
    
    _saveNotifications();
  }

  // معالجة النقر على الإشعار
  void _handleNotificationClick(OSNotificationClickEvent? event) {
    final notification = event?.notification;
    if (notification != null) {
      _addNotification(notification);
      // التنقل للصفحة المناسبة
    }
  }

  // تحميل الإشعارات المحفوظة
  Future<void> _loadSavedNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('notifications');
    if (saved != null) {
      final List<dynamic> decoded = jsonDecode(saved);
      _notifications.clear();
      _notifications.addAll(decoded.map((n) => NotificationModel.fromJson(n)));
    }
  }

  // حفظ الإشعارات
  Future<void> _saveNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_notifications.map((n) => n.toJson()).toList());
    await prefs.setString('notifications', encoded);
  }

  // تعليم كمقروء
  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index].isRead = true;
      _saveNotifications();
    }
  }

  // تعليم الكل كمقروء
  void markAllAsRead() {
    for (var n in _notifications) {
      n.isRead = true;
    }
    _saveNotifications();
  }

  // حذف إشعار
  void deleteNotification(String id) {
    _notifications.removeWhere((n) => n.id == id);
    _saveNotifications();
  }

  // مسح الكل
  void clearAll() {
    _notifications.clear();
    _saveNotifications();
  }
}

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String type;
  final Map<String, dynamic> data;
  final DateTime createdAt;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.data,
    required this.createdAt,
    this.isRead = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id, 'title': title, 'body': body, 'type': type,
      'data': data, 'createdAt': createdAt.toIso8601String(), 'isRead': isRead,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'], title: json['title'], body: json['body'],
      type: json['type'], data: json['data'],
      createdAt: DateTime.parse(json['createdAt']), isRead: json['isRead'] ?? false,
    );
  }

  String get timeAgo {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inDays > 0) return '${diff.inDays} يوم';
    if (diff.inHours > 0) return '${diff.inHours} ساعة';
    if (diff.inMinutes > 0) return '${diff.inMinutes} دقيقة';
    return 'الآن';
  }
}
