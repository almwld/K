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
import 'screens/chat/chat_screen.dart';
import 'screens/ai_assistant_screen.dart';
import 'screens/search_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/offers_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/orders/orders_screen.dart';
import 'screens/addresses_screen.dart';
import 'screens/help_support_screen.dart';
import 'screens/markets_screen.dart';
import 'screens/nearby_screen.dart';
import 'screens/following_screen.dart';
import 'screens/order_detail_screen.dart';
import 'screens/order_tracking_screen.dart';
import 'screens/about_screen.dart';
import 'screens/categories/all_categories_screen.dart';
import 'screens/product/product_detail_screen.dart';
import 'screens/checkout/checkout_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/forgot_password_screen.dart';

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
      onGenerateRoute: (settings) {
        if (settings.name?.startsWith('/product/') == true) {
          final productId = settings.name!.split('/').last;
          return MaterialPageRoute(builder: (_) => ProductDetailScreen(productId: productId));
        }
        if (settings.name?.startsWith('/order/') == true) {
          final orderId = settings.name!.split('/').last;
          return MaterialPageRoute(builder: (_) => OrderDetailScreen(orderId: orderId));
        }
        return null;
      },
      routes: {
        '/': (context) => const MainNavigation(),
        '/home': (context) => const HomeScreen(),
        '/stores': (context) => const StoresScreen(),
        '/auctions': (context) => const AuctionsScreen(),
        '/wallet': (context) => const WalletScreen(),
        '/cart': (context) => const CartScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/chat': (context) => const ChatScreen(),
        '/ai_assistant': (context) => const AIAssistantScreen(),
        '/search': (context) => const SearchScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/offers': (context) => const OffersScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/orders': (context) => const OrdersScreen(),
        '/addresses': (context) => const AddressesScreen(),
        '/help': (context) => const HelpSupportScreen(),
        '/markets': (context) => const MarketsScreen(),
        '/nearby': (context) => const NearbyScreen(),
        '/following': (context) => const FollowingScreen(),
        '/tracking': (context) => const OrderTrackingScreen(),
        '/about': (context) => const AboutScreen(),
        '/categories': (context) => const AllCategoriesScreen(),
        '/checkout': (context) => const CheckoutScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
      },
    );
  }
}
