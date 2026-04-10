import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
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
    _listenForNewMessages();
  }

  Future<void> _loadConversations() async {
    if (_currentUserId == null) return;

    final response = await _supabase
        .from('conversations')
        .select('''
          *,
          user1:profiles!conversations_user1_id_fkey(id, name, avatar_url),
          user2:profiles!conversations_user2_id_fkey(id, name, avatar_url)
        ''')
        .or('user1_id.eq.$_currentUserId,user2_id.eq.$_currentUserId')
        .order('updated_at', ascending: false);

    setState(() {
      _conversations = List<Map<String, dynamic>>.from(response);
      _isLoading = false;
    });
  }

  void _listenForNewMessages() {
    if (_currentUserId == null) return;

    _supabase
        .channel('messages')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'messages',
          callback: (payload) {
            _loadConversations();
          },
        )
        .subscribe();
  }

  Future<void> _startNewChat() async {
    final users = await _supabase
        .from('profiles')
        .select('id, name, avatar_url')
        .neq('id', _currentUserId);
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('اختر مستخدم للدردشة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...users.map((user) => ListTile(
              leading: CircleAvatar(
                backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                child: Text(user['name'][0], style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              title: Text(user['name']),
              onTap: () async {
                Navigator.pop(context);
                await _createConversation(user['id']);
              },
            )),
          ],
        ),
      ),
    );
  }

  Future<void> _createConversation(String otherUserId) async {
    if (_currentUserId == null) return;

    // التحقق من وجود محادثة سابقة
    final existing = await _supabase
        .from('conversations')
        .select()
        .or('and(user1_id.eq.$_currentUserId,user2_id.eq.$otherUserId),and(user1_id.eq.$otherUserId,user2_id.eq.$_currentUserId)')
        .maybeSingle();

    if (existing != null) {
      _openConversation(existing['id'], otherUserId);
      return;
    }

    // إنشاء محادثة جديدة
    final response = await _supabase.from('conversations').insert({
      'user1_id': _currentUserId,
      'user2_id': otherUserId,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    }).select();

    if (response.isNotEmpty) {
      _openConversation(response[0]['id'], otherUserId);
    }
  }

  void _openConversation(String conversationId, String otherUserId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatDetailScreen(
          conversationId: conversationId,
          otherUserId: otherUserId,
        ),
      ),
    ).then((_) => _loadConversations());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(
        title: 'المحادثات',
        actions: [
          IconButton(
            icon: const Icon(Icons.add_comment),
            onPressed: _startNewChat,
            tooltip: 'محادثة جديدة',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _conversations.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _conversations.length,
                  itemBuilder: (context, index) {
                    final conv = _conversations[index];
                    final otherUser = conv['user1_id'] == _currentUserId ? conv['user2'] : conv['user1'];
                    final lastMessage = conv['last_message'] ?? 'ابدأ المحادثة...';
                    final time = _formatTime(conv['updated_at']);
                    final unreadCount = conv['unread_count'] ?? 0;

                    return _buildConversationCard(
                      otherUser: otherUser,
                      lastMessage: lastMessage,
                      time: time,
                      unreadCount: unreadCount,
                      onTap: () => _openConversation(conv['id'], otherUser['id']),
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
          Icon(Icons.chat_bubble_outline, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          const Text('لا توجد محادثات', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          const Text('ابدأ محادثة جديدة', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _startNewChat,
            icon: const Icon(Icons.add),
            label: const Text('محادثة جديدة'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.goldColor,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationCard({
    required Map<String, dynamic> otherUser,
    required String lastMessage,
    required String time,
    required int unreadCount,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.getCardColor(context),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // صورة المستخدم
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                  child: otherUser['name']?.isNotEmpty == true
                      ? Text(
                          otherUser['name'][0],
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        )
                      : const Icon(Icons.person, size: 28),
                ),
                if (unreadCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$unreadCount',
                          style: const TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            // معلومات المحادثة
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    otherUser['name'] ?? 'مستخدم',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: unreadCount > 0 ? AppTheme.goldColor : Colors.grey,
                      fontWeight: unreadCount > 0 ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            // الوقت
            Text(
              time,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(String? dateTimeString) {
    if (dateTimeString == null) return '';
    final dateTime = DateTime.parse(dateTimeString);
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} يوم';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ساعة';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} دقيقة';
    } else {
      return 'الآن';
    }
  }
}
