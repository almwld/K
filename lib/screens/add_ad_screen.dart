import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/custom_button.dart';

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
  String _selectedCondition = 'جديد';
  List<File> _selectedImages = [];
  bool _isSubmitting = false;
  
  final List<String> _categories = [
    'إلكترونيات', 'سيارات', 'عقارات', 'أزياء', 'أثاث', 
    'مطاعم', 'خدمات', 'ألعاب', 'صحة وجمال', 'تعليم'
  ];
  
  final List<String> _cities = [
    'صنعاء', 'عدن', 'تعز', 'الحديدة', 'المكلا', 'إب', 'ذمار', 'صعدة'
  ];
  
  final List<String> _conditions = ['جديد', 'مستخدم بحالة ممتازة', 'مستخدم', 'للإصلاح'];
  
  final ImagePicker _picker = ImagePicker();
  
  Future<void> _pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _selectedImages = images.map((img) => File(img.path)).toList();
      });
    }
  }
  
  Future<void> _takePhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImages.add(File(image.path));
      });
    }
  }
  
  Future<void> _submitAd() async {
    if (!_formKey.currentState!.validate()) {
      _showSnackBar('يرجى ملء جميع الحقول المطلوبة', Colors.red);
      return;
    }
    if (_selectedImages.isEmpty) {
      _showSnackBar('الرجاء إضافة صورة واحدة على الأقل', Colors.red);
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تم النشر!'),
        content: const Text('تم نشر إعلانك بنجاح. سيتم مراجعته قريباً.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
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
      appBar: const SimpleAppBar(title: 'إضافة إعلان'),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // رفع الصور
                  const Text('صور الإعلان', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppTheme.getCardColor(context),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
                    ),
                    child: _selectedImages.isEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.photo_library, size: 32),
                                onPressed: _pickImages,
                                tooltip: 'اختر من المعرض',
                              ),
                              IconButton(
                                icon: const Icon(Icons.camera_alt, size: 32),
                                onPressed: _takePhoto,
                                tooltip: 'التقاط صورة',
                              ),
                            ],
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _selectedImages.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(_selectedImages[index], width: 100, height: 100, fit: BoxFit.cover),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0, right: 0,
                                    child: GestureDetector(
                                      onTap: () => setState(() => _selectedImages.removeAt(index)),
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                        child: const Icon(Icons.close, size: 12, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 16),
                  
                  // العنوان
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'عنوان الإعلان', border: OutlineInputBorder()),
                    validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
                  ),
                  const SizedBox(height: 12),
                  
                  // السعر
                  TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'السعر', border: OutlineInputBorder(), suffixText: 'ر.ي'),
                    validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
                  ),
                  const SizedBox(height: 12),
                  
                  // الفئة
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: const InputDecoration(labelText: 'الفئة', border: OutlineInputBorder()),
                    items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (v) => setState(() => _selectedCategory = v!),
                  ),
                  const SizedBox(height: 12),
                  
                  // المدينة
                  DropdownButtonFormField<String>(
                    value: _selectedCity,
                    decoration: const InputDecoration(labelText: 'المدينة', border: OutlineInputBorder()),
                    items: _cities.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (v) => setState(() => _selectedCity = v!),
                  ),
                  const SizedBox(height: 12),
                  
                  // الحالة
                  DropdownButtonFormField<String>(
                    value: _selectedCondition,
                    decoration: const InputDecoration(labelText: 'حالة المنتج', border: OutlineInputBorder()),
                    items: _conditions.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (v) => setState(() => _selectedCondition = v!),
                  ),
                  const SizedBox(height: 12),
                  
                  // الوصف
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 4,
                    decoration: const InputDecoration(labelText: 'الوصف', border: OutlineInputBorder()),
                    validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
                  ),
                  const SizedBox(height: 32),
                  
                  CustomButton(
                    text: 'نشر الإعلان',
                    onPressed: _submitAd,
                    isLoading: _isSubmitting,
                  ),
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
