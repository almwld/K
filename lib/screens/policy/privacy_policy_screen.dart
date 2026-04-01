import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'سياسة الخصوصية'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(context, 'مقدمة', 'نحن في Flex Yemen نحترم خصوصيتك ونلتزم بحماية بياناتك الشخصية. توضح هذه السياسة كيفية جمعنا واستخدامنا وحمايتنا لمعلوماتك.'),
            _buildBulletSection(context, 'المعلومات التي نجمعها', [
              'المعلومات الشخصية: الاسم، رقم الهاتف، البريد الإلكتروني، العنوان',
              'معلومات المعاملات: الطلبات، عمليات الشراء، سجل الدفع',
              'المعلومات التقنية: نوع الجهاز، نظام التشغيل، عنوان IP',
              'معلومات الموقع: الموقع الجغرافي لتحسين الخدمة',
            ]),
            _buildBulletSection(context, 'استخدام المعلومات', [
              'تشغيل التطبيق وتقديم الخدمات',
              'معالجة الطلبات والمدفوعات',
              'إرسال الإشعارات والتحديثات',
              'تقديم دعم العملاء',
              'تحسين تجربة المستخدم',
            ]),
            _buildBulletSection(context, 'مشاركة البيانات', [
              'لا نبيع بياناتك لأي طرف ثالث',
              'نشارك فقط مع مزودي الدفع وشركات الشحن',
              'قد نشارك مع السلطات إذا تطلب القانون ذلك',
            ]),
            _buildBulletSection(context, 'حقوق المستخدم', [
              'الحق في الوصول إلى بياناتك',
              'الحق في تعديل معلوماتك',
              'الحق في حذف حسابك',
              'الحق في إيقاف الإشعارات',
            ]),
            _buildSection(context, 'اتصل بنا', 'لأي استفسارات، يرجى التواصل معنا على: privacy@flexyemen.com'),
            const SizedBox(height: 24),
            Text(
              'آخر تحديث: مارس 2026',
              style: TextStyle(color: AppTheme.getSecondaryTextColor(context), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontFamily: 'Changa', fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.goldColor)),
        const SizedBox(height: 8),
        Text(content, style: const TextStyle(height: 1.6)),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildBulletSection(BuildContext context, String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontFamily: 'Changa', fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.goldColor)),
        const SizedBox(height: 8),
        ...items.map((item) => _buildBulletPoint(context, item)),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('- ', style: TextStyle(fontSize: 14, color: AppTheme.goldColor, fontWeight: FontWeight.bold)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14, height: 1.5))),
        ],
      ),
    );
  }
}
