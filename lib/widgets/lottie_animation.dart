import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatelessWidget {
  final String asset;
  final double width;
  final double height;
  final bool repeat;
  final bool reverse;
  final VoidCallback? onLoaded;

  const LottieAnimation({
    super.key,
    required this.asset,
    this.width = 120,
    this.height = 120,
    this.repeat = true,
    this.reverse = false,
    this.onLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      asset,
      width: width,
      height: height,
      repeat: repeat,
      reverse: reverse,
      onLoaded: (composition) {
        if (onLoaded != null) onLoaded!();
      },
    );
  }
}

class LoadingAnimation extends StatelessWidget {
  final String? message;
  final double size;

  const LoadingAnimation({super.key, this.message, this.size = 80});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/animations/loading_logo.json',
              width: size,
              height: size,
              repeat: true,
            ),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message!,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white70 : Colors.grey[700],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

