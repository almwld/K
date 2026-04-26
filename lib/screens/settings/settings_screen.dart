import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../profile/profile_screen.dart';
import '../addresses_screen.dart';
import '../notifications_screen.dart';
import '../help_support_screen.dart';
import '../about_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = true;
  bool _saveDataEnabled = false;
  String _selectedLanguage = 'ar';
  String _selectedCurrency = 'YER';

  final List<Map<String, dynamic>> _settingsSections = [
    {
      'title': 'الحساب',
      'items': [
        {'icon': Icons.person_outline, 'title': 'الملف الشخصي', 'subtitle': 'تعديل المعلومات الشخصية', 'route': '/profile'},
        {'icon': Icons.lock_outline, 'title': 'الأمان', 'subtitle': 'كلمة المرور، المصادقة', 'route': '/security'},
        {'icon': Icons.location_on_outlined, 'title': 'العناوين', 'subtitle': 'إدارة عناوين الشحن', 'route': '/addresses'},
      ],
    },
    {
      'title': 'التفضيلات',
      'items': [
        {'icon': Icons.language, 'title': 'اللغة', 'subtitle': 'العربية', 'type': 'language'},
        {'icon': Icons.attach_money, 'title': 'العملة', 'subtitle': 'ريال يمني (YER)', 'type': 'currency'},
        {'icon': Icons.dark_mode, 'title': 'الوضع المظلم', 'subtitle': 'تغيير مظهر التطبيق', 'type': 'darkMode', 'value': true},
        {'icon': Icons.notifications_none, 'title': 'الإشعارات', 'subtitle': 'تفعيل أو تعطيل الإشعارات', 'type': 'notifications', 'value': true},
        {'icon': Icons.data_saver_off, 'title': 'توفير البيانات', 'subtitle': 'تقليل استهلاك البيانات', 'type': 'saveData', 'value': false},
      ],
    },
    {
      'title': 'الدعم',
      'items': [
        {'icon': Icons.help_outline, 'title': 'مركز المساعدة', 'subtitle': 'الأسئلة الشائعة', 'route': '/help'},
        {'icon': Icons.chat_bubble_outline, 'title': 'تواصل معنا', 'subtitle': 'الدعم الفني', 'route': '/contact'},
        {'icon': Icons.info_outline, 'title': 'عن التطبيق', 'subtitle': 'الإصدار 2.0.0', 'route': '/about'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        title: const Text('الإعدادات', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.binanceDark,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _settingsSections.length,
        itemBuilder: (context, index) => _buildSection(_settingsSections[index]),
      ),
    );
  }

  Widget _buildSection(Map<String, dynamic> section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(section['title'] as String, style: TextStyle(color: AppTheme.binanceGold, fontSize: 14, fontWeight: FontWeight.bold)),
        ),
        ...List.generate(section['items'].length, (i) {
          final item = section['items'][i];
          if (item.containsKey('type')) {
            return _buildPreferenceTile(item);
          } else {
            return _buildMenuTile(item);
          }
        }),
      ],
    );
  }

  Widget _buildMenuTile(Map<String, dynamic> item) {
    return Card(
      color: AppTheme.binanceCard,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(width: 40, height: 40, decoration: BoxDecoration(color: AppTheme.binanceGold.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(item['icon'] as IconData, color: AppTheme.binanceGold)),
        title: Text(item['title'] as String, style: const TextStyle(color: Colors.white)),
        subtitle: Text(item['subtitle'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 16),
        onTap: () {
          if (item['route'] == '/profile') {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
          } else if (item['route'] == '/addresses') {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AddressesScreen()));
          } else if (item['route'] == '/help') {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpSupportScreen()));
          } else if (item['route'] == '/about') {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen()));
          }
        },
      ),
    );
  }

  Widget _buildPreferenceTile(Map<String, dynamic> item) {
    final type = item['type'] as String;
    bool value = item['value'] as bool? ?? false;
    
    if (type == 'notifications') value = _notificationsEnabled;
    if (type == 'darkMode') value = _darkModeEnabled;
    if (type == 'saveData') value = _saveDataEnabled;

    return Card(
      color: AppTheme.binanceCard,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(width: 40, height: 40, decoration: BoxDecoration(color: AppTheme.binanceGold.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(item['icon'] as IconData, color: AppTheme.binanceGold)),
        title: Text(item['title'] as String, style: const TextStyle(color: Colors.white)),
        subtitle: Text(_getSubtitle(type), style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
        trailing: Switch(
          value: value,
          onChanged: (newValue) {
            setState(() {
              if (type == 'notifications') _notificationsEnabled = newValue;
              if (type == 'darkMode') _darkModeEnabled = newValue;
              if (type == 'saveData') _saveDataEnabled = newValue;
            });
          },
          activeColor: AppTheme.binanceGold,
        ),
      ),
    );
  }

  String _getSubtitle(String type) {
    switch (type) {
      case 'language': return 'تغيير لغة التطبيق';
      case 'currency': return 'العملة المستخدمة في التطبيق';
      case 'darkMode': return 'تغيير مظهر التطبيق';
      case 'notifications': return 'تفعيل أو تعطيل الإشعارات';
      case 'saveData': return 'تقليل استهلاك البيانات';
      default: return '';
    }
  }
}
