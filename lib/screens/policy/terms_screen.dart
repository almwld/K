import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الشروط والأحكام'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('مقدمة', 'مرحباً بك في منصة Flex Yemen. باستخدامك للمنصة، فإنك توافق على الالتزام بهذه الشروط والأحكام. يرجى قراءتها بعناية.'),
            _buildSection('الحساب والتسجيل', '• يجب أن تقدم معلومات دقيقة وكاملة عند التسجيل.\n• أنت مسؤول عن الحفاظ على سرية حسابك وكلمة المرور.\n• يحق لنا تعليق أو إنهاء حسابك في حال مخالفة الشروط.'),
            _buildSection('المنتجات والمبيعات', '• البائع مسؤول عن دقة وصف المنتج وصوره.\n• جميع المبيعات نهائية إلا في حالات محددة.\n• يتحمل البائع مسؤولية الشحن والتسليم.'),
            _buildSection('المحفظة والمدفوعات', '• المحفظة الإلكترونية هي وسيلة دفع آمنة داخل المنصة.\n• الإيداع في المحفظة غير قابل للاسترداد.\n• الحد الأدنى للسحب من المحفظة هو 10,000 ريال.\n• عمولة السحب 2% من قيمة المبلغ.\n• يحق للمنصة تجميد المحفظة في حال الاشتباه بأي نشاط غير قانوني.\n• المبالغ المحولة بشكل خاطئ غير قابلة للاسترداد بعد إتمام التحويل.'),
            _buildSection('المزادات', '• المزايدة ملزمة وقانونية بمجرد تقديمها.\n• الفائز ملزم بدفع المبلغ النهائي خلال 24 ساعة.\n• في حال عدم الدفع، يتم حظر الحساب وتجميد المحفظة.\n• رسوم المزاد 5% من قيمة المنتج النهائية.'),
            _buildSection('الخصوصية والبيانات', '• نحن نحمي بياناتك وفقاً لسياسة الخصوصية.\n• لن نشارك بياناتك مع أطراف ثالثة دون إذنك.\n• يحق لك طلب حذف بياناتك في أي وقت.'),
            _buildSection('المخالفات والعقوبات', '• إنذار أولي في حال المخالفة الأولى.\n• تعليق الحساب لمدة 30 يوم للمخالفة الثانية.\n• حظر دائم للحساب للمخالفة الثالثة.\n• تجميد المحفظة واسترداد الأموال خلال 60 يوم.'),
            _buildSection('التعديلات', 'نحتفظ بالحق في تعديل هذه الشروط في أي وقت. سيتم إشعارك بأي تغييرات جوهرية.'),
            _buildSection('القانون الواجب التطبيق', 'تخضع هذه الشروط لقوانين الجمهورية اليمنية.'),
            _buildSection('اتصل بنا', 'للاستفسارات: support@flexyemen.com'),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.goldPrimary.withOpacity(0.1),
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
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.goldPrimary)),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(height: 1.5)),
        ],
      ),
    );
  }
}
