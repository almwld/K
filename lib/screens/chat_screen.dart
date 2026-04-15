import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/chat_service.dart';
import '../models/conversation_model.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'chat_detail_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatService>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chatService = context.watch<ChatService>();

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المحادثات'),
      body: StreamBuilder<List<ConversationModel>>(
        stream: chatService.conversationsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppTheme.goldColor));
          }
          
          final conversations = snapshot.data ?? [];
          
          if (conversations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text('لا توجد محادثات', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              final conv = conversations[index];
              return _buildConversationTile(conv);
            },
          );
        },
      ),
    );
  }

  Widget _buildConversationTile(ConversationModel conv) {
    return ListTile(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatDetailScreen(conversationId: conv.id, userName: conv.name),
        ),
      ),
      leading: Stack(
        children: [
          CircleAvatar(
            backgroundColor: AppTheme.goldColor.withOpacity(0.2),
            radius: 25,
            child: Text(conv.avatar, style: const TextStyle(fontSize: 20)),
          ),
          if (conv.isOnline)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
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
          ? Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(color: AppTheme.goldColor, shape: BoxShape.circle),
              child: Text('${conv.unreadCount}', style: const TextStyle(color: Colors.white, fontSize: 12)),
            )
          : null,
    );
  }
}
