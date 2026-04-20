import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _showProfileToAll = true;
  bool _showPhoneNumber = false;
  bool _showEmail = false;
  bool _allowMessages = true;
  bool _showOnlineStatus = true;
  bool _shareActivity = false;
  bool _allowSearchByPhone = false;
  bool _dataAnalytics = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const SimpleAppBar(title: 'إعدادات الخصوصية'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Visibility
          _sectionTitle('رؤية الملف الشخصي'),
          _buildCard([
            _buildSwitchTile(
              icon: Icons.visibility,
              title: 'عرض الملف للجميع',
              subtitle: 'السماح للمستخدمين برؤية ملفك',
              value: _showProfileToAll,
              onChanged: (v) => setState(() => _showProfileToAll = v),
            ),
          ]),
          const SizedBox(height: 20),

          // Contact Info
          _sectionTitle('معلومات التواصل'),
          _buildCard([
            _buildSwitchTile(
              icon: Icons.phone,
              title: 'عرض رقم الهاتف',
              subtitle: 'السماح برؤية رقمك',
              value: _showPhoneNumber,
              onChanged: (v) => setState(() => _showPhoneNumber = v),
            ),
            _buildSwitchTile(
              icon: Icons.email,
              title: 'عرض البريد الإلكتروني',
              subtitle: 'السماح برؤية بريدك',
              value: _showEmail,
              onChanged: (v) => setState(() => _showEmail = v),
            ),
            _buildSwitchTile(
              icon: Icons.message,
              title: 'السماح بالرسائل',
              subtitle: 'استقبال رسائل من المستخدمين',
              value: _allowMessages,
              onChanged: (v) => setState(() => _allowMessages = v),
            ),
          ]),
          const SizedBox(height: 20),

          // Online Status
          _sectionTitle('الحالة والنشاط'),
          _buildCard([
            _buildSwitchTile(
              icon: Icons.circle,
              title: 'عرض حالة الاتصال',
              subtitle: 'إظهار أنك متصل',
              value: _showOnlineStatus,
              onChanged: (v) => setState(() => _showOnlineStatus = v),
            ),
            _buildSwitchTile(
              icon: Icons.share,
              title: 'مشاركة النشاط',
              subtitle: 'إظهار مشترياتك وتقييماتك',
              value: _shareActivity,
              onChanged: (v) => setState(() => _shareActivity = v),
            ),
            _buildSwitchTile(
              icon: Icons.search,
              title: 'البحث برقم الهاتف',
              subtitle: 'السماح بالعثور عليك برقمك',
              value: _allowSearchByPhone,
              onChanged: (v) => setState(() => _allowSearchByPhone = v),
            ),
          ]),
          const SizedBox(height: 20),

          // Data & Analytics
          _sectionTitle('البيانات والتحليلات'),
          _buildCard([
            _buildSwitchTile(
              icon: Icons.analytics,
              title: 'تحليلات البيانات',
              subtitle: 'تحسين التجربة باستخدام بياناتك',
              value: _dataAnalytics,
              onChanged: (v) => setState(() => _dataAnalytics = v),
            ),
          ]),
          const SizedBox(height: 20),

          // Danger Zone
          _sectionTitle('منطقة الخطر'),
          _buildCard([
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6465D).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.delete_forever, color: Color(0xFFF6465D), size: 22),
              ),
              title: const Text(
                'حذف البيانات',
                style: TextStyle(color: Color(0xFFF6465D), fontWeight: FontWeight.w600),
              ),
              subtitle: const Text('حذف جميع بياناتك نهائياً', style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFF6465D)),
              onTap: () => _showDeleteDialog(context),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, right: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Changa',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFFF0B90B),
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2329),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF0B90B).withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFFF0B90B), size: 22),
      ),
      title: Text(title, style: const TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFFF0B90B),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E2329),
        title: const Text('حذف البيانات', style: TextStyle(fontFamily: 'Changa', color: Color(0xFFF6465D))),
        content: const Text(
          'هل أنت متأكد من حذف جميع بياناتك؟ هذا الإجراء لا يمكن التراجع عنه.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(color: Color(0xFF9CA3AF))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم إرسال طلب الحذف', style: TextStyle(fontFamily: 'Changa')),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF6465D)),
            child: const Text('حذف', style: TextStyle(fontFamily: 'Changa')),
          ),
        ],
      ),
    );
  }
}
