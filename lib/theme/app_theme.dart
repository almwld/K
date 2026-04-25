import 'package:flutter/material.dart';

class AppTheme {
  // الألوان الأساسية
  static const Color binanceDark = Color(0xFF0B0E11);
  static const Color binanceCard = Color(0xFF1E2329);
  static const Color binanceBorder = Color(0xFF2B3139);
  static const Color binanceGold = Color(0xFFD4AF37);
  static const Color binanceGreen = Color(0xFF0ECB81);
  static const Color binanceRed = Color(0xFFF6465D);
  
  // ألوان إضافية
  static const Color serviceBlue = Color(0xFF2196F3);
  static const Color serviceGreen = Color(0xFF4CAF50);
  static const Color serviceOrange = Color(0xFFFF9800);
  static const Color binanceServiceBlue = Color(0xFF2196F3);
  
  // التدرجات
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFF4E4A6), Color(0xFFD4AF37), Color(0xFFAA8C2C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1E2329), Color(0xFF16213E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
