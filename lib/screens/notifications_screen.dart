import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/shimmer_effect.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, dynamic>> _notifications = [];
  bool _isLoading = true;

  final List<Map<String, dynamic>> _sampleNotifications = [
    {'title': 'طلب جديد', 'body': 'لديك طلب جديد على منتج آيفون 15', 'time': 'الآن', 'icon': Icons.shopping_cart, 'color': 0xFF4CAF50, 'isRead': false},
    {'title': 'مزاد ينتهي قريباً', 'body': 'مزاد ساعة رولكس ينتهي بعد ساعة', 'time': 'قبل 5 دقائق', 'icon': Icons.gavel, 'color': 0xFFFF9800, 'isRead': false},
    {'title': 'رسالة جديدة', 'body': 'أحمد محمد أرسل لك رسالة', 'time': 'قبل ساعة', 'icon': Icons.chat, 'color': 0xFF2196F3, 'isRead': false},
    {'title': 'تم تأكيد الطلب', 'body': 'تم تأكيد طلبك رقم #1234', 'time': 'أمس', 'icon': Icons.check_circle, 'color': 0xFF4CAF50, 'isRead': true},
    {'title': 'عرض خاص', 'body': 'خصم 20% على جميع المنتجات', 'time': 'أمس', 'icon': Icons.local_offer, 'color': 0xFFE74C3C, 'isRead': true},
  ];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _notifications = List.from(_sampleNotifications);
      _isLoading = false;
    });
  }

  void _markAsRead(int index) {
    setState(() {
      _notifications[index]['isRead'] = true;
    });
  }

  void _clearAll() {
    setState(() {
      _notifications.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم مسح جميع الإشعارات')),
    );
  }

  int get _unreadCount {
    return _notifications.where((n) => n['isRead'] == false).length;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(
        title: 'الإشعارات',
        actions: [
          if (_notifications.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _clearAll,
            ),
        ],
      ),
      body: _isLoading
          ? ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 5,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    const CustomShimmer(width: 50, height: 50, borderRadius: BorderRadius.all(Radius.circular(25))),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomShimmer(width: 120, height: 16),
                          const SizedBox(height: 4),
                          const CustomShimmer(width: double.infinity, height: 12),
                          const SizedBox(height: 4),
                          const CustomShimmer(width: 60, height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : _notifications.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_none, size: 80, color: AppTheme.goldColor.withOpacity(0.5)),
                      const SizedBox(height: 16),
                      const Text('لا توجد إشعارات', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('سيظهر هنا إشعارات الطلبات والمزادات', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
                    ],
                  ),
                )
              : Column(
                  children: [
                    if (_unreadCount > 0)
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.goldColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('لديك $_unreadCount إشعار غير مقروء', style: const TextStyle(fontWeight: FontWeight.bold)),
                            TextButton(
                              onPressed: () {
                                for (int i = 0; i < _notifications.length; i++) {
                                  _markAsRead(i);
                                }
                              },
                              child: const Text('تحديد الكل كمقروء'),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _notifications.length,
                        itemBuilder: (context, index) {
                          final notification = _notifications[index];
                          final isRead = notification['isRead'] == true;
                          return GestureDetector(
                            onTap: () => _markAsRead(index),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isRead ? AppTheme.getCardColor(context) : AppTheme.goldColor.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(16),
                                border: isRead ? null : Border.all(color: AppTheme.goldColor.withOpacity(0.5)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50, height: 50,
                                    decoration: BoxDecoration(
                                      color: Color(notification['color']).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Icon(notification['icon'], color: Color(notification['color']), size: 24),
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
                                            color: AppTheme.getTextColor(context),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          notification['body'],
                                          style: TextStyle(fontSize: 12, color: AppTheme.getSecondaryTextColor(context)),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          notification['time'],
                                          style: TextStyle(fontSize: 10, color: AppTheme.getSecondaryTextColor(context)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (!isRead)
                                    Container(
                                      width: 10, height: 10,
                                      decoration: const BoxDecoration(color: AppTheme.goldColor, shape: BoxShape.circle),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
