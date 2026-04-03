import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/theme_manager.dart';
import '../../services/theme_service.dart';
import '../../widgets/simple_app_bar.dart';

class AppearanceScreen extends StatefulWidget {
  const AppearanceScreen({super.key});

  @override
  State<AppearanceScreen> createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends State<AppearanceScreen> {
  late Color _selectedColor;
  
  final List<Map<String, dynamic>> _colors = [
    {'name': 'ذهبي', 'color': const Color(0xFFD4AF37), 'icon': Icons.star},
    {'name': 'أزرق', 'color': Colors.blue, 'icon': Icons.water_drop},
    {'name': 'أخضر', 'color': Colors.green, 'icon': Icons.eco},
    {'name': 'برتقالي', 'color': Colors.orange, 'icon': Icons.brightness_low},
    {'name': 'بنفسجي', 'color': Colors.purple, 'icon': Icons.grade},
    {'name': 'وردي', 'color': Colors.pink, 'icon': Icons.favorite},
  ];
  
  @override
  void initState() {
    super.initState();
    _loadSelectedColor();
  }
  
  Future<void> _loadSelectedColor() async {
    final color = await ThemeService.getThemeColor();
    setState(() => _selectedColor = color);
  }
  
  Future<void> _selectColor(Color color, String name) async {
    await ThemeService.saveThemeColor(color);
    setState(() => _selectedColor = color);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم تغيير لون التطبيق إلى $name'), backgroundColor: color),
    );
  }
  
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
                    activeColor: _selectedColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // ألوان الثيم
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
                final isSelected = _selectedColor == item['color'];
                return GestureDetector(
                  onTap: () => _selectColor(item['color'], item['name']),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.getCardColor(context),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isSelected ? item['color'] : Colors.transparent, width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50, height: 50,
                          decoration: BoxDecoration(
                            color: item['color'],
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: item['color'].withOpacity(0.3), blurRadius: 8)],
                          ),
                          child: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
                        ),
                        const SizedBox(height: 8),
                        Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            
            // معاينة
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.getCardColor(context),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text('معاينة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [_selectedColor, _selectedColor.withOpacity(0.7)]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(child: Text('Flex Yemen', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
