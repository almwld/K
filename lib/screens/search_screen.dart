import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        title: const Text('البحث', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.binanceDark,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 80, color: AppTheme.binanceGold.withOpacity(0.3)),
            const SizedBox(height: 16),
            const Text('ابحث عن منتجات، متاجر، أو فئات', style: TextStyle(color: Color(0xFF9CA3AF))),
          ],
        ),
      ),
    );
  }
}
