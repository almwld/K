import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'providers/theme_manager.dart';
import 'providers/cart_provider.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/home/main_navigation.dart';
import 'screens/home/home_screen.dart';
import 'screens/all_ads_screen.dart';
import 'screens/add_ad_screen.dart';
import 'screens/wallet/wallet_screen.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/my_ads_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/help_support_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/ultimate_marketplace_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/request_service_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
    ),
  );
  runApp(const FlexYemenApp());
}

class FlexYemenApp extends StatelessWidget {
  const FlexYemenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          return MaterialApp(
            title: 'Flex Yemen',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeManager.flutterMode,
            locale: const Locale('ar', 'YE'),
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: child!,
              );
            },
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashScreen(),
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const RegisterScreen(),
              '/main': (context) => const MainNavigation(),
              '/home': (context) => const HomeScreen(),
              '/add_ad': (context) => const AddAdScreen(),
              '/cart': (context) => const CartScreen(),
              '/request_service': (context) => const RequestServiceScreen(),
              '/marketplace': (context) => const UltimateMarketplaceScreen(),
            },
          );
        },
      ),
    );
  }
}
