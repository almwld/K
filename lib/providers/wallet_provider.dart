import 'package:flutter/material.dart';

class WalletProvider extends ChangeNotifier {
  double _balance = 0.0;
  List<Map<String, dynamic>> _transactions = [];
  
  double get balance => _balance;
  List<Map<String, dynamic>> get transactions => _transactions;
  
  void addBalance(double amount) {
    _balance += amount;
    notifyListeners();
  }
  
  void subtractBalance(double amount) {
    _balance -= amount;
    notifyListeners();
  }
  
  void addTransaction(Map<String, dynamic> transaction) {
    _transactions.insert(0, transaction);
    notifyListeners();
  }
}
