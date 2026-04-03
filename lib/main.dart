import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/theme_manager.dart';
import 'providers/auth_provider.dart';
import 'services/connection_checker.dart';
import 'services/cache/local_storage_service.dart';
import 'services/supabase_service.dart';
import 'theme/app_theme.dart';
import 'models/user_model.dart';
import 'models/order_model.dart';
import 'models/auction_model.dart';

// Screens
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/main_navigation.dart';
import 'screens/home_screen.dart';
import 'screens/all_ads_screen.dart';
import 'screens/ad_detail_screen.dart';
import 'screens/auction_detail_screen.dart';
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

// Screens - Settings
import 'screens/settings/about_screen.dart';
import 'screens/settings/account_settings_screen.dart';
import 'screens/help_support_screen.dart';
import 'screens/settings/language_screen.dart';
import 'screens/settings/notifications_settings_screen.dart';
import 'screens/settings/security_settings_screen.dart';
import 'screens/invite_friends_screen.dart';
import 'screens/my_ads_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/my_orders_screen.dart';
import 'screens/followers_screen.dart';
import 'screens/following_screen.dart';
import 'screens/reviews_screen.dart';
import 'screens/change_password_screen.dart';
import 'screens/biometric_screen.dart';
import 'screens/connected_devices_screen.dart';
import 'screens/login_history_screen.dart';
import 'screens/privacy_settings_screen.dart';
import 'screens/privacy_block_screen.dart';
import 'screens/live_support_screen.dart';
import 'screens/smart_support_screen.dart';
import 'screens/support_tickets_screen.dart';
import 'screens/report_problem_screen.dart';
import 'screens/payment_method_screen.dart';
import 'screens/advanced_search_screen.dart';

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
  
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
            initialRoute: '/',
            onGenerateRoute: _onGenerateRoute,
          );
        },
      ),
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    // مسارات الفئات الديناميكية
    if (settings.name != null && settings.name!.startsWith('/category/')) {
      final category = settings.name!.replaceFirst('/category/', '');
      final categoryNames = {
        'real_estate': 'عقارات',
        'cars': 'سيارات',
        'electronics': 'إلكترونيات',
        'fashion': 'أزياء',
        'furniture': 'أثاث',
        'restaurants': 'مطاعم',
        'services': 'خدمات',
        'games': 'ألعاب',
        'health_beauty': 'صحة وجمال',
        'education': 'تعليم',
      };
      final categoryName = categoryNames[category] ?? category;
      return MaterialPageRoute(
        builder: (_) => CategoryProductsScreen(category: category, categoryName: categoryName),
      );
    }

    // مسار تفاصيل المزاد
    if (settings.name == '/auction_detail' && settings.arguments is AuctionModel) {
      return MaterialPageRoute(
        builder: (_) => AuctionDetailScreen(auction: settings.arguments as AuctionModel),
      );
    }

    // مسار تتبع الطلب
    if (settings.name == '/track_order' && settings.arguments is OrderModel) {
      return MaterialPageRoute(
        builder: (_) => TrackOrderScreen(order: settings.arguments as OrderModel),
      );
    }

    // مسار نجاح الطلب
    if (settings.name == '/order_success' && settings.arguments is OrderModel) {
      return MaterialPageRoute(
        builder: (_) => OrderSuccessScreen(order: settings.arguments as OrderModel),
      );
    }

    // مسار بيانات الهوية
    if (settings.name == '/identity_info' && settings.arguments is UserModel) {
      return MaterialPageRoute(
        builder: (_) => IdentityInfoScreen(userData: settings.arguments as UserModel),
      );
    }

    // مسار تفاصيل الدردشة - تم إصلاحه
    if (settings.name == '/chat_detail') {
      final args = settings.arguments as Map<String, dynamic>?;
      if (args == null) {
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('بيانات المحادثة غير موجودة'))));
      }
      return MaterialPageRoute(
        builder: (_) => ChatDetailScreen(chat: args),
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
        return MaterialPageRoute(builder: (_) => const AdDetailScreen());
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
        return MaterialPageRoute(builder: (_) => const AboutScreen());
      case '/account_info':
        return MaterialPageRoute(builder: (_) => const AccountSettingsScreen());
      case '/help_support':
        return MaterialPageRoute(builder: (_) => const HelpSupportScreen());
      case '/language':
        return MaterialPageRoute(builder: (_) => const LanguageScreen());
      case '/notifications_settings':
        return MaterialPageRoute(builder: (_) => const NotificationsSettingsScreen());
      case '/security_settings':
        return MaterialPageRoute(builder: (_) => const SecuritySettingsScreen());
      case '/payment_methods':
        return MaterialPageRoute(builder: (_) => const PaymentMethodScreen());
      case '/invite_friends':
        return MaterialPageRoute(builder: (_) => const InviteFriendsScreen());
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
      case '/smart_support':
        return MaterialPageRoute(builder: (_) => const SmartSupportScreen());
        return MaterialPageRoute(builder: (_) => const LiveSupportScreen());
      case '/support_tickets':
        return MaterialPageRoute(builder: (_) => const SupportTicketsScreen());
      case '/report_problem':
      case '/advanced_search':
        return MaterialPageRoute(builder: (_) => const AdvancedSearchScreen());
        return MaterialPageRoute(builder: (_) => const ReportProblemScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(
          body: Center(child: Text('الصفحة غير موجودة', style: TextStyle(fontSize: 18))),
        ));
    }
  }
}
