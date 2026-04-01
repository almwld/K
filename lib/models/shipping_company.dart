class ShippingCompany {
  final String id;
  final String name;
  final double price;
  final String estimatedDays;
  final List<String> cities;
  final String phone;
  final bool isExpress;
  
  ShippingCompany({
    required this.id,
    required this.name,
    required this.price,
    required this.estimatedDays,
    required this.cities,
    required this.phone,
    this.isExpress = false,
  });
  
  static final List<ShippingCompany> companies = [
    ShippingCompany(
      id: '1',
      name: 'سبيدكس اليمن',
      price: 1500,
      estimatedDays: '2-3 أيام',
      cities: ['صنعاء', 'عدن', 'تعز'],
      phone: '777123456',
    ),
    ShippingCompany(
      id: '2',
      name: 'يمن إكسبرس',
      price: 2000,
      estimatedDays: '1-2 أيام',
      cities: ['صنعاء', 'عدن', 'تعز'],
      phone: '778123456',
      isExpress: true,
    ),
    ShippingCompany(
      id: '3',
      name: 'دليفري بلس',
      price: 1200,
      estimatedDays: '3-4 أيام',
      cities: ['صنعاء', 'الحديدة', 'إب'],
      phone: '779123456',
    ),
    ShippingCompany(
      id: '4',
      name: 'شحن سريع اليمن',
      price: 2500,
      estimatedDays: '1-2 أيام',
      cities: ['صنعاء', 'عدن', 'المكلا'],
      phone: '770123456',
      isExpress: true,
    ),
    ShippingCompany(
      id: '5',
      name: 'بريد اليمن',
      price: 800,
      estimatedDays: '5-7 أيام',
      cities: ['جميع المحافظات'],
      phone: '771123456',
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
