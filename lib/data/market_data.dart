import '../models/market_item.dart';

class MarketData {
  static List<MarketItem> getAllItemsComplete() {
    return [
      MarketItem(category: 'إلكترونيات', name: 'آيفون 15', imageUrl: 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=200', price: 4500, change24h: 2.5, store: 'إلكترونيات الحديثة'),
      MarketItem(category: 'سيارات', name: 'تويوتا كامري', imageUrl: 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=200', price: 95000, change24h: 1.8, store: 'معارض النخبة'),
      MarketItem(category: 'عقارات', name: 'فيلا فاخرة', imageUrl: 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=200', price: 2500000, change24h: 3.5, store: 'عقارات الماسة'),
    ];
  }
  
  static List<String> getAllSections() {
    return ['إلكترونيات', 'سيارات', 'عقارات', 'أزياء', 'مواد غذائية'];
  }
}
