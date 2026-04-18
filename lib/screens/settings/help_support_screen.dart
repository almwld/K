import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  final List<Map<String, dynamic>> faqs = const [
    {'q': 'كيف أضيف إعلاناً؟', 'a': 'اضغط على زر + في الشريط السفلي واختر "إضافة إعلان"'},
    {'q': 'كيف أتواصل مع البائع؟', 'a': 'ادخل على الإعلان واضغط على زر "دردش"'},
    {'q': 'كيف أشتري؟', 'a': 'اختر المنتج ثم اضغط "اشتري الآن" واتبع خطوات الدفع'},
    {'q': 'كيف أحول رصيد؟', 'a': 'ادخل المحفظة واختر "تحويل" ثم أدخل رقم المستلم'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المساعدة والدعم'),
      body: ListView(
        children: [
          // البحث
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ابحث في المساعدة...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          
          // الأسئلة الشائعة
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'الأسئلة الشائعة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          
          ...faqs.map((faq) => ExpansionTile(
            title: Text(faq['q']!),
            children: [Padding(
              padding: const EdgeInsets.all(16),
              child: Text(faq['a']!, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
            )],
          )),
          
          // تواصل معنا
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'تواصل معنا',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          
          _buildContactCard(Icons.chat, 'الدردشة المباشرة', 'تحدث مع فريق الدعم', () {
            Navigator.pushNamed(context, '/live_support');
          }),
          _buildContactCard(Icons.email, 'البريد الإلكتروني', 'support@flexyemen.com', () {}),
          _buildContactCard(Icons.phone, 'الهاتف', '777 123 456', () {}),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildContactCard(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.goldPrimary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppTheme.goldPrimary),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
