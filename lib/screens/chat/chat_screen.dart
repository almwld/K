import 'package:flutter/material.dart';
import '../../services/chat_service.dart';
import '../../models/conversation_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import 'chat_detail_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();
  List<ConversationModel> _conversations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  Future<void> _loadConversations() async {
    await _chatService.init();
    setState(() {
      _conversations = [
        ConversationModel(id: '1', name: 'الدعم الفني', lastMessage: 'كيف يمكنني مساعدتك؟', time: 'الآن', unreadCount: 0, avatar: '🛠️', isOnline: true),
        ConversationModel(id: '2', name: 'فريق المبيعات', lastMessage: 'لدينا عرض خاص اليوم على الإلكترونيات', time: 'منذ ساعة', unreadCount: 2, avatar: '🛒', isOnline: true),
        ConversationModel(id: '3', name: 'خدمة العملاء', lastMessage: 'شكراً لتواصلك مع فلكس يمن', time: 'أمس', unreadCount: 0, avatar: '📞', isOnline: false),
        ConversationModel(id: '4', name: 'المساعد الذكي', lastMessage: 'مرحباً! أنا هنا لمساعدتك', time: 'منذ يومين', unreadCount: 0, avatar: '🤖', isOnline: true),
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المحادثات'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.goldColor))
          : _conversations.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline, size: 80, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text('لا توجد محادثات', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                      const SizedBox(height: 8),
                      TextButton(onPressed: _loadConversations, child: const Text('تحديث')),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _conversations.length,
                  itemBuilder: (context, index) {
                    final conv = _conversations[index];
                    return _buildConversationTile(conv);
                  },
                ),
    );
  }

  Widget _buildConversationTile(ConversationModel conv) {
    return ListTile(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatDetailScreen(conversationId: conv.id, userName: conv.name))),
      leading: Stack(
        children: [
          CircleAvatar(backgroundColor: AppTheme.goldColor.withOpacity(0.2), radius: 25, child: Text(conv.avatar, style: const TextStyle(fontSize: 20))),
          if (conv.isOnline)
            Positioned(bottom: 0, right: 0, child: Container(width: 12, height: 12, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)))),
        ],
      ),
      title: Row(
        children: [
          Expanded(child: Text(conv.name, style: const TextStyle(fontWeight: FontWeight.bold))),
          Text(conv.time, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
        ],
      ),
      subtitle: Text(conv.lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: conv.unreadCount > 0
          ? Container(padding: const EdgeInsets.all(6), decoration: const BoxDecoration(color: AppTheme.goldColor, shape: BoxShape.circle), child: Text('${conv.unreadCount}', style: const TextStyle(color: Colors.white, fontSize: 12)))
          : null,
    );
  }
}
