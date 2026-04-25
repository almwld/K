import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GoldenFloatingButton extends StatefulWidget {
  final VoidCallback? onAdPressed;
  final VoidCallback? onProductPressed;
  final VoidCallback? onStorePressed;
  final VoidCallback? onConsultationPressed;
  final VoidCallback? onOfferPressed;

  const GoldenFloatingButton({
    super.key,
    this.onAdPressed,
    this.onProductPressed,
    this.onStorePressed,
    this.onConsultationPressed,
    this.onOfferPressed,
  });

  @override
  State<GoldenFloatingButton> createState() => _GoldenFloatingButtonState();
}

class _GoldenFloatingButtonState extends State<GoldenFloatingButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  bool _isOpen = false;

  final List<Map<String, dynamic>> _actions = [
    {'icon': Icons.campaign, 'label': 'إعلان جديد', 'color': const Color(0xFF2196F3)},
    {'icon': Icons.shopping_bag, 'label': 'منتج جديد', 'color': const Color(0xFF4CAF50)},
    {'icon': Icons.store, 'label': 'متجر جديد', 'color': const Color(0xFFFF9800)},
    {'icon': Icons.chat, 'label': 'استشارة', 'color': const Color(0xFF9C27B0)},
    {'icon': Icons.local_offer, 'label': 'عرض خاص', 'color': const Color(0xFFF44336)},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  void _toggleMenu() {
    setState(() { _isOpen = !_isOpen; if (_isOpen) _controller.forward(); else _controller.reverse(); });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        if (_isOpen) GestureDetector(onTap: _toggleMenu, child: Container(color: Colors.black.withOpacity(0.5))),
        ...List.generate(_actions.length, (index) {
          final action = _actions[index];
          final radius = 80.0;
          final angle = (index * 36 - 72) * math.pi / 180;
          return AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(radius * math.cos(angle) * _scaleAnimation.value, radius * math.sin(angle) * _scaleAnimation.value),
                child: Opacity(opacity: _scaleAnimation.value, child: ScaleTransition(scale: _scaleAnimation, child: child)),
              );
            },
            child: GestureDetector(
              onTap: () { _toggleMenu(); switch (index) { case 0: widget.onAdPressed?.call(); break; case 1: widget.onProductPressed?.call(); break; case 2: widget.onStorePressed?.call(); break; case 3: widget.onConsultationPressed?.call(); break; case 4: widget.onOfferPressed?.call(); break; } },
              child: Container(width: 48, height: 48, margin: const EdgeInsets.all(8), decoration: BoxDecoration(color: action['color'] as Color, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8)]), child: Icon(action['icon'] as IconData, color: Colors.white, size: 24)),
            ),
          );
        }),
        GestureDetector(
          onTap: _toggleMenu,
          child: AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) => Transform.rotate(angle: _rotationAnimation.value * math.pi, child: Container(width: 56, height: 56, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFAA8C2C)]), shape: BoxShape.circle, boxShadow: [BoxShadow(color: const Color(0xFFD4AF37).withOpacity(0.4), blurRadius: 12, spreadRadius: 2)]), child: Icon(_isOpen ? Icons.close : Icons.add, color: Colors.black, size: 32))),
          ),
        ),
      ],
    );
  }
}
