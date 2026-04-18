import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _items = [];
  String? _couponCode;
  double _discount = 0;

  List<CartItem> get items => _items;
  String? get couponCode => _couponCode;
  double get discount => _discount;

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  
  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);
  
  double get total => subtotal - _discount;

  CartProvider() {
    _loadCart();
  }

  // تحميل السلة من التخزين المحلي
  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString('cart');
    if (cartJson != null) {
      final List<dynamic> decoded = json.decode(cartJson);
      _items = decoded.map((item) => CartItem.fromJson(item)).toList();
    }
    _couponCode = prefs.getString('coupon');
    _discount = prefs.getDouble('discount') ?? 0;
    notifyListeners();
  }

  // حفظ السلة
  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = json.encode(_items.map((item) => item.toJson()).toList());
    await prefs.setString('cart', cartJson);
    if (_couponCode != null) {
      await prefs.setString('coupon', _couponCode!);
      await prefs.setDouble('discount', _discount);
    }
  }

  // إضافة منتج للسلة
  void addItem(CartItem item) {
    final existingIndex = _items.indexWhere((i) => i.productId == item.productId);
    
    if (existingIndex >= 0) {
      final existingItem = _items[existingIndex];
      final newQuantity = existingItem.quantity + item.quantity;
      
      if (newQuantity <= existingItem.stockQuantity) {
        _items[existingIndex] = existingItem.copyWith(quantity: newQuantity);
      }
    } else {
      _items.add(item);
    }
    
    _saveCart();
    notifyListeners();
  }

  // تحديث الكمية
  void updateQuantity(String productId, int quantity) {
    final index = _items.indexWhere((item) => item.productId == productId);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else if (quantity <= _items[index].stockQuantity) {
        _items[index] = _items[index].copyWith(quantity: quantity);
      }
    }
    _saveCart();
    notifyListeners();
  }

  // حذف منتج
  void removeItem(String productId) {
    _items.removeWhere((item) => item.productId == productId);
    _saveCart();
    notifyListeners();
  }

  // تفريغ السلة
  void clearCart() {
    _items.clear();
    _couponCode = null;
    _discount = 0;
    _saveCart();
    notifyListeners();
  }

  // تطبيق كوبون
  bool applyCoupon(String code) {
    // محاكاة كوبونات
    if (code == 'WELCOME10') {
      _couponCode = code;
      _discount = subtotal * 0.1;
      _saveCart();
      notifyListeners();
      return true;
    } else if (code == 'FLEX20') {
      _couponCode = code;
      _discount = subtotal * 0.2;
      _saveCart();
      notifyListeners();
      return true;
    }
    return false;
  }

  // إزالة الكوبون
  void removeCoupon() {
    _couponCode = null;
    _discount = 0;
    _saveCart();
    notifyListeners();
  }
}
