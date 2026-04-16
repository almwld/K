import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  
  String? _fcmToken;
  final List<NotificationModel> _notifications = [];
  
  String? get fcmToken => _fcmToken;

  // تهيئة الإشعارات
  Future<void> initialize() async {
    await _initializeLocalNotifications();
    await _initializeFirebaseMessaging();
    await _loadSavedNotifications();
  }

  // تهيئة الإشعارات المحلية
  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    
    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }

  // تهيئة Firebase Messaging
  Future<void> _initializeFirebaseMessaging() async {
    // طلب الصلاحيات
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // الحصول على token
      _fcmToken = await _firebaseMessaging.getToken();
      print('FCM Token: $_fcmToken');
      
      // حفظ token
      if (_fcmToken != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('fcm_token', _fcmToken!);
      }
    }
    
    // الاستماع للرسائل في الخلفية
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    
    // الاستماع للرسائل في المقدمة
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    
    // عند فتح التطبيق من إشعار
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationOpen);
    
    // عند تحديث token
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      _fcmToken = newToken;
      _saveFcmToken(newToken);
    });
  }

  // معالجة الإشعارات في الخلفية
  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await NotificationService()._showLocalNotification(message);
  }

  // معالجة الإشعارات في المقدمة
  void _handleForegroundMessage(RemoteMessage message) {
    _showLocalNotification(message);
    _addToNotificationsList(message);
  }

  // معالجة فتح الإشعار
  void _handleNotificationOpen(RemoteMessage message) {
    _addToNotificationsList(message);
    // التنقل للصفحة المناسبة حسب نوع الإشعار
    _navigateFromNotification(message);
  }

  // عرض إشعار محلي
  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    final android = message.data['android_channel'] ?? 'general';
    
    if (notification != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _getAndroidChannel(android),
            _getChannelName(android),
            channelDescription: _getChannelDescription(android),
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
            color: const Color(0xFFD4AF37),
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }

  // إضافة إشعار إلى القائمة
  void _addToNotificationsList(RemoteMessage message) {
    final notification = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: message.notification?.title ?? 'إشعار جديد',
      body: message.notification?.body ?? '',
      type: message.data['type'] ?? 'general',
      data: message.data,
      createdAt: DateTime.now(),
      isRead: false,
    );
    
    _notifications.insert(0, notification);
    _saveNotifications();
  }

  // التنقل من الإشعار
  void _navigateFromNotification(RemoteMessage message) {
    final type = message.data['type'];
    final orderId = message.data['order_id'];
    final productId = message.data['product_id'];
    
    // سيتم تنفيذ التنقل من خلال Stream أو Navigator
  }

  // حفظ FCM Token
  Future<void> _saveFcmToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcm_token', token);
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

  // إرسال إشعار محلي (للتطبيق)
  Future<void> sendLocalNotification({
    required String title,
    required String body,
    String? type,
    Map<String, String>? data,
  }) async {
    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          type ?? 'general',
          _getChannelName(type ?? 'general'),
          channelDescription: _getChannelDescription(type ?? 'general'),
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          color: const Color(0xFFD4AF37),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: jsonEncode(data ?? {}),
    );
    
    // إضافة إلى القائمة
    final notification = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      body: body,
      type: type ?? 'local',
      data: data ?? {},
      createdAt: DateTime.now(),
      isRead: false,
    );
    
    _notifications.insert(0, notification);
    _saveNotifications();
  }

  // الحصول على قنوات Android
  String _getAndroidChannel(String type) {
    switch (type) {
      case 'order': return 'orders_channel';
      case 'offer': return 'offers_channel';
      case 'chat': return 'chat_channel';
      case 'verification': return 'verification_channel';
      default: return 'general_channel';
    }
  }

  String _getChannelName(String type) {
    switch (type) {
      case 'order': return 'إشعارات الطلبات';
      case 'offer': return 'العروض والتخفيضات';
      case 'chat': return 'الرسائل والمحادثات';
      case 'verification': return 'التوثيق والحساب';
      default: return 'إشعارات عامة';
    }
  }

  String _getChannelDescription(String type) {
    switch (type) {
      case 'order': return 'إشعارات حالة الطلبات وتتبع الشحن';
      case 'offer': return 'أحدث العروض والتخفيضات الحصرية';
      case 'chat': return 'رسائل جديدة من المشترين والبائعين';
      case 'verification': return 'تحديثات حالة توثيق الحساب';
      default: return 'إشعارات عامة من منصة فلكس يمن';
    }
  }

  // معالجة النقر على الإشعار
  void _onNotificationTap(NotificationResponse response) {
    if (response.payload != null) {
      final data = jsonDecode(response.payload!);
      // التنقل حسب نوع الإشعار
    }
  }

  // إرسال إشعار طلب جديد (للبائع)
  Future<void> notifyNewOrder({
    required String sellerId,
    required String orderId,
    required String customerName,
    required double totalAmount,
  }) async {
    await sendLocalNotification(
      title: 'طلب جديد! 🎉',
      body: 'لديك طلب جديد من $customerName بقيمة ${totalAmount.toStringAsFixed(2)} ريال',
      type: 'order',
      data: {
        'type': 'new_order',
        'order_id': orderId,
        'seller_id': sellerId,
      },
    );
  }

  // إرسال إشعار تحديث حالة الطلب (للمشتري)
  Future<void> notifyOrderStatusUpdate({
    required String orderId,
    required String status,
    required String customerId,
  }) async {
    String statusText;
    switch (status) {
      case 'confirmed': statusText = 'تم تأكيد طلبك'; break;
      case 'processing': statusText = 'جاري تجهيز طلبك'; break;
      case 'shipped': statusText = 'تم شحن طلبك'; break;
      case 'delivered': statusText = 'تم توصيل طلبك'; break;
      default: statusText = 'تم تحديث حالة طلبك';
    }
    
    await sendLocalNotification(
      title: 'تحديث حالة الطلب 📦',
      body: '$statusText - رقم الطلب #$orderId',
      type: 'order',
      data: {
        'type': 'order_status',
        'order_id': orderId,
      },
    );
  }

  // إرسال إشعار عرض جديد
  Future<void> notifyNewOffer({
    required String offerId,
    required String title,
    required String description,
    required double discount,
  }) async {
    await sendLocalNotification(
      title: 'عرض خاص! 🎁',
      body: 'خصم ${discount.toInt()}% - $title',
      type: 'offer',
      data: {
        'type': 'new_offer',
        'offer_id': offerId,
      },
    );
  }

  // إرسال إشعار رسالة جديدة
  Future<void> notifyNewMessage({
    required String conversationId,
    required String senderName,
    required String message,
  }) async {
    await sendLocalNotification(
      title: 'رسالة جديدة 💬',
      body: '$senderName: $message',
      type: 'chat',
      data: {
        'type': 'new_message',
        'conversation_id': conversationId,
      },
    );
  }

  // إرسال إشعار تحديث التوثيق
  Future<void> notifyVerificationStatus({
    required String status,
    String? reason,
  }) async {
    String title;
    String body;
    
    if (status == 'verified') {
      title = 'تم توثيق حسابك ✅';
      body = 'تهانينا! تم توثيق حسابك بنجاح. يمكنك الآن الاستفادة من جميع ميزات المنصة.';
    } else if (status == 'rejected') {
      title = 'تم رفض طلب التوثيق ❌';
      body = reason ?? 'نعتذر، لم يتم قبول طلب التوثيق. الرجاء مراجعة البيانات والمحاولة مرة أخرى.';
    } else {
      title = 'طلب التوثيق قيد المراجعة ⏳';
      body = 'طلب التوثيق الخاص بك قيد المراجعة. سنقوم بإشعارك فور الانتهاء.';
    }
    
    await sendLocalNotification(
      title: title,
      body: body,
      type: 'verification',
      data: {
        'type': 'verification',
        'status': status,
      },
    );
  }

  // تعليم إشعار كمقروء
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

  // الحصول على عدد الإشعارات غير المقروءة
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  // الحصول على قائمة الإشعارات
  List<NotificationModel> get notifications => List.unmodifiable(_notifications);
}

// نموذج الإشعار
class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String type;
  final Map<String, String> data;
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
      'id': id,
      'title': title,
      'body': body,
      'type': type,
      'data': data,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      type: json['type'],
      data: Map<String, String>.from(json['data']),
      createdAt: DateTime.parse(json['createdAt']),
      isRead: json['isRead'] ?? false,
    );
  }

  String get timeAgo {
    final difference = DateTime.now().difference(createdAt);
    if (difference.inDays > 0) return '${difference.inDays} يوم';
    if (difference.inHours > 0) return '${difference.inHours} ساعة';
    if (difference.inMinutes > 0) return '${difference.inMinutes} دقيقة';
    return 'الآن';
  }

  IconData get icon {
    switch (type) {
      case 'order': return Icons.shopping_bag;
      case 'offer': return Icons.local_offer;
      case 'chat': return Icons.chat;
      case 'verification': return Icons.verified_user;
      default: return Icons.notifications;
    }
  }

  Color get color {
    switch (type) {
      case 'order': return Colors.blue;
      case 'offer': return Colors.orange;
      case 'chat': return Colors.green;
      case 'verification': return Colors.purple;
      default: return Colors.grey;
    }
  }
}
