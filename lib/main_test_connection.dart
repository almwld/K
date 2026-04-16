import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  print('=== اختبار الاتصال بـ Supabase ===');
  print('URL: https://ziqpohdxtemsmunnhlkm.supabase.co');
  
  try {
    await Supabase.initialize(
      url: 'https://ziqpohdxtemsmunnhlkm.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InppcXBvaGR4dGVtc211bm5obGttIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE3ODQzNDcsImV4cCI6MjA4NzM2MDM0N30.ABAg5YZSrrAtBTWATJ3eRTmo4BuZVyVlrMV1HZjRWs0',
    );
    print('✅ تم الاتصال بـ Supabase بنجاح!');
    
    // اختبار المصادقة
    print('=== اختبار المصادقة ===');
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: 'test@flexyemen.com',
        password: 'test123456',
      );
      print('✅ المصادقة تعمل (تم إرسال الطلب)');
    } catch (e) {
      print('⚠️ المصادقة: $e (هذا طبيعي إذا كان المستخدم غير موجود)');
    }
    
  } catch (e) {
    print('❌ فشل الاتصال: $e');
  }
  
  runApp(const MaterialApp(
    home: Scaffold(
      body: Center(
        child: Text('اختبار الاتصال - انظر إلى terminal'),
      ),
    ),
  ));
}
