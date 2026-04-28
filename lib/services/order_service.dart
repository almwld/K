import 'package:supabase_flutter/supabase_flutter.dart';

class OrderService {
  final SupabaseClient client = Supabase.instance.client;

  Future<void> createOrder(Map<String, dynamic> orderData) async {
    await client.from('orders').insert(orderData);
  }

  Future<List<Map<String, dynamic>>> getOrders() async {
    final uid = client.auth.currentUser?.id;
    if (uid == null) return [];
    return await client
        .from('orders')
        .select('*, order_items(*)')
        .eq('user_id', uid)
        .order('created_at', ascending: false);
  }

  Future<Map<String, dynamic>?> getOrderById(String orderId) async {
    return await client
        .from('orders')
        .select('*, order_items(*)')
        .eq('id', orderId)
        .maybeSingle();
  }
}
