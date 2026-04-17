import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'ar';

  final List<Map<String, dynamic>> languages = [
    {'code': 'ar', 'name': 'العربية', 'native': 'العربية'},
    {'code': 'en', 'name': 'English', 'native': 'English'},
    {'code': 'fr', 'name': 'Français', 'native': 'Français'},
    {'code': 'tr', 'name': 'Türkçe', 'native': 'Türkçe'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'اللغة'),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final lang = languages[index];
          final isSelected = _selectedLanguage == lang['code'];
          
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: isSelected ? AppTheme.goldPrimary : Colors.grey.withOpacity(0.2),
              child: Text(
                lang['native']![0],
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(lang['name']!),
            subtitle: Text(lang['native']!),
            trailing: isSelected
                ? const Icon(Icons.check_circle, color: AppTheme.goldPrimary)
                : null,
            onTap: () {
              setState(() => _selectedLanguage = lang['code']!);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('تم تغيير اللغة إلى ${lang['name']}')),
              );
            },
          );
        },
      ),
    );
  }
}
