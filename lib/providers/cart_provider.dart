import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;
  int get itemCount => _items.length;
  double get totalPrice => _items.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));

  void addItem(Map<String, dynamic> product) {
    final existingIndex = _items.indexWhere((item) => item['id'] == product['id']);
    if (existingIndex != -1) {
      _items[existingIndex]['quantity']++;
    } else {
      _items.add({
        'id': product['id'],
        'name': product['name'],
        'price': product['price'],
        'quantity': 1,
        'image': product['image'],
        'seller_id': product['seller_id'],
      });
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item['id'] == id);
    notifyListeners();
  }

  void updateQuantity(String id, int quantity) {
    final index = _items.indexWhere((item) => item['id'] == id);
    if (index != -1) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index]['quantity'] = quantity;
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
