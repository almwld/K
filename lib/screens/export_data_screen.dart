import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/custom_button.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';

class ExportDataScreen extends StatefulWidget {
  const ExportDataScreen({super.key});

  @override
  State<ExportDataScreen> createState() => _ExportDataScreenState();
}

class _ExportDataScreenState extends State<ExportDataScreen> {
  bool _exportProducts = true;
  bool _exportOrders = true;
  bool _exportProfile = true;
  bool _isExporting = false;
  String _selectedFormat = 'json';
  
  final List<Map<String, dynamic>> _formats = [
    {'value': 'json', 'name': 'JSON', 'icon': Icons.code, 'color': 0xFFFF9800},
    {'value': 'csv', 'name': 'CSV', 'icon': Icons.table_chart, 'color': 0xFF4CAF50},
    {'value': 'pdf', 'name': 'PDF', 'icon': Icons.picture_as_pdf, 'color': 0xFFE74C3C},
  ];
  
  Future<void> _exportData() async {
    setState(() => _isExporting = true);
    await Future.delayed(const Duration(seconds: 2));
    
    // محاكاة إنشاء البيانات
    String content = '';
    if (_selectedFormat == 'json') {
      content = jsonEncode({
        'user': {'name': 'أحمد محمد', 'email': 'ahmed@example.com'},
        'products': sampleProducts.take(5).map((p) => p.toJson()).toList(),
        'export_date': DateTime.now().toIso8601String(),
      });
    } else if (_selectedFormat == 'csv') {
      content = 'الاسم,السعر,المدينة,التقييم\n';
      for (var p in sampleProducts.take(5)) {
        content += '${p.title},${p.price},${p.city},${p.rating}\n';
      }
    }
    
    setState(() => _isExporting = false);
    
    // مشاركة الملف
    final text = 'ملف تصدير بيانات Flex Yemen\n'
        'تاريخ التصدير: ${DateTime.now()}\n'
        '================================\n\n'
        '${_selectedFormat == 'json' ? 'بيانات JSON' : content}';
    
    await Share.share(text, subject: 'بياناتي من Flex Yemen');
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم تصدير البيانات بنجاح'), backgroundColor: Colors.green),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'تصدير البيانات'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // شرح
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.gold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: AppTheme.gold),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'قم بتصدير بياناتك الشخصية (المنتجات، الطلبات، الملف الشخصي) بتنسيق مختلف',
                      style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // اختيار البيانات للتصدير
            const Text('اختر البيانات للتصدير', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  CheckboxListTile(
                    title: const Text('المنتجات والإعلانات'),
                    subtitle: const Text('جميع منتجاتك وإعلاناتك'),
                    value: _exportProducts,
                    onChanged: (v) => setState(() => _exportProducts = v!),
                    activeColor: AppTheme.gold,
                  ),
                  CheckboxListTile(
                    title: const Text('الطلبات'),
                    subtitle: const Text('جميع طلباتك السابقة'),
                    value: _exportOrders,
                    onChanged: (v) => setState(() => _exportOrders = v!),
                    activeColor: AppTheme.gold,
                  ),
                  CheckboxListTile(
                    title: const Text('الملف الشخصي'),
                    subtitle: const Text('معلومات حسابك الشخصية'),
                    value: _exportProfile,
                    onChanged: (v) => setState(() => _exportProfile = v!),
                    activeColor: AppTheme.gold,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // اختيار التنسيق
            const Text('اختر تنسيق التصدير', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: _formats.map((format) {
                final isSelected = _selectedFormat == format['value'];
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedFormat = format['value']),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? Color(format['color']).withOpacity(0.2) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isSelected ? Color(format['color']) : Colors.grey.withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          Icon(format['icon'], color: isSelected ? Color(format['color']) : Colors.grey, size: 28),
                          const SizedBox(height: 4),
                          Text(format['name'], style: TextStyle(color: isSelected ? Color(format['color']) : Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            
            // معلومات الحجم
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildInfoRow('حجم البيانات المتوقعة', '≈ 2.5 MB'),
                  _buildInfoRow('المنتجات', '12 منتج'),
                  _buildInfoRow('الطلبات', '48 طلب'),
                  const Divider(),
                  _buildInfoRow('آخر تصدير', 'لم يتم التصدير بعد', isLast: true),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // زر التصدير
            CustomButton(
              text: 'تصدير البيانات',
              onPressed: _exportData,
              isLoading: _isExporting,
              icon: Icons.download,
            ),
            
            const SizedBox(height: 16),
            
            // نص توضيحي
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.security, color: Colors.red, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'بياناتك آمنة ومشفرة. يتم تصدير البيانات بشكل آمن.',
                      style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyMedium!.color),
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
  
  Widget _buildInfoRow(String label, String value, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}

