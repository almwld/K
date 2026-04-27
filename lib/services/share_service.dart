import 'package:share_plus/share_plus.dart';

class ShareService {
  static Future<void> shareApp() async {
    await Share.share('مرحباً، أدعوك لتجربة تطبيق فلكس يمن!\nhttps://flexyemen.com/download');
  }

  static Future<void> shareProduct(String productName, String productPrice) async {
    await Share.share('🎁 اكتشف المنتج: $productName بسعر $productPrice ريال\nعبر تطبيق فلكس يمن');
  }
}
