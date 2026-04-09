import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/ad_service.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'home_screen.dart';

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
  final _oldPriceController = TextEditingController();
  final _phoneController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _locationController = TextEditingController();

  String _selectedCategory = 'electronics';
  String _selectedCondition = 'جديد';
  List<File> _selectedImages = [];
  bool _isSubmitting = false;

  final List<Map<String, dynamic>> _categories = [
    {'id': 'electronics', 'name': 'إلكترونيات', 'icon': Icons.electrical_services},
    {'id': 'fashion', 'name': 'أزياء', 'icon': Icons.checkroom},
    {'id': 'furniture', 'name': 'أثاث', 'icon': Icons.weekend},
    {'id': 'cars', 'name': 'سيارات', 'icon': Icons.directions_car},
    {'id': 'real_estate', 'name': 'عقارات', 'icon': Icons.house},
    {'id': 'services', 'name': 'خدمات', 'icon': Icons.build},
    {'id': 'restaurants', 'name': 'مطاعم', 'icon': Icons.restaurant},
  ];

  final List<String> _conditions = ['جديد', 'مستخدم', 'مجددد'];

  Future<void> _pickImages() async {
    final images = await StorageService().pickImages(maxCount: 5 - _selectedImages.length);
    setState(() {
      _selectedImages.addAll(images);
    });
  }

  Future<void> _submitAd() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء اختيار صورة واحدة على الأقل')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // رفع الصور
      final adService = AdService();
      final storageService = StorageService();
      final tempId = DateTime.now().millisecondsSinceEpoch.toString();
      final imageUrls = await storageService.uploadAdImages(_selectedImages, tempId);

      // إنشاء الإعلان
      await adService.createAd(
        title: _titleController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        oldPrice: _oldPriceController.text.isNotEmpty ? double.parse(_oldPriceController.text) : null,
        category: _selectedCategory,
        condition: _selectedCondition,
        location: _locationController.text,
        phone: _phoneController.text,
        whatsapp: _whatsappController.text,
        images: imageUrls,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم نشر الإعلان بنجاح'), backgroundColor: Colors.green),
      );

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
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
      appBar: const SimpleAppBar(title: 'إضافة إعلان'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // اختيار الصور
              const Text('الصور', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                height: 120,
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
                          decoration: BoxDecoration(
                            color: isDark ? Colors.grey[800] : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.add_photo_alternate, size: 40),
                        ),
                      );
                    }
                    return Stack(
                      children: [
                        Container(
                          width: 100, height: 100,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: FileImage(_selectedImages[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0, right: 8,
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedImages.removeAt(index)),
                            child: const CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.red,
                              child: Icon(Icons.close, size: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // عنوان الإعلان
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'عنوان الإعلان',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? 'الرجاء إدخال عنوان' : null,
              ),
              const SizedBox(height: 16),

              // الوصف
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'وصف الإعلان',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // السعر
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
                      controller: _oldPriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'السعر القديم (اختياري)', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // القسم والحالة
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedCategory,
                      decoration: const InputDecoration(labelText: 'القسم', border: OutlineInputBorder()),
                      items: _categories.map((c) => DropdownMenuItem(value: c['id'], child: Text(c['name']))).toList(),
                      onChanged: (v) => setState(() => _selectedCategory = v.toString()),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedCondition,
                      decoration: const InputDecoration(labelText: 'الحالة', border: OutlineInputBorder()),
                      items: _conditions.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                      onChanged: (v) => setState(() => _selectedCondition = v.toString()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // الموقع
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'الموقع',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // رقم الهاتف
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? 'الرجاء إدخال رقم الهاتف' : null,
              ),
              const SizedBox(height: 16),

              // واتساب
              TextFormField(
                controller: _whatsappController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'رقم واتساب (اختياري)',
                  prefixIcon: Icon(Icons.chat),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),

              // زر النشر
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitAd,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.goldColor,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator(strokeWidth: 2)
                      : const Text('نشر الإعلان', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
