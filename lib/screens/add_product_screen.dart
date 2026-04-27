import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../theme/app_theme.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  String _selectedCategory = 'إلكترونيات';
  XFile? _selectedImage;
  bool _inStock = true;
  bool _isLoading = false;

  final List<String> _categories = ['إلكترونيات', 'أزياء', 'سيارات', 'عقارات', 'أثاث', 'مطاعم'];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => _selectedImage = image);
  }

  Future<void> _submitProduct() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إضافة المنتج بنجاح!'), backgroundColor: AppTheme.binanceGreen),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('إضافة منتج', style: TextStyle(fontWeight: FontWeight.bold)),
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
                            ? ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.file(File(_selectedImage!.path), fit: BoxFit.cover))
                            : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Icon(Icons.add_photo_alternate, size: 40, color: AppTheme.binanceGold),
                                const SizedBox(height: 8),
                                const Text('صورة المنتج', style: TextStyle(color: Color(0xFF9CA3AF))),
                              ]),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'اسم المنتج',
                        prefixIcon: Icon(Icons.shopping_bag, color: AppTheme.binanceGold),
                        filled: true,
                        fillColor: Color(0xFF1E2329),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v!.isEmpty ? 'يرجى إدخال اسم المنتج' : null,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
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
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _stockController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'الكمية',
                              prefixIcon: Icon(Icons.inventory, color: AppTheme.binanceGold),
                              filled: true,
                              fillColor: Color(0xFF1E2329),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
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
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('متوفر في المخزون'),
                      value: _inStock,
                      onChanged: (v) => setState(() => _inStock = v),
                      activeColor: AppTheme.binanceGold,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submitProduct,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.binanceGold,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('إضافة المنتج', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
