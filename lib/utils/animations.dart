import 'package:flutter/material.dart';

class AppAnimations {
  static Widget fadeInUp({required Widget child, int delay = 0}) {
    return TweenAnimationBuilder<double>(tween: Tween(begin: 0.0, end: 1.0), duration: Duration(milliseconds: 500 + delay), curve: Curves.easeOut, builder: (context, value, _) => Opacity(opacity: value, child: Transform.translate(offset: Offset(0, 20 * (1 - value)), child: child)));
  }

  static Widget scaleIn({required Widget child, int delay = 0}) {
    return TweenAnimationBuilder<double>(tween: Tween(begin: 0.5, end: 1.0), duration: Duration(milliseconds: 400 + delay), curve: Curves.elasticOut, builder: (context, value, _) => Transform.scale(scale: value, child: child));
  }

  static Widget slideInRight({required Widget child, int delay = 0}) {
    return TweenAnimationBuilder<Offset>(tween: Tween(begin: const Offset(0.3, 0), end: Offset.zero), duration: Duration(milliseconds: 400 + delay), curve: Curves.easeOut, builder: (context, value, _) => FractionalTranslation(translation: value, child: child));
  }
}
