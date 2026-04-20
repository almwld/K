import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // handle login/register
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_isLogin ? 'تم تسجيل الدخول' : 'تم التسجيل')));
    }
  }

  void _forgotPassword() {
    // open forgot password flow
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المصادقة'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              width: 520,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(_isLogin ? 'تسجيل الدخول' : 'إنشاء حساب', style: Theme.of(context).textTheme.headline6),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: emailC,
                      decoration: const InputDecoration(labelText: 'البريد الإلكتروني'),
                      validator: (v) => v != null && v.contains('@') ? null : 'أدخل بريد إلكتروني صالح',
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: passC,
                      decoration: const InputDecoration(labelText: 'كلمة المرور'),
                      obscureText: true,
                      validator: (v) => v != null && v.length >= 6 ? null : 'يجب أن تكون كلمة المرور 6 أحرف على الأقل',
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: _forgotPassword, child: const Text('نسيت كلمة المرور؟')),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold, foregroundColor: Colors.black),
                      child: Text(_isLogin ? 'دخول' : 'تسجيل'),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => setState(() => _isLogin = !_isLogin),
                      child: Text(_isLogin ? 'إنشاء حساب جديد' : 'لديك حساب؟ تسجيل الدخول'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

