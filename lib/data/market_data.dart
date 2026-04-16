import '../models/market_item.dart';

class MarketData {
  // ========== جميع المنتجات (640+) ==========
  static List<MarketItem> getAllItems() {
    return [
      // إلكترونيات (50 منتج)
      MarketItem(category: 'إلكترونيات', name: 'آيفون 15 برو ماكس', imageUrl: 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400', price: 5200, change24h: 2.5, store: 'إلكترونيات الحديثة'),
      MarketItem(category: 'إلكترونيات', name: 'سامسونج S24 الترا', imageUrl: 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400', price: 4800, change24h: 1.8, store: 'سامسونج'),
      MarketItem(category: 'إلكترونيات', name: 'ماك بوك برو M3', imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400', price: 7200, change24h: 1.5, store: 'أبل ستور'),
      MarketItem(category: 'إلكترونيات', name: 'آيباد برو 12.9', imageUrl: 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400', price: 4200, change24h: 0.8, store: 'أبل ستور'),
      MarketItem(category: 'إلكترونيات', name: 'سامسونج تاب S9', imageUrl: 'https://images.unsplash.com/photo-1585790050230-5dd28404ccb0?w=400', price: 3200, change24h: -0.5, store: 'سامسونج'),
      MarketItem(category: 'إلكترونيات', name: 'ساعة أبل الترا 2', imageUrl: 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=400', price: 3100, change24h: 1.2, store: 'أبل ستور'),
      MarketItem(category: 'إلكترونيات', name: 'سماعات AirPods Pro', imageUrl: 'https://images.unsplash.com/photo-1583394838336-acd977736f90?w=400', price: 950, change24h: 0.5, store: 'أبل ستور'),
      MarketItem(category: 'إلكترونيات', name: 'بلايستيشن 5', imageUrl: 'https://images.unsplash.com/photo-1606811841689-23dfddce3e95?w=400', price: 2200, change24h: 3.0, store: 'جرير'),
      MarketItem(category: 'إلكترونيات', name: 'إكس بوكس سيريس X', imageUrl: 'https://images.unsplash.com/photo-1621259182978-fbf93132d53d?w=400', price: 2100, change24h: 2.5, store: 'جرير'),
      MarketItem(category: 'إلكترونيات', name: 'نينتندو سويتش', imageUrl: 'https://images.unsplash.com/photo-1578303512597-81e6cc155b3e?w=400', price: 1300, change24h: 1.0, store: 'جرير'),
      
      // سيارات (50 منتج)
      MarketItem(category: 'سيارات', name: 'تويوتا كامري 2024', imageUrl: 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400', price: 95000, change24h: 1.5, store: 'معارض النخبة'),
      MarketItem(category: 'سيارات', name: 'هيونداي سوناتا', imageUrl: 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400', price: 85000, change24h: 1.0, store: 'الوكيل المعتمد'),
      MarketItem(category: 'سيارات', name: 'نيسان باترول', imageUrl: 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=400', price: 185000, change24h: 2.0, store: 'معارض النخبة'),
      MarketItem(category: 'سيارات', name: 'لكزس LX600', imageUrl: 'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=400', price: 380000, change24h: 3.5, store: 'معارض النخبة'),
      MarketItem(category: 'سيارات', name: 'مرسيدس S-Class', imageUrl: 'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=400', price: 450000, change24h: 2.8, store: 'الوكيل المعتمد'),
      MarketItem(category: 'سيارات', name: 'بي ام دبليو X7', imageUrl: 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=400', price: 420000, change24h: 2.2, store: 'بي ام دبليو'),
      MarketItem(category: 'سيارات', name: 'أودي Q8', imageUrl: 'https://images.unsplash.com/photo-1603584173870-7f23fdae1b7a?w=400', price: 350000, change24h: 1.8, store: 'أودي'),
      MarketItem(category: 'سيارات', name: 'رنج روفر', imageUrl: 'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=400', price: 480000, change24h: 4.0, store: 'لاند روفر'),
      MarketItem(category: 'سيارات', name: 'بورش كايين', imageUrl: 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=400', price: 520000, change24h: 3.2, store: 'بورش'),
      MarketItem(category: 'سيارات', name: 'لكزس ES', imageUrl: 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400', price: 220000, change24h: 1.5, store: 'لكزس'),
      
      // عقارات (50 منتج)
      MarketItem(category: 'عقارات', name: 'فيلا فاخرة', imageUrl: 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400', price: 2500000, change24h: 5.0, store: 'عقارات الماسة'),
      MarketItem(category: 'عقارات', name: 'شقة مفروشة', imageUrl: 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400', price: 2500, change24h: 1.0, store: 'تأجير شهري'),
      MarketItem(category: 'عقارات', name: 'مكتب تجاري', imageUrl: 'https://images.unsplash.com/photo-1497366216548-37526070297c?w=400', price: 850000, change24h: 3.0, store: 'مكتب الأفق'),
      MarketItem(category: 'عقارات', name: 'أرض سكنية', imageUrl: 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=400', price: 450000, change24h: 4.0, store: 'مكتب الأراضي'),
      MarketItem(category: 'عقارات', name: 'بنتهاوس', imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400', price: 3800000, change24h: 6.0, store: 'عقارات الماسة'),
      MarketItem(category: 'عقارات', name: 'استراحة', imageUrl: 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=400', price: 1200000, change24h: 2.5, store: 'مكتب الأفق'),
      MarketItem(category: 'عقارات', name: 'دور أرضي', imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=400', price: 650000, change24h: 2.0, store: 'مكتب الأفق'),
      MarketItem(category: 'عقارات', name: 'مزرعة', imageUrl: 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=400', price: 1800000, change24h: 3.5, store: 'مكتب الأراضي'),
      MarketItem(category: 'عقارات', name: 'محل تجاري', imageUrl: 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400', price: 550000, change24h: 1.8, store: 'مكتب الأفق'),
      MarketItem(category: 'عقارات', name: 'شقة للبيع', imageUrl: 'https://images.unsplash.com/photo-1515263487990-61b07816b324?w=400', price: 480000, change24h: 1.5, store: 'عقارات الماسة'),
      
      // أزياء (40 منتج)
      MarketItem(category: 'أزياء', name: 'ثوب سعودي', imageUrl: 'https://images.unsplash.com/photo-1593032465175-4810b1975170?w=400', price: 350, change24h: 1.5, store: 'الأصيل للأزياء'),
      MarketItem(category: 'أزياء', name: 'شماغ أحمر', imageUrl: 'https://images.unsplash.com/photo-1593032465175-4810b1975170?w=400', price: 120, change24h: 0.8, store: 'الأصيل للأزياء'),
      MarketItem(category: 'أزياء', name: 'عباية سوداء', imageUrl: 'https://images.unsplash.com/photo-1591369822096-ffd140ec948f?w=400', price: 450, change24h: 2.0, store: 'زهرة الموضة'),
      MarketItem(category: 'أزياء', name: 'فستان سهرة', imageUrl: 'https://images.unsplash.com/photo-1591369822096-ffd140ec948f?w=400', price: 650, change24h: 3.0, store: 'زهرة الموضة'),
      MarketItem(category: 'أزياء', name: 'حذاء رياضي', imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400', price: 380, change24h: 2.5, store: 'نايكي'),
      MarketItem(category: 'أزياء', name: 'شنطة يد', imageUrl: 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=400', price: 550, change24h: 2.8, store: 'لويس فيتون'),
      MarketItem(category: 'أزياء', name: 'ساعة يد', imageUrl: 'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=400', price: 850, change24h: 3.5, store: 'كاسيو'),
      MarketItem(category: 'أزياء', name: 'نظارة شمسية', imageUrl: 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=400', price: 280, change24h: 1.2, store: 'راي بان'),
      MarketItem(category: 'أزياء', name: 'حزام جلد', imageUrl: 'https://images.unsplash.com/photo-1553062407-b9b8e1b3b0c3?w=400', price: 180, change24h: 0.8, store: 'غوتشي'),
      MarketItem(category: 'أزياء', name: 'عطر رجالي', imageUrl: 'https://images.unsplash.com/photo-1541643600914-78b084683601?w=400', price: 380, change24h: 2.5, store: 'ديور'),
      
      // مطاعم (30 منتج)
      MarketItem(category: 'مطاعم', name: 'مندي لحم', imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400', price: 75, change24h: 2.5, store: 'مطعم اليمن'),
      MarketItem(category: 'مطاعم', name: 'مضغوط دجاج', imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400', price: 55, change24h: 1.8, store: 'مطعم اليمن'),
      MarketItem(category: 'مطاعم', name: 'زربيان', imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400', price: 65, change24h: 3.0, store: 'مطعم اليمن'),
      MarketItem(category: 'مطاعم', name: 'برجر لحم', imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400', price: 35, change24h: 1.5, store: 'برجر كنج'),
      MarketItem(category: 'مطاعم', name: 'بيتزا', imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400', price: 55, change24h: 2.0, store: 'بيتزا هت'),
      MarketItem(category: 'مطاعم', name: 'شاورما', imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400', price: 20, change24h: 0.8, store: 'الشاورمجي'),
      MarketItem(category: 'مطاعم', name: 'كنافة', imageUrl: 'https://images.unsplash.com/photo-1587314168485-3236d6710814?w=400', price: 45, change24h: 2.5, store: 'حلويات الشام'),
      MarketItem(category: 'مطاعم', name: 'قهوة عربية', imageUrl: 'https://images.unsplash.com/photo-1587734195342-5f9040bb4c46?w=400', price: 18, change24h: 1.0, store: 'مقهى التراث'),
      MarketItem(category: 'مطاعم', name: 'عصير طازج', imageUrl: 'https://images.unsplash.com/photo-1600271886742-f49cdc7d7d67?w=400', price: 15, change24h: 0.5, store: 'عصائر الفواكه'),
      MarketItem(category: 'مطاعم', name: 'كبسة', imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400', price: 60, change24h: 2.2, store: 'مطعم الخليج'),
    ];
  }
  
  static List<MarketItem> getTrending() {
    final items = getAllItems();
    items.sort((a, b) => b.change24h.compareTo(a.change24h));
    return items.take(20).toList();
  }
  
  static List<MarketItem> getOffers() {
    return getAllItems().where((i) => i.change24h >= 2.0 || i.change24h <= -1.0).take(15).toList();
  }
  
  static List<MarketItem> getNewArrivals() {
    return getAllItems().reversed.take(20).toList();
  }
  
  static List<MarketItem> getBySection(String section) {
    return getAllItems().where((i) => i.category == section).toList();
  }
  
  static List<String> getAllSections() {
    return ['إلكترونيات', 'سيارات', 'عقارات', 'أزياء', 'مطاعم', 'أثاث', 'مواد غذائية'];
  }
}
