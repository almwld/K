// ... (المحتوى السابق مع إضافة المسار)

// أضف هذا الاستيراد في أعلى الملف
import 'screens/terms_screen.dart';
import 'screens/forgot_password_screen.dart';

// وأضف هذا المسار في switch statement:
// case '/terms':
case '/forgot_password':
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
//   return MaterialPageRoute(builder: (_) => const TermsScreen());

