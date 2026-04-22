import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class RealestateScreen extends StatelessWidget {
  const RealestateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(title: Text('realestate', style: const TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11)),
      body: const Center(child: Text('منتجات realestate', style: TextStyle(color: Colors.white))),
    );
  }
}
