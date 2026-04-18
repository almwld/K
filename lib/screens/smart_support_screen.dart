import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../services/chatbot_service.dart';
import 'live_support_screen.dart';

class SmartSupportScreen extends StatefulWidget {
  const SmartSupportScreen({super.key});

  @override
  State<SmartSupportScreen> createState() => _SmartSupportScreenState();
}

class _SmartSupportScreenState extends State<SmartSupportScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;
  
  // أسئلة مقترحة
  final List<String> _suggestedQuestions = [
    'كيف أضيف منتج؟',
    'كيف أشحن محفظتي؟',
    'متى يصل طلبي؟',
    'كيف أشارك في المزاد؟',
  ];
  
  @override
  void initState() {
    super.initState();
    _addWelcomeMessage();
  }
  
  void _addWelcomeMessage() {
    _messages.add({
      'sender': 'bot',
      'message': '👋 مرحباً! أنا مساعد Flex Yemen الذكي.\n\n'
          'يمكنني مساعدتك في:\n'
          '• إنشاء حساب وتعديل البيانات\n'
          '• إضافة منتجات وإعلانات\n'
          '• الشحن والتوصيل والتتبع\n'
          '• المزادات والدفع\n'
          '• المحفظة والسحب والإيداع\n\n'
          'اكتب سؤالك وسأجيبك فوراً!',
      'time': _getCurrentTime(),
    });
  }
  
  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
  
  void _sendMessage(String message) async {
    if (message.trim().isEmpty) return;
    
    // إضافة رسالة المستخدم
    setState(() {
      _messages.add({
        'sender': 'user',
        'message': message,
        'time': _getCurrentTime(),
      });
      _messageController.clear();
    });
    _scrollToBottom();
    
    // محاكاة كتابة البوت
    setState(() => _isTyping = true);
    await Future.delayed(const Duration(milliseconds: 800));
    
    // الحصول على رد البوت
    final botResponse = ChatbotService.getResponse(message);
    
    setState(() => _isTyping = false);
    
    if (botResponse != null) {
      setState(() {
        _messages.add({
          'sender': 'bot',
          'message': botResponse,
          'time': _getCurrentTime(),
        });
      });
    } else {
      // إذا لم يجد البوت إجابة، عرض خيار التحويل لموظف
      setState(() {
        _messages.add({
          'sender': 'bot',
          'message': '🙏 عذراً، لم أتمكن من الإجابة على سؤالك.\n\n'
              'هل تريد التحدث مع أحد موظفي الدعم المباشر؟',
          'time': _getCurrentTime(),
          'showTransferButton': true,
        });
      });
    }
    _scrollToBottom();
  }
  
  void _transferToHuman() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LiveSupportScreen()),
    );
  }
  
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(
        title: 'الدعم الذكي',
        actions: [
          IconButton(
            icon: const Icon(Icons.headset_mic),
            onPressed: _transferToHuman,
            tooltip: 'تحدث مع موظف',
          ),
        ],
      ),
      body: Column(
        children: [
          // حالة البوت
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: AppTheme.gold.withOpacity(0.1),
            child: Row(
              children: [
                Container(
                  width: 8, height: 8,
                  decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                const Text('متصل', style: TextStyle(fontSize: 12)),
                const Spacer(),
                const Icon(Icons.smart_toy, size: 16, color: AppTheme.gold),
                const SizedBox(width: 4),
                const Text('مساعد ذكي', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          
          // منطقة الرسائل
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return _buildTypingIndicator();
                }
                final message = _messages[index];
                final isUser = message['sender'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        decoration: BoxDecoration(
                          color: isUser ? AppTheme.gold : Theme.of(context).cardColor,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(12),
                            topRight: const Radius.circular(12),
                            bottomLeft: isUser ? const Radius.circular(12) : Radius.zero,
                            bottomRight: isUser ? Radius.zero : const Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          message['message'],
                          style: TextStyle(
                            color: isUser ? Colors.black : AppTheme.getTextColor(context),
                          ),
                        ),
                      ),
                      if (message['showTransferButton'] == true)
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 8),
                          child: ElevatedButton.icon(
                            onPressed: _transferToHuman,
                            icon: const Icon(Icons.support_agent),
                            label: const Text('تحدث مع موظف دعم'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.gold,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                        child: Text(
                          message['time'],
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          // الأسئلة المقترحة
          if (_messages.length <= 2)
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('أسئلة مقترحة:', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _suggestedQuestions.map((question) {
                      return ActionChip(
                        label: Text(question),
                        onPressed: () => _sendMessage(question),
                        backgroundColor: AppTheme.gold.withOpacity(0.1),
                        labelStyle: const TextStyle(fontSize: 12),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          
          // حقل إدخال الرسالة
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(top: BorderSide(color: AppTheme.getDividerColor(context))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'اكتب سؤالك هنا...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: isDark ? AppTheme.nightCard : Colors.grey[100],
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.gold,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.black),
                    onPressed: () => _sendMessage(_messageController.text),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(
              width: 8, height: 8,
              child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.gold),
            ),
            SizedBox(width: 4),
            SizedBox(
              width: 8, height: 8,
              child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.gold),
            ),
            SizedBox(width: 4),
            SizedBox(
              width: 8, height: 8,
              child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.gold),
            ),
          ],
        ),
      ),
    );
  }
}
