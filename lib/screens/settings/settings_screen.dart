import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            _buildListTile('profile', 'تعديل الملف الشخصي'),
            _buildListTile('security', 'تغيير كلمة المرور'),
            _buildListTile('phone', 'رقم الجوال'),
          ]),
          _buildSection('التفضيلات', [
            SwitchListTile(
              title: const Text('الإشعارات', style: TextStyle(color: Colors.white)),
              value: _notificationsEnabled,
              activeColor: const Color(0xFFD4AF37),
              onChanged: (v) => setState(() => _notificationsEnabled = v),
            ),
            SwitchListTile(
              title: const Text('الوضع الداكن', style: TextStyle(color: Colors.white)),
              value: _darkMode,
              activeColor: const Color(0xFFD4AF37),
              onChanged: (v) => setState(() => _darkMode = v),
            ),
            SwitchListTile(
              title: const Text('توفير البيانات', style: TextStyle(color: Colors.white)),
              value: _saveData,
              activeColor: const Color(0xFFD4AF37),
              onChanged: (v) => setState(() => _saveData = v),
            ),
          ]),
          _buildSection('اللغة', [
            ListTile(
              leading: SvgPicture.asset('assets/icons/svg/language.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)),
              title: const Text('اللغة', style: TextStyle(color: Colors.white)),
              subtitle: Text(_language, style: const TextStyle(color: Color(0xFF9CA3AF))),
              trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 14),
              onTap: _showLanguageDialog,
            ),
          ]),
          _buildSection('الدعم', [
            _buildListTile('help', 'مركز المساعدة'),
            _buildListTile('chat', 'تواصل معنا'),
            _buildListTile('about', 'عن التطبيق'),
          ]),
          _buildSection('', [
            ListTile(
              leading: SvgPicture.asset('assets/icons/svg/logout.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFF6465D), BlendMode.srcIn)),
              title: const Text('تسجيل الخروج', style: TextStyle(color: Color(0xFFF6465D))),
              onTap: _showLogoutDialog,
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

  Widget _buildListTile(String icon, String title) {
    return ListTile(
      leading: SvgPicture.asset('assets/icons/svg/$icon.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)),
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
              onChanged: (v) => setState(() => _language = v.toString()),
            ),
            RadioListTile(
              title: const Text('English', style: TextStyle(color: Colors.white)),
              value: 'English',
              groupValue: _language,
              activeColor: const Color(0xFFD4AF37),
              onChanged: (v) => setState(() => _language = v.toString()),
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
