import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class RequestServiceScreen extends StatefulWidget {
  const RequestServiceScreen({super.key});

  @override
  State<RequestServiceScreen> createState() => _RequestServiceScreenState();
}

class _RequestServiceScreenState extends State<RequestServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _budgetController = TextEditingController();
  String _selectedCategory = 'cleaning';
  bool _isSubmitting = false;

  final List<Map<String, dynamic>> _categories = [
    {'id': 'cleaning', 'name': 'تنظيف', 'icon': Icons.cleaning_services},
    {'id': 'plumbing', 'name': 'سباكة', 'icon': Icons.plumbing},
    {'id': 'electrical', 'name': 'كهرباء', 'icon': Icons.electrical_services},
    {'id': 'carpentry', 'name': 'نجارة', 'icon': Icons.handyman},
    {'id': 'painting', 'name': 'دهان', 'icon': Icons.format_paint},
    {'id': 'moving', 'name': 'نقل أثاث', 'icon': Icons.local_shipping},
  ];

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isSubmitting = false);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إرسال طلب الخدمة بنجاح'), backgroundColor: Colors.green),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'طلب خدمة'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('نوع الخدمة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _categories.map((cat) {
                  final isSelected = _selectedCategory == cat['id'];
                  return FilterChip(
                    label: Text(cat['name']),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() => _selectedCategory = cat['id']);
                    },
                    avatar: Icon(cat['icon'], size: 18),
                    selectedColor: AppTheme.goldColor,
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'عنوان الخدمة',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? 'الرجاء إدخال عنوان' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'تفاصيل الخدمة',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? 'الرجاء إدخال تفاصيل الخدمة' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _budgetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'الميزانية المقترحة (ريال)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.goldColor,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator(strokeWidth: 2)
                      : const Text('إرسال الطلب', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
