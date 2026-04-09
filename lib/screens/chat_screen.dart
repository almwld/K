import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/chat_service.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'chat_detail_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark 
          ? AppTheme.darkBackground 
          : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المحادثات'),
      body: chatService.isLoading
          ? const Center(child: CircularProgressIndicator())
          : chatService.conversations.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text('لا توجد محادثات', style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text('ابدأ محادثة جديدة', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: chatService.conversations.length,
                  itemBuilder: (context, index) {
                    final conv = chatService.conversations[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatDetailScreen(conversationId: conv.id, otherUserId: conv.userId, otherUserName: conv.userName),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.getCardColor(context),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                              child: Text(
                                conv.userName.isNotEmpty ? conv.userName[0] : '?',
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    conv.userName,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    conv.lastMessage,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: conv.unreadCount > 0 ? AppTheme.goldColor : Colors.grey,
                                      fontWeight: conv.unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  _formatTime(conv.lastMessageTime),
                                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                                ),
                                if (conv.unreadCount > 0)
                                  Container(
                                    margin: const EdgeInsets.only(top: 4),
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: AppTheme.goldColor,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                                    child: Text(
                                      '${conv.unreadCount}',
                                      style: const TextStyle(color: Colors.black, fontSize: 10),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inDays > 0) return '${diff.inDays}ي';
    if (diff.inHours > 0) return '${diff.inHours}س';
    if (diff.inMinutes > 0) return '${diff.inMinutes}د';
    return 'الآن';
  }
}
