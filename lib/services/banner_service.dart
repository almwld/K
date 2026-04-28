import 'package:supabase_flutter/supabase_flutter.dart';

class BannerService {
  final SupabaseClient client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getActiveBanners() async {
    return await client
        .from('banners')
        .select()
        .eq('is_active', true)
        .order('order', ascending: true);
  }
}
