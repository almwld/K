import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/custom_button.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;
  
  final List<Map<String, dynamic>> _contactMethods = [
    {'icon': Icons.phone, 'title': 'الهاتف', 'value': '+967 777 123 456', 'color': 0xFF4CAF50, 'action': 'tel:+967777123456'},
    {'icon': Icons.email, 'title': 'البريد الإلكتروني', 'value': 'support@flexyemen.com', 'color': 0xFF2196F3, 'action': 'mailto:support@flexyemen.com'},
    {'icon': Icons.chat, 'title': 'واتساب', 'value': '+967 777 123 456', 'color': 0xFF25D366, 'action': 'https://wa.me/967777123456'},
    {'icon': Icons.location_on, 'title': 'العنوان', 'value': 'صنعاء، اليمن', 'color': 0xFFFF9800, 'action': null},
  ];
  
  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
  
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isSubmitting = false);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إرسال رسالتك بنجاح! سنتواصل معك قريباً'), backgroundColor: Colors.green),
    );
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'اتصل بنا'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // طرق التواصل
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _contactMethods.length,
              itemBuilder: (context, index) {
                final method = _contactMethods[index];
                return GestureDetector(
                  onTap: method['action'] != null ? () => _launchUrl(method['action']) : null,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Color(method['color']).withOpacity(0.3)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(method['icon'], color: Color(method['color']), size: 32),
                        const SizedBox(height: 8),
                        Text(method['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(method['value'], style: const TextStyle(fontSize: 10), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            
            // نموذج الاتصال
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text('أرسل لنا رسالة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'الاسم الكامل', border: OutlineInputBorder()),
                      validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'البريد الإلكتروني', border: OutlineInputBorder()),
                      validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _messageController,
                      maxLines: 4,
                      decoration: const InputDecoration(labelText: 'الرسالة', border: OutlineInputBorder()),
                      validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      text: 'إرسال',
                      onPressed: _submitForm,
                      isLoading: _isSubmitting,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // ساعات العمل
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.gold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.access_time, color: AppTheme.gold),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('ساعات العمل', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('السبت - الخميس: 9 صباحاً - 9 مساءً'),
                        Text('الجمعة: مغلق'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
