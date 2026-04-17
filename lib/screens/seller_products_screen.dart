import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

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
  final _descriptionController = TextEditingController();
  
  String _selectedCategory = 'electronics';
  List<XFile> _selectedImages = [];
  bool _isSubmitting = false;
  final ImagePicker _picker = ImagePicker();
  
  final List<Map<String, String>> _categories = [
    {'id': 'electronics', 'name': 'إلكترونيات'},
    {'id': 'fashion', 'name': 'أزياء'},
    {'id': 'furniture', 'name': 'أثاث'},
    {'id': 'cars', 'name': 'سيارات'},
    {'id': 'real_estate', 'name': 'عقارات'},
    {'id': 'services', 'name': 'خدمات'},
  ];

  Future<void> _pickImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    setState(() {
      _selectedImages = pickedFiles;
    });
  }

  Future<void> _submitProduct() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء اختيار صورة واحدة على الأقل')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    
    try {
      final supabase = Supabase.instance.client;
      final userId = supabase.auth.currentUser?.id;
      
      if (userId == null) {
        throw Exception('يجب تسجيل الدخول أولاً');
      }
      
      // رفع الصور
      List<String> imageUrls = [];
      for (int i = 0; i < _selectedImages.length; i++) {
        final file = _selectedImages[i];
        final fileName = 'products/${DateTime.now().millisecondsSinceEpoch}_$i.jpg';
        await supabase.storage.from('products').upload(fileName, File(file.path));
        final imageUrl = supabase.storage.from('products').getPublicUrl(fileName);
        imageUrls.add(imageUrl);
      }
      
      // حفظ المنتج
      await supabase.from('products').insert({
        'seller_id': userId,
        'name': _nameController.text,
        'price': double.parse(_priceController.text),
        'stock': int.parse(_stockController.text),
        'category': _selectedCategory,
        'description': _descriptionController.text,
        'images': imageUrls,
        'is_available': true,
        'created_at': DateTime.now().toIso8601String(),
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إضافة المنتج بنجاح'), backgroundColor: Colors.green),
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
      appBar: const SimpleAppBar(title: 'إضافة منتج'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildImagePicker(),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'اسم المنتج', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'الرجاء إدخال اسم المنتج' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'السعر (ريال)', border: OutlineInputBorder()),
                      validator: (v) => v!.isEmpty ? 'الرجاء إدخال السعر' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _stockController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'الكمية', border: OutlineInputBorder()),
                      validator: (v) => v!.isEmpty ? 'الرجاء إدخال الكمية' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'القسم', border: OutlineInputBorder()),
                items: _categories.map((c) => DropdownMenuItem(value: c['id'], child: Text(c['name']!))).toList(),
                onChanged: (v) => setState(() => _selectedCategory = v.toString()),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'الوصف', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitProduct,
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldPrimary, foregroundColor: Colors.black),
                  child: _isSubmitting ? const CircularProgressIndicator(strokeWidth: 2) : const Text('إضافة المنتج'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('الصور', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _selectedImages.length + 1,
            itemBuilder: (context, index) {
              if (index == _selectedImages.length) {
                return GestureDetector(
                  onTap: _pickImages,
                  child: Container(
                    width: 100, height: 100,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(color: isDark ? Colors.grey[800] : Colors.grey[200], borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.goldPrimary, width: 1)),
                    child: const Icon(Icons.add_photo_alternate, size: 40),
                  ),
                );
              }
              return Stack(children: [
                Container(
                  width: 100, height: 100,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), image: DecorationImage(image: FileImage(File(_selectedImages[index].path)), fit: BoxFit.cover)),
                ),
                Positioned(
                  top: 0, right: 8,
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedImages.removeAt(index)),
                    child: const CircleAvatar(radius: 14, backgroundColor: Colors.red, child: Icon(Icons.close, size: 16, color: Colors.white)),
                  ),
                ),
              ]);
            },
          ),
        ),
      ],
    );
  }
}
