import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/chat_service.dart';
import '../../models/chat_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import 'chat_detail_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatService _chatService;
  List<ConversationModel> _conversations = [];

  @override
  void initState() {
    super.initState();
    _chatService = context.read<ChatService>();
    _chatService.initialize();
    _chatService.conversationsStream.listen((conversations) {
      if (mounted) setState(() => _conversations = conversations);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const SimpleAppBar(title: 'المحادثات'),
      body: _conversations.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text('لا توجد محادثات', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _conversations.length,
              itemBuilder: (context, index) {
                final conv = _conversations[index];
                return ListTile(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatDetailScreen(conversation: conv))),
                  leading: CircleAvatar(backgroundImage: NetworkImage(conv.merchantAvatar)),
                  title: Text(conv.merchantName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(conv.lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis),
                  trailing: conv.unreadCount > 0
                      ? CircleAvatar(radius: 12, backgroundColor: Colors.red, child: Text('${conv.unreadCount}', style: const TextStyle(color: Colors.white, fontSize: 10)))
                      : null,
                );
              },
            ),
    );
  }
}
