import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Providers
import 'providers/theme_manager.dart';
import 'providers/auth_provider.dart';
import 'providers/view_mode_provider.dart';
import 'services/connection_checker.dart';
import 'services/cache/local_storage_service.dart';
import 'services/supabase_service.dart';
import 'theme/app_theme.dart';

// Screens
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/main_navigation.dart';
import 'screens/home_screen.dart';
import 'screens/all_ads_screen.dart';
import 'screens/ad_detail_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/chat_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/track_order_screen.dart';
import 'screens/order_success_screen.dart';
import 'screens/garden_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/auctions_screen.dart';
import 'screens/wallet/wallet_screen.dart';
import 'screens/map/interactive_map_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/all_categories_screen.dart';
import 'screens/category_products_screen.dart';
import 'screens/add_ad_screen.dart';
import 'screens/identity_info_screen.dart';
import 'screens/settings/about_screen.dart';
import 'screens/settings/account_settings_screen.dart';
import 'screens/help_support_screen.dart';
import 'screens/settings/language_screen.dart';
import 'screens/settings/notifications_settings_screen.dart';
import 'screens/settings/security_settings_screen.dart';
import 'screens/invite_friends_screen.dart';
import 'screens/share_profile_screen.dart';
import 'screens/export_data_screen.dart';
import 'screens/my_ads_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/my_orders_screen.dart';
import 'screens/followers_screen.dart';
import 'screens/following_screen.dart';
import 'screens/reviews_screen.dart';
import 'screens/product_review_screen.dart';
import 'screens/seller_review_screen.dart';
import 'screens/change_password_screen.dart';
import 'screens/biometric_screen.dart';
import 'screens/connected_devices_screen.dart';
import 'screens/login_history_screen.dart';
import 'screens/privacy_settings_screen.dart';
import 'screens/privacy_block_screen.dart';
import 'screens/live_support_screen.dart';
import 'screens/smart_support_screen.dart';
import 'screens/ai_chat_assistant.dart';
import 'screens/support_tickets_screen.dart';
import 'screens/report_problem_screen.dart';
import 'screens/payment_method_screen.dart';
import 'screens/addresses_screen.dart';
import 'screens/saved_payment_methods_screen.dart';
import 'screens/advanced_search_screen.dart';
import 'screens/terms_screen.dart';
import 'screens/forgot_password_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.init();
  
  try {
    await dotenv.load(fileName: ".env");
    debugPrint('✅ .env file loaded');
  } catch (e) {
    debugPrint('⚠️ .env file not found: $e');
  }
  
  await SupabaseService.initialize();
  
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
        ChangeNotifierProvider(create: (_) => ConnectionChecker()),
        ChangeNotifierProvider(create: (_) => ViewModeProvider()),
      ],
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          return MaterialApp(
            title: 'Flex Yemen',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeManager.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            locale: const Locale('ar', 'YE'),
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: child!,
              );
            },
            initialRoute: '/home',
            onGenerateRoute: _onGenerateRoute,
          );
        },
      ),
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    // مسارات الفئات الديناميكية
    if (settings.name != null && settings.name!.startsWith('/category/')) {
      final categoryId = settings.name!.replaceFirst('/category/', '');
      final categoryNames = {
        'agriculture': 'الزراعة',
        'real_estate': 'العقارات',
        'cars': 'السيارات',
        'electronics': 'الإلكترونيات',
        'fashion': 'الأزياء',
        'furniture': 'الأثاث',
        'restaurants': 'المطاعم',
        'services': 'الخدمات',
        'games': 'الألعاب',
        'health_beauty': 'الصحة والجمال',
        'education': 'التعليم',
        'baby': 'مستلزمات الأطفال',
        'sports': 'الرياضة',
        'jewelry': 'المجوهرات',
        'watches': 'الساعات',
        'perfumes': 'العطور',
        'bags': 'الحقائب',
        'shoes': 'الأحذية',
        'phones': 'الجوالات',
        'laptops': 'الكمبيوترات',
        'tv': 'الشاشات',
        'home_appliances': 'الأجهزة المنزلية',
        'books': 'الكتب',
        'gifts': 'الهدايا',
        'flowers': 'الورود',
        'bakery': 'المخبوزات',
        'grocery': 'المواد الغذائية',
        'meat': 'اللحوم',
        'vegetables': 'الخضروات',
        'dairy': 'منتجات الألبان',
        'drinks': 'المشروبات',
        'coffee': 'القهوة',
        'dates': 'التمور',
        'honey': 'العسل',
        'incense': 'البخور',
        'carpets': 'السجاد',
      };
      final categoryName = categoryNames[categoryId] ?? categoryId;
      return MaterialPageRoute(
        builder: (_) => CategoryProductsScreen(
          categoryId: categoryId,
          categoryName: categoryName,
        ),
      );
    }

    // المسارات الثابتة
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/main':
        return MaterialPageRoute(builder: (_) => const MainNavigation());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/all_ads':
        return MaterialPageRoute(builder: (_) => const AllAdsScreen());
      case '/ad_detail':
        return MaterialPageRoute(builder: (_) => const AdDetailScreen(adId: ""));
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/chat':
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      case '/cart':
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case '/checkout':
        return MaterialPageRoute(builder: (_) => const CheckoutScreen());
      case '/garden':
        return MaterialPageRoute(builder: (_) => const GardenScreen());
      case '/notifications':
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case '/auctions':
        return MaterialPageRoute(builder: (_) => const AuctionsScreen());
      case '/wallet':
        return MaterialPageRoute(builder: (_) => const WalletScreen());
      case '/map':
        return MaterialPageRoute(builder: (_) => const InteractiveMapScreen());
      case '/categories':
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());
      case '/all_categories':
        return MaterialPageRoute(builder: (_) => const AllCategoriesScreen());
      case '/add_ad':
        return MaterialPageRoute(builder: (_) => const AddAdScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case '/about':
      case '/about_app':
        return MaterialPageRoute(builder: (_) => const AboutScreen());
      case '/account_info':
        return MaterialPageRoute(builder: (_) => const AccountSettingsScreen());
      case '/help_support':
        return MaterialPageRoute(builder: (_) => const HelpSupportScreen());
      case '/language':
      case '/appearance':
        return MaterialPageRoute(builder: (_) => const LanguageScreen());
      case '/notifications_settings':
        return MaterialPageRoute(builder: (_) => const NotificationsSettingsScreen());
      case '/security_settings':
        return MaterialPageRoute(builder: (_) => const SecuritySettingsScreen());
      case '/payment_methods':
        return MaterialPageRoute(builder: (_) => const PaymentMethodScreen());
      case '/addresses':
        return MaterialPageRoute(builder: (_) => const AddressesScreen());
      case '/saved_payment_methods':
        return MaterialPageRoute(builder: (_) => const SavedPaymentMethodsScreen());
      case '/invite_friends':
        return MaterialPageRoute(builder: (_) => const InviteFriendsScreen());
      case '/share_profile':
        return MaterialPageRoute(builder: (_) => const ShareProfileScreen());
      case '/export_data':
        return MaterialPageRoute(builder: (_) => const ExportDataScreen());
      case '/my_ads':
        return MaterialPageRoute(builder: (_) => const MyAdsScreen());
      case '/favorites':
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());
      case '/my_orders':
        return MaterialPageRoute(builder: (_) => const MyOrdersScreen());
      case '/followers':
        return MaterialPageRoute(builder: (_) => const FollowersScreen());
      case '/following':
        return MaterialPageRoute(builder: (_) => const FollowingScreen());
      case '/reviews':
        return MaterialPageRoute(builder: (_) => const ReviewsScreen());
      case '/product_review':
        return MaterialPageRoute(builder: (_) => const ProductReviewScreen());
      case '/seller_review':
        return MaterialPageRoute(builder: (_) => const SellerReviewScreen());
      case '/change_password':
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case '/biometric_auth':
        return MaterialPageRoute(builder: (_) => const BiometricScreen());
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
      case '/smart_support':
        return MaterialPageRoute(builder: (_) => const SmartSupportScreen());
      case '/ai_chat':
        return MaterialPageRoute(builder: (_) => const AIChatAssistant());
      case '/support_tickets':
        return MaterialPageRoute(builder: (_) => const SupportTicketsScreen());
      case '/report_problem':
        return MaterialPageRoute(builder: (_) => const ReportProblemScreen());
      case '/advanced_search':
        return MaterialPageRoute(builder: (_) => const AdvancedSearchScreen());
      case '/terms':
        return MaterialPageRoute(builder: (_) => const TermsScreen());
      case '/forgot_password':
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(
          body: Center(child: Text('الصفحة غير موجودة', style: TextStyle(fontSize: 18))),
        ));
    }
  }
}
