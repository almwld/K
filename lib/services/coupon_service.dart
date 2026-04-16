import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/coupon_model.dart';

class CouponService {
  final SupabaseClient _client = Supabase.instance.client;
  String? _currentUserId;

  CouponService() {
    _currentUserId = _client.auth.currentUser?.id;
  }

  // الحصول على الكوبونات المتاحة للعموم
  Future<List<CouponModel>> getPublicCoupons() async {
    try {
      final response = await _client
          .from('coupons')
          .select()
          .eq('is_public', true)
          .eq('is_active', true)
          .gte('valid_until', DateTime.now().toIso8601String())
          .order('created_at', ascending: false);

      return (response as List).map<CouponModel>((json) => 
        CouponModel.fromJson(json as Map<String, dynamic>)
      ).toList();
    } catch (e) {
      return _getMockPublicCoupons();
    }
  }

  // الحصول على كوبونات المستخدم
  Future<List<UserCouponModel>> getUserCoupons() async {
    if (_currentUserId == null) return [];
    
    try {
      final response = await _client
          .from('user_coupons')
          .select()
          .eq('user_id', _currentUserId)
          .order('claimed_at', ascending: false);

      return (response as List).map<UserCouponModel>((json) => 
        UserCouponModel.fromJson(json as Map<String, dynamic>)
      ).toList();
    } catch (e) {
      return _getMockUserCoupons();
    }
  }

  // المطالبة بكوبون
  Future<bool> claimCoupon(String couponId) async {
    if (_currentUserId == null) return false;
    
    try {
      // التحقق من وجود الكوبون مسبقاً
      final existing = await _client
          .from('user_coupons')
          .select()
          .eq('user_id', _currentUserId)
          .eq('coupon_id', couponId);

      if ((existing as List).isNotEmpty) return false;

      // الحصول على بيانات الكوبون
      final couponResponse = await _client
          .from('coupons')
          .select()
          .eq('id', couponId)
          .single();

      final coupon = CouponModel.fromJson(couponResponse as Map<String, dynamic>);
      
      if (!coupon.isValid) return false;

      // إضافة الكوبون للمستخدم
      await _client.from('user_coupons').insert({
        'user_id': _currentUserId,
        'coupon_id': couponId,
        'coupon_code': coupon.code,
        'coupon_title': coupon.title,
        'coupon_description': coupon.description,
        'coupon_type': coupon.type.name,
        'coupon_value': coupon.value,
        'claimed_at': DateTime.now().toIso8601String(),
        'is_used': false,
      });

      // زيادة عدد الاستخدامات
      await _client
          .from('coupons')
          .update({'used_count': coupon.usedCount + 1})
          .eq('id', couponId);

      return true;
    } catch (e) {
      return false;
    }
  }

  // التحقق من صحة كوبون
  Future<CouponValidationResult> validateCoupon(String code, {double? orderAmount, String? storeId, String? productId}) async {
    try {
      final response = await _client
          .from('coupons')
          .select()
          .eq('code', code.toUpperCase())
          .eq('is_active', true)
          .single();

      final coupon = CouponModel.fromJson(response as Map<String, dynamic>);
      
      // التحقق من الصلاحية
      if (!coupon.isValid) {
        return CouponValidationResult(isValid: false, message: 'الكوبون منتهي الصلاحية');
      }
      
      // التحقق من المتجر
      if (coupon.scope == CouponScope.store && coupon.storeId != storeId) {
        return CouponValidationResult(isValid: false, message: 'هذا الكوبون غير صالح لهذا المتجر');
      }
      
      // التحقق من الحد الأدنى
      if (coupon.minPurchaseAmount != null && orderAmount != null && orderAmount < coupon.minPurchaseAmount!) {
        return CouponValidationResult(isValid: false, message: 'الحد الأدنى للشراء ${coupon.minPurchaseAmount} ريال');
      }
      
      // حساب الخصم
      double discountAmount = 0;
      if (coupon.type == CouponType.percentage) {
        discountAmount = (orderAmount ?? 0) * coupon.value / 100;
        if (coupon.maxDiscountAmount != null && discountAmount > coupon.maxDiscountAmount!) {
          discountAmount = coupon.maxDiscountAmount!;
        }
      } else if (coupon.type == CouponType.fixed) {
        discountAmount = coupon.value;
      }
      
      return CouponValidationResult(
        isValid: true,
        coupon: coupon,
        discountAmount: discountAmount,
        message: 'تم تطبيق الكوبون بنجاح',
      );
    } catch (e) {
      return CouponValidationResult(isValid: false, message: 'الكوبون غير صالح');
    }
  }

  // استخدام الكوبون
  Future<bool> useCoupon(String userCouponId, String orderId) async {
    try {
      await _client
          .from('user_coupons')
          .update({
            'is_used': true,
            'used_at': DateTime.now().toIso8601String(),
            'order_id': orderId,
          })
          .eq('id', userCouponId);
      return true;
    } catch (e) {
      return false;
    }
  }

  // توليد كود كوبون عشوائي
  String generateCouponCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(8, (index) => chars[random.nextInt(chars.length)]).join();
  }

  // بيانات وهمية للكوبونات العامة
  List<CouponModel> _getMockPublicCoupons() {
    return [
      CouponModel(
        id: '1', code: 'WELCOME50', title: 'خصم 50%', description: 'خصم 50% على أول طلب لك',
        type: CouponType.percentage, value: 50, scope: CouponScope.firstOrder,
        validFrom: DateTime.now().subtract(const Duration(days: 10)),
        validUntil: DateTime.now().add(const Duration(days: 20)),
        maxDiscountAmount: 100,
      ),
      CouponModel(
        id: '2', code: 'FREE100', title: 'خصم 100 ريال', description: 'خصم 100 ريال على المشتريات فوق 500 ريال',
        type: CouponType.fixed, value: 100, scope: CouponScope.all,
        minPurchaseAmount: 500,
        validFrom: DateTime.now().subtract(const Duration(days: 5)),
        validUntil: DateTime.now().add(const Duration(days: 25)),
      ),
      CouponModel(
        id: '3', code: 'SHIPFREE', title: 'شحن مجاني', description: 'توصيل مجاني على جميع الطلبات',
        type: CouponType.freeShipping, value: 0, scope: CouponScope.all,
        validFrom: DateTime.now().subtract(const Duration(days: 15)),
        validUntil: DateTime.now().add(const Duration(days: 15)),
      ),
      CouponModel(
        id: '4', code: 'ELECTRO30', title: 'خصم 30% إلكترونيات', description: 'خصم 30% على جميع الإلكترونيات',
        type: CouponType.percentage, value: 30, scope: CouponScope.category,
        scopeId: 'إلكترونيات',
        validFrom: DateTime.now().subtract(const Duration(days: 2)),
        validUntil: DateTime.now().add(const Duration(days: 28)),
        maxDiscountAmount: 200,
      ),
      CouponModel(
        id: '5', code: 'FLASH20', title: 'فلاش سيل 20%', description: 'خصم 20% لمدة 48 ساعة',
        type: CouponType.percentage, value: 20, scope: CouponScope.all,
        validFrom: DateTime.now().subtract(const Duration(hours: 12)),
        validUntil: DateTime.now().add(const Duration(hours: 36)),
        maxUses: 100, usedCount: 45,
      ),
    ];
  }

  // بيانات وهمية لكوبونات المستخدم
  List<UserCouponModel> _getMockUserCoupons() {
    return [
      UserCouponModel(
        id: '1', userId: _currentUserId ?? 'user1', couponId: '1', couponCode: 'WELCOME50',
        couponTitle: 'خصم 50%', couponDescription: 'خصم 50% على أول طلب',
        couponType: CouponType.percentage, couponValue: 50,
        claimedAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      UserCouponModel(
        id: '2', userId: _currentUserId ?? 'user1', couponId: '3', couponCode: 'SHIPFREE',
        couponTitle: 'شحن مجاني', couponDescription: 'توصيل مجاني',
        couponType: CouponType.freeShipping, couponValue: 0,
        claimedAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];
  }
}

class CouponValidationResult {
  final bool isValid;
  final CouponModel? coupon;
  final double discountAmount;
  final String message;

  CouponValidationResult({
    required this.isValid,
    this.coupon,
    this.discountAmount = 0,
    required this.message,
  });
}
