import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class VoiceVisualizer extends StatelessWidget {
  final bool isListening;
  final VoidCallback onListeningStart;
  final VoidCallback onListeningStop;

  const VoiceVisualizer({
    super.key,
    required this.isListening,
    required this.onListeningStart,
    required this.onListeningStop,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isListening ? onListeningStop : onListeningStart,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: isListening
                ? [Colors.red, Colors.red.withOpacity(0.7)]
                : [AppTheme.goldPrimary, AppTheme.goldLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: (isListening ? Colors.red : AppTheme.goldPrimary).withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Icon(
          isListening ? Icons.mic : Icons.mic_none,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
