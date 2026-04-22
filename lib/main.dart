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
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home/main_navigation.dart';
import 'screens/home/home_screen.dart';
import 'screens/product/product_detail_screen.dart';
import 'screens/stores/stores_screen.dart';
import 'screens/stores/store_detail_screen.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/auctions/auctions_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/offers_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/search_screen.dart';
import 'screens/orders/orders_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/wallet/wallet_screen.dart';
import 'screens/wallet/deposit_screen.dart';
import 'screens/wallet/withdraw_screen.dart';
import 'screens/wallet/transfer_screen.dart';
import 'screens/wallet/transactions_screen.dart';
import 'screens/wallet/banks_wallets_screen.dart';
import 'screens/wallet/gift_cards_screen.dart';
import 'screens/wallet/payments_screen.dart';
import 'screens/wallet/recharge_screen.dart';
import 'screens/wallet/deposit_screen.dart';
import 'screens/wallet/withdraw_screen.dart';
import 'screens/wallet/transfer_screen.dart';
import 'screens/wallet/transactions_screen.dart';
import 'screens/wallet/banks_wallets_screen.dart';
import 'screens/wallet/gift_cards_screen.dart';
import 'screens/wallet/payments_screen.dart';
import 'screens/wallet/recharge_screen.dart';
import 'screens/checkout/checkout_screen.dart';
import 'screens/track_order_screen.dart';
import 'screens/add_ad_screen.dart';
import 'screens/add_product_screen.dart';
import 'screens/request_service_screen.dart';
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
      '/admin': (context) => const AdminDashboard(),
      '/admin/users': (context) => const AdminUsersScreen(),
      '/admin/stores': (context) => const AdminStoresScreen(),
      '/admin/settings': (context) => const AdminSettingsScreen(),
      '/category/electronics': (context) => const ElectronicsScreen(),
      '/category/fashion': (context) => const FashionScreen(),
      '/category/cars': (context) => const CarsScreen(),
      '/category/realestate': (context) => const RealEstateScreen(),
      '/category/furniture': (context) => const FurnitureScreen(),
      '/category/restaurants': (context) => const RestaurantsScreen(),
      '/category/beauty': (context) => const BeautyScreen(),
      '/category/sports': (context) => const SportsScreen(),
      '/category/books': (context) => const BooksScreen(),
      '/category/games': (context) => const GamesScreen(),
      '/deposit': (context) => const DepositScreen(),
      '/withdraw': (context) => const WithdrawScreen(),
      '/transfer': (context) => const TransferScreen(),
      '/transactions': (context) => const TransactionsScreen(),
      '/banks': (context) => const BanksWalletsScreen(),
      '/gift_cards': (context) => const GiftCardsScreen(),
      '/payments': (context) => const PaymentsScreen(),
      '/recharge': (context) => const RechargeScreen(),
      '/deposit': (context) => const DepositScreen(),
      '/withdraw': (context) => const WithdrawScreen(),
      '/transfer': (context) => const TransferScreen(),
      '/transactions': (context) => const TransactionsScreen(),
      '/banks': (context) => const BanksWalletsScreen(),
      '/gift_cards': (context) => const GiftCardsScreen(),
      '/payments': (context) => const PaymentsScreen(),
      '/recharge': (context) => const RechargeScreen(),
              '/': (context) => const SplashScreen(),
              '/onboarding': (context) => const OnboardingScreen(),
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const RegisterScreen(),
              '/home': (context) => const MainNavigation(),
              '/main': (context) => const HomeScreen(),
              '/stores': (context) => const StoresScreen(),
              '/store': (context) => const StoreDetailScreen(storeId: ''),
              '/chat': (context) => const ChatScreen(),
              '/auctions': (context) => const AuctionsScreen(),
              '/cart': (context) => const CartScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/favorites': (context) => const FavoritesScreen(),
              '/offers': (context) => const OffersScreen(),
              '/notifications': (context) => const NotificationsScreen(),
              '/search': (context) => const SearchScreen(),
              '/orders': (context) => const OrdersScreen(),
              '/settings': (context) => const SettingsScreen(),
              '/wallet': (context) => const WalletScreen(),
              '/checkout': (context) => const CheckoutScreen(),
              '/track': (context) => const TrackOrderScreen(),
              '/add_ad': (context) => const AddAdScreen(),
              '/add_product': (context) => const AddProductScreen(),
              '/request_service': (context) => const RequestServiceScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == '/product') {
                final productId = settings.arguments as String? ?? '';
                return MaterialPageRoute(builder: (_) => ProductDetailScreen(productId: productId));
              }
              if (settings.name == '/store_detail') {
                final storeId = settings.arguments as String? ?? '';
                return MaterialPageRoute(builder: (_) => StoreDetailScreen(storeId: storeId));
              }
              return null;
            },
          );
        },
      ),
    );
  }
}

// شاشات الفئات
import 'screens/categories/electronics_screen.dart';
import 'screens/categories/fashion_screen.dart';
import 'screens/categories/cars_screen.dart';
import 'screens/categories/realestate_screen.dart';
import 'screens/categories/furniture_screen.dart';
import 'screens/categories/restaurants_screen.dart';
import 'screens/categories/beauty_screen.dart';
import 'screens/categories/sports_screen.dart';
import 'screens/categories/books_screen.dart';
import 'screens/categories/games_screen.dart';

// شاشات الإدارة
import 'screens/admin/admin_dashboard.dart';
import 'screens/admin/admin_users_screen.dart';
import 'screens/admin/admin_stores_screen.dart';
import 'screens/admin/admin_settings_screen.dart';
