import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإشعارات')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_outlined, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text('لا توجد إشعارات', style: TextStyle(fontSize: 18, color: Colors.grey[600], fontFamily: 'Changa')),
          ],
        ),
      ),
    );
  }
}
