import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
class FollowingScreen extends StatelessWidget {
  const FollowingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFF0B0E11), appBar: AppBar(title: const Text('المتابعات', style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11)), body: const Center(child: Text('المتاجر التي تتابعها', style: TextStyle(color: Colors.white))));
  }
}
