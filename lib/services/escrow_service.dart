import 'package:supabase_flutter/supabase_flutter.dart';

class EscrowService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // إنشاء معاملة محتجزة
  Future<Map<String, dynamic>> createEscrowTransaction({
    required String orderId,
    required String buyerId,
    required String sellerId,
    required double amount,
  }) async {
    final response = await _supabase.from('escrow_transactions').insert({
      'order_id': orderId,
      'buyer_id': buyerId,
      'seller_id': sellerId,
      'amount': amount,
      'status': 'held',
      'held_at': DateTime.now().toIso8601String(),
    }).select();

    return response[0];
  }

  // تأكيد استلام المنتج (تحرير المال للبائع)
  Future<void> confirmDelivery(String escrowId) async {
    await _supabase.from('escrow_transactions').update({
      'status': 'released',
      'released_at': DateTime.now().toIso8601String(),
    }).eq('id', escrowId);
  }

  // فتح نزاع (المشتري لم يستلم المنتج)
  Future<void> openDispute(String escrowId, String reason) async {
    await _supabase.from('escrow_transactions').update({
      'status': 'disputed',
      'disputed_at': DateTime.now().toIso8601String(),
      'dispute_reason': reason,
    }).eq('id', escrowId);
  }

  // حل النزاع (لأدمن فقط)
  Future<void> resolveDispute(String escrowId, String resolution) async {
    await _supabase.from('escrow_transactions').update({
      'resolution': resolution,
    }).eq('id', escrowId);
  }

  // استرداد المال للمشتري
  Future<void> refund(String escrowId) async {
    await _supabase.from('escrow_transactions').update({
      'status': 'refunded',
      'refunded_at': DateTime.now().toIso8601String(),
    }).eq('id', escrowId);
  }

  // جلب معاملة محتجزة
  Future<Map<String, dynamic>?> getEscrowTransaction(String escrowId) async {
    final response = await _supabase
        .from('escrow_transactions')
        .select()
        .eq('id', escrowId)
        .maybeSingle();
    return response;
  }

  // جلب معاملات المستخدم
  Future<List<Map<String, dynamic>>> getUserEscrowTransactions(String userId) async {
    final response = await _supabase
        .from('escrow_transactions')
        .select('*, orders(*)')
        .or('buyer_id.eq.$userId,seller_id.eq.$userId')
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }
}
