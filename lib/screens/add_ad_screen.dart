import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class AddAdScreen extends StatefulWidget {
  const AddAdScreen({super.key});

  @override
  State<AddAdScreen> createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedCategory;
  String? _selectedCity;
  List<File> _images = [];
  bool _isLoading = false;

  final List<String> _categories = ['إلكترونيات', 'سيارات', 'عقارات', 'أثاث', 'أزياء', 'خدمات', 'أخرى'];
  final List<String> _cities = ['صنعاء', 'عدن', 'تعز', 'الحديدة', 'إب', 'المكلا', 'سيئون', 'ذمار'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('إضافة إعلان جديد', style: TextStyle(color: Colors.black)),
        backgroundColor: AppTheme.gold,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('صور الإعلان'),
              const SizedBox(height: 8),
              _buildImagePicker(),
              const SizedBox(height: 20),
              _buildSectionTitle('معلومات الإعلان'),
              const SizedBox(height: 16),
              _buildTextField(_titleController, 'عنوان الإعلان', Icons.title, 'مثال: آيفون 15 برو ماكس', maxLines: 1),
              const SizedBox(height: 16),
              _buildDropdown(_selectedCategory, 'القسم', _categories, Icons.category, (value) => setState(() => _selectedCategory = value)),
              const SizedBox(height: 16),
              _buildTextField(_priceController, 'السعر (ريال يمني)', Icons.monetization_on, 'مثال: 450000', keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildTextField(_descriptionController, 'وصف الإعلان', Icons.description, 'اكتب وصفاً مفصلاً للإعلان...', maxLines: 5),
              const SizedBox(height: 20),
              _buildSectionTitle('معلومات الاتصال'),
              const SizedBox(height: 16),
              _buildDropdown(_selectedCity, 'المدينة', _cities, Icons.location_on, (value) => setState(() => _selectedCity = value)),
              const SizedBox(height: 16),
              _buildTextField(_phoneController, 'رقم الهاتف', Icons.phone, 'مثال: 777123456', keyboardType: TextInputType.phone),
              const SizedBox(height: 30),
              _buildSubmitButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget _buildImagePicker() {
    return Column(
      children: [
        SizedBox(
          height: 110,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              GestureDetector(
                onTap: _pickImages,
                child: Container(
                  width: 100, height: 100,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.gold, width: 2, style: BorderStyle.solid),
                  ),
                  child: const Icon(Icons.add_photo_alternate, size: 40, color: AppTheme.gold),
                ),
              ),
              ..._images.map((image) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(image, width: 100, height: 100, fit: BoxFit.cover),
                    ),
                    Positioned(
                      top: 4, right: 4,
                      child: GestureDetector(
                        onTap: () => setState(() => _images.remove(image)),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                          child: const Icon(Icons.close, size: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
        if (_images.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('* أضف صورة واحدة على الأقل', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, String hint, {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppTheme.gold),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.gold, width: 2)),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: (value) => value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
    );
  }

  Widget _buildDropdown(String? value, String label, List<String> items, IconData icon, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppTheme.gold),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'الرجاء اختيار $label' : null,
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submitAd,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.gold,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: _isLoading
            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
            : const Text('نشر الإعلان', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
      ),
    );
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() => _images.addAll(pickedFiles.map((file) => File(file.path))));
    }
  }

  void _submitAd() async {
    if (_formKey.currentState!.validate()) {
      if (_images.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('الرجاء إضافة صورة واحدة على الأقل'), backgroundColor: Colors.red),
        );
        return;
      }
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم نشر الإعلان بنجاح! 🎉'), backgroundColor: Colors.green),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}

