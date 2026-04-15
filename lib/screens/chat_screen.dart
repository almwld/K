import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'chat_detail_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _conversations = [];
  bool _isLoading = true;
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _currentUserId = _supabase.auth.currentUser?.id;
    _loadConversations();
  }

  Future<void> _loadConversations() async {
    if (_currentUserId == null) return;

    final response = await _supabase
        .from('conversations')
        .select('*, user1:user1_id(id, name), user2:user2_id(id, name)')
        .or('user1_id.eq.$_currentUserId,user2_id.eq.$_currentUserId')
        .order('updated_at', ascending: false);

    setState(() {
      _conversations = List<Map<String, dynamic>>.from(response);
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
          ? const Center(child: CircularProgressIndicator())
          : _conversations.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text('لا توجد محادثات', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _conversations.length,
                  itemBuilder: (context, index) {
                    final conv = _conversations[index];
                    final otherUser = conv['user1_id'] == _currentUserId ? conv['user2'] : conv['user1'];
                    return ListTile(
                      leading: CircleAvatar(child: Text(otherUser['name'][0])),
                      title: Text(otherUser['name']),
                      subtitle: Text(conv['last_message'] ?? 'ابدأ المحادثة'),
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
                    );
                  },
                ),
    );
  }
}
