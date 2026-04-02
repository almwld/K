import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/product_model.dart';

class OfflineStorageService {
  static const String _productsBox = 'products_box';
  static const String _favoritesBox = 'favorites_box';
  static const String _cartBox = 'cart_box';
  static const String _settingsBox = 'settings_box';
  
  static late Box _productsBoxInstance;
  static late Box _favoritesBoxInstance;
  static late Box _cartBoxInstance;
  static late Box _settingsBoxInstance;

  static Future<void> init() async {
    await Hive.initFlutter();
    _productsBoxInstance = await Hive.openBox(_productsBox);
    _favoritesBoxInstance = await Hive.openBox(_favoritesBox);
    _cartBoxInstance = await Hive.openBox(_cartBox);
    _settingsBoxInstance = await Hive.openBox(_settingsBox);
  }

  // ==================== المنتجات ====================
  static Future<void> saveProducts(List<ProductModel> products) async {
    await _productsBoxInstance.put('products', products.map((p) => p.toJson()).toList());
    await _productsBoxInstance.put('last_update', DateTime.now().millisecondsSinceEpoch);
  }

  static List<ProductModel> getProducts() {
    final data = _productsBoxInstance.get('products');
    if (data == null) return [];
    final List<dynamic> list = data;
    return list.map((json) => ProductModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  static bool hasProducts() {
    return _productsBoxInstance.containsKey('products');
  }

  static int getLastUpdate() {
    return _productsBoxInstance.get('last_update') ?? 0;
  }

  // ==================== المفضلة ====================
  static Future<void> toggleFavorite(String productId) async {
    final favorites = getFavorites();
    if (favorites.contains(productId)) {
      favorites.remove(productId);
    } else {
      favorites.add(productId);
    }
    await _favoritesBoxInstance.put('favorites', favorites);
  }

  static List<String> getFavorites() {
    final data = _favoritesBoxInstance.get('favorites');
    if (data == null) return [];
    return List<String>.from(data);
  }

  static bool isFavorite(String productId) {
    return getFavorites().contains(productId);
  }

  // ==================== السلة ====================
  static Future<void> addToCart(Map<String, dynamic> item) async {
    final cart = getCart();
    cart.add(item);
    await _cartBoxInstance.put('cart', cart);
  }

  static Future<void> removeFromCart(int index) async {
    final cart = getCart();
    cart.removeAt(index);
    await _cartBoxInstance.put('cart', cart);
  }

  static Future<void> clearCart() async {
    await _cartBoxInstance.put('cart', []);
  }

  static List<Map<String, dynamic>> getCart() {
    final data = _cartBoxInstance.get('cart');
    if (data == null) return [];
    return List<Map<String, dynamic>>.from(data);
  }

  // ==================== الإعدادات ====================
  static Future<void> saveSetting(String key, dynamic value) async {
    await _settingsBoxInstance.put(key, value);
  }

  static dynamic getSetting(String key, {dynamic defaultValue}) {
    return _settingsBoxInstance.get(key, defaultValue: defaultValue);
  }

  // ==================== التنظيف ====================
  static Future<void> clearAll() async {
    await _productsBoxInstance.clear();
    await _favoritesBoxInstance.clear();
    await _cartBoxInstance.clear();
    await _settingsBoxInstance.clear();
  }
}
