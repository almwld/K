class YemenDeliveryService {
  final String id;
  final String name;
  final String logoUrl;
  final String phone;
  final String address;
  final double rating;
  final int totalOrders;
  final double deliveryFee;
  final String estimatedTime;
  final bool isAvailable;
  final String coverage;
  final String workingHours;
  final List<String> cities;
  final String color;

  YemenDeliveryService({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.phone,
    required this.address,
    required this.rating,
    required this.totalOrders,
    required this.deliveryFee,
    required this.estimatedTime,
    this.isAvailable = true,
    required this.coverage,
    required this.workingHours,
    required this.cities,
    required this.color,
  });
}

class YemenDeliveryData {
  static List<YemenDeliveryService> getAllServices() {
    return [
      // 1. توصيل - Tawseel
      YemenDeliveryService(
        id: 'tawseel',
        name: 'توصيل',
        logoUrl: 'https://play-lh.googleusercontent.com/tawseel_logo=w240',
        phone: '775000111',
        address: 'صنعاء - شارع الستين',
        rating: 4.7,
        totalOrders: 25000,
        deliveryFee: 1000,
        estimatedTime: '30-45 دقيقة',
        coverage: 'صنعاء - جميع الأحياء',
        workingHours: '24 ساعة',
        cities: ['صنعاء', 'عمران', 'ذمار'],
        color: '#E31937',
      ),
      
      // 2. سريع - Saree3
      YemenDeliveryService(
        id: 'saree3',
        name: 'سريع',
        logoUrl: 'https://play-lh.googleusercontent.com/saree3_logo=w240',
        phone: '771234567',
        address: 'صنعاء - شارع هائل',
        rating: 4.8,
        totalOrders: 32000,
        deliveryFee: 800,
        estimatedTime: '20-35 دقيقة',
        coverage: 'صنعاء - جميع المناطق',
        workingHours: '24 ساعة',
        cities: ['صنعاء', 'تعز', 'إب'],
        color: '#00A859',
      ),
      
      // 3. ناس - NAS
      YemenDeliveryService(
        id: 'nas',
        name: 'ناس',
        logoUrl: 'https://play-lh.googleusercontent.com/nas_delivery_logo=w240',
        phone: '772345678',
        address: 'صنعاء - شارع القاهرة',
        rating: 4.6,
        totalOrders: 18000,
        deliveryFee: 1200,
        estimatedTime: '25-40 دقيقة',
        coverage: 'صنعاء - مركزي وشمال',
        workingHours: '8 ص - 12 م',
        cities: ['صنعاء', 'عمران', 'صعدة'],
        color: '#1A5F7A',
      ),
      
      // 4. اطلبني - Otlobni
      YemenDeliveryService(
        id: 'otlobni',
        name: 'اطلبني',
        logoUrl: 'https://play-lh.googleusercontent.com/otlobni_logo=w240',
        phone: '773456789',
        address: 'صنعاء - الحصبة',
        rating: 4.9,
        totalOrders: 28000,
        deliveryFee: 900,
        estimatedTime: '15-30 دقيقة',
        coverage: 'صنعاء - جميع الأحياء',
        workingHours: '24 ساعة',
        cities: ['صنعاء', 'ذمار', 'إب', 'تعز'],
        color: '#F5821F',
      ),
      
      // 5. مرسول - Mrsool
      YemenDeliveryService(
        id: 'mrsool',
        name: 'مرسول',
        logoUrl: 'https://play-lh.googleusercontent.com/mrsool_logo=w240',
        phone: '774567890',
        address: 'صنعاء - باب اليمن',
        rating: 4.5,
        totalOrders: 15000,
        deliveryFee: 1100,
        estimatedTime: '30-50 دقيقة',
        coverage: 'صنعاء - جميع المناطق',
        workingHours: '24 ساعة',
        cities: ['صنعاء', 'عمران', 'ذمار', 'إب', 'الحديدة'],
        color: '#6B3FA0',
      ),
      
      // 6. وصل - Wasel
      YemenDeliveryService(
        id: 'wasel',
        name: 'وصل',
        logoUrl: 'https://play-lh.googleusercontent.com/wasel_logo=w240',
        phone: '775678901',
        address: 'صنعاء - شعوب',
        rating: 4.4,
        totalOrders: 12000,
        deliveryFee: 700,
        estimatedTime: '35-55 دقيقة',
        coverage: 'صنعاء - جنوب وشرق',
        workingHours: '9 ص - 11 م',
        cities: ['صنعاء', 'ذمار'],
        color: '#2E86AB',
      ),
      
      // 7. هنقرستيشن - HungerStation
      YemenDeliveryService(
        id: 'hungerstation',
        name: 'هنقرستيشن',
        logoUrl: 'https://play-lh.googleusercontent.com/hungerstation_logo=w240',
        phone: '776789012',
        address: 'صنعاء - شارع الستين',
        rating: 4.7,
        totalOrders: 35000,
        deliveryFee: 850,
        estimatedTime: '20-40 دقيقة',
        coverage: 'صنعاء - جميع الأحياء',
        workingHours: '24 ساعة',
        cities: ['صنعاء', 'عدن', 'تعز', 'إب', 'الحديدة'],
        color: '#E23744',
      ),
      
      // 8. طلبات - Talabat
      YemenDeliveryService(
        id: 'talabat',
        name: 'طلبات',
        logoUrl: 'https://play-lh.googleusercontent.com/talabat_logo=w240',
        phone: '777890123',
        address: 'صنعاء - حدة',
        rating: 4.6,
        totalOrders: 22000,
        deliveryFee: 950,
        estimatedTime: '25-45 دقيقة',
        coverage: 'صنعاء - شمال وغرب',
        workingHours: '10 ص - 12 م',
        cities: ['صنعاء', 'عدن', 'تعز'],
        color: '#FF5A00',
      ),
      
      // 9. كريم ناو - Careem Now
      YemenDeliveryService(
        id: 'careem_now',
        name: 'كريم ناو',
        logoUrl: 'https://play-lh.googleusercontent.com/careem_logo=w240',
        phone: '778901234',
        address: 'صنعاء - شارع هائل',
        rating: 4.8,
        totalOrders: 30000,
        deliveryFee: 1000,
        estimatedTime: '15-35 دقيقة',
        coverage: 'صنعاء - جميع الأحياء',
        workingHours: '24 ساعة',
        cities: ['صنعاء', 'عدن', 'تعز', 'إب', 'الحديدة', 'المكلا'],
        color: '#5FB709',
      ),
      
      // 10. Go Delivery
      YemenDeliveryService(
        id: 'go_delivery',
        name: 'Go Delivery',
        logoUrl: 'https://play-lh.googleusercontent.com/go_delivery_logo=w240',
        phone: '779012345',
        address: 'صنعاء - شارع العدل',
        rating: 4.3,
        totalOrders: 8000,
        deliveryFee: 600,
        estimatedTime: '40-60 دقيقة',
        coverage: 'صنعاء - شرق',
        workingHours: '8 ص - 10 م',
        cities: ['صنعاء'],
        color: '#009688',
      ),
    ];
  }
  
  static List<YemenDeliveryService> getServicesByCity(String city) {
    return getAllServices().where((s) => s.cities.contains(city)).toList();
  }
  
  static List<YemenDeliveryService> getTopRatedServices({int limit = 5}) {
    final services = List<YemenDeliveryService>.from(getAllServices());
    services.sort((a, b) => b.rating.compareTo(a.rating));
    return services.take(limit).toList();
  }
  
  static List<YemenDeliveryService> getFastestServices({int limit = 5}) {
    final services = List<YemenDeliveryService>.from(getAllServices());
    services.sort((a, b) => a.deliveryFee.compareTo(b.deliveryFee));
    return services.take(limit).toList();
  }
  
  static List<YemenDeliveryService> getMostPopularServices({int limit = 5}) {
    final services = List<YemenDeliveryService>.from(getAllServices());
    services.sort((a, b) => b.totalOrders.compareTo(a.totalOrders));
    return services.take(limit).toList();
  }
}

