import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../theme/app_theme.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({super.key});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  XFile? _selectedImage;
  String _storyText = '';
  bool _isLoading = false;
  int _selectedType = 0; // 0: نص, 1: صورة

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
        _selectedType = 1;
      });
    }
  }

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _selectedImage = photo;
        _selectedType = 1;
      });
    }
  }

  void _publishStory() {
    if (_selectedType == 0 && _storyText.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال نص الحالة'), backgroundColor: AppTheme.binanceRed),
      );
      return;
    }
    if (_selectedType == 1 && _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار صورة'), backgroundColor: AppTheme.binanceRed),
      );
      return;
    }

    setState(() => _isLoading = true);

    // محاكاة رفع الحالة
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم نشر الحالة بنجاح!'), backgroundColor: AppTheme.binanceGreen),
      );
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('إضافة حالة', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _publishStory,
            child: Text('نشر', style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.binanceGold))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // خيارات نوع الحالة
                  Row(
                    children: [
                      _buildTypeButton('نص', Icons.text_fields, 0),
                      const SizedBox(width: 12),
                      _buildTypeButton('صورة', Icons.image, 1),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // محتوى الحالة حسب النوع
                  if (_selectedType == 0) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.binanceCard : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.binanceBorder),
                      ),
                      child: TextField(
                        maxLines: 5,
                        onChanged: (value) => _storyText = value,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'اكتب حالتك هنا...',
                          hintStyle: TextStyle(color: isDark ? Colors.grey.shade500 : Colors.grey.shade600),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],

                  if (_selectedType == 1) ...[
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.binanceCard : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.binanceBorder),
                      ),
                      child: _selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.file(
                                File(_selectedImage!.path),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image, size: 64, color: AppTheme.binanceGold.withOpacity(0.5)),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: _pickImage,
                                      icon: const Icon(Icons.photo_library),
                                      label: const Text('اختيار من المعرض'),
                                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceGold),
                                    ),
                                    const SizedBox(width: 12),
                                    ElevatedButton.icon(
                                      onPressed: _takePhoto,
                                      icon: const Icon(Icons.camera_alt),
                                      label: const Text('تصوير'),
                                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceCard),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ),
                  ],

                  const SizedBox(height: 24),

                  // خيارات إضافية
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.binanceCard : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.binanceBorder),
                    ),
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text('مشاركة مع الجميع'),
                          value: true,
                          onChanged: (_) {},
                          activeColor: AppTheme.binanceGold,
                        ),
                        const Divider(),
                        SwitchListTile(
                          title: const Text('إشعار عند المشاهدة'),
                          value: false,
                          onChanged: (_) {},
                          activeColor: AppTheme.binanceGold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildTypeButton(String label, IconData icon, int type) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = _selectedType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedType = type;
            if (type != 1) _selectedImage = null;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.binanceGold : (isDark ? AppTheme.binanceCard : Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.binanceBorder),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? Colors.black : AppTheme.binanceGold),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.black : AppTheme.binanceGold,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
