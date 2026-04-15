import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../theme/app_theme.dart';
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
  String? _selectedCategory;
  String? _selectedCity;
  List<File> _images = [];
  bool _isLoading = false;

  final List<String> _categories = ['إلكترونيات', 'سيارات', 'عقارات', 'أثاث', 'أزياء', 'خدمات'];
  final List<String> _cities = ['صنعاء', 'عدن', 'تعز', 'الحديدة', 'إب', 'المكلا'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'إضافة إعلان'),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImagePicker(),
              const SizedBox(height: 20),
              _buildTextField(_titleController, 'عنوان الإعلان', Icons.title, maxLines: 1),
              const SizedBox(height: 16),
              _buildTextField(_descriptionController, 'وصف الإعلان', Icons.description, maxLines: 4),
              const SizedBox(height: 16),
              _buildTextField(_priceController, 'السعر (ريال يمني)', Icons.monetization_on, keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildDropdown('القسم', _selectedCategory, _categories, (value) => setState(() => _selectedCategory = value)),
              const SizedBox(height: 16),
              _buildDropdown('المدينة', _selectedCity, _cities, (value) => setState(() => _selectedCity = value)),
              const SizedBox(height: 24),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('صور الإعلان', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              GestureDetector(
                onTap: _pickImages,
                child: Container(width: 100, height: 100, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.goldColor, width: 2, style: BorderStyle.solid)), child: const Icon(Icons.add_photo_alternate, size: 40, color: AppTheme.goldColor)),
              ),
              ..._images.map((image) => Padding(padding: const EdgeInsets.only(left: 8), child: Stack(children: [ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.file(image, width: 100, height: 100, fit: BoxFit.cover)), Positioned(top: 4, right: 4, child: GestureDetector(onTap: () => setState(() => _images.remove(image)), child: Container(padding: const EdgeInsets.all(2), decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle), child: const Icon(Icons.close, size: 16, color: Colors.white))))]))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon, color: AppTheme.goldColor), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.goldColor, width: 2))),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: (value) => value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
    );
  }

  Widget _buildDropdown(String label, String? value, List<String> items, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(labelText: label, prefixIcon: Icon(label == 'القسم' ? Icons.category : Icons.location_on, color: AppTheme.goldColor), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'هذا الحقل مطلوب' : null,
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submitAd,
        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        child: _isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Text('نشر الإعلان', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
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
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('الرجاء إضافة صورة واحدة على الأقل'), backgroundColor: Colors.red));
        return;
      }
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم نشر الإعلان بنجاح!'), backgroundColor: Colors.green));
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
