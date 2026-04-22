import 'package:flutter/material.dart';
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
  List<String> _selectedImages = [];

  final List<String> _categories = [
    'إلكترونيات', 'سيارات', 'عقارات', 'أزياء', 'أثاث', 'خدمات'
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        title: const Text('إضافة إعلان', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _submitAd,
            child: const Text('نشر', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // رفع الصور
            GestureDetector(
              onTap: _pickImages,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2329),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF2B3139), style: BorderStyle.solid),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_photo_alternate, color: Color(0xFFD4AF37), size: 40),
                    const SizedBox(height: 8),
                    Text(
                      _selectedImages.isEmpty ? 'اضغط لإضافة صور' : 'تم اختيار ${_selectedImages.length} صور',
                      style: const TextStyle(color: Color(0xFF9CA3AF)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // العنوان
            TextFormField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'عنوان الإعلان',
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

            // الفئة
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2329),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedCategory,
                dropdownColor: const Color(0xFF1E2329),
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(border: InputBorder.none),
                items: _categories.map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat, style: const TextStyle(color: Colors.white)));
                }).toList(),
                onChanged: (v) => setState(() => _selectedCategory = v!),
              ),
            ),
            const SizedBox(height: 16),

            // السعر
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'السعر (ريال)',
                labelStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                prefixIcon: const Icon(Icons.attach_money, color: Color(0xFFD4AF37)),
                filled: true,
                fillColor: const Color(0xFF1E2329),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (v) => v == null || v.isEmpty ? 'السعر مطلوب' : null,
            ),
            const SizedBox(height: 16),

            // الوصف
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'وصف الإعلان',
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

  void _pickImages() {
    setState(() {
      _selectedImages = ['image1', 'image2'];
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('جاري رفع الصور...')),
    );
  }

  void _submitAd() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم نشر الإعلان بنجاح!'),
          backgroundColor: Color(0xFF0ECB81),
        ),
      );
    }
  }
}
