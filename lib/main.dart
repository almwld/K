import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/splash_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/theme_manager.dart';
import 'services/chat_service.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // تهيئة Firebase
  await Firebase.initializeApp();
  
  // تهيئة الإشعارات
  await NotificationService().initialize();
  
  // تحميل المتغيرات البيئية
  await dotenv.load();
  
  final supabaseUrl = dotenv.env['SUPABASE_URL'] ?? 'https://ziqpohdxtemsmunnhlkm.supabase.co';
  final supabaseKey = dotenv.env['SUPABASE_ANON_KEY'] ?? 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InppcXBvaGR4dGVtc211bm5obGttIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE3ODQzNDcsImV4cCI6MjA4NzM2MDM0N30.ABAg5YZSrrAtBTWATJ3eRTmo4BuZVyVlrMV1HZjRWs0';
  
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );
  
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
            routes: {
              '/notifications': (_) => const NotificationsScreen(),
              // routes أخرى...
            },
          );
        },
      ),
    );
  }
}

// استيراد شاشة الإشعارات
import 'screens/notifications_screen.dart';
