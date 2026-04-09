import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _notifications = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get notifications => _notifications;
  bool get isLoading => _isLoading;
  int get unreadCount => _notifications.where((n) => n['is_read'] == false).length;

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    // تحميل الإشعارات
    await loadNotifications();

    // الاستماع للإشعارات الجديدة في الوقت الفعلي
    _supabase
        .channel('notifications')
        .on(
          RealtimeListenTypes.insert,
          ChannelFilter(event: 'INSERT', schema: 'public', table: 'notifications'),
          (payload) {
            _addNotification(payload.newRecord);
          },
        )
        .subscribe();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadNotifications() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    final response = await _supabase
        .from('notifications')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    _notifications = List<Map<String, dynamic>>.from(response);
    notifyListeners();
  }

  void _addNotification(Map<String, dynamic> notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }

  Future<void> markAsRead(String notificationId) async {
    await _supabase
        .from('notifications')
        .update({'is_read': true})
        .eq('id', notificationId);

    final index = _notifications.indexWhere((n) => n['id'] == notificationId);
    if (index != -1) {
      _notifications[index]['is_read'] = true;
      notifyListeners();
    }
  }

  Future<void> markAllAsRead() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    await _supabase
        .from('notifications')
        .update({'is_read': true})
        .eq('user_id', userId)
        .eq('is_read', false);

    for (var notification in _notifications) {
      notification['is_read'] = true;
    }
    notifyListeners();
  }

  Future<void> deleteNotification(String notificationId) async {
    await _supabase.from('notifications').delete().eq('id', notificationId);
    _notifications.removeWhere((n) => n['id'] == notificationId);
    notifyListeners();
  }

  Future<void> sendNotification({
    required String userId,
    required String title,
    required String body,
    String type = 'general',
    Map<String, dynamic>? data,
  }) async {
    await _supabase.from('notifications').insert({
      'user_id': userId,
      'title': title,
      'body': body,
      'type': type,
      'data': data,
      'created_at': DateTime.now().toIso8601String(),
    });
  }
}
