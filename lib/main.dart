import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/theme_manager.dart';
import 'providers/auth_provider.dart';
import 'services/connection_checker.dart';
import 'services/cache/local_storage_service.dart';
import 'theme/app_theme.dart';
import 'models/user_model.dart';
import 'models/order_model.dart';
import 'models/auction_model.dart';

// Screens - Main
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.init();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint('Warning: .env file not found');
  }
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
        'pets': 'حيوانات',
        'sports': 'رياضة',
        'books': 'كتب',
        'music': 'موسيقى',
        'movies': 'أفلام',
        'travel': 'سفر',
        'jobs': 'وظائف',
        'home_services': 'خدمات منزلية',
        'equipment': 'معدات',
        'gifts': 'هدايا',
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
      case '/chat_detail':
        return MaterialPageRoute(builder: (_) => const ChatDetailScreen());
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
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case '/categories':
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());
      case '/all_categories':
        return MaterialPageRoute(builder: (_) => const AllCategoriesScreen());
      case '/add_ad':
        return MaterialPageRoute(builder: (_) => const AddAdScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('الصفحة غير موجودة'))));
    }
  }
}
