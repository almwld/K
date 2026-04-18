import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'theme/app_theme.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppTheme.lightBackground,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  
  // ✅ مسح الإعداد القديم للثيم (ليبدأ بالذهبي)
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('is_dark_mode');
  
  await Supabase.initialize(
    url: 'https://ziqpohdxtermunnhlkm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InppcXBvaGR4dGVtc211bm5obGttIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE3ODQzNDcsImV4cCI6MjA4NzM2MDM0N30.ABAg5YZSrrAtBTWATJ3eRTmo4BuZVyVlrMV1HZjRWs0',
  );
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeManager(),
      child: const FlexYemenApp(),
    ),
  );
}

class FlexYemenApp extends StatelessWidget {
  const FlexYemenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        return MaterialApp(
          title: 'FLEX YEMEN',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeManager.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const SplashScreen(),
          builder: (context, child) {
            return Animate(
              effects: const [
                FadeEffect(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
              ],
              child: child ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}
