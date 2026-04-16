import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/splash_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/theme_manager.dart';
import 'services/chat_service.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // تحميل المتغيرات البيئية
  await dotenv.load();
  
  // استخدام المفاتيح الصحيحة مباشرة
  const supabaseUrl = 'https://ziqpohdxtemsmunnhlkm.supabase.co';
  const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InppcXBvaGR4dGVtc211bm5obGttIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE3ODQzNDcsImV4cCI6MjA4NzM2MDM0N30.ABAg5YZSrrAtBTWATJ3eRTmo4BuZVyVlrMV1HZjRWs0';
  
  print('=== تهيئة Supabase ===');
  print('URL: $supabaseUrl');
  
  try {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseKey,
    );
    print('✅ تم تهيئة Supabase بنجاح');
  } catch (e) {
    print('❌ فشل تهيئة Supabase: $e');
  }
  
  // تهيئة الإشعارات (بدون Firebase مؤقتاً)
  try {
    await NotificationService().initialize();
  } catch (e) {
    print('⚠️ فشل تهيئة الإشعارات: $e');
  }
  
  runApp(const FlexYemenApp());
}

class FlexYemenApp extends StatelessWidget {
  const FlexYemenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        Provider(create: (_) => ChatService()),
        Provider(create: (_) => NotificationService()),
      ],
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          return MaterialApp(
            title: 'Flex Yemen',
            debugShowCheckedModeBanner: false,
            theme: themeManager.currentTheme,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
