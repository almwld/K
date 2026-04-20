import 'package:flutter/material.dart';
import '../models/market_model.dart';

class MarketProvider extends ChangeNotifier {
  List<MarketModel> _markets = [];
  MarketModel? _selectedMarket;
  bool _isLoading = false;

  List<MarketModel> get markets => _markets;
  MarketModel? get selectedMarket => _selectedMarket;
  bool get isLoading => _isLoading;
  List<MarketModel> get trendingMarkets => _markets.where((m) => m.isTrending).toList();
  List<MarketModel> get positiveMarkets => _markets.where((m) => m.isPositive).toList();

  MarketProvider() {
    loadMarkets();
  }

  void loadMarkets() {
    _isLoading = true;
    notifyListeners();
    
    Future.delayed(const Duration(milliseconds: 800), () {
      _markets = mockMarkets;
      _isLoading = false;
      notifyListeners();
    });
  }

  void selectMarket(MarketModel market) {
    _selectedMarket = market;
    notifyListeners();
  }

  void refreshMarkets() {
    loadMarkets();
  }

  MarketModel? getMarketById(String id) {
    try {
      return _markets.firstWhere((m) => m.id == id);
    } catch (e) {
      return null;
    }
  }
}
