import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
class MarketsScreen extends StatelessWidget {
  const MarketsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFF0B0E11), appBar: AppBar(title: const Text('الأسواق', style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11)), body: const Center(child: Text('جميع الأسواق', style: TextStyle(color: Colors.white))));
  }
}
