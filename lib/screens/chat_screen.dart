import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المحادثات'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('لا توجد محادثات', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            const Text('سيتم إضافة المحادثات قريباً', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
