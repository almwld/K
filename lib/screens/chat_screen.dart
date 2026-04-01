import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../services/chat_service.dart';
import '../providers/auth_provider.dart';
import '../models/chat_model.dart';
import 'chat_detail_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();
  List<ChatModel> _chats = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  Future<void> _loadChats() async {
    setState(() => _isLoading = true);
    final userId = context.read<AuthProvider>().userData?.id ?? 'guest';
    final chats = await _chatService.getUserChats(userId);
    setState(() {
      _chats = chats;
      _isLoading = false;
    });
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inDays > 0) return '${diff.inDays} يوم';
    if (diff.inHours > 0) return '${diff.inHours} ساعة';
    if (diff.inMinutes > 0) return '${diff.inMinutes} دقيقة';
    return 'الآن';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentUserId = context.read<AuthProvider>().userData?.id ?? 'guest';

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المحادثات'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _chats.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _chats.length,
                  itemBuilder: (context, index) {
                    final chat = _chats[index];
                    final otherName = chat.getOtherUserName(currentUserId);
                    final otherAvatar = chat.getOtherUserAvatar(currentUserId);
                    final hasUnread = chat.unreadCount > 0;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatDetailScreen(chat: chat),
                          ),
                        ).then((_) => _loadChats());
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.getCardColor(context),
                          borderRadius: BorderRadius.circular(16),
                          border: hasUnread
                              ? Border.all(color: AppTheme.goldColor, width: 1.5)
                              : null,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                              backgroundImage: otherAvatar != null
                                  ? NetworkImage(otherAvatar)
                                  : null,
                              child: otherAvatar == null
                                  ? Text(
                                      otherName.isNotEmpty ? otherName[0] : 'م',
                                      style: const TextStyle(fontSize: 20),
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          otherName,
                                          style: TextStyle(
                                            fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
                                            color: AppTheme.getTextColor(context),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        _formatTime(chat.lastMessageTime),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: AppTheme.getSecondaryTextColor(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          chat.lastMessage.isEmpty ? 'ابدأ المحادثة' : chat.lastMessage,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: hasUnread
                                                ? AppTheme.goldColor
                                                : AppTheme.getSecondaryTextColor(context),
                                            fontWeight: hasUnread ? FontWeight.w500 : FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      if (hasUnread)
                                        Container(
                                          margin: const EdgeInsets.only(left: 8),
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            color: AppTheme.goldColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            '${chat.unreadCount}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 80,
            color: AppTheme.goldColor.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'لا توجد محادثات',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'ابدأ محادثة مع البائعين',
            style: TextStyle(color: AppTheme.getSecondaryTextColor(context)),
          ),
        ],
      ),
    );
  }
}
