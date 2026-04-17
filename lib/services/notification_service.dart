import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final List<NotificationModel> _notifications = [];
  bool _isInitialized = false;
  
  List<NotificationModel> get notifications => _notifications;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  Future<void> initialize() async {
    if (_isInitialized) return;
    _isInitialized = true;
    _loadSavedNotifications();
  }

  void _addNotification(String title, String body, {Map<String, dynamic>? data}) {
    _notifications.insert(0, NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title, body: body, type: data?['type'] ?? 'general',
      data: data ?? {}, createdAt: DateTime.now(),
    ));
    _saveNotifications();
  }

  Future<void> _loadSavedNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('notifications');
    if (saved != null) {
      final List<dynamic> decoded = json.decode(saved);
      _notifications.clear();
      _notifications.addAll(decoded.map((n) => NotificationModel.fromJson(n)));
    }
  }

  Future<void> _saveNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = json.encode(_notifications.map((n) => n.toJson()).toList());
    await prefs.setString('notifications', encoded);
  }

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) { _notifications[index].isRead = true; _saveNotifications(); }
  }

  void markAllAsRead() {
    for (var n in _notifications) { n.isRead = true; }
    _saveNotifications();
  }

  void clearAll() {
    _notifications.clear();
    _saveNotifications();
  }
}

class NotificationModel {
  final String id, title, body, type;
  final Map<String, dynamic> data;
  final DateTime createdAt;
  bool isRead;

  NotificationModel({required this.id, required this.title, required this.body, required this.type, required this.data, required this.createdAt, this.isRead = false});

  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'body': body, 'type': type, 'data': data, 'createdAt': createdAt.toIso8601String(), 'isRead': isRead};
  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(id: json['id'], title: json['title'], body: json['body'], type: json['type'], data: json['data'], createdAt: DateTime.parse(json['createdAt']), isRead: json['isRead'] ?? false);
  String get timeAgo { final diff = DateTime.now().difference(createdAt); if (diff.inDays > 0) return '${diff.inDays} يوم'; if (diff.inHours > 0) return '${diff.inHours} ساعة'; if (diff.inMinutes > 0) return '${diff.inMinutes} دقيقة'; return 'الآن'; }
}
