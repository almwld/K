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
import 'screens/search_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/all_ads_screen.dart';
import 'screens/ad_detail_screen.dart';
import 'screens/add_ad_screen.dart';
import 'screens/offers_screen.dart';
import 'screens/auctions_screen.dart';
import 'screens/wallet/wallet_screen.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/chat/chat_detail_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/profile/account_info_screen.dart';
import 'screens/my_ads_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/orders/my_orders_screen.dart';
import 'screens/orders/order_detail_screen.dart';
import 'screens/product_review_screen.dart';
import 'screens/report_ad_screen.dart';
import 'screens/live_support_screen.dart';
import 'screens/faq_screen.dart';
import 'screens/contact_us_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/seller_profile_screen.dart';
import 'screens/seller_dashboard.dart';
import 'screens/changelog_screen.dart';
import 'screens/following_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/notifications_settings_screen.dart';
import 'screens/security_settings_screen.dart';
import 'screens/language_screen.dart';
import 'screens/payment_methods_screen.dart';
import 'screens/about_screen.dart';
import 'screens/privacy_policy_screen.dart';
import 'screens/help_support_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/ultimate_marketplace_screen.dart';
import 'screens/cart/cart_screen.dart';

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

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
              '/product_detail': (context) => const ProductDetailScreen(
        id: '',
        title: '',
        image: '',
        price: 0,
        description: '',
        sellerName: '',
        rating: 0,
        reviewCount: 0,
        images: [],
        inStock: true,
      ),
              '/marketplace': (context) => const UltimateMarketplaceScreen(),
              '/cart': (context) => const CartScreen(),
            },
          );
        },
      ),
    );
  }
}
