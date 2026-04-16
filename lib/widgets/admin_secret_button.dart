import 'package:flutter/material.dart';
import '../screens/admin/admin_secret_screen.dart';

class AdminSecretButton extends StatefulWidget {
  final Widget child;
  const AdminSecretButton({super.key, required this.child});

  @override
  State<AdminSecretButton> createState() => _AdminSecretButtonState();
}

class _AdminSecretButtonState extends State<AdminSecretButton> {
  int _tapCount = 0;
  DateTime? _lastTapTime;

  void _onTap() {
    final now = DateTime.now();
    
    if (_lastTapTime != null && now.difference(_lastTapTime!).inSeconds > 2) {
      _tapCount = 0;
    }
    
    _tapCount++;
    _lastTapTime = now;
    
    if (_tapCount >= 5) {
      _tapCount = 0;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AdminSecretScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: widget.child,
    );
  }
}
