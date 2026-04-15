import 'screens/settings/security_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'providers/auth_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/wallet_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';
import 'theme/app_theme.dart';

// Screens
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/main_navigation.dart';
import 'screens/all_ads_screen.dart';
import 'screens/auctions_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/chat_detail_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/garden_screen.dart';
import 'screens/identity_info_screen.dart';
import 'screens/invite_friends_screen.dart';
import 'screens/my_ads_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/order_success_screen.dart';
import 'screens/order_detail_screen.dart';
import 'screens/payment_method_screen.dart';
import 'screens/addresses_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/profile_picture_status_screen.dart';
import 'screens/push_notifications_screen.dart';
import 'screens/receive_transfer_request_screen.dart';
import 'screens/reels_screen.dart';
import 'screens/report_ad_screen.dart';
import 'screens/report_problem_screen.dart';
import 'screens/request_service_screen.dart';
import 'screens/reviews_screen.dart';
import 'screens/saved_payment_methods_screen.dart';
import 'screens/search_screen.dart';
import 'screens/seller/seller_dashboard.dart';
import 'screens/seller_analytics_screen.dart';
import 'screens/seller_payouts_screen.dart';
import 'screens/seller_products_screen.dart';
import 'screens/seller_profile_screen.dart';
import 'screens/seller_review_screen.dart';
import 'screens/seller_reviews_screen.dart';
import 'screens/settings/about_screen.dart';
import 'screens/settings/account_settings_screen.dart';
import 'screens/settings/help_support_screen.dart';
import 'screens/settings/language_screen.dart';
import 'screens/settings/notifications_settings_screen.dart';
import 'screens/settings/payment_methods_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/share_app_screen.dart';
import 'screens/share_profile_screen.dart';
import 'screens/sliders_screen.dart';
import 'screens/smart_support_screen.dart';
import 'screens/spending_screen.dart';
import 'screens/store_detail_screen.dart';
import 'screens/stores_nearby_screen.dart';
import 'screens/stores_screen.dart';
import 'screens/support_tickets_screen.dart';
import 'screens/terms_screen.dart';
import 'screens/track_order_screen.dart';
import 'screens/two_factor_screen.dart';
import 'screens/upload_documents_screen.dart';
import 'screens/walkthrough_screen.dart';
import 'screens/wallet_screen.dart';
import 'screens/ai_assistant_screen.dart';
import 'screens/map/interactive_map_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/all_categories_screen.dart';
import 'screens/category_products_screen.dart';
import 'screens/add_ad_screen.dart';
import 'screens/change_password_screen.dart';
import 'screens/connected_devices_screen.dart';
import 'screens/login_history_screen.dart';
import 'screens/privacy_settings_screen.dart';
import 'screens/privacy_block_screen.dart';
import 'screens/live_support_screen.dart';
import 'screens/advanced_search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'https://ziqpohdxtemsmunnhlkm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InppcXBvaGR4dGVtc211bm5obGttIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE3ODQzNDcsImV4cCI6MjA4NzM2MDM0N30.ABAg5YZSrrAtBTWATJ3eRTmo4BuZVyVlrMV1HZjRWs0',
  );
  
  runApp(const FlexYemenApp());
}

class FlexYemenApp extends StatelessWidget {
  const FlexYemenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WalletProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Flex Yemen',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
            locale: const Locale('ar', 'YE'),
            initialRoute: '/',
            onGenerateRoute: _onGenerateRoute,
          );
        },
      ),
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/main':
        return MaterialPageRoute(builder: (_) => const MainNavigation());
      case '/all_ads':
        return MaterialPageRoute(builder: (_) => const AllAdsScreen());
      case '/auctions':
        return MaterialPageRoute(builder: (_) => const AuctionsScreen());
      case '/cart':
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case '/checkout':
        return MaterialPageRoute(builder: (_) => const CheckoutScreen());
      case '/chat':
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      case '/chat_detail':
        return MaterialPageRoute(builder: (_) => const ChatDetailScreen(conversationId: "", otherUserId: "", otherUserName: ""));
      case '/favorites':
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());
      case '/forgot_password':
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case '/garden':
        return MaterialPageRoute(builder: (_) => const GardenScreen());
      case '/identity_info':
        return MaterialPageRoute(builder: (_) => const IdentityInfoScreen());
      case '/invite_friends':
        return MaterialPageRoute(builder: (_) => const InviteFriendsScreen());
      case '/my_ads':
        return MaterialPageRoute(builder: (_) => const MyAdsScreen());
      case '/my_orders':
      case '/notifications':
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case '/order_success':
        return MaterialPageRoute(builder: (_) => const OrderSuccessScreen());
      case '/order_detail':
        return MaterialPageRoute(builder: (_) => const OrderDetailScreen());
      case '/order_tracking':
      case '/orders':
      case '/payment_methods':
        return MaterialPageRoute(builder: (_) => const PaymentMethodScreen());
      case '/addresses':
        return MaterialPageRoute(builder: (_) => const AddressesScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/profile_picture_status':
        return MaterialPageRoute(builder: (_) => const ProfilePictureStatusScreen());
      case '/push_notifications':
        return MaterialPageRoute(builder: (_) => const PushNotificationsScreen());
      case '/receive_transfer':
        return MaterialPageRoute(builder: (_) => const ReceiveTransferRequestScreen());
      case '/reels':
        return MaterialPageRoute(builder: (_) => const ReelsScreen());
      case '/report_ad':
        return MaterialPageRoute(builder: (_) => const ReportAdScreen(adId: ""));
      case '/report_problem':
        return MaterialPageRoute(builder: (_) => const ReportProblemScreen());
      case '/request_service':
        return MaterialPageRoute(builder: (_) => const RequestServiceScreen());
      case '/reviews':
        return MaterialPageRoute(builder: (_) => const ReviewsScreen());
      case '/sanaa_services':
      case '/saved_payment_methods':
        return MaterialPageRoute(builder: (_) => const SavedPaymentMethodsScreen());
      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case '/security_settings':
        return MaterialPageRoute(builder: (_) => const SecuritySettingsScreen());
      case '/seller_dashboard':
        return MaterialPageRoute(builder: (_) => const SellerDashboard());
      case '/seller_analytics':
        return MaterialPageRoute(builder: (_) => const SellerAnalyticsScreen());
      case '/seller_orders':
      case '/seller_payouts':
        return MaterialPageRoute(builder: (_) => const SellerPayoutsScreen());
      case '/seller_products':
        return MaterialPageRoute(builder: (_) => const SellerProductsScreen());
      case '/seller_profile':
        return MaterialPageRoute(builder: (_) => const SellerProfileScreen());
      case '/seller_review':
        return MaterialPageRoute(builder: (_) => const SellerReviewScreen());
      case '/seller_reviews':
        return MaterialPageRoute(builder: (_) => const SellerReviewsScreen());
      case '/about':
        return MaterialPageRoute(builder: (_) => const AboutScreen());
      case '/account_settings':
        return MaterialPageRoute(builder: (_) => const AccountSettingsScreen());
      case '/help_support':
        return MaterialPageRoute(builder: (_) => const HelpSupportScreen());
      case '/language':
        return MaterialPageRoute(builder: (_) => const LanguageScreen());
      case '/notifications_settings':
        return MaterialPageRoute(builder: (_) => const NotificationsSettingsScreen());
      case '/payment_methods_settings':
        return MaterialPageRoute(builder: (_) => const PaymentMethodsScreen());
      case '/security_settings_settings':
        return MaterialPageRoute(builder: (_) => const SecuritySettingsScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case '/share_app':
        return MaterialPageRoute(builder: (_) => const ShareAppScreen());
      case '/share_profile':
        return MaterialPageRoute(builder: (_) => const ShareProfileScreen());
      case '/sliders':
        return MaterialPageRoute(builder: (_) => const SlidersScreen());
      case '/smart_support':
        return MaterialPageRoute(builder: (_) => const SmartSupportScreen());
      case '/spending':
        return MaterialPageRoute(builder: (_) => const SpendingScreen());
      case '/store_detail':
        return MaterialPageRoute(builder: (_) => const StoreDetailScreen(storeId: ""));
      case '/stores_nearby':
        return MaterialPageRoute(builder: (_) => const StoresNearbyScreen());
      case '/stores':
        return MaterialPageRoute(builder: (_) => const StoresScreen());
      case '/support_tickets':
        return MaterialPageRoute(builder: (_) => const SupportTicketsScreen());
      case '/terms':
        return MaterialPageRoute(builder: (_) => const TermsScreen());
      case '/track_order':
        return MaterialPageRoute(builder: (_) => const TrackOrderScreen());
      case '/two_factor':
        return MaterialPageRoute(builder: (_) => const TwoFactorScreen());
      case '/upload_documents':
        return MaterialPageRoute(builder: (_) => const UploadDocumentsScreen());
      case '/walkthrough':
        return MaterialPageRoute(builder: (_) => const WalkthroughScreen());
      case '/wallet':
        return MaterialPageRoute(builder: (_) => const WalletScreen());
      case '/withdraw':
      case '/deposit':
      case '/transfer':
      case '/transactions':
      case '/bill_payment':
      case '/recharge':
      case '/gift_cards':
      case '/currency_exchange':
      case '/qr_code':
      case '/ai_assistant':
        return MaterialPageRoute(builder: (_) => const AIAssistantScreen());
      case '/map':
        return MaterialPageRoute(builder: (_) => const InteractiveMapScreen());
      case '/nearby_stores':
      case '/professional_map':
      case '/categories':
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());
      case '/all_categories':
        return MaterialPageRoute(builder: (_) => const AllCategoriesScreen());
      case '/category_products':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => CategoryProductsScreen(
            categoryId: args?['categoryId'] ?? '',
            categoryName: args?['categoryName'] ?? '',
          ),
        );
      case '/add_ad':
        return MaterialPageRoute(builder: (_) => const AddAdScreen());
      case '/change_password':
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case '/connected_devices':
        return MaterialPageRoute(builder: (_) => const ConnectedDevicesScreen());
      case '/login_history':
        return MaterialPageRoute(builder: (_) => const LoginHistoryScreen());
      case '/privacy_settings':
        return MaterialPageRoute(builder: (_) => const PrivacySettingsScreen());
      case '/privacy_block':
        return MaterialPageRoute(builder: (_) => const PrivacyBlockScreen());
      case '/live_support':
        return MaterialPageRoute(builder: (_) => const LiveSupportScreen());
      case '/advanced_search':
        return MaterialPageRoute(builder: (_) => const AdvancedSearchScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(
          body: Center(child: Text('الصفحة غير موجودة', style: TextStyle(fontSize: 18))),
        ));
    }
  }
}
