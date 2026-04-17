import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../services/ai_chat_service.dart';
import '../models/product_model.dart';

class AIChatAssistant extends StatefulWidget {
  final ProductModel? product;
  final String? sellerId;
  final String? sellerName;
  
  const AIChatAssistant({
    super.key,
    this.product,
    this.sellerId,
    this.sellerName,
  });

  @override
  State<AIChatAssistant> createState() => _AIChatAssistantState();
}

class _AIChatAssistantState extends State<AIChatAssistant> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;
  bool _isTransferring = false;
  
  @override
  void initState() {
    super.initState();
    _addWelcomeMessage();
  }
  
  void _addWelcomeMessage() {
    _messages.add({
      'sender': 'ai',
      'message': '🤖 مرحباً! أنا مساعد Flex Yemen الذكي.\n\n'
          'يمكنني مساعدتك في:\n'
          '• الاستفسار عن المنتجات والتوفر\n'
          '• معرفة الأسعار والضمان\n'
          '• معلومات الشحن والتوصيل\n'
          '• طرق الدفع والاسترجاع\n\n'
          '${widget.product != null ? "المنتج: ${widget.product!.title}\n" : ""}'
          'كيف يمكنني مساعدتك اليوم؟',
      'time': _getCurrentTime(),
    });
  }
  
  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
  
  Future<void> _sendMessage(String message) async {
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
    
    // محاكاة كتابة AI
    setState(() => _isTyping = true);
    await Future.delayed(const Duration(milliseconds: 800));
    
    // الحصول على رد AI
    final aiResponse = await AIChatService.getAIResponse(
      message,
      productTitle: widget.product?.title,
      productPrice: widget.product?.price,
    );
    
    setState(() => _isTyping = false);
    
    if (aiResponse != null) {
      setState(() {
        _messages.add({
          'sender': 'ai',
          'message': aiResponse,
          'time': _getCurrentTime(),
        });
      });
    } else {
      // عرض خيار التحويل للتاجر
      setState(() {
        _messages.add({
          'sender': 'ai',
          'message': '🙏 عذراً، لم أتمكن من الإجابة على سؤالك بدقة.\n\n'
              'هل تريد التواصل مباشرة مع ${widget.sellerName ?? "التاجر"} للحصول على إجابة دقيقة؟',
          'time': _getCurrentTime(),
          'showTransferButton': true,
        });
      });
    }
    _scrollToBottom();
  }
  
  void _transferToSeller() {
    setState(() => _isTransferring = true);
    
    // إضافة رسالة تحويل
    setState(() {
      _messages.add({
        'sender': 'system',
        'message': '🔄 جاري تحويل المحادثة إلى ${widget.sellerName ?? "التاجر"}...',
        'time': _getCurrentTime(),
      });
    });
    
    // محاكاة اتصال التاجر
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _messages.add({
          'sender': 'seller',
          'message': '👋 مرحباً! أنا ${widget.sellerName ?? "التاجر"}. كيف يمكنني مساعدتك؟',
          'time': _getCurrentTime(),
        });
      });
      _scrollToBottom();
    });
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
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(
        title: widget.product != null ? 'AI مساعد' : 'AI الدعم الذكي',
        actions: [
          if (!_isTransferring)
            IconButton(
              icon: const Icon(Icons.headset_mic),
              onPressed: _transferToSeller,
              tooltip: 'تحدث مع التاجر',
            ),
        ],
      ),
      body: Column(
        children: [
          // معلومات المنتج (إذا وجد)
          if (widget.product != null)
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.getCardColor(context),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.goldPrimary.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(
                      color: AppTheme.goldPrimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.image, color: AppTheme.goldPrimary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.product!.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('${widget.product!.price.toStringAsFixed(0)} ر.ي', style: const TextStyle(color: AppTheme.goldPrimary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          
          // حالة AI
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: AppTheme.goldPrimary.withOpacity(0.1),
            child: Row(
              children: [
                Container(
                  width: 8, height: 8,
                  decoration: BoxDecoration(
                    color: _isTransferring ? Colors.orange : Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _isTransferring ? 'متصل مع التاجر' : 'AI مساعد نشط',
                  style: const TextStyle(fontSize: 12),
                ),
                const Spacer(),
                if (!_isTransferring) ...[
                  const Icon(Icons.bolt, size: 16, color: AppTheme.goldPrimary),
                  const SizedBox(width: 4),
                  const Text('ذكي', style: TextStyle(fontSize: 12)),
                ],
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
                final isAI = message['sender'] == 'ai';
                final isSeller = message['sender'] == 'seller';
                final isSystem = message['sender'] == 'system';
                
                Color bgColor;
                
                if (isUser) {
                  bgColor = AppTheme.goldPrimary;
                } else if (isAI) {
                  bgColor = AppTheme.getCardColor(context);
                } else if (isSeller) {
                  bgColor = Colors.green.withOpacity(0.1);
                } else {
                  bgColor = Colors.orange.withOpacity(0.1);
                }
                
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
                          color: bgColor,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(12),
                            topRight: const Radius.circular(12),
                            bottomLeft: isUser ? const Radius.circular(12) : Radius.zero,
                            bottomRight: isUser ? Radius.zero : const Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isAI)
                              const Row(
                                children: [
                                  Icon(Icons.bolt, size: 12, color: AppTheme.goldPrimary),
                                  SizedBox(width: 4),
                                  Text('AI Assistant', style: TextStyle(fontSize: 10)),
                                ],
                              ),
                            if (isSeller)
                              const Row(
                                children: [
                                  Icon(Icons.store, size: 12, color: Colors.green),
                                  SizedBox(width: 4),
                                  Text('التاجر', style: TextStyle(fontSize: 10)),
                                ],
                              ),
                            Text(
                              message['message'],
                              style: TextStyle(
                                color: isUser ? Colors.black : AppTheme.getTextColor(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (message['showTransferButton'] == true)
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 8),
                          child: ElevatedButton.icon(
                            onPressed: _transferToSeller,
                            icon: const Icon(Icons.support_agent),
                            label: const Text('تحدث مع التاجر'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.goldPrimary,
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
          
          // الأسئلة المقترحة (قبل بدء المحادثة)
          if (_messages.length <= 2 && !_isTransferring)
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
                    children: AIChatService.getSuggestedQuestions().map((question) {
                      return ActionChip(
                        label: Text(question),
                        onPressed: () => _sendMessage(question),
                        backgroundColor: AppTheme.goldPrimary.withOpacity(0.1),
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
              color: AppTheme.getCardColor(context),
              border: Border(top: BorderSide(color: AppTheme.getDividerColor(context))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: _isTransferring ? 'اكتب رسالتك للتاجر...' : 'اسأل AI assistant...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: isDark ? AppTheme.darkCard : Colors.grey[100],
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.goldPrimary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(_isTransferring ? Icons.send : Icons.bolt, color: Colors.black),
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
          color: AppTheme.getCardColor(context),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(
              width: 8, height: 8,
              child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.goldPrimary),
            ),
            SizedBox(width: 4),
            SizedBox(
              width: 8, height: 8,
              child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.goldPrimary),
            ),
            SizedBox(width: 4),
            SizedBox(
              width: 8, height: 8,
              child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.goldPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
