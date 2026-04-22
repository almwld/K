import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  CategoryModel({required this.id, required this.name});
}

class StoreModel {
  final String id;
  final String name;
  StoreModel({required this.id, required this.name});
}

class ProductModel {
  final String id;
  final String name;
  ProductModel({required this.id, required this.name});
}

class MallModel {
  final String id;
  final String name;
  MallModel({required this.id, required this.name});
}

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
    _categories = [
      CategoryModel(id: '1', name: 'إلكترونيات'),
      CategoryModel(id: '2', name: 'أزياء'),
      CategoryModel(id: '3', name: 'سيارات'),
    ];
    
    _stores = [
      StoreModel(id: '1', name: 'متجر التقنية'),
      StoreModel(id: '2', name: 'عالم الجوالات'),
      StoreModel(id: '3', name: 'كمبيوتر مول'),
    ];
    
    _products = [
      ProductModel(id: '1', name: 'iPhone 15 Pro'),
      ProductModel(id: '2', name: 'MacBook Pro'),
      ProductModel(id: '3', name: 'ساعة أبل'),
    ];
    
    _malls = [
      MallModel(id: '1', name: 'اليمن مول'),
      MallModel(id: '2', name: 'سيتي مول'),
    ];
    
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
