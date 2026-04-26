import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({super.key});

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  final List<String> _suggestions = [
    'ما هي المنتجات المتوفرة؟',
    'كيف أتابع طلبي؟',
    'طرق الدفع المتاحة',
    'خدمة التوصيل',
  ];

  @override
  void initState() {
    super.initState();
    _messages.add({
      'role': 'assistant',
      'content': 'مرحباً! 👋\nأنا مساعد فلكس الذكي. كيف يمكنني مساعدتك اليوم؟'
    });
  }

  void _sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'content': message});
      _isLoading = true;
    });
    _controller.clear();

    await Future.delayed(const Duration(milliseconds: 800));
    
    String response = _getResponse(message);
    
    setState(() {
      _messages.add({'role': 'assistant', 'content': response});
      _isLoading = false;
    });
  }

  String _getResponse(String message) {
    final lowerMsg = message.toLowerCase();
    if (lowerMsg.contains('مرحب') || lowerMsg.contains('السلام')) {
      return 'وعليكم السلام! 👋\nأهلاً بك في فلكس يمن. كيف可以帮助ك؟';
    }
    if (lowerMsg.contains('منتج') || lowerMsg.contains('متجر')) {
      return '🛍️ يمكنك تصفح المنتجات من الصفحة الرئيسية أو من قسم "المتاجر". هل تبحث عن شيء محدد؟';
    }
    if (lowerMsg.contains('طلب') || lowerMsg.contains('تتبع')) {
      return '📦 يمكنك تتبع طلباتك من قسم "طلباتي" في الملف الشخصي.';
    }
    if (lowerMsg.contains('دفع') || lowerMsg.contains('سلة')) {
      return '💳 طرق الدفع المتاحة:\n• الدفع عند الاستلام\n• بطاقات الائتمان\n• المحافظ الإلكترونية (كاش، جوالي، جيب)';
    }
    if (lowerMsg.contains('توصيل') || lowerMsg.contains('شحن')) {
      return '🚚 خدمة التوصيل تغطي جميع محافظات اليمن خلال 24-48 ساعة. للطلبات فوق 200,000 ريال التوصيل مجاني!';
    }
    if (lowerMsg.contains('في آي بي') || lowerMsg.contains('vip')) {
      return '👑 برنامج VIP يمنحك خصم 25% إضافي وشحن مجاني! سجل الآن من ملفك الشخصي.';
    }
    return 'شكراً لسؤالك! 😊\nيمكنك مراسلة الدعم الفني على الرقم 777123456 للمساعدة الفورية.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: AppTheme.goldGradient,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.smart_toy, color: Colors.black, size: 18),
              ),
            ),
            const SizedBox(width: 8),
            const Text('مساعد فلكس الذكي', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: AppTheme.binanceDark,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppTheme.binanceGold),
            onPressed: () {
              setState(() {
                _messages.clear();
                _messages.add({
                  'role': 'assistant',
                  'content': 'مرحباً! 👋\nأنا مساعد فلكس الذكي. كيف يمكنني مساعدتك اليوم؟'
                });
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _suggestions.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => _sendMessage(_suggestions[index]),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.binanceCard,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.binanceBorder),
                  ),
                  child: Text(
                    _suggestions[index],
                    style: const TextStyle(color: AppTheme.binanceGold, fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[_messages.length - 1 - index];
                final isUser = msg['role'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      gradient: isUser ? AppTheme.goldGradient : null,
                      color: isUser ? null : AppTheme.binanceCard,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      msg['content']!,
                      style: TextStyle(color: isUser ? Colors.black : Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(color: AppTheme.binanceGold),
            ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.binanceCard,
              border: Border(top: BorderSide(color: AppTheme.binanceBorder)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'اكتب سؤالك هنا...',
                      hintStyle: const TextStyle(color: Color(0xFF5E6673)),
                      filled: true,
                      fillColor: AppTheme.binanceDark,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(_controller.text),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _sendMessage(_controller.text),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: AppTheme.goldGradient,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
