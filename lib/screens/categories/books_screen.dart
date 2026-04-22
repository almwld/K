import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(title: Text('books', style: const TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11)),
      body: const Center(child: Text('منتجات books', style: TextStyle(color: Colors.white))),
    );
  }
}
