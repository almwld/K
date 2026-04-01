import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('شروط الاستخدام', style: TextStyle(fontFamily: 'Changa')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBulletSection(context, 'قبول الشروط', 'باستخدامك للتطبيق، أنت توافق على الالتزام بكافة الشروط المذكورة.', Icons.check_circle),
            _buildBulletSection(context, 'الحسابات', 'يجب أن تكون المعلومات المقدمة عند التسجيل دقيقة ومحدثة دائماً.', Icons.person),
            _buildBulletSection(context, 'المحتوى', 'يُمنع نشر أي محتوى يخالف القوانين أو يمس حقوق الآخرين.', Icons.content_paste),
            _buildBulletSection(context, 'المسؤولية', 'نحن غير مسؤولين عن أي تعاملات تجارية تتم خارج نطاق المنصة الرسمي.', Icons.gavel),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletSection(BuildContext context, String title, String content, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.goldColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(content, style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
