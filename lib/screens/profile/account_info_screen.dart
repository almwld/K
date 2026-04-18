import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('معلومات الحساب')),
      body: const Center(child: Text('معلومات الحساب')),
    );
  }
}
