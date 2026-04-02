import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../providers/auth_provider.dart';
import 'chat_detail_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // محادثات وهمية للعرض
  final List<Map<String, dynamic>> _chats = [
    {
      'id': '1',
      'name': 'أحمد محمد',
      'avatar': null,
      'lastMessage': 'مرحباً، هل المنتج متوفر؟',
      'time': '10:30',
      'unread': 2,
      'online': true,
    },
    {
      'id': '2',
      'name': 'متجر التقنية',
      'avatar': null,
      'lastMessage': 'تم تأكيد طلبك رقم #1234',
      'time': '09:15',
      'unread': 0,
      'online': false,
    },
    {
      'id': '3',
      'name': 'فاطمة علي',
      'avatar': null,
      'lastMessage': 'شكراً لك!',
      'time': 'أمس',
      'unread': 0,
      'online': true,
    },
    {
      'id': '4',
      'name': 'دعم فلكس',
      'avatar': null,
      'lastMessage': 'كيف يمكننا مساعدتك؟',
      'time': 'أمس',
      'unread': 1,
      'online': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المحادثات'),
      body: _chats.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline, size: 80, color: AppTheme.goldColor.withOpacity(0.5)),
                  const SizedBox(height: 16),
                  const Text('لا توجد محادثات', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('ابدأ محادثة مع البائعين', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/all_ads'),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black),
                    child: const Text('تصفح المنتجات'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                final chat = _chats[index];
                final hasUnread = chat['unread'] > 0;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.getCardColor(context),
                    borderRadius: BorderRadius.circular(16),
                    border: hasUnread ? Border.all(color: AppTheme.goldColor, width: 1.5) : null,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: Stack(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                          child: Text(
                            chat['name'][0],
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.goldColor),
                          ),
                        ),
                        if (chat['online'])
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 12, height: 12,
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
                        Expanded(
                          child: Text(
                            chat['name'],
                            style: TextStyle(
                              fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
                              color: AppTheme.getTextColor(context),
                            ),
                          ),
                        ),
                        Text(
                          chat['time'],
                          style: TextStyle(fontSize: 11, color: AppTheme.getSecondaryTextColor(context)),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Expanded(
                          child: Text(
                            chat['lastMessage'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: hasUnread ? AppTheme.goldColor : AppTheme.getSecondaryTextColor(context),
                              fontWeight: hasUnread ? FontWeight.w500 : FontWeight.normal,
                            ),
                          ),
                        ),
                        if (hasUnread)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.goldColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${chat['unread']}',
                              style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatDetailScreen(chat: chat),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
