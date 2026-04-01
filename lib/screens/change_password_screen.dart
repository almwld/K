import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final oldC = TextEditingController();
  final newC = TextEditingController();
  final confirmC = TextEditingController();

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم تغيير كلمة المرور')));
      oldC.clear();
      newC.clear();
      confirmC.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'تغيير كلمة المرور'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: oldC, obscureText: true, decoration: const InputDecoration(labelText: 'كلمة المرور الحالية'), validator: (v) => (v?.isEmpty ?? true) ? 'أدخل كلمة المرور' : null),
              const SizedBox(height: 12),
              TextFormField(controller: newC, obscureText: true, decoration: const InputDecoration(labelText: 'كلمة المرور الجديدة'), validator: (v) => (v != null && v.length >= 6) ? null : '6 أحرف على الأقل'),
              const SizedBox(height: 12),
              TextFormField(controller: confirmC, obscureText: true, decoration: const InputDecoration(labelText: 'تأكيد كلمة المرور'), validator: (v) => v == newC.text ? null : 'غير متطابقة'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black),
                child: const Text('حفظ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
