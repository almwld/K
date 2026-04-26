import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  final List<Map<String, dynamic>> _contactMethods = const [
    {'icon': Icons.phone, 'title': 'اتصال', 'value': '+967 777 123 456', 'color': 0xFF4CAF50, 'action': 'tel'},
    {'icon': Icons.chat, 'title': 'واتساب', 'value': '+967 777 123 456', 'color': 0xFF25D366, 'action': 'whatsapp'},
    {'icon': Icons.email, 'title': 'بريد إلكتروني', 'value': 'info@flexyemen.com', 'color': 0xFFD4AF37, 'action': 'mail'},
    {'icon': Icons.location_on, 'title': 'العنوان', 'value': 'صنعاء، الستين', 'color': 0xFF2196F3, 'action': 'map'},
  ];

  final List<Map<String, dynamic>> _socialMedia = const [
    {'icon': Icons.facebook, 'name': 'فيسبوك', 'url': 'https://facebook.com/flexyemen', 'color': 0xFF1877F2},
    {'icon': Icons.camera_alt, 'name': 'انستغرام', 'url': 'https://instagram.com/flexyemen', 'color': 0xFFE4405F},
    {'icon': Icons.chat, 'name': 'تويتر', 'url': 'https://twitter.com/flexyemen', 'color': 0xFF1DA1F2},
    {'icon': Icons.play_circle, 'name': 'يوتيوب', 'url': 'https://youtube.com/flexyemen', 'color': 0xFFFF0000},
  ];

  Future<void> _launchAction(Map<String, dynamic> method) async {
    String url;
    switch (method['action']) {
      case 'tel':
        url = 'tel:${method['value'].replaceAll(' ', '')}';
        break;
      case 'whatsapp':
        url = 'https://wa.me/${method['value'].replaceAll(' ', '').replaceAll('+', '')}';
        break;
      case 'mail':
        url = 'mailto:${method['value']}';
        break;
      case 'map':
        url = 'https://maps.google.com/?q=${Uri.encodeComponent(method['value'])}';
        break;
      default:
        return;
    }
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('تواصل معنا', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: AppTheme.goldGradient,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('FLX', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
            ),
            const SizedBox(height: 16),
            const Text('فلكس يمن', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ..._contactMethods.map((method) => _buildContactCard(method, isDark)),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('وسائل التواصل الاجتماعي', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: _socialMedia.map((social) => _buildSocialButton(social, isDark)).toList(),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(Map<String, dynamic> method, bool isDark) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      color: isDark ? AppTheme.binanceCard : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(method['color'] as int).withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(method['icon'], color: Color(method['color'] as int)),
        ),
        title: Text(method['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(method['value'], style: const TextStyle(color: Color(0xFF9CA3AF))),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF5E6673)),
        onTap: () => _launchAction(method),
      ),
    );
  }

  Widget _buildSocialButton(Map<String, dynamic> social, bool isDark) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(social['url']))) {
          await launchUrl(Uri.parse(social['url']));
        }
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Color(social['color'] as int).withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(social['icon'], color: Color(social['color'] as int), size: 28),
            const SizedBox(height: 4),
            Text(social['name'], style: const TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
