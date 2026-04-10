import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'نسيت كلمة المرور'),
      body: const Center(child: Text('سيتم إضافة صفحة استعادة كلمة المرور قريباً')),
    );
  }
}
