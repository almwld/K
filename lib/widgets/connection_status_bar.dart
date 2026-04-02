import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/connection_checker.dart';
import '../theme/app_theme.dart';

class ConnectionStatusBar extends StatelessWidget {
  const ConnectionStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final connectionChecker = Provider.of<ConnectionChecker>(context);
    final isOnline = connectionChecker.isOnline;

    if (isOnline) return const SizedBox(height: 0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off, color: Colors.white, size: 16),
          const SizedBox(width: 8),
          const Text(
            'لا يوجد اتصال بالإنترنت - عرض البيانات المخزنة محلياً',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          const SizedBox(width: 8),
          Container(
            width: 8, height: 8,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}
