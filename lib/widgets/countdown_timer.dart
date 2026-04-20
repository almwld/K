import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final Duration duration;
  final VoidCallback? onExpire;
  final bool showLabel;
  final double fontSize;

  const CountdownTimer({
    super.key,
    required this.duration,
    this.onExpire,
    this.showLabel = true,
    this.fontSize = 14,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _remaining = widget.duration;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    if (_remaining.inSeconds <= 0) {
      _timer.cancel();
      widget.onExpire?.call();
      return;
    }
    setState(() {
      _remaining = Duration(seconds: _remaining.inSeconds - 1);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final hours = _twoDigits(_remaining.inHours);
    final minutes = _twoDigits(_remaining.inMinutes.remainder(60));
    final seconds = _twoDigits(_remaining.inSeconds.remainder(60));
    final isUrgent = _remaining.inMinutes < 30;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showLabel) ...[
          Icon(
            Icons.timer,
            size: widget.fontSize + 2,
            color: isUrgent ? const Color(0xFFF6465D) : const Color(0xFFF0B90B),
          ),
          const SizedBox(width: 4),
        ],
        _timeBox(hours, isUrgent),
        _separator(),
        _timeBox(minutes, isUrgent),
        _separator(),
        _timeBox(seconds, isUrgent),
      ],
    );
  }

  Widget _timeBox(String value, bool isUrgent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: isUrgent
            ? const Color(0xFFF6465D).withOpacity(0.2)
            : const Color(0xFFF0B90B).withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isUrgent
              ? const Color(0xFFF6465D).withOpacity(0.5)
              : const Color(0xFFF0B90B).withOpacity(0.5),
        ),
      ),
      child: Text(
        value,
        style: TextStyle(
          fontFamily: 'Changa',
          fontSize: widget.fontSize,
          fontWeight: FontWeight.bold,
          color: isUrgent ? const Color(0xFFF6465D) : const Color(0xFFF0B90B),
        ),
      ),
    );
  }

  Widget _separator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Text(
        ':',
        style: TextStyle(
          fontFamily: 'Changa',
          fontSize: widget.fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF9CA3AF),
        ),
      ),
    );
  }
}
