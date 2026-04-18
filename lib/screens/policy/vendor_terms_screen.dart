import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class VendorTermsScreen extends StatelessWidget {
  const VendorTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'شروط التجار'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBulletSection(context, 'المنتجات', [
              'يجب أن تكون المنتجات أصلية وغير مقلدة',
              'يمنع بيع المنتجات المخالفة للقوانين',
              'يجب تقديم وصف دقيق وصور حقيقية',
            ]),
            _buildBulletSection(context, 'العمولات وسحب الأرباح', [
              'نسبة عمولة محددة على كل عملية بيع',
              'السحب عبر المحفظة الإلكترونية لـ Flex',
              'الحد الأدنى للسحب: 10,000 ر.ي',
            ]),
            _buildBulletSection(context, 'العقوبات', [
              'إنذار أولي في حال المخالفة',
              'تعليق مؤقت أو حظر نهائي للحسابات المتلاعبة',
            ]),
            const SizedBox(height: 24),
            Text(
              'آخر تحديث: مارس 2026',
              style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletSection(BuildContext context, String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontFamily: 'Changa', fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.goldPrimary)),
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
          const Text('- ', style: TextStyle(fontSize: 14, color: AppTheme.goldPrimary, fontWeight: FontWeight.bold)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14, height: 1.5))),
        ],
      ),
    );
  }
}
