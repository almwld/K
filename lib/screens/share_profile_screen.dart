import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/custom_button.dart';
import '../providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ShareProfileScreen extends StatefulWidget {
  const ShareProfileScreen({super.key});

  @override
  State<ShareProfileScreen> createState() => _ShareProfileScreenState();
}

class _ShareProfileScreenState extends State<ShareProfileScreen> {
  String _profileUrl = '';
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadProfileUrl();
  }
  
  Future<void> _loadProfileUrl() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _profileUrl = 'https://flexyemen.com/profile/user123';
      _isLoading = false;
    });
  }
  
  void _shareProfile() {
    final shareText = '''
🌟 اكتشف ملفي الشخصي على Flex Yemen!
📱 رابط الملف: $_profileUrl
✨ تابعني لترى إعلاناتي ومنتجاتي المميزة
''';
    Share.share(shareText, subject: 'ملفي الشخصي على Flex Yemen');
  }
  
  void _copyLink() {
    // نسخ الرابط
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم نسخ الرابط'), backgroundColor: Colors.green),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authProvider = Provider.of<AuthProvider>(context);
    final userName = authProvider.userName ?? 'مستخدم';
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'مشاركة الملف الشخصي'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // صورة الملف الشخصي
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                          child: const Icon(Icons.person, size: 60, color: AppTheme.goldColor),
                        ),
                        Positioned(
                          bottom: 0, right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppTheme.goldColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.share, size: 16, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userName,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '@${userName.replaceAll(' ', '').toLowerCase()}',
                    style: TextStyle(color: AppTheme.goldColor),
                  ),
                  const SizedBox(height: 24),
                  
                  // QR Code
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
                    ),
                    child: Column(
                      children: [
                        QrImageView(
                          data: _profileUrl,
                          version: QrVersions.auto,
                          size: 180,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'امسح الرمز لمشاهدة ملفي الشخصي',
                          style: TextStyle(color: AppTheme.getSecondaryTextColor(context)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // رابط الملف الشخصي
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.getCardColor(context),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('رابط الملف الشخصي', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark ? AppTheme.darkCard : Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _profileUrl,
                                  style: TextStyle(color: AppTheme.goldColor),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.copy, size: 20),
                                onPressed: _copyLink,
                                tooltip: 'نسخ الرابط',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // إحصائيات سريعة
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.getCardColor(context),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStat('12', 'إعلان'),
                        _buildStat('156', 'متابع'),
                        _buildStat('4.8', 'تقييم'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // أزرار المشاركة
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _shareProfile,
                          icon: const Icon(Icons.share),
                          label: const Text('مشاركة'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.goldColor,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.qr_code),
                          label: const Text('حفظ QR'),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppTheme.goldColor),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // نص توجيهي
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.goldColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: AppTheme.goldColor),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'شارك ملفك الشخصي مع أصدقائك ليروا إعلاناتك ومنتجاتك',
                            style: TextStyle(color: AppTheme.getSecondaryTextColor(context)),
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
  
  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
