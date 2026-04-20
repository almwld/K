import 'package:flutter/material.dart';

class AIChatService {
  static final Map<String, List<String>> _knowledgeBase = {
    'المنتج': [
      'هل المنتج متوفر؟', 'ما هي مواصفات المنتج؟', 'ما هو سعر المنتج؟',
      'هل يوجد ضمان؟', 'ما هي ألوان المنتج؟', 'هل يمكن تجربة المنتج؟'
    ],
    'الشحن': [
      'كم تكلفة الشحن؟', 'كم يستغرق وقت التوصيل؟', 'هل التوصيل مجاني؟',
      'هل تشحنون إلى خارج اليمن؟', 'كيف يمكن تتبع الطلب؟'
    ],
    'الدفع': [
      'ما هي طرق الدفع؟', 'هل يمكن الدفع عند الاستلام؟', 'كيف أشحن محفظتي؟',
      'هل يوجد تقسيط؟', 'ما هي رسوم التحويل؟'
    ],
    'الضمان': [
      'هل هناك ضمان على المنتج؟', 'كم مدة الضمان؟', 'ماذا تشمل خدمة الضمان؟',
      'كيف أستفيد من الضمان؟'
    ],
    'الاسترجاع': [
      'هل يمكن استرجاع المنتج؟', 'ما هي سياسة الاسترجاع؟', 'كم المدة المسموحة للاسترجاع؟',
      'من يتحمل تكاليف الشحن للإرجاع؟'
    ],
  };
  
  static final Map<String, String> _intentResponses = {
    'product_available': 'نعم، المنتج متوفر حالياً. هل تريد معرفة السعر؟',
    'product_price': 'سعر المنتج هو {price} ريال. هل تريد شراءه؟',
    'product_warranty': 'المنتج عليه ضمان لمدة سنة ضد عيوب الصناعة.',
    'shipping_cost': 'تكلفة الشحن تعتمد على موقعك، تبدأ من 500 ريال.',
    'shipping_time': 'مدة التوصيل تتراوح بين 2-5 أيام عمل.',
    'payment_methods': 'نقبل الدفع عند الاستلام، التحويل البنكي، والمحفظة الإلكترونية.',
    'return_policy': 'يمكن استرجاع المنتج خلال 14 يوماً من تاريخ الشراء.',
  };
  
  static Future<String?> getAIResponse(String message, {String? productTitle, double? productPrice}) async {
    final lowerMsg = message.toLowerCase();
    
    if (lowerMsg.contains('متوفر') || lowerMsg.contains('موجود')) {
      return _intentResponses['product_available'] ?? 'نعم، المنتج متوفر حالياً.';
    }
    if (lowerMsg.contains('سعر') || lowerMsg.contains('كم')) {
      if (productPrice != null) {
        return 'سعر المنتج هو ${productPrice.toStringAsFixed(0)} ريال. هل تريد شراءه؟';
      }
      return _intentResponses['product_price']?.replaceAll('{price}', '?') ?? 'سعر المنتج مناسب جداً. هل تريد معرفة التفاصيل؟';
    }
    if (lowerMsg.contains('ضمان')) {
      return _intentResponses['product_warranty']!;
    }
    if (lowerMsg.contains('شحن') || lowerMsg.contains('توصيل')) {
      if (lowerMsg.contains('تكلفة') || lowerMsg.contains('سعر')) {
        return _intentResponses['shipping_cost']!;
      }
      if (lowerMsg.contains('مدة') || lowerMsg.contains('وقت')) {
        return _intentResponses['shipping_time']!;
      }
    }
    if (lowerMsg.contains('دفع') || lowerMsg.contains('طريقة')) {
      return _intentResponses['payment_methods']!;
    }
    if (lowerMsg.contains('استرجاع') || lowerMsg.contains('إرجاع')) {
      return _intentResponses['return_policy']!;
    }
    
    if (lowerMsg.contains('مرحب') || lowerMsg.contains('السلام')) {
      return '👋 وعليكم السلام! أنا مساعد Flex Yemen الذكي. كيف يمكنني مساعدتك اليوم؟';
    }
    if (lowerMsg.contains('شكر')) {
      return '🌹 العفو! دائماً في خدمتك. هل هناك شيء آخر؟';
    }
    
    return null;
  }
  
  static bool canAnswer(String message) {
    final lowerMsg = message.toLowerCase();
    return lowerMsg.contains('متوفر') ||
           lowerMsg.contains('سعر') ||
           lowerMsg.contains('ضمان') ||
           lowerMsg.contains('شحن') ||
           lowerMsg.contains('دفع') ||
           lowerMsg.contains('مرحب') ||
           lowerMsg.contains('شكر');
  }
  
  static List<String> getSuggestedQuestions() {
    return [
      'هل المنتج متوفر؟',
      'ما هو السعر؟',
      'هل يوجد ضمان؟',
      'كم تكلفة الشحن؟',
      'ما هي طرق الدفع؟',
    ];
  }
}

