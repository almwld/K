import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'إعدادات الحساب'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // صورة الملف الشخصي
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppTheme.gold.withOpacity(0.2),
                    child: const Icon(Icons.person, size: 50, color: AppTheme.gold),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: AppTheme.gold,
                      child: const Icon(Icons.camera_alt, size: 16, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // النموذج
            _buildTextField('الاسم الكامل', 'أحمد محمد'),
            _buildTextField('اسم المستخدم', '@ahmed123'),
            _buildTextField('البريد الإلكتروني', 'ahmed@email.com'),
            _buildTextField('رقم الهاتف', '+967 777 123 456'),
            _buildTextField('العنوان', 'صنعاء - اليمن'),
            
            const SizedBox(height: 24),
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم حفظ التغييرات')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.gold,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('حفظ التغييرات', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: TextEditingController(text: initialValue),
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppTheme.gold, width: 2),
          ),
        ),
      ),
    );
  }
}

