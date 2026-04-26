import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        title: const Text('عن التطبيق', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.binanceDark,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            SvgPicture.asset('assets/icons/svg/logo.svg', width: 80, height: 80),
            const SizedBox(height: 16),
            const Text('FLEX YEMEN', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.binanceGold)),
            const SizedBox(height: 8),
            const Text('الإصدار 2.0.0', style: TextStyle(color: Color(0xFF9CA3AF))),
            const SizedBox(height: 40),
            _buildInfoCard(),
            const SizedBox(height: 20),
            _buildLinksCard(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.binanceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.binanceBorder),
      ),
      child: Column(
        children: [
          const Text('Flex Yemen - سوق يمني شامل', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Text(
            'تطبيق متكامل للتجارة الإلكترونية يجمع بين المتاجر والأسواق والمزادات في مكان واحد، مع تجربة مستخدم فاخرة بتصميم Binance الداكن.',
            style: TextStyle(color: Color(0xFF9CA3AF), height: 1.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          _buildInfoRow('المطور', 'Flex Yemen Team'),
          _buildInfoRow('البريد الإلكتروني', 'info@flexyemen.com'),
          _buildInfoRow('الهاتف', '+967 777 123 456'),
        ],
      ),
    );
  }

  Widget _buildLinksCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.binanceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.binanceBorder),
      ),
      child: Column(
        children: [
          const Text('روابط سريعة', style: TextStyle(color: AppTheme.binanceGold, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildLinkTile(Icons.privacy_tip, 'سياسة الخصوصية', () {}),
          _buildLinkTile(Icons.description, 'شروط الاستخدام', () {}),
          _buildLinkTile(Icons.star, 'قيم التطبيق', () {}),
          _buildLinkTile(Icons.share, 'مشاركة التطبيق', () {}),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF9CA3AF))),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildLinkTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.binanceGold),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 16),
      onTap: onTap,
    );
  }
}
