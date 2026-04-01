# Flex Yemen - منصة التجارة الإلكترونية اليمنية

## نظرة عامة
Flex Yemen هو تطبيق تجارة إلكترونية متكامل مصمم خصيصاً للسوق اليمني. يوفر التطبيق منصة شاملة للبيع والشراء مع دعم كامل للخدمات المالية.

## المميزات الرئيسية

### 🏠 الصفحة الرئيسية
- سلايدر ترويجي تلقائي
- بطاقة حديقة فلكس (Flex Garden)
- الأقسام الرئيسية (عقارات، سيارات، إلكترونيات، أزياء)
- مزاد الجنابي الأسبوعي
- العقارات والاستثمارات
- منتجات مقترحة

### 🗺️ الخريطة التفاعلية
- خريطة تفاعلية باستخدام OpenStreetMap
- عرض المتاجر القريبة
- تحديد الموقع الحالي
- بطاقات معلومات المتاجر

### 🌟 حديقة فلكس (Flex Garden)
- نظام نقاط المكافآت
- مهام يومية
- ألعاب وفعاليات
- متجر الجوائز
- قائمة المتصدرين

### 💰 المحفظة الإلكترونية
- إيداع وسحب الأموال
- التحويلات المالية
- 22+ خدمة مالية متنوعة
- سجل العمليات

### 👤 الملف الشخصي
- إدارة الإعلانات
- المفضلة والطلبات
- المتابعون والمراجعات
- الإعدادات المتقدمة

## هيكل المشروع

```
lib/
├── main.dart                 # نقطة الدخول الرئيسية
├── theme/
│   └── app_theme.dart        # الثيم والألوان
├── services/
│   ├── cache/
│   │   └── local_storage_service.dart  # التخزين المحلي
│   └── connection_checker.dart          # مراقبة الاتصال
├── providers/
│   ├── theme_manager.dart    # إدارة الثيم
│   └── auth_provider.dart    # إدارة المصادقة
├── models/
│   ├── store_model.dart      # نموذج المتجر
│   └── product_model.dart    # نموذج المنتج
├── widgets/
│   ├── custom_app_bar.dart   # الشريط العلوي
│   └── custom_button.dart    # الأزرار المخصصة
└── screens/
    ├── splash_screen.dart
    ├── login_screen.dart
    ├── register_screen.dart
    ├── main_navigation.dart
    ├── home_screen.dart
    ├── garden_screen.dart
    ├── profile_screen.dart
    ├── wallet/
    │   └── (22 شاشة للمحفظة)
    ├── map/
    │   ├── interactive_map_screen.dart
    │   └── nearby_stores_screen.dart
    ├── policy/
    │   ├── privacy_policy_screen.dart
    │   ├── security_policy_screen.dart
    │   ├── terms_screen.dart
    │   └── vendor_terms_screen.dart
    ├── settings/
    │   └── (6 شاشات إعدادات)
    ├── seller/
    │   └── seller_dashboard.dart
    └── (60+ شاشة إضافية)
```

## التقنيات المستخدمة

- **Flutter 3.22+** - إطار العمل
- **Dart 3.0+** - لغة البرمجة
- **Provider** - إدارة الحالة
- **Supabase** - قاعدة البيانات
- **Hive + SharedPreferences** - التخزين المحلي
- **flutter_map** - الخرائط التفاعلية
- **carousel_slider** - السلايدر
- **flutter_animate** - الرسوم المتحركة

## الألوان الرئيسية

```dart
static const goldColor = Color(0xFFD4AF37);      // الذهبي الرئيسي
static const goldLight = Color(0xFFF4D03F);       // الذهبي الفاتح
static const goldDark = Color(0xFFB8860B);        // الذهبي الداكن
static const success = Color(0xFF2ECC71);         // أخضر للنجاح
static const error = Color(0xFFE74C3C);           // أحمر للخطأ
static const info = Color(0xFF3498DB);             // أزرق للمعلومات
static const warning = Color(0xFFF39C12);          // برتقالي للتحذير
```

## كيفية التشغيل

1. تأكد من تثبيت Flutter 3.22+:
```bash
flutter --version
```

2. احصل على依赖ات المشروع:
```bash
flutter pub get
```

3. شغل التطبيق:
```bash
flutter run
```

## ملاحظات هامة

- التطبيق يدعم الوضع الليلي والنهاري
- واجهة عربية كاملة (RTL)
- تصميم متجاوب مع جميع أحجام الشاشات
- دعم كامل للوضع Offline First

## الترخيص

جميع الحقوق محفوظة © 2026 Flex Yemen
# Flex-Yemen2
# Flex-_Yemen4
