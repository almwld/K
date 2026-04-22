import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        title: const Text('المفضلة', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('لا توجد منتجات في المفضلة', style: TextStyle(color: Color(0xFF9CA3AF))),
      ),
    );
  }
}
