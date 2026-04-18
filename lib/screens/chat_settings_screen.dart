import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class ChatSettingsScreen extends StatefulWidget {
  const ChatSettingsScreen({super.key});

  @override
  State<ChatSettingsScreen> createState() => _ChatSettingsScreenState();
}

class _ChatSettingsScreenState extends State<ChatSettingsScreen> {
  bool realtimeEnabled = true;
  bool readReceipts = true;
  bool typingIndicator = true;
  bool allowFiles = true;
  bool allowEmoji = true;
  bool dailyStatus = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'إعدادات المحادثة'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('إرسال مباشر (Realtime)'),
            subtitle: const Text('تفعيل التحديث الفوري للرسائل'),
            value: realtimeEnabled,
            onChanged: (v) => setState(() => realtimeEnabled = v),
            activeColor: AppTheme.gold,
          ),
          SwitchListTile(
            title: const Text('إظهار حالة الكتابة'),
            value: typingIndicator,
            onChanged: (v) => setState(() => typingIndicator = v),
            activeColor: AppTheme.gold,
          ),
          SwitchListTile(
            title: const Text('تأكيدات القراءة'),
            value: readReceipts,
            onChanged: (v) => setState(() => readReceipts = v),
            activeColor: AppTheme.gold,
          ),
          SwitchListTile(
            title: const Text('السماح بمشاركة الملفات والمستندات'),
            value: allowFiles,
            onChanged: (v) => setState(() => allowFiles = v),
            activeColor: AppTheme.gold,
          ),
          SwitchListTile(
            title: const Text('السماح بالإيموجي'),
            value: allowEmoji,
            onChanged: (v) => setState(() => allowEmoji = v),
            activeColor: AppTheme.gold,
          ),
          SwitchListTile(
            title: const Text('الحالات اليومية'),
            subtitle: const Text('عرض وإمكانية مشاركة حالات يومية (Stories)'),
            value: dailyStatus,
            onChanged: (v) => setState(() => dailyStatus = v),
            activeColor: AppTheme.gold,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم حفظ إعدادات الدردشة')));
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold, foregroundColor: Colors.black),
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }
}
