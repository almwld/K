import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MiniMaxService {
  static final MiniMaxService _instance = MiniMaxService._internal();
  factory MiniMaxService() => _instance;
  MiniMaxService._internal();

  final Random _random = Random();
  
  final List<String> _greetings = [
    'مرحباً! كيف يمكنني مساعدتك اليوم؟ 😊',
    'أهلاً بك في فلكس يمن! كيف أقدر أخدمك؟ 🛍️',
    'مرحباً! أنا هنا لمساعدتك في كل ما يتعلق بالتسوق 💫',
    'أهلاً وسهلاً! ماذا تريد أن تعرف عن منتجاتنا؟ 🎯',
  ];
  
  final List<String> _prices = [
    'الأسعار تبدأ من 1000 ريال. هل تريد معرفة منتج معين؟ 💰',
    'لدينا منتجات بأسعار تناسب جميع الميزانيات. ما الذي تبحث عنه؟ 💵',
    'الأسعار تختلف حسب المنتج. أخبرني ماذا تريد وسأعطيك التفاصيل! 📊',
  ];
  
  final List<String> _shipping = [
    'نوفر التوصيل لجميع محافظات اليمن خلال 3-5 أيام عمل 🚚',
    'الشحن مجاني للطلبات التي تزيد عن 10,000 ريال 📦',
    'يمكنك تتبع طلبك عبر التطبيق بعد الشحن 🔍',
  ];
  
  final List<String> _products = [
    'لدينا آلاف المنتجات في مختلف الأقسام: إلكترونيات، أزياء، عقارات، سيارات، ومطاعم 🛒',
    'يمكنك تصفح المنتجات من الصفحة الرئيسية أو استخدام البحث 🔎',
    'أحدث المنتجات أضيفت اليوم! جرب قسم "منتجات مميزة" ✨',
  ];

  Future<void> init() async {
    await dotenv.load();
  }

  Future<String> chat(String message) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final msg = message.toLowerCase();
    
    if (msg.contains('سعر') || msg.contains('price') || msg.contains('كم')) {
      return _prices[_random.nextInt(_prices.length)];
    }
    if (msg.contains('شحن') || msg.contains('delivery') || msg.contains('توصيل')) {
      return _shipping[_random.nextInt(_shipping.length)];
    }
    if (msg.contains('منتج') || msg.contains('product') || msg.contains('متجر')) {
      return _products[_random.nextInt(_products.length)];
    }
    if (msg.contains('مرحب') || msg.contains('اهلا') || msg.contains('hello')) {
      return _greetings[_random.nextInt(_greetings.length)];
    }
    
    return _greetings[_random.nextInt(_greetings.length)];
  }
}
