import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  bool _isDarkMode = true;
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _saveDataEnabled = false;
  String _selectedLanguage = 'ar';
  String _selectedCurrency = 'YER';

  final List<Map<String, dynamic>> _menuSections = [
    {
      'title': 'الحساب',
      'items': [
        {'icon': Icons.person_outline, 'title': 'الملف الشخصي', 'subtitle': 'تعديل المعلومات الشخصية', 'route': '/profile'},
        {'icon': Icons.lock_outline, 'title': 'الأمان', 'subtitle': 'كلمة المرور، المصادقة', 'route': '/security'},
        {'icon': Icons.location_on_outline, 'title': 'العناوين', 'subtitle': 'إدارة عناوين الشحن', 'route': '/addresses'},
      ],
    },
    {
      'title': 'التفضيلات',
      'items': [
        {'icon': Icons.language, 'title': 'اللغة', 'subtitle': 'تغيير لغة التطبيق', 'type': 'language'},
        {'icon': Icons.attach_money, 'title': 'العملة', 'subtitle': 'ريال يمني (YER)', 'type': 'currency'},
        {'icon': Icons.dark_mode, 'title': 'الوضع الداكن', 'subtitle': 'تغيير مظهر التطبيق', 'type': 'darkMode'},
        {'icon': Icons.notifications_none, 'title': 'الإشعارات', 'subtitle': 'تفعيل أو تعطيل الإشعارات', 'type': 'notifications'},
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

  final List<Map<String, dynamic>> _languages = [
    {'code': 'ar', 'name': 'العربية', 'flag': '🇸🇦', 'native': 'العربية'},
    {'code': 'en', 'name': 'English', 'flag': '🇬🇧', 'native': 'English (Beta)'},
  ];

  final List<Map<String, dynamic>> _currencies = [
    {'code': 'YER', 'name': 'ريال يمني', 'symbol': 'ر.ي'},
    {'code': 'USD', 'name': 'دولار أمريكي', 'symbol': '$'},
    {'code': 'SAR', 'name': 'ريال سعودي', 'symbol': 'ر.س'},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        backgroundColor: AppTheme.binanceDark,
        elevation: 0,
        title: const Text('الإعدادات', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildUserHeader(),
            const SizedBox(height: 20),
            ..._menuSections.map((section) => _buildSection(section)),
            const SizedBox(height: 20),
            _buildLogoutButton(),
            const SizedBox(height: 30),
            _buildVersionInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppTheme.cardGradient,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.binanceBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: AppTheme.goldGradient,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.person, color: Colors.black, size: 30),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('أحمد محمد', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const Text('ahmed@flexyemen.com', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.binanceGold.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('عضو ذهبي', style: TextStyle(color: AppTheme.binanceGold, fontSize: 10)),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: AppTheme.binanceGold),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSection(Map<String, dynamic> section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            section['title'] as String,
            style: const TextStyle(color: AppTheme.binanceGold, fontSize: 14, fontWeight: FontWeight.bold),
          ),
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
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.binanceGold.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(item['icon'] as IconData, color: AppTheme.binanceGold),
        ),
        title: Text(item['title'] as String, style: const TextStyle(color: Colors.white)),
        subtitle: Text(item['subtitle'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 16),
        onTap: () {},
      ),
    );
  }

  Widget _buildPreferenceTile(Map<String, dynamic> item) {
    final type = item['type'] as String;
    
    return Card(
      color: AppTheme.binanceCard,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.binanceGold.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(item['icon'] as IconData, color: AppTheme.binanceGold),
        ),
        title: Text(item['title'] as String, style: const TextStyle(color: Colors.white)),
        subtitle: Text(_getSubtitle(type), style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
        trailing: type == 'darkMode' || type == 'notifications' 
            ? Switch(
                value: type == 'darkMode' ? _isDarkMode : _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    if (type == 'darkMode') {
                      _isDarkMode = value;
                    } else if (type == 'notifications') {
                      _notificationsEnabled = value;
                    }
                  });
                },
                activeColor: AppTheme.binanceGold,
              )
            : GestureDetector(
                onTap: () => _showPickerDialog(type),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_getSelectedValue(type), style: TextStyle(color: AppTheme.binanceGold, fontSize: 14)),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_drop_down, color: AppTheme.binanceGold),
                  ],
                ),
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
      default: return '';
    }
  }

  String _getSelectedValue(String type) {
    switch (type) {
      case 'language':
        return _languages.firstWhere((l) => l['code'] == _selectedLanguage)['name'] as String;
      case 'currency':
        return _currencies.firstWhere((c) => c['code'] == _selectedCurrency)['name'] as String;
      default:
        return '';
    }
  }

  void _showPickerDialog(String type) {
    final items = type == 'language' ? _languages : _currencies;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.binanceCard,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.binanceBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              type == 'language' ? 'اختر اللغة' : 'اختر العملة',
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...List.generate(items.length, (i) {
              final item = items[i];
              return ListTile(
                leading: Text(
                  type == 'language' ? (item['flag'] as String) : (item['symbol'] as String),
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(item['name'] as String, style: const TextStyle(color: Colors.white)),
                trailing: (type == 'language' ? _selectedLanguage : _selectedCurrency) == item['code']
                    ? Icon(Icons.check_circle, color: AppTheme.binanceGold)
                    : null,
                onTap: () {
                  setState(() {
                    if (type == 'language') {
                      _selectedLanguage = item['code'] as String;
                    } else {
                      _selectedCurrency = item['code'] as String;
                    }
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('تم تغيير ${type == 'language' ? 'اللغة' : 'العملة'} بنجاح'),
                      backgroundColor: AppTheme.binanceGreen,
                    ),
                  );
                },
              );
            }),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildLogoutButton() {
    return ElevatedButton.icon(
      onPressed: () => _showLogoutDialog(),
      icon: const Icon(Icons.logout, size: 20),
      label: const Text('تسجيل الخروج', style: TextStyle(fontSize: 16)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.binanceRed,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppTheme.binanceRed.withOpacity(0.5)),
        ),
      ),
    );
  }

  Widget _buildVersionInfo() {
    return const Center(
      child: Column(
        children: [
          Text('Flex Yemen Marketplace', style: TextStyle(color: Color(0xFF5E6673), fontSize: 14)),
          SizedBox(height: 4),
          Text('الإصدار 2.0.0', style: TextStyle(color: Color(0xFF5E6673), fontSize: 12)),
          SizedBox(height: 4),
          Text('© 2024 Flex Yemen. جميع الحقوق محفوظة', style: TextStyle(color: Color(0xFF5E6673), fontSize: 10)),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.binanceCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تسجيل الخروج', style: TextStyle(color: Colors.white)),
        content: const Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟', style: TextStyle(color: Color(0xFF9CA3AF))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(color: Color(0xFF9CA3AF))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم تسجيل الخروج بنجاح'), backgroundColor: AppTheme.binanceGreen),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceRed),
            child: const Text('تسجيل خروج', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
