import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class SocialMediaWidget extends StatelessWidget {
  const SocialMediaWidget({super.key});

  static const List<Map<String, dynamic>> socialLinks = [
    {
      'name': 'انستغرام',
      'icon': 'assets/icons/svg/social/instagram.svg',
      'url': 'https://instagram.com/flexyemen',
      'username': '@flexyemen',
    },
    {
      'name': 'فيسبوك',
      'icon': 'assets/icons/svg/social/facebook.svg',
      'url': 'https://facebook.com/flexyemen',
      'username': '@flexyemen',
    },
    {
      'name': 'تيك توك',
      'icon': 'assets/icons/svg/social/tiktok.svg',
      'url': 'https://tiktok.com/@flexyemen',
      'username': '@flexyemen',
    },
    {
      'name': 'يوتيوب',
      'icon': 'assets/icons/svg/social/youtube.svg',
      'url': 'https://youtube.com/@flexyemen',
      'username': '@flexyemen',
    },
    {
      'name': 'أكس',
      'icon': 'assets/icons/svg/social/x.svg',
      'url': 'https://x.com/flexyemen',
      'username': '@flexyemen',
    },
    {
      'name': 'نريدز',
      'icon': 'assets/icons/svg/social/needs.svg',
      'url': 'https://needs.com/flexyemen',
      'username': '@flexyemen',
    },
  ];

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العنوان
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: AppTheme.goldGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مواقع التواصل الاجتماعي',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'حساباتنا الرسمية على مواقع التواصل',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // شبكة الأيقونات
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 1.2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
            children: socialLinks.map((social) {
              return _buildSocialItem(
                context: context,
                name: social['name'],
                iconPath: social['icon'],
                url: social['url'],
                username: social['username'],
              );
            }).toList(),
          ),
          
          const SizedBox(height: 16),
          
          // تنبيه
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.gold.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.gold.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: AppTheme.gold,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'تنبيه: لا تتعامل مع أي حسابات غير مذكورة في هذه القائمة للحفاظ على أمان حسابك بمنصتنا',
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? Colors.grey[400] : Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialItem({
    required BuildContext context,
    required String name,
    required String iconPath,
    required String url,
    required String username,
  }) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(
                color: Colors.grey.withOpacity(0.2),
              ),
            ),
            child: SvgPicture.asset(iconPath),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            username,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

// ويدجت مبسط للاستخدام في أماكن أخرى
class SocialMediaCompactWidget extends StatelessWidget {
  const SocialMediaCompactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: SocialMediaWidget.socialLinks.take(5).map((social) {
          return GestureDetector(
            onTap: () async {
              final uri = Uri.parse(social['url']);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
            child: SvgPicture.asset(
              social['icon'],
              width: 28,
              height: 28,
            ),
          );
        }).toList(),
      ),
    );
  }
}
