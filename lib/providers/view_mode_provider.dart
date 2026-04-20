import 'package:flutter/material.dart';

enum ViewMode { lite, pro }

class ViewModeProvider extends ChangeNotifier {
  ViewMode _currentMode = ViewMode.lite;
  
  ViewMode get currentMode => _currentMode;
  bool get isPro => _currentMode == ViewMode.pro;
  bool get isLite => _currentMode == ViewMode.lite;
  
  void setMode(ViewMode mode) {
    _currentMode = mode;
    notifyListeners();
  }
  
  void toggleMode() {
    _currentMode = _currentMode == ViewMode.lite ? ViewMode.pro : ViewMode.lite;
    notifyListeners();
  }
}

