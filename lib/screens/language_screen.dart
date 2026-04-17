import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'ar';
  
  final List<Map<String, dynamic>> _languages = [
    {'code': 'ar', 'name': 'العربية', 'native': 'العربية', 'flag': '🇸🇦', 'direction': 'rtl'},
    {'code': 'en', 'name': 'English', 'native': 'English', 'flag': '🇬🇧', 'direction': 'ltr'},
  ];
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'اللغة'),
      body: ListView.builder(
        itemCount: _languages.length,
        itemBuilder: (context, index) {
          final lang = _languages[index];
          final isSelected = _selectedLanguage == lang['code'];
          return ListTile(
            leading: Text(lang['flag'], style: const TextStyle(fontSize: 32)),
            title: Text(lang['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(lang['native']),
            trailing: isSelected
                ? const Icon(Icons.check_circle, color: AppTheme.goldPrimary)
                : null,
            onTap: () {
              setState(() => _selectedLanguage = lang['code']);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('تم تغيير اللغة إلى ${lang['name']}'), backgroundColor: AppTheme.goldPrimary),
              );
            },
          );
        },
      ),
    );
  }
}
