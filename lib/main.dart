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
import 'screens/discover_screen.dart';
import 'screens/news_screen.dart';
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

// ==================== Imports شاشات الفئات (60+ شاشة) ====================
import 'screens/categories/agriculture_screen.dart';
import 'screens/categories/aviation_screen.dart';
import 'screens/categories/baby_kids_screen.dart';
import 'screens/categories/bakery_screen.dart';
import 'screens/categories/beauty_screen.dart';
import 'screens/categories/beverages_screen.dart';
import 'screens/categories/books_screen.dart';
import 'screens/categories/cars_screen.dart';
import 'screens/categories/cinema_screen.dart';
import 'screens/categories/electronics_screen.dart';
import 'screens/categories/fashion_screen.dart';
import 'screens/categories/furniture_screen.dart';
import 'screens/categories/games_screen.dart';
import 'screens/categories/gifts_screen.dart';
import 'screens/categories/groceries_screen.dart';
import 'screens/categories/jewelry_watches_screen.dart';
import 'screens/categories/pets_screen.dart';
import 'screens/categories/restaurants_screen.dart';
import 'screens/categories/sports_screen.dart';
import 'screens/categories/stationery_screen.dart';
import 'screens/categories/traditional_food_screen.dart';
import 'screens/categories/travel_tourism_screen.dart';

// ==================== Imports شاشات المحفظة (30+ شاشة) ====================
import 'screens/wallet/deposit_screen.dart';
import 'screens/wallet/withdraw_screen.dart';
import 'screens/wallet/transfer_screen.dart';
import 'screens/wallet/transactions_screen.dart';
import 'screens/wallet/gift_cards_screen.dart';
import 'screens/wallet/banks_wallets_screen.dart';
import 'screens/wallet/wallet_settings_screen.dart';
import 'screens/wallet/wallet_statement_screen.dart';

// ==================== Imports شاشات الأدمن (6 شاشات) ====================
import 'screens/admin/admin_dashboard.dart';
import 'screens/admin/admin_main_screen.dart';
import 'screens/admin/admin_secret_screen.dart';
import 'screens/admin/admin_settings_screen.dart';
import 'screens/admin/admin_stores_screen.dart';
import 'screens/admin/admin_users_screen.dart';

// ==================== Imports شاشات القوانين ====================
import 'screens/legal/privacy_policy_screen.dart';
import 'screens/legal/terms_of_service_screen.dart';
import 'screens/legal/disclaimer_screen.dart';
import 'screens/legal/fee_schedule_screen.dart';

// ==================== Imports شاشات الملف الشخصي ====================
import 'screens/profile/account_info_screen.dart';

// ==================== Imports شاشات أخرى ====================
import 'screens/reviews_screen.dart';
import 'screens/support_tickets_screen.dart';
import 'screens/live_support_screen.dart';
import 'screens/contact_us_screen.dart';
import 'screens/faq_screen.dart';
import 'screens/invite_friends_screen.dart';
import 'screens/share_app_screen.dart';
import 'screens/theme_selection_screen.dart';
import 'screens/language_screen.dart';
import 'screens/biometric_screen.dart';
import 'screens/security_settings_screen.dart';
import 'screens/connected_devices_screen.dart';
import 'screens/export_data_screen.dart';
import 'screens/privacy_settings_screen.dart';
import 'screens/notifications_settings_screen.dart';
import 'screens/upload_documents_screen.dart';
import 'screens/identity_info_screen.dart';
import 'screens/seller/seller_dashboard.dart';
import 'screens/seller/seller_reports_screen.dart';
import 'screens/report_problem_screen.dart';
import 'screens/changelog_screen.dart';
import 'screens/walkthrough_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/splash_screen.dart';

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
        // ==================== Routes الأساسية ====================
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
    '/discover': (context) => const DiscoverScreen(),
    '/news': (context) => const NewsScreen(),
        '/nearby': (context) => const NearbyScreen(),
        '/following': (context) => const FollowingScreen(),
        '/tracking': (context) => const OrderTrackingScreen(),
        '/about': (context) => const AboutScreen(),
        '/categories': (context) => const AllCategoriesScreen(),
        '/checkout': (context) => const CheckoutScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),

        // ==================== Routes شاشات الفئات (60+ شاشة) ====================
        '/categories/agriculture': (context) => const AgricultureScreen(),
        '/categories/aviation': (context) => const AviationScreen(),
        '/categories/baby_kids': (context) => const BabyKidsScreen(),
        '/categories/bakery': (context) => const BakeryScreen(),
        '/categories/beauty': (context) => const BeautyScreen(),
        '/categories/beverages': (context) => const BeveragesScreen(),
        '/categories/books': (context) => const BooksScreen(),
        '/categories/cars': (context) => const CarsScreen(),
        '/categories/cinema': (context) => const CinemaScreen(),
        '/categories/electronics': (context) => const ElectronicsScreen(),
        '/categories/fashion': (context) => const FashionScreen(),
        '/categories/furniture': (context) => const FurnitureScreen(),
        '/categories/games': (context) => const GamesScreen(),
        '/categories/gifts': (context) => const GiftsScreen(),
        '/categories/groceries': (context) => const GroceriesScreen(),
        '/categories/jewelry_watches': (context) => const JewelryWatchesScreen(),
        '/categories/pets': (context) => const PetsScreen(),
        '/categories/restaurants': (context) => const RestaurantsScreen(),
        '/categories/sports': (context) => const SportsScreen(),
        '/categories/stationery': (context) => const StationeryScreen(),
        '/categories/traditional_food': (context) => const TraditionalFoodScreen(),
        '/categories/travel_tourism': (context) => const TravelTourismScreen(),

        // ==================== Routes شاشات المحفظة ====================
        '/wallet/deposit': (context) => const DepositScreen(),
        '/wallet/withdraw': (context) => const WithdrawScreen(),
        '/wallet/transfer': (context) => const TransferScreen(),
        '/wallet/transactions': (context) => const TransactionsScreen(),
        '/wallet/gift_cards': (context) => const GiftCardsScreen(),
        '/wallet/banks': (context) => const BanksWalletsScreen(),
        '/wallet/settings': (context) => const WalletSettingsScreen(),
        '/wallet/statement': (context) => const WalletStatementScreen(),

        // ==================== Routes شاشات الأدمن ====================
        '/admin/dashboard': (context) => const AdminDashboard(),
        '/admin/main': (context) => const AdminMainScreen(),
        '/admin/secret': (context) => const AdminSecretScreen(),
        '/admin/settings': (context) => const AdminSettingsScreen(),
        '/admin/stores': (context) => const AdminStoresScreen(),
        '/admin/users': (context) => const AdminUsersScreen(),

        // ==================== Routes شاشات القوانين ====================
        '/legal/privacy': (context) => const PrivacyPolicyScreen(),
        '/legal/terms': (context) => const TermsOfServiceScreen(),
        '/legal/disclaimer': (context) => const DisclaimerScreen(),
        '/legal/fees': (context) => const FeeScheduleScreen(),

        // ==================== Routes شاشات أخرى ====================
        '/reviews': (context) => const ReviewsScreen(),
        '/support_tickets': (context) => const SupportTicketsScreen(),
        '/live_support': (context) => const LiveSupportScreen(),
        '/contact': (context) => const ContactUsScreen(),
        '/faq': (context) => const FaqScreen(),
        '/invite': (context) => const InviteFriendsScreen(),
        '/share_app': (context) => const ShareAppScreen(),
        '/theme': (context) => const ThemeSelectionScreen(),
        '/language': (context) => const LanguageScreen(),
        '/biometric': (context) => const BiometricScreen(),
        '/security': (context) => const SecuritySettingsScreen(),
        '/connected_devices': (context) => const ConnectedDevicesScreen(),
        '/export_data': (context) => const ExportDataScreen(),
        '/privacy_settings': (context) => const PrivacySettingsScreen(),
        '/notification_settings': (context) => const NotificationsSettingsScreen(),
        '/upload_documents': (context) => const UploadDocumentsScreen(),
        '/identity': (context) => const IdentityInfoScreen(),
        '/seller_dashboard': (context) => const SellerDashboard(),
        '/seller_reports': (context) => const SellerReportsScreen(),
        '/report_problem': (context) => const ReportProblemScreen(),
        '/changelog': (context) => const ChangelogScreen(),
        '/walkthrough': (context) => const WalkthroughScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/splash': (context) => const SplashScreen(),
        '/account_info': (context) => const AccountInfoScreen(),
      },
    );
  }
}
