import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../theme/app_theme.dart';
import '../services/chat_service.dart';
import '../widgets/simple_app_bar.dart';
import 'chat_detail_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _users = [];
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _currentUserId = _supabase.auth.currentUser?.id;
    _loadUsers();
    context.read<ChatService>().loadConversations();
  }

  Future<void> _loadUsers() async {
    final response = await _supabase
        .from('profiles')
        .select('id, name, avatar_url')
        .neq("id", _currentUserId ?? "");
    setState(() => _users = List<Map<String, dynamic>>.from(response));
  }

  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(
        title: 'المحادثات',
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.add_comment),
            itemBuilder: (context) => _users.map((user) {
              return PopupMenuItem(
                value: user,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      child: Text(user['name'][0]),
                    ),
                    const SizedBox(width: 12),
                    Text(user['name']),
                  ],
                ),
              );
            }).toList(),
            onSelected: (user) async {
              await chatService.createConversation(user['id']);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatDetailScreen(
                    conversationId: chatService.currentConversationId ?? "" ?? '',
                    otherUserId: user['id'],
                    otherUserName: user['name'],
                  ),
                ),
              );
            },
          ),
        ],
      ),
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
                      const Text('ابدأ محادثة جديدة', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: chatService.conversations.length,
                  itemBuilder: (context, index) {
                    final conv = chatService.conversations[index];
                    final otherUser = conv['user1_id'] == _currentUserId ? conv['user2'] : conv['user1'];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatDetailScreen(
                              conversationId: conv['id'],
                              otherUserId: otherUser['id'],
                              otherUserName: otherUser['name'],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.getCardColor(context),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              child: Text(otherUser['name'][0]),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    otherUser['name'],
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    conv['last_message'] ?? 'ابدأ المحادثة',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              _formatTime(conv['updated_at']),
                              style: const TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  String _formatTime(String? dateTimeString) {
    if (dateTimeString == null) return '';
    final dateTime = DateTime.parse(dateTimeString);
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) return '${difference.inDays} ي';
    if (difference.inHours > 0) return '${difference.inHours} س';
    if (difference.inMinutes > 0) return '${difference.inMinutes} د';
    return 'الآن';
  }
}
