import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class GlowingBrain extends StatelessWidget {
  final bool isListening;
  final AnimationController pulseController;

  const GlowingBrain({
    super.key,
    required this.isListening,
    required this.pulseController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulseController,
      builder: (context, child) {
        final glowValue = isListening ? 1.0 + pulseController.value * 0.3 : 1.0;
        return Container(
          width: 100 * glowValue,
          height: 100 * glowValue,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppTheme.goldColor.withOpacity(0.8),
                AppTheme.goldColor.withOpacity(0.3),
                Colors.transparent,
              ],
              stops: const [0.3, 0.6, 1.0],
            ),
          ),
          child: Center(
            child: Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(
                Icons.psychology,
                color: AppTheme.goldColor,
                size: 40,
              ),
            ),
          ),
        );
      },
    );
  }
}
