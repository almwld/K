import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../theme/app_theme.dart';

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
  String _selectedCategory = 'إلكترونيات';
  String _selectedCity = 'صنعاء';
  XFile? _selectedImage;
  bool _isLoading = false;

  final List<String> _categories = ['إلكترونيات', 'أزياء', 'سيارات', 'عقارات', 'أثاث', 'خدمات'];
  final List<String> _cities = ['صنعاء', 'عدن', 'تعز', 'الحديدة', 'المكلا', 'إب'];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => _selectedImage = image);
  }

  Future<void> _submitAd() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم نشر الإعلان بنجاح!'), backgroundColor: AppTheme.binanceGreen),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('إضافة إعلان', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.binanceGold))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isDark ? AppTheme.binanceCard : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.binanceBorder),
                        ),
                        child: _selectedImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(File(_selectedImage!.path), fit: BoxFit.cover),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_photo_alternate, size: 40, color: AppTheme.binanceGold),
                                  const SizedBox(height: 8),
                                  const Text('اضغط لإضافة صورة', style: TextStyle(color: Color(0xFF9CA3AF))),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _titleController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'عنوان الإعلان',
                        prefixIcon: Icon(Icons.title, color: AppTheme.binanceGold),
                        filled: true,
                        fillColor: Color(0xFF1E2329),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v!.isEmpty ? 'يرجى إدخال العنوان' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'وصف الإعلان',
                        prefixIcon: Icon(Icons.description, color: AppTheme.binanceGold),
                        filled: true,
                        fillColor: Color(0xFF1E2329),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v!.isEmpty ? 'يرجى إدخال الوصف' : null,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedCategory,
                            items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                            onChanged: (v) => setState(() => _selectedCategory = v!),
                            decoration: const InputDecoration(
                              labelText: 'الفئة',
                              prefixIcon: Icon(Icons.category, color: AppTheme.binanceGold),
                              filled: true,
                              fillColor: Color(0xFF1E2329),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedCity,
                            items: _cities.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                            onChanged: (v) => setState(() => _selectedCity = v!),
                            decoration: const InputDecoration(
                              labelText: 'المدينة',
                              prefixIcon: Icon(Icons.location_on, color: AppTheme.binanceGold),
                              filled: true,
                              fillColor: Color(0xFF1E2329),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'السعر (ريال)',
                        prefixIcon: Icon(Icons.attach_money, color: AppTheme.binanceGold),
                        filled: true,
                        fillColor: Color(0xFF1E2329),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v!.isEmpty ? 'يرجى إدخال السعر' : null,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submitAd,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.binanceGold,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('نشر الإعلان', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
