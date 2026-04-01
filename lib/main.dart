import 'models/user_model.dart';
import 'models/order_model.dart';
import 'models/shipping_company.dart';
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

// Screens - Main (imports kept; ensure files exist)
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/identity_info_screen.dart';
import 'screens/main_navigation.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/all_ads_screen.dart';
import 'screens/ad_detail_screen.dart';
import 'screens/add_ad_screen.dart';
import 'screens/offers_screen.dart';
import 'screens/auctions_screen.dart';
import 'screens/wallet/wallet_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/chat_detail_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/account_info_screen.dart';
import 'screens/my_ads_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/my_orders_screen.dart';
import 'screens/order_detail_screen.dart';
import 'screens/product_review_screen.dart';
import 'screens/report_ad_screen.dart';
import 'screens/live_support_screen.dart';
import 'screens/faq_screen.dart';
import 'screens/contact_us_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/seller_profile_screen.dart';
import 'screens/seller/seller_dashboard.dart';
import 'screens/changelog_screen.dart';
import 'screens/following_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/settings/notifications_settings_screen.dart';
import 'screens/settings/security_settings_screen.dart';
import 'screens/settings/language_screen.dart';
import 'screens/settings/payment_methods_screen.dart';
import 'screens/settings/about_screen.dart';
import 'screens/settings/help_support_screen.dart';
import 'screens/settings/account_settings_screen.dart';
import 'screens/garden_screen.dart';
import 'screens/map/interactive_map_screen.dart';
import 'screens/map/nearby_stores_screen.dart';

// Wallet Screens
import 'screens/wallet/deposit_screen.dart';
import 'screens/wallet/withdraw_screen.dart';
import 'screens/wallet/transfer_screen.dart';
import 'screens/wallet/payments_screen.dart';
import 'screens/wallet/transactions_screen.dart';
import 'screens/wallet/transfer_network_screen.dart';
import 'screens/wallet/entertainment_services_screen.dart';
import 'screens/wallet/games_screen.dart';
import 'screens/wallet/apps_screen.dart';
import 'screens/wallet/gift_cards_screen.dart';
import 'screens/wallet/amazon_gift_cards_screen.dart';
import 'screens/wallet/banks_wallets_screen.dart';
import 'screens/wallet/money_transfers_screen.dart';
import 'screens/wallet/government_payments_screen.dart';
import 'screens/wallet/jib_screen.dart';
import 'screens/wallet/cash_withdrawal_screen.dart';
import 'screens/wallet/universities_screen.dart';
import 'screens/wallet/recharge_payment_screen.dart';
import 'screens/wallet/recharge_credit_screen.dart';
import 'screens/wallet/pay_bundles_screen.dart';
import 'screens/wallet/internet_landline_screen.dart';
import 'screens/wallet/receive_transfer_request_screen.dart';

// Policy Screens
import 'screens/policy/privacy_policy_screen.dart';
import 'screens/policy/security_policy_screen.dart';
import 'screens/policy/terms_screen.dart';
import 'screens/policy/vendor_terms_screen.dart';

// Additional Screens
import 'screens/checkout_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/add_address_screen.dart';
import 'screens/payment_method_screen.dart';
import 'screens/track_order_screen.dart';
import 'screens/invoice_screen.dart';
import 'screens/pick_location_screen.dart';
import 'screens/order_success_screen.dart';
import 'screens/seller_products_screen.dart';
import 'screens/seller_orders_screen.dart';
import 'screens/seller_analytics_screen.dart';
import 'screens/seller_reviews_screen.dart';
import 'screens/seller_payouts_screen.dart';
import 'screens/followers_screen.dart';
import 'screens/reviews_screen.dart';
import 'screens/share_app_screen.dart';
import 'screens/invite_friends_screen.dart';
import 'screens/support_tickets_screen.dart';
import 'screens/report_problem_screen.dart';
import 'screens/ad_stats_screen.dart';
import 'screens/earnings_screen.dart';
import 'screens/spending_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/walkthrough_screen.dart';
import 'screens/change_password_screen.dart';
import 'screens/two_factor_screen.dart';
import 'screens/biometric_screen.dart';
import 'screens/connected_devices_screen.dart';
import 'screens/login_history_screen.dart';
import 'screens/privacy_settings_screen.dart';

// Category Screens (kept as before)
import 'screens/categories/health_beauty_screen.dart';
import 'screens/categories/home_appliances_screen.dart';
import 'screens/categories/kitchen_food_screen.dart';
import 'screens/categories/handicrafts_antiques_screen.dart';
import 'screens/categories/construction_materials_screen.dart';
import 'screens/categories/agriculture_screen.dart';
import 'screens/categories/education_screen.dart';
import 'screens/categories/travel_tourism_screen.dart';
import 'screens/categories/auctions_category_screen.dart';
import 'screens/categories/donations_screen.dart';
import 'screens/categories/luxury_items_screen.dart';
import 'screens/categories/heavy_equipment_screen.dart';
import 'screens/categories/software_screen.dart';
import 'screens/categories/security_safety_screen.dart';
import 'screens/categories/aviation_screen.dart';
import 'screens/categories/music_screen.dart';
import 'screens/categories/currency_screen.dart';
import 'screens/categories/cinema_screen.dart';
import 'screens/categories/luxury_cars_screen.dart';
import 'screens/categories/commercial_realestate_screen.dart';
import 'screens/categories/consumer_electronics_screen.dart';
import 'screens/categories/luxury_furniture_screen.dart';
import 'screens/categories/jewelry_watches_screen.dart';
import 'screens/categories/perfumes_makeup_screen.dart';
import 'screens/categories/food_beverages_screen.dart';
import 'screens/categories/baby_kids_screen.dart';
import 'screens/categories/pets_screen.dart';
import 'screens/categories/gifts_screen.dart';
import 'screens/categories/sports_fitness_screen.dart';
import 'screens/categories/stationery_screen.dart';
import 'screens/categories/industrial_equipment_screen.dart';
import 'screens/categories/electrical_tools_screen.dart';
import 'screens/categories/plumbing_tools_screen.dart';
import 'screens/categories/carpentry_tools_screen.dart';
import 'screens/categories/blacksmith_tools_screen.dart';
import 'screens/categories/home_services_screen.dart';
import 'screens/categories/car_services_screen.dart';
import 'screens/categories/contracting_services_screen.dart';
import 'screens/categories/delivery_services_screen.dart';
import 'screens/categories/training_services_screen.dart';
import 'screens/categories/medical_equipment_screen.dart';
import 'screens/categories/cosmetics_screen.dart';
import 'screens/categories/hair_care_screen.dart';
import 'screens/categories/skin_care_screen.dart';
import 'screens/categories/perfumes_screen.dart';
import 'screens/categories/groceries_screen.dart';
import 'screens/categories/beverages_screen.dart';
import 'screens/categories/fruits_vegetables_screen.dart';
import 'screens/categories/meat_poultry_screen.dart';
import 'screens/categories/seafood_screen.dart';
import 'screens/categories/dairy_products_screen.dart';
import 'screens/categories/bakery_screen.dart';
import 'screens/categories/desserts_screen.dart';
import 'screens/categories/nuts_dried_fruits_screen.dart';
import 'screens/categories/canned_food_screen.dart';
import 'screens/categories/spices_screen.dart';
import 'screens/categories/rice_grains_screen.dart';
import 'screens/categories/oils_fats_screen.dart';
import 'screens/categories/sugar_sweets_screen.dart';
import 'screens/categories/hot_drinks_screen.dart';
import 'screens/categories/cold_drinks_screen.dart';
import 'screens/categories/wedding_supplies_screen.dart';
import 'screens/categories/graduation_parties_screen.dart';
import 'screens/categories/birthday_supplies_screen.dart';
import 'screens/categories/events_supplies_screen.dart';
import 'screens/categories/traditional_food_screen.dart';

// --- Screens added later by assistant (ensure these files exist) ---
import 'screens/appearance_screen.dart';
import 'screens/chat_settings_screen.dart';
import 'screens/map_nearby_screen.dart';
import 'screens/upload_documents_screen.dart';
import 'screens/sliders_screen.dart';
import 'screens/wheels_investments_screen.dart';
import 'screens/product_recommendations_screen.dart';
import 'screens/reels_screen.dart';
import 'screens/stores_nearby_screen.dart';
import 'screens/biometric_screen.dart';
import 'screens/privacy_block_screen.dart';
import 'screens/profile_picture_status_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة التخزين المحلي فوراً
  await LocalStorageService.init();

  // تحميل متغيرات البيئة
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint('Warning: .env file not found');
  }

  // تهيئة Supabase في الخلفية بعد 10 ثواني
  _initSupabaseDelayed();

  // إعدادات النظام
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

Future<void> _initSupabaseDelayed() async {
  await Future.delayed(const Duration(seconds: 10));
  try {
    final url = dotenv.env['SUPABASE_URL'];
    final anonKey = dotenv.env['SUPABASE_ANON_KEY'];
    if (url != null && anonKey != null) {
      await Supabase.initialize(url: url, anonKey: anonKey);
      debugPrint('Supabase initialized successfully');
    }
  } catch (e) {
    debugPrint('Supabase initialization error: $e');
  }
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
              return Directionality(textDirection: TextDirection.rtl, child: child!);
            },
            initialRoute: '/',
            routes: {
              // Main Routes
              '/': (context) => const SplashScreen(),
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const RegisterScreen(),
      '/identity_info': (context) {
        final args = ModalRoute.of(context)?.settings.arguments as UserModel?;
        if (args == null) return const SizedBox();
        return IdentityInfoScreen(userData: args);
      },
              '/main': (context) => const MainNavigation(),
              '/home': (context) => const HomeScreen(),
              '/search': (context) => const SearchScreen(),
              '/notifications': (context) => const NotificationsScreen(),
              '/all_ads': (context) => const AllAdsScreen(),
              '/ad_detail': (context) => const AdDetailScreen(),
              '/add_ad': (context) => const AddAdScreen(),
              '/offers': (context) => const OffersScreen(),
              '/auctions': (context) => const AuctionsScreen(),
              '/wallet': (context) => const WalletScreen(),
              '/chat': (context) => const ChatScreen(),
              '/chat_detail': (context) => const ChatDetailScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/account_info': (context) => const AccountSettingsScreen(),
              '/my_ads': (context) => const MyAdsScreen(),
              '/favorites': (context) => const FavoritesScreen(),
              '/my_orders': (context) => const MyOrdersScreen(),
              '/order_detail': (context) => const OrderDetailScreen(),
              '/product_review': (context) => const ProductReviewScreen(),
              '/report_ad': (context) => const ReportAdScreen(),
              '/live_support': (context) => const LiveSupportScreen(),
              '/faq': (context) => const FaqScreen(),
              '/contact_us': (context) => const ContactUsScreen(),
              '/categories': (context) => const CategoriesScreen(),
              '/seller_profile': (context) => const SellerProfileScreen(),
              '/seller_dashboard': (context) => const SellerDashboard(),
              '/changelog': (context) => const ChangelogScreen(),
              '/following': (context) => const FollowingScreen(),
              '/settings': (context) => const SettingsScreen(),
              '/notifications_settings': (context) => const NotificationsSettingsScreen(),
              '/security_settings': (context) => const SecuritySettingsScreen(),
              '/language': (context) => const LanguageScreen(),
              '/payment_methods': (context) => const PaymentMethodsScreen(),
              '/about': (context) => const AboutScreen(),
              '/help_support': (context) => const HelpSupportScreen(),
              '/garden': (context) => const GardenScreen(),
              '/map': (context) => const InteractiveMapScreen(),
              '/nearby_stores': (context) => const NearbyStoresScreen(),

              // Wallet Routes
              '/deposit': (context) => const DepositScreen(),
              '/withdraw': (context) => const WithdrawScreen(),
              '/transfer': (context) => const TransferScreen(),
              '/payments': (context) => const PaymentsScreen(),
              '/transactions': (context) => const TransactionsScreen(),
              '/transfer_network': (context) => const TransferNetworkScreen(),
              '/entertainment': (context) => const EntertainmentServicesScreen(),
              '/games': (context) => const GamesScreen(),
              '/apps': (context) => const AppsScreen(),
              '/gift_cards': (context) => const GiftCardsScreen(),
              '/amazon_gift_cards': (context) => const AmazonGiftCardsScreen(),
              '/banks_wallets': (context) => const BanksWalletsScreen(),
              '/money_transfers': (context) => const MoneyTransfersScreen(),
              '/government_payments': (context) => const GovernmentPaymentsScreen(),
              '/jib': (context) => const JibScreen(),
              '/cash_withdrawal': (context) => const CashWithdrawalScreen(),
              '/universities': (context) => const UniversitiesScreen(),
              '/recharge_payment': (context) => const RechargePaymentScreen(),
              '/recharge_credit': (context) => const RechargeCreditScreen(),
              '/pay_bundles': (context) => const PayBundlesScreen(),
              '/internet_landline': (context) => const InternetLandlineScreen(),
              '/receive_transfer': (context) => const ReceiveTransferRequestScreen(),

              // Policy Routes
              '/privacy_policy': (context) => const PrivacyPolicyScreen(),
              '/security_policy': (context) => const SecurityPolicyScreen(),
              '/terms': (context) => const TermsScreen(),
              '/vendor_terms': (context) => const VendorTermsScreen(),

              // Additional Routes
              '/checkout': (context) => const CheckoutScreen(),
              '/cart': (context) => const CartScreen(),
              '/add_address': (context) => const AddAddressScreen(),
              '/payment_method': (context) => const PaymentMethodScreen(),
              '/track_order': (context) => const TrackOrderScreen(),
              '/invoice': (context) => const InvoiceScreen(),
              '/pick_location': (context) => const PickLocationScreen(),
              '/order_success': (context) => const OrderSuccessScreen(),
              '/seller_products': (context) => const SellerProductsScreen(),
              '/seller_orders': (context) => const SellerOrdersScreen(),
              '/seller_analytics': (context) => const SellerAnalyticsScreen(),
              '/seller_reviews': (context) => const SellerReviewsScreen(),
              '/seller_payouts': (context) => const SellerPayoutsScreen(),
              '/followers': (context) => const FollowersScreen(),
              '/reviews': (context) => const ReviewsScreen(),
              '/share_app': (context) => const ShareAppScreen(),
              '/invite_friends': (context) => const InviteFriendsScreen(),
              '/support_tickets': (context) => const SupportTicketsScreen(),
              '/report_problem': (context) => const ReportProblemScreen(),
              '/ad_stats': (context) => const AdStatsScreen(),
              '/earnings': (context) => const EarningsScreen(),
              '/spending': (context) => const SpendingScreen(),
              '/onboarding': (context) => const OnboardingScreen(),
              '/walkthrough': (context) => const WalkthroughScreen(),
              '/change_password': (context) => const ChangePasswordScreen(),
              '/two_factor': (context) => const TwoFactorScreen(),
              '/biometric_auth': (context) => const BiometricScreen(),
              '/connected_devices': (context) => const ConnectedDevicesScreen(),
              '/login_history': (context) => const LoginHistoryScreen(),
              '/privacy_settings': (context) => const PrivacySettingsScreen(),

              // Category Routes (kept as before)
              '/health_beauty': (context) => const HealthBeautyScreen(),
              '/home_appliances': (context) => const HomeAppliancesScreen(),
              '/kitchen_food': (context) => const KitchenFoodScreen(),
              '/handicrafts_antiques': (context) => const HandicraftsAntiquesScreen(),
              '/construction_materials': (context) => const ConstructionMaterialsScreen(),
              '/agriculture': (context) => const AgricultureScreen(),
              '/education': (context) => const EducationScreen(),
              '/travel_tourism': (context) => const TravelTourismScreen(),
              '/auctions_category': (context) => const AuctionsCategoryScreen(),
              '/donations': (context) => const DonationsScreen(),
              '/luxury_items': (context) => const LuxuryItemsScreen(),
              '/heavy_equipment': (context) => const HeavyEquipmentScreen(),
              '/software': (context) => const SoftwareScreen(),
              '/security_safety': (context) => const SecuritySafetyScreen(),
              '/aviation': (context) => const AviationScreen(),
              '/music': (context) => const MusicScreen(),
              '/currency': (context) => const CurrencyScreen(),
              '/cinema': (context) => const CinemaScreen(),
              '/luxury_cars': (context) => const LuxuryCarsScreen(),
              '/commercial_realestate': (context) => const CommercialRealestateScreen(),
              '/consumer_electronics': (context) => const ConsumerElectronicsScreen(),
              '/luxury_furniture': (context) => const LuxuryFurnitureScreen(),
              '/jewelry_watches': (context) => const JewelryWatchesScreen(),
              '/perfumes_makeup': (context) => const PerfumesMakeupScreen(),
              '/food_beverages': (context) => const FoodBeveragesScreen(),
              '/baby_kids': (context) => const BabyKidsScreen(),
              '/pets': (context) => const PetsScreen(),
              '/gifts': (context) => const GiftsScreen(),
              '/sports_fitness': (context) => const SportsFitnessScreen(),
              '/stationery': (context) => const StationeryScreen(),
              '/industrial_equipment': (context) => const IndustrialEquipmentScreen(),
              '/electrical_tools': (context) => const ElectricalToolsScreen(),
              '/plumbing_tools': (context) => const PlumbingToolsScreen(),
              '/carpentry_tools': (context) => const CarpentryToolsScreen(),
              '/blacksmith_tools': (context) => const BlacksmithToolsScreen(),
              '/home_services': (context) => const HomeServicesScreen(),
              '/car_services': (context) => const CarServicesScreen(),
              '/contracting_services': (context) => const ContractingServicesScreen(),
              '/delivery_services': (context) => const DeliveryServicesScreen(),
              '/training_services': (context) => const TrainingServicesScreen(),
              '/medical_equipment': (context) => const MedicalEquipmentScreen(),
              '/cosmetics': (context) => const CosmeticsScreen(),
              '/hair_care': (context) => const HairCareScreen(),
              '/skin_care': (context) => const SkinCareScreen(),
              '/perfumes': (context) => const PerfumesScreen(),
              '/groceries': (context) => const GroceriesScreen(),
              '/beverages': (context) => const BeveragesScreen(),
              '/fruits_vegetables': (context) => const FruitsVegetablesScreen(),
              '/meat_poultry': (context) => const MeatPoultryScreen(),
              '/seafood': (context) => const SeafoodScreen(),
              '/dairy_products': (context) => const DairyProductsScreen(),
              '/bakery': (context) => const BakeryScreen(),
              '/desserts': (context) => const DessertsScreen(),
              '/nuts_dried_fruits': (context) => const NutsDriedFruitsScreen(),
              '/canned_food': (context) => const CannedFoodScreen(),
              '/spices': (context) => const SpicesScreen(),
              '/rice_grains': (context) => const RiceGrainsScreen(),
              '/oils_fats': (context) => const OilsFatsScreen(),
              '/sugar_sweets': (context) => const SugarSweetsScreen(),
              '/hot_drinks': (context) => const HotDrinksScreen(),
              '/cold_drinks': (context) => const ColdDrinksScreen(),
              '/wedding_supplies': (context) => const WeddingSuppliesScreen(),
              '/graduation_parties': (context) => const GraduationPartiesScreen(),
              '/birthday_supplies': (context) => const BirthdaySuppliesScreen(),
              '/events_supplies': (context) => const EventsSuppliesScreen(),
              '/traditional_food': (context) => const TraditionalFoodScreen(),

              // Routes for screens created later by assistant
              '/appearance': (context) => const AppearanceScreen(),
              '/chat_settings': (context) => const ChatSettingsScreen(),
              '/map_nearby': (context) => const MapNearbyScreen(),
              '/upload_documents': (context) => const UploadDocumentsScreen(),
              '/sliders': (context) => const SlidersScreen(),
              '/wheels_investments': (context) => const WheelsInvestmentsScreen(),
              '/product_recommendations': (context) => const ProductRecommendationsScreen(),
              '/reels': (context) => const ReelsScreen(),
              '/stores_nearby_custom': (context) => const StoresNearbyScreen(),
              '/biometric_custom': (context) => const BiometricScreen(),
              '/privacy_block': (context) => const PrivacyBlockScreen(),
              '/profile_picture_status': (context) => const ProfilePictureStatusScreen(),
            },
          );
        },
      ),
    );
  }
}
