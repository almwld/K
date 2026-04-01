import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class LiveSupportScreen extends StatelessWidget {
  const LiveSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الدعم المباشر'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.getCardColor(context),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const CircleAvatar(child: Icon(Icons.headset_mic)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('الدردشة مع الدعم', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('متوفر 24/7', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // open chat or start live call
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black),
                    child: const Text('بدء الدردشة'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.help_outline),
                    title: const Text('الأسئلة الشائعة'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.email_outlined),
                    title: const Text('إرسال بريد للدعم'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone_outlined),
                    title: const Text('الاتصال بنا'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
