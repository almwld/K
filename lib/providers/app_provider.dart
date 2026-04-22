import 'package:flutter/material.dart';
import '../data/full_data.dart';

class AppProvider extends ChangeNotifier {
  List<CategoryModel> _categories = [];
  List<StoreModel> _stores = [];
  List<ProductModel> _products = [];
  List<MallModel> _malls = [];
  
  List<CategoryModel> get categories => _categories;
  List<StoreModel> get stores => _stores;
  List<ProductModel> get products => _products;
  List<MallModel> get malls => _malls;
  
  AppProvider() {
    loadData();
  }
  
  void loadData() {
    _categories = FullData.getAllCategoriesComplete();
    _stores = FullData.getAllStoresComplete();
    _products = FullData.getAllProducts();
    _malls = FullData.getAllMalls();
    notifyListeners();
  }
  
  ProductModel? getProductById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
  
  StoreModel? getStoreById(String id) {
    try {
      return _stores.firstWhere((s) => s.id == id);
    } catch (e) {
      return null;
    }
  }
}
