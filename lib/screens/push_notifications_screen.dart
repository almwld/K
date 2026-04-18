import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class PushNotificationsScreen extends StatefulWidget {
  const PushNotificationsScreen({super.key});

  @override
  State<PushNotificationsScreen> createState() => _PushNotificationsScreenState();
}

class _PushNotificationsScreenState extends State<PushNotificationsScreen> {
  List<Map<String, dynamic>> _notifications = [];
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }
  
  void _loadNotifications() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _notifications = [
          {'title': 'طلب جديد', 'body': 'لديك طلب جديد على منتج آيفون 15', 'time': 'الآن', 'icon': Icons.shopping_cart, 'color': 0xFF4CAF50, 'read': false},
          {'title': 'مزاد ينتهي قريباً', 'body': 'مزاد ساعة رولكس ينتهي بعد ساعة', 'time': 'قبل 5 دقائق', 'icon': Icons.gavel, 'color': 0xFFFF9800, 'read': false},
          {'title': 'رسالة جديدة', 'body': 'أحمد محمد أرسل لك رسالة', 'time': 'قبل ساعة', 'icon': Icons.chat, 'color': 0xFF2196F3, 'read': true},
          {'title': 'تم تأكيد الطلب', 'body': 'تم تأكيد طلبك رقم #1234', 'time': 'أمس', 'icon': Icons.check_circle, 'color': 0xFF4CAF50, 'read': true},
        ];
        _isLoading = false;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الإشعارات'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notifications.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_none, size: 80, color: AppTheme.gold.withOpacity(0.5)),
                      const SizedBox(height: 16),
                      const Text('لا توجد إشعارات', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _notifications.length,
                  itemBuilder: (context, index) {
                    final notification = _notifications[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: notification['read'] ? null : Border.all(color: AppTheme.gold, width: 1),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50, height: 50,
                            decoration: BoxDecoration(
                              color: Color(notification['color']).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(notification['icon'], color: Color(notification['color']), size: 24),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(notification['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(notification['body'], style: const TextStyle(fontSize: 12)),
                                const SizedBox(height: 4),
                                Text(notification['time'], style: const TextStyle(fontSize: 10, color: Colors.grey)),
                              ],
                            ),
                          ),
                          if (!notification['read'])
                            Container(
                              width: 8, height: 8,
                              decoration: const BoxDecoration(color: AppTheme.gold, shape: BoxShape.circle),
                            ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
