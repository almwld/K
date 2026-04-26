import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../theme/app_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'أحمد محمد');
  final _emailController = TextEditingController(text: 'ahmed@flexyemen.com');
  final _phoneController = TextEditingController(text: '+967 777 123 456');
  String? _avatarImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _avatarImage = image.path);
    }
  }

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() => _avatarImage = photo.path);
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم حفظ التغييرات بنجاح'), backgroundColor: AppTheme.binanceGreen),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('تعديل الملف الشخصي', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
        actions: [
          TextButton(onPressed: _saveProfile, child: const Text('حفظ', style: TextStyle(color: AppTheme.binanceGold))),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _showImagePickerDialog(),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppTheme.binanceGold.withOpacity(0.2),
                      child: _avatarImage != null
                          ? ClipOval(child: Image.file(File(_avatarImage!), width: 100, height: 100, fit: BoxFit.cover))
                          : ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => const Icon(Icons.person, size: 50),
                              ),
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppTheme.binanceGold,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt, size: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  labelText: 'الاسم الكامل',
                  labelStyle: TextStyle(color: isDark ? Colors.grey.shade400 : Colors.grey.shade700),
                  prefixIcon: const Icon(Icons.person_outline, color: AppTheme.binanceGold),
                  filled: true,
                  fillColor: isDark ? AppTheme.binanceCard : Colors.grey.shade100,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
                validator: (v) => v!.isEmpty ? 'يرجى إدخال الاسم' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  labelStyle: TextStyle(color: isDark ? Colors.grey.shade400 : Colors.grey.shade700),
                  prefixIcon: const Icon(Icons.email_outlined, color: AppTheme.binanceGold),
                  filled: true,
                  fillColor: isDark ? AppTheme.binanceCard : Colors.grey.shade100,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
                validator: (v) => v!.isEmpty ? 'يرجى إدخال البريد' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  labelText: 'رقم الهاتف',
                  labelStyle: TextStyle(color: isDark ? Colors.grey.shade400 : Colors.grey.shade700),
                  prefixIcon: const Icon(Icons.phone_outlined, color: AppTheme.binanceGold),
                  filled: true,
                  fillColor: isDark ? AppTheme.binanceCard : Colors.grey.shade100,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePickerDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.binanceCard,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppTheme.binanceGold),
              title: const Text('اختيار من المعرض', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _pickImage();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppTheme.binanceGold),
              title: const Text('التقاط صورة', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _takePhoto();
              },
            ),
          ],
        ),
      ),
    );
  }
}
