import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
  final _addressController = TextEditingController();
  
  String _selectedService = 'cleaning';
  bool _isSubmitting = false;
  
  final List<Map<String, dynamic>> _services = [
    {'id': 'cleaning', 'name': 'تنظيف', 'icon': Icons.cleaning_services, 'price': 5000},
    {'id': 'plumbing', 'name': 'سباكة', 'icon': Icons.plumbing, 'price': 10000},
    {'id': 'electrical', 'name': 'كهرباء', 'icon': Icons.electrical_services, 'price': 8000},
    {'id': 'carpentry', 'name': 'نجارة', 'icon': Icons.handyman, 'price': 7000},
    {'id': 'painting', 'name': 'دهان', 'icon': Icons.format_paint, 'price': 6000},
    {'id': 'moving', 'name': 'نقل أثاث', 'icon': Icons.local_shipping, 'price': 15000},
  ];

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    
    try {
      final supabase = Supabase.instance.client;
      final userId = supabase.auth.currentUser?.id;
      
      if (userId == null) {
        throw Exception('يجب تسجيل الدخول أولاً');
      }
      
      await supabase.from('service_requests').insert({
        'user_id': userId,
        'service_type': _selectedService,
        'title': _titleController.text,
        'description': _descriptionController.text,
        'budget': double.parse(_budgetController.text),
        'address': _addressController.text,
        'status': 'pending',
        'created_at': DateTime.now().toIso8601String(),
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إرسال طلب الخدمة بنجاح'), backgroundColor: Colors.green),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
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
            children: [
              const Text('اختر نوع الخدمة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: _services.map((service) {
                  final isSelected = _selectedService == service['id'];
                  return FilterChip(
                    label: Text(service['name']),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() => _selectedService = service['id']);
                    },
                    avatar: Icon(service['icon'], size: 18),
                    selectedColor: AppTheme.goldColor,
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'عنوان الخدمة', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'الرجاء إدخال عنوان' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'تفاصيل الخدمة', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'الرجاء إدخال تفاصيل الخدمة' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _budgetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'الميزانية المقترحة (ريال)', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'الرجاء إدخال الميزانية' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'العنوان', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitRequest,
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black),
                  child: _isSubmitting ? const CircularProgressIndicator(strokeWidth: 2) : const Text('إرسال الطلب'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
