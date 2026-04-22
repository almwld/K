import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(title: Text('games', style: const TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11)),
      body: const Center(child: Text('منتجات games', style: TextStyle(color: Colors.white))),
    );
  }
}
