import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkMode = true;
  bool _saveData = false;
  String _language = 'العربية';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        title: const Text('الإعدادات', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: [
          _buildSection('الحساب', [
            _buildListTile(Icons.person_outline, 'تعديل الملف الشخصي'),
            _buildListTile(Icons.lock_outline, 'تغيير كلمة المرور'),
            _buildListTile(Icons.phone_outlined, 'رقم الجوال'),
          ]),
          _buildSection('التفضيلات', [
            SwitchListTile(
              title: const Text('الإشعارات', style: TextStyle(color: Colors.white)),
              subtitle: const Text('تفعيل إشعارات التطبيق', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
              value: _notificationsEnabled,
              activeColor: const Color(0xFFD4AF37),
              onChanged: (value) => setState(() => _notificationsEnabled = value),
            ),
            SwitchListTile(
              title: const Text('الوضع الداكن', style: TextStyle(color: Colors.white)),
              value: _darkMode,
              activeColor: const Color(0xFFD4AF37),
              onChanged: (value) => setState(() => _darkMode = value),
            ),
            SwitchListTile(
              title: const Text('توفير البيانات', style: TextStyle(color: Colors.white)),
              subtitle: const Text('تقليل استهلاك البيانات', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
              value: _saveData,
              activeColor: const Color(0xFFD4AF37),
              onChanged: (value) => setState(() => _saveData = value),
            ),
          ]),
          _buildSection('اللغة', [
            ListTile(
              leading: const Icon(Icons.language, color: Color(0xFFD4AF37)),
              title: const Text('اللغة', style: TextStyle(color: Colors.white)),
              subtitle: Text(_language, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 14),
              onTap: () => _showLanguageDialog(),
            ),
          ]),
          _buildSection('الدعم', [
            _buildListTile(Icons.help_outline, 'مركز المساعدة'),
            _buildListTile(Icons.chat_outlined, 'تواصل معنا'),
            _buildListTile(Icons.info_outline, 'عن التطبيق'),
          ]),
          _buildSection('', [
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFFF6465D)),
              title: const Text('تسجيل الخروج', style: TextStyle(color: Color(0xFFF6465D))),
              onTap: () => _showLogoutDialog(),
            ),
          ]),
          const SizedBox(height: 20),
          const Center(
            child: Text('Flex Yemen - الإصدار 1.0.0', style: TextStyle(color: Color(0xFF5E6673), fontSize: 12)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(title, style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 14, fontWeight: FontWeight.bold)),
          ),
        ...children,
        const Divider(color: Color(0xFF2B3139)),
      ],
    );
  }

  Widget _buildListTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFD4AF37)),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 14),
      onTap: () {},
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E2329),
        title: const Text('اختر اللغة', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: const Text('العربية', style: TextStyle(color: Colors.white)),
              value: 'العربية',
              groupValue: _language,
              activeColor: const Color(0xFFD4AF37),
              onChanged: (value) => setState(() => _language = value.toString()),
            ),
            RadioListTile(
              title: const Text('English', style: TextStyle(color: Colors.white)),
              value: 'English',
              groupValue: _language,
              activeColor: const Color(0xFFD4AF37),
              onChanged: (value) => setState(() => _language = value.toString()),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('موافق', style: TextStyle(color: Color(0xFFD4AF37))),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E2329),
        title: const Text('تسجيل الخروج', style: TextStyle(color: Colors.white)),
        content: const Text('هل أنت متأكد من تسجيل الخروج؟', style: TextStyle(color: Color(0xFF9CA3AF))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(color: Color(0xFF9CA3AF))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF6465D)),
            child: const Text('تسجيل الخروج'),
          ),
        ],
      ),
    );
  }
}
