import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class PrivacyBlockScreen extends StatefulWidget {
  const PrivacyBlockScreen({super.key});

  @override
  State<PrivacyBlockScreen> createState() => _PrivacyBlockScreenState();
}

class _PrivacyBlockScreenState extends State<PrivacyBlockScreen> {
  final List<String> blocked = ['user123', 'spam_account'];

  void _unblock(int i) {
    setState(() => blocked.removeAt(i));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إلغاء الحظر')));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الخصوصية والحظر'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.visibility_off),
              title: const Text('من يستطيع رؤية ملفي؟'),
              subtitle: const Text('التحكم في من يرى نشاطك ومعلوماتك'),
              onTap: () {},
            ),
            const SizedBox(height: 12),
            const Text('المستخدمين المحظورين', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: blocked.isEmpty
                  ? Center(child: Text('لا توجد حسابات محظورة', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))))
                  : ListView.separated(
                      itemCount: blocked.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, i) {
                        return ListTile(
                          tileColor: AppTheme.getCardColor(context),
                          title: Text(blocked[i]),
                          trailing: TextButton(onPressed: () => _unblock(i), child: const Text('إلغاء الحظر', style: TextStyle(color: Colors.red))),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
