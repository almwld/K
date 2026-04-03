import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_manager.dart';
import '../services/theme_service.dart';
import '../widgets/simple_app_bar.dart';

class AppearanceScreen extends StatefulWidget {
  const AppearanceScreen({super.key});

  @override
  State<AppearanceScreen> createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends State<AppearanceScreen> {
  late Color _selectedColor;
  double _fontSize = 14;
  String _selectedFont = 'Changa';
  
  final List<Map<String, dynamic>> _colors = [
    {'name': 'ذهبي', 'color': const Color(0xFFD4AF37), 'icon': Icons.star, 'primary': true},
    {'name': 'أزرق', 'color': Colors.blue, 'icon': Icons.water_drop, 'primary': false},
    {'name': 'أخضر', 'color': Colors.green, 'icon': Icons.eco, 'primary': false},
    {'name': 'برتقالي', 'color': Colors.orange, 'icon': Icons.brightness_low, 'primary': false},
    {'name': 'بنفسجي', 'color': Colors.purple, 'icon': Icons.grade, 'primary': false},
    {'name': 'وردي', 'color': Colors.pink, 'icon': Icons.favorite, 'primary': false},
    {'name': 'أحمر', 'color': Colors.red, 'icon': Icons.whatshot, 'primary': false},
    {'name': 'تركواز', 'color': Colors.teal, 'icon': Icons.water, 'primary': false},
  ];
  
  final List<Map<String, dynamic>> _fonts = [
    {'name': 'Changa', 'family': 'Changa', 'type': 'عربي'},
    {'name': 'Cairo', 'family': 'Cairo', 'type': 'عربي'},
    {'name': 'Tajawal', 'family': 'Tajawal', 'type': 'عربي'},
    {'name': 'Roboto', 'family': 'Roboto', 'type': 'إنجليزي'},
    {'name': 'Poppins', 'family': 'Poppins', 'type': 'إنجليزي'},
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
            
            // ألوان التطبيق
            const Text('ألوان التطبيق', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
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
                  child: Column(
                    children: [
                      Container(
                        width: 50, height: 50,
                        decoration: BoxDecoration(
                          color: item['color'],
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: item['color'].withOpacity(0.3), blurRadius: 8)],
                          border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
                        ),
                        child: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
                      ),
                      const SizedBox(height: 8),
                      Text(item['name'], style: const TextStyle(fontSize: 11)),
                      if (item['primary'])
                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: AppTheme.goldColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('أساسي', style: TextStyle(fontSize: 8, color: Colors.black)),
                        ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            
            // حجم الخط
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.getCardColor(context),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('حجم الخط', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.text_fields, size: 20),
                      Expanded(
                        child: Slider(
                          value: _fontSize,
                          min: 12,
                          max: 22,
                          divisions: 5,
                          activeColor: _selectedColor,
                          onChanged: (v) => setState(() => _fontSize = v),
                        ),
                      ),
                      const Icon(Icons.text_fields, size: 28),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'نموذج للنص بحجم ${_fontSize.toInt()}',
                      style: TextStyle(fontSize: _fontSize),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // الخط
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.getCardColor(context),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('نوع الخط', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _fonts.map((font) {
                      final isSelected = _selectedFont == font['name'];
                      return FilterChip(
                        label: Text(font['name']),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() => _selectedFont = font['name']);
                        },
                        selectedColor: _selectedColor,
                        backgroundColor: AppTheme.getCardColor(context),
                        labelStyle: TextStyle(
                          fontFamily: isSelected ? font['family'] : null,
                          color: isSelected ? Colors.black : null,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // معاينة
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [_selectedColor, _selectedColor.withOpacity(0.7)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text('معاينة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Flex Yemen',
                          style: TextStyle(
                            color: _selectedColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(backgroundColor: _selectedColor),
                          child: const Text('زر تجريبي'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // زر حفظ
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم حفظ إعدادات المظهر'), backgroundColor: Colors.green),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('حفظ الإعدادات'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
