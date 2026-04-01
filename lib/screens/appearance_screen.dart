import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class AppearanceScreen extends StatefulWidget {
  const AppearanceScreen({super.key});

  @override
  State<AppearanceScreen> createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends State<AppearanceScreen> {
  bool darkMode = false;
  double fontSize = 14;
  String themeAccent = 'Gold';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المظهر'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('الوضع الداكن'),
            subtitle: const Text('تفعيل / تعطيل الوضع الداكن'),
            value: darkMode,
            onChanged: (v) => setState(() => darkMode = v),
            activeColor: AppTheme.goldColor,
          ),
          const SizedBox(height: 8),
          ListTile(
            title: const Text('حجم الخط'),
            subtitle: Slider(
              min: 12,
              max: 22,
              divisions: 5,
              value: fontSize,
              onChanged: (v) => setState(() => fontSize = v),
            ),
            trailing: Text('${fontSize.toInt()}'),
          ),
          const SizedBox(height: 8),
          ListTile(
            title: const Text('لون الثيم'),
            subtitle: Text('اختر لون التمييز للتطبيق'),
            trailing: DropdownButton<String>(
              value: themeAccent,
              items: const [
                DropdownMenuItem(value: 'Gold', child: Text('ذهبي')),
                DropdownMenuItem(value: 'Blue', child: Text('أزرق')),
                DropdownMenuItem(value: 'Green', child: Text('أخضر')),
              ],
              onChanged: (v) => setState(() => themeAccent = v ?? 'Gold'),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.getCardColor(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('معاينة المظهر', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('هذا نص تجريبي بحجم ${fontSize.toInt()} لون الثيم: $themeAccent'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم حفظ إعدادات المظهر')));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black),
                  child: const Text('حفظ التغييرات'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
