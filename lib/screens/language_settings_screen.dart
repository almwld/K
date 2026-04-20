import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

enum AppLanguage { arabic, english }

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  AppLanguage _currentLanguage = AppLanguage.arabic;

  final List<Map<String, dynamic>> _languages = [
    {
      'code': 'ar',
      'name': 'العربية',
      'nameEn': 'Arabic',
      'flag': '🇸🇦',
      'locale': AppLanguage.arabic,
    },
    {
      'code': 'en',
      'name': 'English',
      'nameEn': 'English',
      'flag': '🇬🇧',
      'locale': AppLanguage.english,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const SimpleAppBar(title: 'إعدادات اللغة'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'اختر لغة التطبيق',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'سيتم تطبيق اللغة المختارة على جميع أقسام التطبيق',
              style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
            ),
            const SizedBox(height: 20),
            ..._languages.map((lang) => _buildLanguageCard(lang)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0B90B).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Color(0xFFF0B90B)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'سيتم إضافة لغات جديدة قريباً: فرنسية، تركية، أوردو',
                      style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
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

  Widget _buildLanguageCard(Map<String, dynamic> lang) {
    final isSelected = _currentLanguage == lang['locale'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFFF0B90B).withOpacity(0.15)
            : const Color(0xFF1E2329),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? const Color(0xFFF0B90B) : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () => setState(() => _currentLanguage = lang['locale']),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Text(
                lang['flag'],
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang['name'],
                      style: const TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      lang['nameEn'],
                      style: const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0B90B),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.black, size: 18),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
