import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ElectronicsScreen extends StatelessWidget {
  const ElectronicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(title: Text('electronics', style: const TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11)),
      body: const Center(child: Text('منتجات electronics', style: TextStyle(color: Colors.white))),
    );
  }
}
