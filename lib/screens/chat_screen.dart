import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  final List<Map<String, dynamic>> _chats = const [
    {'id': '1', 'name': 'أحمد محمد', 'message': 'مرحباً، هل المنتج متوفر؟', 'time': '10:30', 'unread': 2, 'avatar': null},
    {'id': '2', 'name': 'متجر التقنية', 'message': 'تم تأكيد طلبك', 'time': '09:15', 'unread': 0, 'avatar': null},
    {'id': '3', 'name': 'فاطمة علي', 'message': 'شكراً لك!', 'time': 'أمس', 'unread': 0, 'avatar': null},
    {'id': '4', 'name': 'دعم فلكس', 'message': 'كيف يمكننا مساعدتك؟', 'time': 'أمس', 'unread': 1, 'avatar': null},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الدردشة'),
      body: _chats.isEmpty
          ? _buildEmptyChat(context)
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                final chat = _chats[index];
                return _buildChatItem(context, chat);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.goldColor,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildEmptyChat(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 100,
            color: AppTheme.goldColor.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'لا توجد محادثات',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.getTextColor(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'ابدأ محادثة مع البائعين',
            style: TextStyle(
              color: AppTheme.getSecondaryTextColor(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, Map<String, dynamic> chat) {
    final unreadCount = chat['unread'] as int;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: AppTheme.goldColor.withOpacity(0.2),
          child: chat['avatar'] != null
              ? ClipOval(child: Image.network(chat['avatar']))
              : const Icon(Icons.person, color: AppTheme.goldColor),
        ),
        title: Text(
          chat['name'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.getTextColor(context),
          ),
        ),
        subtitle: Text(
          chat['message'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppTheme.getSecondaryTextColor(context),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              chat['time'],
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.getSecondaryTextColor(context),
              ),
            ),
            if (unreadCount > 0) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.goldColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$unreadCount',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        onTap: () => Navigator.pushNamed(context, '/chat_detail'),
      ),
    );
  }
}
