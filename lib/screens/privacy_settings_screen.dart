import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _showProfile = true;
  bool _showEmail = false;
  bool _showPhone = true;
  bool _showLocation = false;
  bool _allowMessages = true;
  bool _allowComments = true;
  bool _dataSharing = false;
  bool _personalizedAds = true;
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'إعدادات الخصوصية'),
      body: ListView(
        children: [
          _buildSection('من يمكنه رؤية معلوماتي'),
          _buildSwitch('الملف الشخصي', 'عرض معلوماتك الشخصية', _showProfile, (v) => setState(() => _showProfile = v)),
          _buildSwitch('البريد الإلكتروني', 'عرض بريدك الإلكتروني', _showEmail, (v) => setState(() => _showEmail = v)),
          _buildSwitch('رقم الهاتف', 'عرض رقم هاتفك', _showPhone, (v) => setState(() => _showPhone = v)),
          _buildSwitch('الموقع', 'عرض موقعك الجغرافي', _showLocation, (v) => setState(() => _showLocation = v)),
          
          _buildSection('التفاعل مع الآخرين'),
          _buildSwitch('الرسائل الخاصة', 'السماح للآخرين بإرسال رسائل لك', _allowMessages, (v) => setState(() => _allowMessages = v)),
          _buildSwitch('التعليقات', 'السماح بالتعليقات على إعلاناتك', _allowComments, (v) => setState(() => _allowComments = v)),
          
          _buildSection('البيانات والإعلانات'),
          _buildSwitch('مشاركة البيانات', 'السماح بمشاركة بياناتك لتحسين الخدمة', _dataSharing, (v) => setState(() => _dataSharing = v)),
          _buildSwitch('إعلانات مخصصة', 'عرض إعلانات مخصصة بناءً على اهتماماتك', _personalizedAds, (v) => setState(() => _personalizedAds = v)),
          
          _buildSection('البيانات المحفوظة'),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppTheme.goldPrimary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.download, color: AppTheme.goldPrimary),
            ),
            title: const Text('تحميل بياناتي'),
            subtitle: const Text('احصل على نسخة من بياناتك'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('جاري تحضير بياناتك...'), backgroundColor: AppTheme.goldPrimary),
              );
            },
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.delete_forever, color: Colors.red),
            ),
            title: const Text('حذف حسابي', style: TextStyle(color: Colors.red)),
            subtitle: const Text('حذف حسابك وجميع بياناتك نهائياً'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red),
            onTap: () => _showDeleteAccountDialog(),
          ),
          
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم حفظ إعدادات الخصوصية'), backgroundColor: Colors.green),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.goldPrimary,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('حفظ الإعدادات'),
            ),
          ),
        ],
      ),
    );
  }
  
  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف الحساب', style: TextStyle(color: Colors.red)),
        content: const Text(
          'هل أنت متأكد من رغبتك في حذف حسابك؟\n\n'
          'سيتم حذف جميع بياناتك بشكل نهائي:\n'
          '• المنتجات والإعلانات\n'
          '• الطلبات والسجل\n'
          '• المحفظة والرصيد\n'
          '• المحادثات والرسائل\n\n'
          'هذا الإجراء لا يمكن التراجع عنه.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('جاري حذف الحساب...'), backgroundColor: Colors.red),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('تأكيد الحذف'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(title, style: const TextStyle(color: AppTheme.goldPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }
  
  Widget _buildSwitch(String title, String subtitle, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      value: value,
      onChanged: onChanged,
      activeColor: AppTheme.goldPrimary,
    );
  }
}
