import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_manager.dart';
import '../widgets/simple_app_bar.dart';

class AppearanceScreen extends StatefulWidget {
  const AppearanceScreen({super.key});

  @override
  State<AppearanceScreen> createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends State<AppearanceScreen> {
  final List<Map<String, dynamic>> _colors = [
    {'name': 'ذهبي', 'color': const Color(0xFFD4AF37), 'icon': Icons.star},
    {'name': 'أزرق', 'color': Colors.blue, 'icon': Icons.water_drop},
    {'name': 'أخضر', 'color': Colors.green, 'icon': Icons.eco},
    {'name': 'برتقالي', 'color': Colors.orange, 'icon': Icons.brightness_low},
    {'name': 'بنفسجي', 'color': Colors.purple, 'icon': Icons.grade},
    {'name': 'وردي', 'color': Colors.pink, 'icon': Icons.favorite},
  ];

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المظهر'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // الوضع الليلي
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.getCardColor(context),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.goldColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.brightness_6, color: AppTheme.goldColor),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('الوضع الليلي', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('تفعيل المظهر الداكن', style: TextStyle(fontSize: 12, color: AppTheme.getSecondaryTextColor(context))),
                        ],
                      ),
                    ],
                  ),
                  Switch(
                    value: themeManager.isDarkMode,
                    onChanged: (_) => themeManager.toggleTheme(),
                    activeColor: AppTheme.goldColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ألوان التطبيق
            const Text('ألوان التطبيق', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _colors.length,
              itemBuilder: (context, index) {
                final item = _colors[index];
                return Container(
                  decoration: BoxDecoration(
                    color: AppTheme.getCardColor(context),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50, height: 50,
                        decoration: BoxDecoration(
                          color: item['color'],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(item['name']),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
