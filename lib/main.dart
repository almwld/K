import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/theme_manager.dart';
import 'providers/market_provider.dart';
import 'providers/subscription_provider.dart';
import 'providers/user_stats_provider.dart';
import 'providers/app_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home/main_navigation.dart';
import 'screens/product/product_detail_screen.dart';
import 'screens/stores/store_detail_screen.dart';
import 'screens/checkout/checkout_screen.dart';
import 'screens/track_order_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => MarketProvider()),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
        ChangeNotifierProvider(create: (_) => UserStatsProvider()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          return MaterialApp(
            title: 'Flex Yemen',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeManager.themeMode,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashScreen(),
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const RegisterScreen(),
              '/home': (context) => const MainNavigation(),
              '/product': (context) => const ProductDetailScreen(productId: ''),
              '/store': (context) => const StoreDetailScreen(storeId: ''),
              '/checkout': (context) => const CheckoutScreen(),
              '/track': (context) => const TrackOrderScreen(),
            },
          );
        },
      ),
    );
  }
}
