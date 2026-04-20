import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/custom_button.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'أحمد محمد');
  final _emailController = TextEditingController(text: 'ahmed@example.com');
  final _phoneController = TextEditingController(text: '777123456');
  final _addressController = TextEditingController(text: 'صنعاء، اليمن');
  
  bool _isEditing = false;
  bool _isLoading = false;
  
  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoading = false;
      _isEditing = false;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم تحديث المعلومات بنجاح'), backgroundColor: Colors.green),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(
        title: 'معلومات الحساب',
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => setState(() => _isEditing = true),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // الصورة
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppTheme.gold.withOpacity(0.2),
                      child: const Icon(Icons.person, size: 50, color: AppTheme.gold),
                    ),
                    if (_isEditing)
                      Positioned(
                        bottom: 0, right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: AppTheme.gold, shape: BoxShape.circle),
                          child: const Icon(Icons.camera_alt, size: 16, color: Colors.black),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // الاسم
              TextFormField(
                controller: _nameController,
                enabled: _isEditing,
                decoration: const InputDecoration(labelText: 'الاسم الكامل', border: OutlineInputBorder()),
                validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
              ),
              const SizedBox(height: 12),
              
              // البريد الإلكتروني
              TextFormField(
                controller: _emailController,
                enabled: _isEditing,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'البريد الإلكتروني', border: OutlineInputBorder()),
                validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
              ),
              const SizedBox(height: 12),
              
              // رقم الهاتف
              TextFormField(
                controller: _phoneController,
                enabled: _isEditing,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'رقم الهاتف', border: OutlineInputBorder()),
                validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
              ),
              const SizedBox(height: 12),
              
              // العنوان
              TextFormField(
                controller: _addressController,
                enabled: _isEditing,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'العنوان', border: OutlineInputBorder()),
                validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
              ),
              
              const SizedBox(height: 32),
              
              if (_isEditing)
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => setState(() => _isEditing = false),
                        child: const Text('إلغاء'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomButton(
                        text: 'حفظ',
                        onPressed: _saveChanges,
                        isLoading: _isLoading,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

