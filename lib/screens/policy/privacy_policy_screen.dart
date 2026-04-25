import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'سياسة الخصوصية'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('مقدمة', 'نحن في Flex Yemen نلتزم بحماية خصوصيتك وبياناتك الشخصية. توضح هذه السياسة كيفية جمعنا واستخدامنا وحمايتنا لمعلوماتك.'),
            _buildBulletSection('المعلومات التي نجمعها', [
              'الاسم الكامل، البريد الإلكتروني، رقم الهاتف',
              'معلومات الدفع والمعاملات المالية',
              'بيانات الموقع الجغرافي',
              'سجل التصفح والبحث',
              'الصور والمستندات التي ترفعها',
            ]),
            _buildBulletSection('كيف نستخدم معلوماتك', [
              'توفير وتحسين خدمات المنصة',
              'معالجة الطلبات والمدفوعات',
              'التواصل معك بشأن حسابك وطلباتك',
              'إرسال العروض والتحديثات (يمكنك إلغاء الاشتراك)',
              'الامتثال للالتزامات القانونية',
            ]),
            _buildBulletSection('حماية المعلومات', [
              'نستخدم تشفير SSL لحماية بياناتك',
              'نخزن بياناتك على خوادم آمنة',
              'نحدد الوصول إلى بياناتك للموظفين المصرح لهم فقط',
              'نقوم بمراجعات أمنية دورية',
            ]),
            _buildBulletSection('مشاركة المعلومات', [
              'لا نبيع بياناتك لأي طرف ثالث',
              'نشارك المعلومات مع شركات الشحن لتوصيل الطلبات',
              'قد نشارك المعلومات مع السلطات إذا تطلب القانون ذلك',
            ]),
            _buildBulletSection('حقوقك', [
              'الحق في الوصول إلى بياناتك',
              'الحق في تصحيح بياناتك',
              'الحق في حذف بياناتك',
              'الحق في نقل بياناتك',
              'الحق في الاعتراض على معالجة بياناتك',
            ]),
            _buildSection('ملفات تعريف الارتباط (Cookies)', 'نستخدم ملفات تعريف الارتباط لتحسين تجربتك. يمكنك تعطيلها من إعدادات المتصفح.'),
            _buildSection('تخزين البيانات', 'نحتفظ ببياناتك طالما أن حسابك نشط. يمكنك طلب حذف بياناتك في أي وقت.'),
            _buildSection('خصوصية الأطفال', 'لا نستخدم خدماتنا للأطفال دون سن 18 عاماً. إذا علمنا بذلك، سنحذف الحساب فوراً.'),
            _buildSection('التعديلات', 'قد نقوم بتحديث سياسة الخصوصية من وقت لآخر. سنقوم بإشعارك بأي تغييرات جوهرية.'),
            _buildSection('اتصل بنا', 'للاستفسارات: privacy@flexyemen.com'),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.binanceGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'آخر تحديث: 1 أبريل 2026',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.binanceGold)),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildBulletSection(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.binanceGold)),
          const SizedBox(height: 8),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 4, right: 16),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('• ', style: TextStyle(fontSize: 16, color: AppTheme.binanceGold)),
              Expanded(child: Text(item)),
            ]),
          )),
        ],
      ),
    );
  }
}

