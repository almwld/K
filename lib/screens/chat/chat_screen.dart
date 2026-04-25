import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/chat_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  final List<ChatModel> _allChats = [
    ChatModel(id: '1', name: 'متجر التقنية', type: ChatType.store, lastMessage: 'مرحباً، هل المنتج متوفر؟', lastMessageTime: DateTime.now().subtract(const Duration(minutes: 30)), unreadCount: 2, isPinned: true, isOnline: true, avatar: Icons.store, avatarColor: const Color(0xFFF0B90B), lastMessageIsMine: false),
    ChatModel(id: '2', name: 'أحمد محمد', type: ChatType.user, lastMessage: 'شكراً على المنتج، وصلني بحالة ممتازة', lastMessageTime: DateTime.now().subtract(const Duration(days: 1)), unreadCount: 0, isPinned: false, isOnline: false, avatar: Icons.person, avatarColor: Colors.blue, lastMessageIsMine: false),
    ChatModel(id: '3', name: 'عروض فلكس', type: ChatType.broadcast, lastMessage: 'عرض خاص: خصم 30% على جميع المنتجات', lastMessageTime: DateTime.now().subtract(const Duration(days: 1)), unreadCount: 0, isPinned: false, isOnline: true, avatar: Icons.local_offer, avatarColor: const Color(0xFFF0B90B), lastMessageIsMine: false),
    ChatModel(id: '4', name: 'مجموعة فلكس', type: ChatType.group, lastMessage: 'أهلاً بك في المجموعة!', lastMessageTime: DateTime.now().subtract(const Duration(days: 2)), unreadCount: 8, isPinned: false, isOnline: false, avatar: Icons.group, avatarColor: Colors.purple, lastMessageIsMine: false),
    ChatModel(id: '5', name: 'مساعد فلكس الذكي', type: ChatType.ai, lastMessage: 'كيف يمكنني مساعدتك اليوم؟', lastMessageTime: DateTime.now(), unreadCount: 0, isPinned: true, isOnline: true, avatar: Icons.smart_toy, avatarColor: const Color(0xFFF0B90B), lastMessageIsMine: false),
  ];

  List<ChatModel> get _unreadChats => _allChats.where((c) => c.unreadCount > 0).toList();
  List<ChatModel> get _groupChats => _allChats.where((c) => c.type == ChatType.group).toList();

  List<ChatModel> get _filteredChats {
    var chats = _tabController.index == 0 ? _allChats : _tabController.index == 1 ? _unreadChats : _groupChats;
    if (_searchQuery.isNotEmpty) {
      chats = chats.where((c) => c.name.contains(_searchQuery) || c.lastMessage.contains(_searchQuery)).toList();
    }
    chats.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return b.lastMessageTime.compareTo(a.lastMessageTime);
    });
    return chats;
  }

  @override
  void initState() { super.initState(); _tabController = TabController(length: 3, vsync: this); }
  @override
  void dispose() { _tabController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        title: const Text('الدردشة', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.search, color: Color(0xFFF0B90B)), onPressed: () {}),
          PopupMenuButton(icon: const Icon(Icons.more_vert, color: Color(0xFFF0B90B)), color: const Color(0xFF1E2329), itemBuilder: (_) => [const PopupMenuItem(value: 'archive', child: Text('الأرشيف', style: TextStyle(color: Colors.white))), const PopupMenuItem(value: 'settings', child: Text('إعدادات الدردشة', style: TextStyle(color: Colors.white)))], onSelected: (_) {}),
        ],
      ),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(16), child: TextField(
            onChanged: (v) => setState(() => _searchQuery = v),
            decoration: InputDecoration(hintText: 'ابحث عن محادثة...', hintStyle: const TextStyle(color: Color(0xFF5E6673)), prefixIcon: const Icon(Icons.search, color: Color(0xFFF0B90B)), filled: true, fillColor: const Color(0xFF1E2329), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)),
            style: const TextStyle(color: Colors.white),
          )),
          Container(padding: const EdgeInsets.symmetric(horizontal: 16), child: TabBar(controller: _tabController, indicatorColor: const Color(0xFFF0B90B), labelColor: const Color(0xFFF0B90B), unselectedLabelColor: const Color(0xFF9CA3AF), onTap: (_) => setState(() {}), tabs: [Tab(text: 'جميع (${_allChats.length})'), Tab(text: 'غير مقروء (${_unreadChats.length})'), Tab(text: 'مجموعات (${_groupChats.length})')])),
          const SizedBox(height: 8),
          Expanded(
            child: _filteredChats.isEmpty
                ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.chat_bubble_outline, size: 64, color: const Color(0xFFF0B90B).withOpacity(0.3)), const SizedBox(height: 16), Text('لا توجد محادثات', style: TextStyle(color: const Color(0xFFF0B90B).withOpacity(0.5)))]))
                : ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: _filteredChats.length, itemBuilder: (_, i) => _buildChatCard(_filteredChats[i])),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => _showNewChatDialog(), backgroundColor: const Color(0xFFF0B90B), child: const Icon(Icons.chat_bubble_outline, color: Colors.black)),
    );
  }

  Widget _buildChatCard(ChatModel chat) {
    return Dismissible(
      key: Key(chat.id), direction: DismissDirection.endToStart,
      background: Container(margin: const EdgeInsets.only(bottom: 8), decoration: BoxDecoration(color: const Color(0xFFF6465D), borderRadius: BorderRadius.circular(16)), alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), child: const Icon(Icons.delete, color: Colors.white)),
      onDismissed: (_) { setState(() => _allChats.removeWhere((c) => c.id == chat.id)); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم حذف المحادثة'))); },
      child: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(16), border: Border.all(color: chat.unreadCount > 0 ? const Color(0xFFF0B90B).withOpacity(0.3) : const Color(0xFF2B3139))),
          child: Row(children: [
            Stack(children: [
              Container(width: 55, height: 55, decoration: BoxDecoration(shape: BoxShape.circle, color: chat.avatarColor.withOpacity(0.2)), child: Icon(chat.avatar, color: chat.avatarColor, size: 28)),
              if (chat.isOnline && chat.type != ChatType.ai) Positioned(bottom: 2, right: 2, child: Container(width: 12, height: 12, decoration: BoxDecoration(color: const Color(0xFF0ECB81), shape: BoxShape.circle, border: Border.all(color: const Color(0xFF1E2329), width: 2)))),
            ]),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [Expanded(child: Text(chat.name, style: TextStyle(color: Colors.white, fontWeight: chat.unreadCount > 0 ? FontWeight.bold : FontWeight.normal, fontSize: 15), maxLines: 1, overflow: TextOverflow.ellipsis)), Text(chat.formattedTime, style: const TextStyle(color: Color(0xFF5E6673), fontSize: 11))]),
              const SizedBox(height: 4),
              Row(children: [Expanded(child: Text(chat.lastMessage, style: TextStyle(color: chat.unreadCount > 0 ? Colors.white : const Color(0xFF9CA3AF), fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis)), if (chat.unreadCount > 0) Container(margin: const EdgeInsets.only(left: 8), padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: const Color(0xFFF6465D), borderRadius: BorderRadius.circular(12)), child: Text('${chat.unreadCount}', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)))]),
              const SizedBox(height: 4),
              if (chat.statusText.isNotEmpty) Text(chat.statusText, style: TextStyle(color: chat.statusColor, fontSize: 10)),
            ])),
            if (chat.isPinned) Padding(padding: const EdgeInsets.only(left: 8), child: Icon(Icons.push_pin, color: const Color(0xFFF0B90B), size: 16)),
          ]),
        ),
      ),
    );
  }

  void _showNewChatDialog() {
    showModalBottomSheet(
      context: context, backgroundColor: const Color(0xFF1E2329),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(padding: const EdgeInsets.all(20), child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 40, height: 4, decoration: BoxDecoration(color: const Color(0xFF2B3139), borderRadius: BorderRadius.circular(2))),
        const SizedBox(height: 20), const Text('بدء محادثة جديدة', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        TextField(autofocus: true, decoration: InputDecoration(hintText: 'ابحث عن مستخدم أو متجر...', prefixIcon: const Icon(Icons.search, color: Color(0xFFF0B90B)), filled: true, fillColor: const Color(0xFF0B0E11), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)), style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 16),
        ListTile(leading: Container(width: 40, height: 40, decoration: BoxDecoration(color: const Color(0xFFF0B90B).withOpacity(0.2), shape: BoxShape.circle), child: const Icon(Icons.store, color: Color(0xFFF0B90B))), title: const Text('متجر التقنية', style: TextStyle(color: Colors.white)), onTap: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('بدء محادثة مع متجر التقنية'))); }),
        ListTile(leading: Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.blue.withOpacity(0.2), shape: BoxShape.circle), child: const Icon(Icons.person, color: Colors.blue)), title: const Text('أحمد محمد', style: TextStyle(color: Colors.white)), onTap: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('بدء محادثة مع أحمد محمد'))); }),
        const SizedBox(height: 20),
      ])),
    );
  }
}
