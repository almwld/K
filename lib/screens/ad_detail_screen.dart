import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/ad_service.dart';
import '../models/ad_model.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'chat_screen.dart';
import 'report_ad_screen.dart';

class AdDetailScreen extends StatefulWidget {
  final String adId;
  const AdDetailScreen({super.key, required this.adId});

  @override
  State<AdDetailScreen> createState() => _AdDetailScreenState();
}

class _AdDetailScreenState extends State<AdDetailScreen> {
  final AdService _adService = AdService();
  AdModel? _ad;
  bool _isLoading = true;
  bool _isLiked = false;
  int _currentImageIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  Future<void> _loadAd() async {
    setState(() => _isLoading = true);
    final ad = await _adService.getAd(widget.adId);
    if (ad != null) {
      _ad = ad;
      _isLiked = await _adService.isAdLiked(widget.adId);
    }
    setState(() => _isLoading = false);
  }

  Future<void> _toggleLike() async {
    if (_isLiked) {
      await _adService.unlikeAd(widget.adId);
      setState(() => _isLiked = false);
    } else {
      await _adService.likeAd(widget.adId);
      setState(() => _isLiked = true);
    }
  }

  Future<void> _makePhoneCall(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      _showSnackBar('لا يمكن الاتصال بهذا الرقم');
    }
  }

  Future<void> _openWhatsApp(String phone) async {
    final Uri whatsappUri = Uri(scheme: 'https', path: 'wa.me/$phone');
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      _showSnackBar('تطبيق واتساب غير مثبت');
    }
  }

  Future<void> _shareAd() async {
    if (_ad == null) return;
    final String shareText = '''
🛍️ ${_ad!.title}
💰 السعر: ${_ad!.formattedPrice}
📱 تطبيق فلكس اليمن
    ''';
    // يمكن إضافة Share package هنا
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_isLoading) {
      return Scaffold(
        backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
        appBar: const SimpleAppBar(title: 'تفاصيل الإعلان'),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_ad == null) {
      return Scaffold(
        backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
        appBar: const SimpleAppBar(title: 'تفاصيل الإعلان'),
        body: const Center(child: Text('الإعلان غير موجود')),
      );
    }

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(
        title: 'تفاصيل الإعلان',
        actions: [
          IconButton(
            icon: Icon(_isLiked ? Icons.favorite : Icons.favorite_border, color: _isLiked ? Colors.red : null),
            onPressed: _toggleLike,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareAd,
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'report', child: Text('تبليغ عن الإعلان')),
              const PopupMenuItem(value: 'save', child: Text('حفظ الإعلان')),
            ],
            onSelected: (value) {
              if (value == 'report') {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ReportAdScreen(adId: _ad!.id)));
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // معرض الصور
            _buildImageGallery(),
            
            // معلومات البائع
            _buildSellerInfo(),
            
            // تفاصيل الإعلان
            _buildAdDetails(),
            
            // معلومات إضافية
            _buildAdditionalInfo(),
            
            // أزرار التواصل
            _buildContactButtons(),
            
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildImageGallery() {
    final images = _ad!.images;
    
    if (images.isEmpty) {
      return Container(
        height: 300,
        color: Colors.grey[300],
        child: const Center(child: Icon(Icons.image_not_supported, size: 50)),
      );
    }

    return Stack(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentImageIndex = index),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: images[index],
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (_, __) => Container(color: Colors.grey[300], child: const Center(child: CircularProgressIndicator())),
                errorWidget: (_, __, ___) => Container(color: Colors.grey[300], child: const Icon(Icons.error)),
              );
            },
          ),
        ),
        // مؤشر الصور
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(images.length, (index) {
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentImageIndex == index ? AppTheme.goldColor : Colors.white.withOpacity(0.5),
                ),
              );
            }),
          ),
        ),
        // عدد الصور
        Positioned(
          top: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${_currentImageIndex + 1}/${images.length}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSellerInfo() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: AppTheme.goldColor.withOpacity(0.2),
            child: Text(
              _ad!.userName.isNotEmpty ? _ad!.userName[0] : '?',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_ad!.userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text('4.8', style: TextStyle(color: isDark ? Colors.white70 : Colors.grey[600])),
                    const SizedBox(width: 12),
                    const Icon(Icons.shopping_bag, size: 14),
                    const SizedBox(width: 4),
                    Text('12 إعلان', style: TextStyle(color: isDark ? Colors.white70 : Colors.grey[600])),
                  ],
                ),
              ],
            ),
          ),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChatScreen()),
              );
            },
            icon: const Icon(Icons.chat_bubble_outline, size: 18),
            label: const Text('راسل'),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppTheme.goldColor),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdDetails() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _ad!.title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.goldColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _ad!.condition ?? 'جديد',
                  style: TextStyle(color: AppTheme.goldColor, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                _ad!.formattedPrice,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.goldColor,
                ),
              ),
              if (_ad!.oldPrice != null) ...[
                const SizedBox(width: 8),
                Text(
                  _ad!.formattedOldPrice,
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '-${_ad!.discountPercentage.toStringAsFixed(0)}%',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            ],
          ),
          const Divider(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildInfoRow(Icons.category, 'القسم', _getCategoryName(_ad!.category)),
              ),
              Expanded(
                child: _buildInfoRow(Icons.location_on, 'الموقع', _ad!.location ?? 'اليمن'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildInfoRow(Icons.remove_red_eye, 'المشاهدات', '${_ad!.views}'),
              ),
              Expanded(
                child: _buildInfoRow(Icons.favorite, 'الإعجابات', '${_ad!.likes}'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_ad!.description != null && _ad!.description!.isNotEmpty) ...[
            const Divider(height: 24),
            const Text('الوصف', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              _ad!.description!,
              style: TextStyle(
                height: 1.5,
                color: isDark ? Colors.white70 : Colors.grey[700],
              ),
            ),
          ],
          const Divider(height: 24),
          const Text('تاريخ النشر', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
            '${_ad!.createdAt.year}/${_ad!.createdAt.month}/${_ad!.createdAt.day}',
            style: TextStyle(color: isDark ? Colors.white60 : Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppTheme.goldColor),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              Text(value, style: const TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('معلومات إضافية', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified, size: 16, color: Colors.green),
              const SizedBox(width: 8),
              const Text('حساب موثوق'),
              const Spacer(),
              const Icon(Icons.security, size: 16),
              const SizedBox(width: 8),
              const Text('بيانات مؤكدة'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.timer, size: 16, color: Colors.orange),
              const SizedBox(width: 8),
              Text('ينتهي في: ${_getRemainingDays()} أيام'),
              const Spacer(),
              const Icon(Icons.check_circle, size: 16, color: Colors.green),
              const SizedBox(width: 8),
              const Text('إعلان نشط'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _makePhoneCall(_ad!.phone),
                  icon: const Icon(Icons.phone),
                  label: const Text('اتصال'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.goldColor,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              if (_ad!.whatsapp != null)
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _openWhatsApp(_ad!.whatsapp!),
                    icon: const Icon(Icons.chat),
                    label: const Text('واتساب'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.goldColor),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? AppTheme.darkSurface : Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _makePhoneCall(_ad!.phone),
                icon: const Icon(Icons.phone),
                label: const Text('اتصال'),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.goldColor),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: () => _openWhatsApp(_ad!.whatsapp ?? _ad!.phone),
                icon: const Icon(Icons.chat),
                label: const Text('راسل البائع'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.goldColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCategoryName(String id) {
    switch (id) {
      case 'electronics': return 'إلكترونيات';
      case 'fashion': return 'أزياء';
      case 'furniture': return 'أثاث';
      case 'cars': return 'سيارات';
      case 'real_estate': return 'عقارات';
      case 'services': return 'خدمات';
      case 'restaurants': return 'مطاعم';
      default: return id;
    }
  }

  String _getRemainingDays() {
    if (_ad!.expiresAt == null) return '30';
    final days = _ad!.expiresAt!.difference(DateTime.now()).inDays;
    return days > 0 ? days.toString() : '0';
  }
}
