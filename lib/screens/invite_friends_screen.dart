import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'package:share_plus/share_plus.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  Future<void> _shareInvite(BuildContext context) async {
    final url = 'https://example.com/invite?ref=USER123';
    try {
      await Share.share('انضم إلى التطبيق الرائع هذا: $url');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم مشاركة رابط الدعوة')));
    } catch (_) {
      // Fallback: copy to clipboard
      await Clipboard.setData(ClipboardData(text: url));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('نسخ رابط الدعوة إلى الحافظة')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textStyle = Theme.of(context).textTheme.titleLarge; // استخدم titleLarge بدلاً من headline6
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'دعوة الأصدقاء'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('ادعُ أصدقائك واحصل على مكافآت', style: textStyle),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text('رابط الدعوة الخاص بك', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  SelectableText('https://example.com/invite?ref=USER123'),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () => _shareInvite(context),
                    icon: const Icon(Icons.share),
                    label: const Text('مشاركة'),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold, foregroundColor: Colors.black),
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

