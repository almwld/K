import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الشروط والأحكام'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مرحباً بك في فلكس اليمن',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.goldColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'باستخدامك لتطبيق فلكس اليمن، فإنك توافق على الشروط والأحكام التالية:',
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.getTextColor(context),
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              '1. الحساب والتسجيل',
              '• يجب أن يكون عمرك 18 سنة أو أكثر.\n'
              '• يجب تقديم معلومات صحيحة وكاملة عند التسجيل.\n'
              '• أنت مسؤول عن الحفاظ على سرية حسابك.\n'
              '• يحق لنا إلغاء حسابك في حال مخالفة الشروط.',
            ),
            _buildSection(
              context,
              '2. المشتريات والمدفوعات',
              '• جميع الأسعار معروضة بالريال اليمني.\n'
              '• نقبل الدفع عبر المحفظة الرقمية والبطاقات الائتمانية.\n'
              '• يتم تأكيد الطلب بعد استلام الدفع.\n'
              '• يمكنك إلغاء الطلب خلال 24 ساعة من الشراء.',
            ),
            _buildSection(
              context,
              '3. التوصيل والشحن',
              '• نوفر خدمة التوصيل لجميع محافظات اليمن.\n'
              '• وقت التوصيل يتراوح بين 3-7 أيام عمل.\n'
              '• رسوم التوصيل تحسب حسب الموقع والوزن.\n'
              '• يمكنك تتبع طلبك من خلال التطبيق.',
            ),
            _buildSection(
              context,
              '4. الإرجاع والاستبدال',
              '• يمكنك إرجاع المنتج خلال 14 يوماً من الاستلام.\n'
              '• يجب أن يكون المنتج بحالته الأصلية.\n'
              '• لا نقبل إرجاع المنتجات الغذائية والطبية.\n'
              '• يتم استرداد المبلغ خلال 7 أيام عمل.',
            ),
            _buildSection(
              context,
              '5. الخصوصية والأمان',
              '• نحن نحمي بياناتك الشخصية ولا نشاركها مع أطراف ثالثة.\n'
              '• يمكنك طلب حذف بياناتك في أي وقت.\n'
              '• نستخدم تقنيات تشفير متقدمة لحماية مدفوعاتك.',
            ),
            _buildSection(
              context,
              '6. التعديلات على الشروط',
              '• نحتفظ بالحق في تعديل هذه الشروط في أي وقت.\n'
              '• سيتم إخطارك بأي تغييرات جوهرية.\n'
              '• استمرار استخدامك للتطبيق يعني موافقتك على التعديلات.',
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.goldColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'للتواصل والدعم',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.goldColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'البريد الإلكتروني: support@flexyemen.com',
                    style: TextStyle(color: AppTheme.getSecondaryTextColor(context)),
                  ),
                  Text(
                    'الهاتف: 777777777',
                    style: TextStyle(color: AppTheme.getSecondaryTextColor(context)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                'آخر تحديث: 1 يناير 2024',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.getSecondaryTextColor(context),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.goldColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: AppTheme.getTextColor(context),
            ),
          ),
          const Divider(height: 24),
        ],
      ),
    );
  }
}
