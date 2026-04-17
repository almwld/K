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
  final _locationController = TextEditingController();
  String? _selectedCategory;
  String? _selectedUrgency;
  bool _isLoading = false;

  final List<String> _categories = ['صيانة منزلية', 'تنظيف', 'نقل أثاث', 'تصميم', 'برمجة', 'تعليم', 'استشارات', 'أخرى'];
  final List<String> _urgencyLevels = ['عاجل جداً', 'عاجل', 'عادي', 'غير مستعجل'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'طلب خدمة'),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderInfo(),
              const SizedBox(height: 20),
              _buildTextField(_titleController, 'عنوان الخدمة', Icons.title, 'مثال: أحتاج سباك لإصلاح تسرب مياه'),
              const SizedBox(height: 16),
              _buildDropdown('نوع الخدمة', _selectedCategory, _categories, (value) => setState(() => _selectedCategory = value)),
              const SizedBox(height: 16),
              _buildTextField(_descriptionController, 'وصف الخدمة', Icons.description, 'اشرح بالتفصيل ما تحتاجه...', maxLines: 4),
              const SizedBox(height: 16),
              _buildTextField(_budgetController, 'الميزانية (ريال)', Icons.monetization_on, 'مثال: 5000', keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildTextField(_locationController, 'الموقع', Icons.location_on, 'المدينة - المنطقة'),
              const SizedBox(height: 16),
              _buildDropdown('مستوى الاستعجال', _selectedUrgency, _urgencyLevels, (value) => setState(() => _selectedUrgency = value)),
              const SizedBox(height: 24),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.goldPrimary.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
      child: const Row(
        children: [
          Icon(Icons.info_outline, color: AppTheme.goldPrimary),
          SizedBox(width: 12),
          Expanded(child: Text('سيتم نشر طلبك وسيتواصل معك مقدمو الخدمات المهتمون', style: TextStyle(fontSize: 13))),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, String hint, {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(hintText: hint, prefixIcon: Icon(icon, color: AppTheme.goldPrimary), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.goldPrimary, width: 2))),
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: (value) => value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, String? value, List<String> items, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(hintText: 'اختر $label', prefixIcon: const Icon(Icons.category, color: AppTheme.goldPrimary), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: onChanged,
          validator: (value) => value == null ? 'هذا الحقل مطلوب' : null,
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submitRequest,
        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldPrimary, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        child: _isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Text('نشر الطلب', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
      ),
    );
  }

  void _submitRequest() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم نشر طلب الخدمة بنجاح!'), backgroundColor: Colors.green));
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _budgetController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
