class CouponsData {
  static final List<Map<String, dynamic>> coupons = [
    {'code': 'FLEX10', 'discount': 10, 'minOrder': 50000, 'expiry': '2024-12-31'},
    {'code': 'WELCOME20', 'discount': 20, 'minOrder': 100000, 'expiry': '2024-12-31'},
    {'code': 'VIP25', 'discount': 25, 'minOrder': 200000, 'expiry': '2024-12-31'},
  ];

  static int validateCoupon(String code, int total) {
    final coupon = coupons.firstWhere((c) => c['code'] == code.toUpperCase(), orElse: () => {});
    if (coupon.isEmpty) return 0;
    if (total < (coupon['minOrder'] as int)) return 0;
    return (total * (coupon['discount'] as int) ~/ 100);
  }
}
