class ShippingCompany {
  final String id;
  final String name;
  final double basePrice;
  final double pricePerKm;
  final String estimatedDays;
  final List<String> cities;
  final String phone;
  final bool isExpress;
  final String? logo;
  final double? minOrderAmount;

  ShippingCompany({
    required this.id,
    required this.name,
    required this.basePrice,
    required this.pricePerKm,
    required this.estimatedDays,
    required this.cities,
    required this.phone,
    this.isExpress = false,
    this.logo,
    this.minOrderAmount,
  });

  double calculateDeliveryCost(double distance) {
    return basePrice + (pricePerKm * distance);
  }

  static final List<ShippingCompany> companies = [
    ShippingCompany(
      id: 'speedex',
      name: 'سبيدكس اليمن',
      basePrice: 500,
      pricePerKm: 100,
      estimatedDays: '2-3 أيام',
      cities: ['صنعاء', 'عدن', 'تعز', 'الحديدة'],
      phone: '777123456',
      logo: 'assets/icons/speedex.png',
    ),
    ShippingCompany(
      id: 'yemen_express',
      name: 'يمن إكسبرس',
      basePrice: 800,
      pricePerKm: 120,
      estimatedDays: '1-2 أيام',
      cities: ['صنعاء', 'عدن', 'تعز'],
      phone: '778123456',
      isExpress: true,
      logo: 'assets/icons/yemen_express.png',
    ),
    ShippingCompany(
      id: 'delivery_plus',
      name: 'دليفري بلس',
      basePrice: 400,
      pricePerKm: 80,
      estimatedDays: '3-4 أيام',
      cities: ['صنعاء', 'الحديدة', 'إب', 'ذمار'],
      phone: '779123456',
      logo: 'assets/icons/delivery_plus.png',
    ),
    ShippingCompany(
      id: 'fast_ship',
      name: 'شحن سريع اليمن',
      basePrice: 1000,
      pricePerKm: 150,
      estimatedDays: '1-2 أيام',
      cities: ['صنعاء', 'عدن', 'المكلا', 'سيئون'],
      phone: '770123456',
      isExpress: true,
      logo: 'assets/icons/fast_ship.png',
      minOrderAmount: 5000,
    ),
    ShippingCompany(
      id: 'yemen_post',
      name: 'بريد اليمن',
      basePrice: 300,
      pricePerKm: 50,
      estimatedDays: '5-7 أيام',
      cities: ['جميع المحافظات'],
      phone: '771123456',
      logo: 'assets/icons/yemen_post.png',
    ),
  ];

  static ShippingCompany? getById(String id) {
    try {
      return companies.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }
}

