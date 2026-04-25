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
      appBar: AppBar(title: const Text('الإعدادات', style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11)),
      body: ListView(
        children: [
          // الحساب
          _buildSection('الحساب'),
          _buildTile(context, Icons.person_outline, 'تعديل الملف الشخصي', () {}),
          _buildTile(context, Icons.lock_outline, 'تغيير كلمة المرور', () {}),
          _buildTile(context, Icons.phone_outlined, 'رقم الجوال', () {}),
          const Divider(color: Color(0xFF2B3139)),
          
          // التفضيلات
          _buildSection('التفضيلات'),
          SwitchListTile(title: const Text('الإشعارات', style: TextStyle(color: Colors.white)), value: _notificationsEnabled, activeColor: const Color(0xFFD4AF37), onChanged: (v) => setState(() => _notificationsEnabled = v)),
          SwitchListTile(title: const Text('الوضع الداكن', style: TextStyle(color: Colors.white)), value: _darkMode, activeColor: const Color(0xFFD4AF37), onChanged: (v) => setState(() => _darkMode = v)),
          SwitchListTile(title: const Text('توفير البيانات', style: TextStyle(color: Colors.white)), value: _saveData, activeColor: const Color(0xFFD4AF37), onChanged: (v) => setState(() => _saveData = v)),
          const Divider(color: Color(0xFF2B3139)),
          
          // اللغة
          _buildSection('اللغة'),
          ListTile(leading: SvgPicture.asset('assets/icons/svg/language.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)), title: const Text('اللغة', style: TextStyle(color: Colors.white)), subtitle: Text(_language, style: const TextStyle(color: Color(0xFF9CA3AF))), trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 14), onTap: _showLanguageDialog),
          const Divider(color: Color(0xFF2B3139)),
          
          // الدعم
          _buildSection('الدعم'),
          _buildTile(context, Icons.help_outline, 'مركز المساعدة', () {}),
          _buildTile(context, Icons.chat_outlined, 'تواصل معنا', () {}),
          _buildTile(context, Icons.info_outline, 'عن التطبيق', () {
            showDialog(context: context, builder: (c) => AlertDialog(backgroundColor: const Color(0xFF1E2329), title: const Text('Flex Yemen', style: TextStyle(color: Colors.white)), content: const Text('الإصدار 1.0.0\nمنصة التجارة الإلكترونية اليمنية', style: TextStyle(color: Color(0xFF9CA3AF))), actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text('موافق', style: TextStyle(color: Color(0xFFD4AF37))))]));
          }),
          const SizedBox(height: 20),
          const Center(child: Text('Flex Yemen - الإصدار 1.0.0', style: TextStyle(color: Color(0xFF5E6673), fontSize: 12))),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSection(String title) => Padding(padding: const EdgeInsets.fromLTRB(16, 16, 16, 8), child: Text(title, style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 14, fontWeight: FontWeight.bold)));

  Widget _buildTile(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(leading: Icon(icon, color: const Color(0xFFD4AF37)), title: Text(title, style: const TextStyle(color: Colors.white)), trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 14), onTap: onTap);
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        backgroundColor: const Color(0xFF1E2329),
        title: const Text('اختر اللغة', style: TextStyle(color: Colors.white)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          RadioListTile(title: const Text('العربية', style: TextStyle(color: Colors.white)), value: 'العربية', groupValue: _language, activeColor: const Color(0xFFD4AF37), onChanged: (v) => setState(() => _language = v.toString())),
          RadioListTile(title: const Text('English', style: TextStyle(color: Colors.white)), value: 'English', groupValue: _language, activeColor: const Color(0xFFD4AF37), onChanged: (v) => setState(() => _language = v.toString())),
        ]),
        actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text('موافق', style: TextStyle(color: Color(0xFFD4AF37))))],
      ),
    );
  }
}
