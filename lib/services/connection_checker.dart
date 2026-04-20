import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectionChecker extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  bool _isOnline = true;
  bool _isChecking = false;

  bool get isOnline => _isOnline;
  bool get isChecking => _isChecking;

  ConnectionChecker() {
    _initConnectivity();
    _startMonitoring();
  }

  Future<void> _initConnectivity() async {
    try {
      final results = await _connectivity.checkConnectivity();
      await _updateConnectionStatus(results);
    } catch (e) {
      debugPrint('Connectivity check error: $e');
    }
  }

  void _startMonitoring() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        _updateConnectionStatus(results);
      },
    );
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    final wasOnline = _isOnline;
    // تحديث: التحقق إذا كانت القائمة تحتوي على اتصال فعلي
    _isOnline = !results.contains(ConnectivityResult.none);

    if (_isOnline != wasOnline) {
      notifyListeners();
    }
  }

  Future<void> forceCheck() async {
    final results = await _connectivity.checkConnectivity();
    await _updateConnectionStatus(results);
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }
}

class ConnectionStatusBar extends StatelessWidget {
  const ConnectionStatusBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 0,
    );
  }
}

class OfflineIndicator extends StatelessWidget {
  const OfflineIndicator({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.red,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, color: Colors.white, size: 16),
          SizedBox(width: 8),
          Text(
            'لا يوجد اتصال بالإنترنت',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

