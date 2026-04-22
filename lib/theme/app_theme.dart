import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // 🌙 Night (كحلي فاخر)
  static const Color nightBackground = Color(0xFF0F172A);
  static const Color nightSurface = Color(0xFF16213E);
  static const Color nightCard = Color(0xFF1A2A44);
  static const Color nightTextPrimary = Color(0xFFFFFFFF);
  static const Color nightTextSecondary = Color(0xFFB0B0B0);

  // ☀️ Light
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF5F5F5);
  static const Color lightTextPrimary = Color(0xFF1A1A1A);
  static const Color lightTextSecondary = Color(0xFF757575);

  // ✨ Brand
  static const Color gold = Color(0xFFD4AF37);
  static const Color goldDark = Color(0xFFB8962E);
  static const Color goldLight = Color(0xFFF4E4A6);

  // ⚠️ Status
  static const Color error = Color(0xFFB00020);
  static const Color success = Color(0xFF00C853);
  static const Color warning = Color(0xFFFF9100);

  // 🎨 Service Colors
  static const Color serviceBlue = Color(0xFF2196F3);
  static const Color serviceOrange = Color(0xFFFF9800);
  static const Color serviceRed = Color(0xFFE53935);
  static const Color serviceGreen = Color(0xFF4CAF50);

  static LinearGradient get goldGradient => const LinearGradient(
    colors: [gold, goldLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // دوال مساعدة
  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? nightCard 
        : lightCard;
  }
