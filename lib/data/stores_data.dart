import '../models/store_model.dart';

class StoresData {
  static List<StoreModel> getAllStores() {
    return [
      StoreModel(id: '1', name: 'معارض النخبة للسيارات', category: 'سيارات', imageUrl: 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400', description: 'أكبر معرض سيارات في اليمن', address: 'صنعاء - شارع الستين', phone: '777123456', rating: 4.8, totalProducts: 45),
      StoreModel(id: '2', name: 'إلكترونيات الحديثة', category: 'إلكترونيات', imageUrl: 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=400', description: 'أحدث الأجهزة الإلكترونية', address: 'صنعاء - شارع العدل', phone: '777890123', rating: 4.8, totalProducts: 320),
      StoreModel(id: '3', name: 'مكتب الأفق العقاري', category: 'عقارات', imageUrl: 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400', description: 'بيع وشراء العقارات', address: 'صنعاء - شارع هائل', phone: '777567890', rating: 4.7, totalProducts: 28),
      StoreModel(id: '4', name: 'أسواق المزرعة', category: 'مواد غذائية', imageUrl: 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400', description: 'خضروات وفواكه طازجة', address: 'صنعاء - شارع الستين', phone: '777556677', rating: 4.8, totalProducts: 150),
      StoreModel(id: '5', name: 'مطعم اليمن للمندي', category: 'مطاعم', imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400', description: 'أشهى المندي اليمني', address: 'صنعاء - شارع هائل', phone: '777889900', rating: 4.9, totalProducts: 25),
    ];
  }
  
  static List<StoreModel> getStoresByCategory(String category) {
    return getAllStores().where((store) => store.category == category).toList();
  }
}

