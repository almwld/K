import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'حول التطبيق'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // الشعار
            Container(
              width: 100, height: 100,
              decoration: BoxDecoration(
                gradient: AppTheme.goldGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.shopping_bag, size: 50, color: Colors.black),
            ),
            const SizedBox(height: 16),
            const Text(
              'Flex Yemen',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'الإصدار 2.0.0',
              style: TextStyle(color: AppTheme.gold),
            ),
            const SizedBox(height: 24),
            
            // معلومات التطبيق
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildInfoRow('المطور', 'Flex Yemen Team'),
                  _buildInfoRow('تاريخ الإصدار', 'أبريل 2026'),
                  _buildInfoRow('الترخيص', 'جميع الحقوق محفوظة'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // المميزات
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('المميزات الرئيسية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildFeature(Icons.shopping_cart, 'متجر متكامل', 'بيع وشراء المنتجات بسهولة'),
                  _buildFeature(Icons.gavel, 'مزادات حية', 'شارك في المزادات وتفاعل مع العروض'),
                  _buildFeature(Icons.account_balance_wallet, 'محفظة إلكترونية', 'إدارة أموالك بكل أمان'),
                  _buildFeature(Icons.chat, 'دردشة فورية', 'تواصل مع البائعين والعملاء'),
                  _buildFeature(Icons.map, 'خريطة تفاعلية', 'اعثر على المتاجر القريبة منك'),
                  _buildFeature(Icons.bolt, 'AI مساعد ذكي', 'اسأل واحصل على إجابات فورية'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // روابط
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.privacy_tip),
                    title: const Text('سياسة الخصوصية'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => Navigator.pushNamed(context, '/privacy_policy'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: const Text('الشروط والأحكام'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => Navigator.pushNamed(context, '/terms'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.share),
                    title: const Text('مشاركة التطبيق'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text(
              '© 2026 Flex Yemen. جميع الحقوق محفوظة',
              style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
  
  Widget _buildFeature(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.gold.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppTheme.gold, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(description, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
