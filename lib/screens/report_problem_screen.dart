import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/custom_button.dart';

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({super.key});

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  String _selectedType = 'فني';
  bool _includeScreenshot = false;
  bool _isSubmitting = false;
  
  final List<Map<String, dynamic>> _problemTypes = [
    {'name': 'فني', 'icon': Icons.build, 'color': 0xFFFF9800},
    {'name': 'دفع', 'icon': Icons.payment, 'color': 0xFF4CAF50},
    {'name': 'شحن', 'icon': Icons.local_shipping, 'color': 0xFF2196F3},
    {'name': 'حساب', 'icon': Icons.person, 'color': 0xFF9C27B0},
    {'name': 'أخرى', 'icon': Icons.help, 'color': 0xFFE74C3C},
  ];
  
  Future<void> _submitReport() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isSubmitting = false);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إرسال البلاغ بنجاح! سنقوم بمراجعته قريباً'), backgroundColor: Colors.green),
    );
    Navigator.pop(context);
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الإبلاغ عن مشكلة'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // نوع المشكلة
              const Text('نوع المشكلة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: _problemTypes.length,
                itemBuilder: (context, index) {
                  final type = _problemTypes[index];
                  final isSelected = _selectedType == type['name'];
                  return GestureDetector(
                    onTap: () => setState(() => _selectedType = type['name']),
                    child: Column(
                      children: [
                        Container(
                          width: 50, height: 50,
                          decoration: BoxDecoration(
                            color: isSelected ? Color(type['color']) : AppTheme.getCardColor(context),
                            shape: BoxShape.circle,
                            border: Border.all(color: Color(type['color'])),
                          ),
                          child: Icon(type['icon'], color: isSelected ? Colors.white : Color(type['color'])),
                        ),
                        const SizedBox(height: 4),
                        Text(type['name'], style: const TextStyle(fontSize: 10)),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              
              // وصف المشكلة
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'وصف المشكلة بالتفصيل',
                  hintText: 'يرجى وصف المشكلة التي تواجهها...',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
              ),
              const SizedBox(height: 16),
              
              // إرفاق صورة
              SwitchListTile(
                title: const Text('إرفاق لقطة شاشة'),
                subtitle: const Text('سيساعدنا ذلك في فهم المشكلة بشكل أفضل'),
                value: _includeScreenshot,
                onChanged: (v) => setState(() => _includeScreenshot = v),
                activeColor: AppTheme.goldColor,
              ),
              
              if (_includeScreenshot) ...[
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppTheme.getCardColor(context),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_photo_alternate, size: 40),
                          SizedBox(height: 8),
                          Text('اضغط لإضافة صورة'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              
              const SizedBox(height: 32),
              
              CustomButton(
                text: 'إرسال البلاغ',
                onPressed: _submitReport,
                isLoading: _isSubmitting,
              ),
              
              const SizedBox(height: 16),
              
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.goldColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppTheme.goldColor),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'سيتم الرد على بلاغك خلال 24 ساعة. نشكرك على مساعدتنا في تحسين المنصة.',
                        style: TextStyle(fontSize: 12, color: AppTheme.getSecondaryTextColor(context)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
