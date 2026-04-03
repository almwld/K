import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/custom_button.dart';

class SellerProductsScreen extends StatefulWidget {
  const SellerProductsScreen({super.key});

  @override
  State<SellerProductsScreen> createState() => _SellerProductsScreenState();
}

class _SellerProductsScreenState extends State<SellerProductsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  
  String _selectedCategory = 'إلكترونيات';
  List<File> _selectedImages = [];
  bool _isSubmitting = false;
  
  final List<String> _categories = [
    'إلكترونيات', 'سيارات', 'عقارات', 'أزياء', 'أثاث', 'مطاعم'
  ];
  
  final ImagePicker _picker = ImagePicker();
  
  Future<void> _pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _selectedImages = images.map((img) => File(img.path)).toList();
      });
    }
  }
  
  Future<void> _submitProduct() async {
    if (!_formKey.currentState!.validate()) {
      _showSnackBar('يرجى ملء جميع الحقول', Colors.red);
      return;
    }
    if (_selectedImages.isEmpty) {
      _showSnackBar('الرجاء إضافة صورة للمنتج', Colors.red);
      return;
    }
    
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isSubmitting = false);
    
    _showSuccessDialog();
  }
  
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تم الإضافة!'),
        content: const Text('تم إضافة المنتج بنجاح.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً')),
        ],
      ),
    );
  }
  
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'إضافة منتج'),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImages,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppTheme.getCardColor(context),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
                      ),
                      child: _selectedImages.isEmpty
                          ? const Center(child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Icon(Icons.add_photo_alternate, size: 40), SizedBox(height: 8), Text('اضغط لإضافة صور')],
                            ))
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _selectedImages.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(4),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(_selectedImages[index], width: 100, height: 130, fit: BoxFit.cover),
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'اسم المنتج', border: OutlineInputBorder()), validator: (v) => v?.isEmpty == true ? 'مطلوب' : null),
                  const SizedBox(height: 12),
                  TextFormField(controller: _priceController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'السعر', border: OutlineInputBorder(), suffixText: 'ر.ي'), validator: (v) => v?.isEmpty == true ? 'مطلوب' : null),
                  const SizedBox(height: 12),
                  TextFormField(controller: _stockController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'الكمية', border: OutlineInputBorder()), validator: (v) => v?.isEmpty == true ? 'مطلوب' : null),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: const InputDecoration(labelText: 'الفئة', border: OutlineInputBorder()),
                    items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (v) => setState(() => _selectedCategory = v!),
                  ),
                  const SizedBox(height: 32),
                  CustomButton(text: 'إضافة المنتج', onPressed: _submitProduct, isLoading: _isSubmitting),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          if (_isSubmitting)
            Container(
              color: Colors.black.withOpacity(0.7),
              child: const Center(child: CircularProgressIndicator(color: AppTheme.goldColor)),
            ),
        ],
      ),
    );
  }
}
