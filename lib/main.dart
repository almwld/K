import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home/main_navigation.dart';
import 'screens/home/home_screen.dart';
import 'screens/stores/stores_screen.dart';
import 'screens/auctions/auctions_screen.dart';
import 'screens/wallet/wallet_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/search_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/offers_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/orders/orders_screen.dart';
import 'screens/product/product_detail_screen.dart';

void main() {
  runApp(const FlexYemenApp());
}

class FlexYemenApp extends StatelessWidget {
  const FlexYemenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flex Yemen',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainNavigation(),
        '/home': (context) => const HomeScreen(),
        '/stores': (context) => const StoresScreen(),
        '/auctions': (context) => const AuctionsScreen(),
        '/wallet': (context) => const WalletScreen(),
        '/cart': (context) => const CartScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/search': (context) => const SearchScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/offers': (context) => const OffersScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/orders': (context) => const OrdersScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name?.startsWith('/product/') == true) {
          final productId = settings.name!.split('/').last;
          return MaterialPageRoute(builder: (_) => ProductDetailScreen(productId: productId));
        }
        return null;
      },
    );
  }
}
