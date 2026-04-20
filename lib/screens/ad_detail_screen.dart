import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'chat/chat_detail_screen.dart';
import '../models/chat_model.dart';

class AdDetailScreen extends StatefulWidget {
  final Map<String, dynamic> ad;

  const AdDetailScreen({super.key, required this.ad});

  @override
  State<AdDetailScreen> createState() => _AdDetailScreenState();
}

class _AdDetailScreenState extends State<AdDetailScreen> {
  int _currentImageIndex = 0;
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final images = widget.ad['images'] as List<String>? ?? [
      'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=800',
      'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?w=800',
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(widget.ad['title'] ?? 'تفاصيل الإعلان'),
        backgroundColor: AppTheme.gold,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () => setState(() => _isFavorite = !_isFavorite),
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border, color: _isFavorite ? Colors.red : Colors.black),
          ),
          IconButton(onPressed: _shareAd, icon: const Icon(Icons.share, color: Colors.black)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // معرض الصور
            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(height: 300, viewportFraction: 1, onPageChanged: (index, _) => setState(() => _currentImageIndex = index)),
                  items: images.map((image) => Image.network(image, width: double.infinity, fit: BoxFit.cover)).toList(),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: images.asMap().entries.map((entry) {
                      return Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentImageIndex == entry.key ? AppTheme.gold : Colors.grey[400],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: AppTheme.gold, borderRadius: BorderRadius.circular(20)),
                    child: Text('${widget.ad['price']} ريال', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                ),
              ],
            ),
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.ad['title'] ?? '', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(widget.ad['location'] ?? 'صنعاء', style: TextStyle(color: Colors.grey[600])),
                      const SizedBox(width: 16),
                      const Icon(Icons.access_time, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(widget.ad['time'] ?? 'منذ ساعة', style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // معلومات البائع
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        const CircleAvatar(radius: 25, backgroundImage: NetworkImage('https://ui-avatars.com/api/?name=Seller&background=D4AF37&color=fff')),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.ad['seller'] ?? 'البائع', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 14),
                                  Text(' ${widget.ad['rating'] ?? '4.5'}'),
                                  const SizedBox(width: 12),
                                  Text('${widget.ad['adsCount'] ?? '5'} إعلانات', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: _chatWithSeller,
                          icon: const Icon(Icons.chat, size: 18),
                          label: const Text('محادثة'),
                          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // الوصف
                  const Text('الوصف', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(widget.ad['description'] ?? 'لا يوجد وصف', style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.5)),
                  
                  const SizedBox(height: 20),
                  
                  // المواصفات
                  if (widget.ad['specs'] != null) ...[
                    const Text('المواصفات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    ...(widget.ad['specs'] as Map<String, String>).entries.map((spec) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            SizedBox(width: 120, child: Text(spec.key, style: TextStyle(color: Colors.grey[600]))),
                            Expanded(child: Text(spec.value, style: const TextStyle(fontWeight: FontWeight.w500))),
                          ],
                        ),
                      );
                    }),
                  ],
                  
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Theme.of(context).cardColor, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2))]),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _callSeller,
                  icon: const Icon(Icons.call),
                  label: const Text('اتصال'),
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: _chatWithSeller,
                  icon: const Icon(Icons.chat),
                  label: const Text('محادثة'),
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _callSeller() async {
    final phone = widget.ad['phone'] ?? '777123456';
    final url = Uri.parse('tel:$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _chatWithSeller() {
    // إنشاء محادثة مع البائع
    final conversation = ConversationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      customerId: 'current_user',
      customerName: 'مستخدم',
      customerAvatar: 'https://ui-avatars.com/api/?name=User&background=D4AF37&color=fff',
      merchantId: widget.ad['sellerId'] ?? 'seller1',
      merchantName: widget.ad['seller'] ?? 'البائع',
      merchantAvatar: 'https://ui-avatars.com/api/?name=Seller&background=2196F3&color=fff',
      lastMessage: 'بداية محادثة',
      lastMessageTime: DateTime.now(),
      productName: widget.ad['title'],
      productImage: (widget.ad['images'] as List<String>? ?? []).isNotEmpty ? widget.ad['images'][0] : null,
    );
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ChatDetailScreen(userName: conversation.merchantName, userId: conversation.merchantId)),
    );
  }

  void _shareAd() {
    // مشاركة الإعلان
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('جاري مشاركة الإعلان...')));
  }
}

