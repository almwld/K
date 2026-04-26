import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final List<Map<String, String>> _faqs = const [
    {'question': 'كيف يمكنني تتبع طلبي؟', 'answer': 'يمكنك تتبع طلبك من قسم "طلباتي" في الملف الشخصي، ستجد جميع تفاصيل الطلب وحالة الشحن.'},
    {'question': 'ما هي طرق الدفع المتاحة؟', 'answer': 'نقبل الدفع عند الاستلام، البطاقات الائتمانية، والمحافظ الإلكترونية (كاش، جوالي، جيب).'},
    {'question': 'كم تستغرق عملية التوصيل؟', 'answer': 'خدمة التوصيل تغطي جميع محافظات اليمن خلال 24-48 ساعة، والتوصيل مجاني للطلبات فوق 200,000 ريال.'},
    {'question': 'كيف يمكنني إرجاع منتج؟', 'answer': 'يمكنك إرجاع المنتج خلال 14 يوم من الاستلام مع الحفاظ على العبوة الأصلية.'},
    {'question': 'كيف يمكنني التواصل مع البائع؟', 'answer': 'يمكنك التواصل مع البائع من خلال زر "تواصل" في صفحة تفاصيل المنتج أو من شاشة الدردشة.'},
  ];

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        title: const Text('مركز المساعدة', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.binanceDark,
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'الأسئلة الشائعة'),
                Tab(text: 'تواصل معنا'),
              ],
              labelColor: AppTheme.binanceGold,
              unselectedLabelColor: Color(0xFF9CA3AF),
              indicatorColor: AppTheme.binanceGold,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildFaqsList(),
                  _buildContactForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _faqs.length,
      itemBuilder: (context, index) => Card(
        color: AppTheme.binanceCard,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ExpansionTile(
          title: Text(
            _faqs[index]['question']!,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                _faqs[index]['answer']!,
                style: const TextStyle(color: Color(0xFF9CA3AF), height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactForm() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Color(0xFF1E2329),
            child: Icon(Icons.support_agent, size: 40, color: AppTheme.binanceGold),
          ),
          const SizedBox(height: 16),
          const Text(
            'فريق الدعم',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'نحن هنا لمساعدتك 24/7',
            style: TextStyle(color: Color(0xFF9CA3AF)),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _messageController,
            maxLines: 5,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'اكتب رسالتك هنا...',
              hintStyle: const TextStyle(color: Color(0xFF5E6673)),
              filled: true,
              fillColor: AppTheme.binanceCard,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_messageController.text.trim().isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم إرسال رسالتك، سنرد عليك قريباً'), backgroundColor: AppTheme.binanceGreen),
                  );
                  _messageController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.binanceGold,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('إرسال', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildContactIcon(Icons.phone, 'اتصال', () {}),
              _buildContactIcon(Icons.chat, 'واتساب', () {}),
              _buildContactIcon(Icons.email, 'بريد', () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactIcon(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.binanceCard,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppTheme.binanceGold, size: 24),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
        ],
      ),
    );
  }
}
