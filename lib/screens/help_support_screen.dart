import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  final List<Map<String, dynamic>> _supportOptions = const [
    {'icon': Icons.chat_bubble_outline, 'title': 'الدردشة المباشرة', 'subtitle': 'تحدث مع فريق الدعم', 'route': '/live_support'},
    {'icon': Icons.email_outlined, 'title': 'البريد الإلكتروني', 'subtitle': 'support@flexyemen.com', 'route': null},
    {'icon': Icons.phone_outlined, 'title': 'الهاتف', 'subtitle': '777-123-456', 'route': null},
    {'icon': Icons.help_outline, 'title': 'الأسئلة الشائعة', 'subtitle': 'إجابات على أسئلتك', 'route': '/faq'},
    {'icon': Icons.confirmation_number_outlined, 'title': 'تذاكر الدعم', 'subtitle': 'تتبع طلباتك', 'route': '/support_tickets'},
    {'icon': Icons.report_problem_outlined, 'title': 'الإبلاغ عن مشكلة', 'subtitle': 'أبلغ عن مشكلة', 'route': '/report_problem'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المساعدة والدعم'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.goldColor, AppTheme.goldLight],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(Icons.support_agent, size: 64, color: Colors.black),
                  const SizedBox(height: 16),
                  const Text(
                    'كيف يمكننا مساعدتك؟',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'فريق الدعم متواجد على مدار الساعة',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'خيارات الدعم',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ..._supportOptions.map((option) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.goldColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(option['icon'] as IconData, color: AppTheme.goldColor),
                  ),
                  title: Text(option['title'] as String),
                  subtitle: Text(option['subtitle'] as String),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: option['route'] != null
                      ? () => Navigator.pushNamed(context, option['route'] as String)
                      : null,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
