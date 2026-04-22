import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RequestServiceScreen extends StatefulWidget {
  const RequestServiceScreen({super.key});

  @override
  State<RequestServiceScreen> createState() => _RequestServiceScreenState();
}

class _RequestServiceScreenState extends State<RequestServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  String _selectedService = 'صيانة';
  String _selectedUrgency = 'عادي';

  final List<String> _services = [
    'صيانة', 'تنظيف', 'سباكة', 'كهرباء', 'دهان', 'نجارة', 'تكييف', 'نقل'
  ];

  final List<String> _urgencyLevels = ['عاجل', 'عادي', 'خلال أسبوع'];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        title: const Text('طلب خدمة', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _submitRequest,
            child: const Text('إرسال', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // عنوان الطلب
            TextFormField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'عنوان الطلب',
                labelStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                filled: true,
                fillColor: const Color(0xFF1E2329),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (v) => v == null || v.isEmpty ? 'العنوان مطلوب' : null,
            ),
            const SizedBox(height: 16),

            // نوع الخدمة
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2329),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedService,
                dropdownColor: const Color(0xFF1E2329),
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(border: InputBorder.none),
                items: _services.map((s) {
                  return DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(color: Colors.white)));
                }).toList(),
                onChanged: (v) => setState(() => _selectedService = v!),
              ),
            ),
            const SizedBox(height: 16),

            // درجة الاستعجال
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2329),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedUrgency,
                dropdownColor: const Color(0xFF1E2329),
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(border: InputBorder.none),
                items: _urgencyLevels.map((u) {
                  return DropdownMenuItem(
                    value: u,
                    child: Text(u, style: TextStyle(color: u == 'عاجل' ? const Color(0xFFF6465D) : Colors.white)),
                  );
                }).toList(),
                onChanged: (v) => setState(() => _selectedUrgency = v!),
              ),
            ),
            const SizedBox(height: 16),

            // الموقع
            TextFormField(
              controller: _locationController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'الموقع',
                labelStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                prefixIcon: const Icon(Icons.location_on, color: Color(0xFFD4AF37)),
                filled: true,
                fillColor: const Color(0xFF1E2329),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (v) => v == null || v.isEmpty ? 'الموقع مطلوب' : null,
            ),
            const SizedBox(height: 16),

            // الوصف
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'وصف الخدمة المطلوبة',
                labelStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                filled: true,
                fillColor: const Color(0xFF1E2329),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (v) => v == null || v.isEmpty ? 'الوصف مطلوب' : null,
            ),
          ],
        ),
      ),
    );
  }

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إرسال طلب الخدمة بنجاح!'),
          backgroundColor: Color(0xFF0ECB81),
        ),
      );
    }
  }
}
