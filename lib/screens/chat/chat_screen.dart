import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';
import 'chat_detail_screen.dart';

class ChatModel {
  final String id, name, lastMessage, time, type, avatar;
  final int unread;
  final bool isOnline;
  bool isPinned;
  final String storeId;

  ChatModel({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unread,
    required this.isOnline,
    required this.isPinned,
    required this.type,
    required this.avatar,
    required this.storeId,
  });
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';
  
  List<ChatModel> _allChats = [
    ChatModel(id: '1', name: 'متجر التقنية', lastMessage: 'مرحباً، هل المنتج متوفر؟', time: '10:30 ص', unread: 2, isOnline: true, isPinned: true, type: 'متجر', avatar: 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200', storeId: '1'),
    ChatModel(id: '2', name: 'مطعم مندي الملكي', lastMessage: 'عرض خاص اليوم!', time: 'أمس', unread: 0, isOnline: true, isPinned: false, type: 'مطعم', avatar: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200', storeId: '2'),
    ChatModel(id: '3', name: 'الأزياء العصرية', lastMessage: 'الطلب قيد التجهيز', time: 'أمس', unread: 0, isOnline: false, isPinned: false, type: 'أزياء', avatar: 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200', storeId: '3'),
    ChatModel(id: '4', name: 'عطور الشرق', lastMessage: 'تم شحن طلبك', time: 'الثلاثاء', unread: 1, isOnline: true, isPinned: false, type: 'عطور', avatar: 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=200', storeId: '4'),
    ChatModel(id: '5', name: 'مساعد فلكس الذكي', lastMessage: 'كيف يمكنني مساعدتك؟', time: 'الآن', unread: 0, isOnline: true, isPinned: true, type: 'مساعد', avatar: '', storeId: 'ai'),
  ];

  List<ChatModel> get _unreadChats => _allChats.where((c) => c.unread > 0).toList();
  List<ChatModel> get _groupChats => _allChats.where((c) => c.type == 'مجموعة').toList();

  List<ChatModel> get _filteredChats {
    var chats = _tabController.index == 0 ? _allChats : _tabController.index == 1 ? _unreadChats : _groupChats;
    if (_searchQuery.isNotEmpty) {
      chats = chats.where((c) => c.name.contains(_searchQuery) || c.lastMessage.contains(_searchQuery)).toList();
    }
    chats.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return b.time.compareTo(a.time);
    });
    return chats;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        title: const Text('الدردشة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.binanceDark,
        centerTitle: true,
        actions: [
          IconButton(icon: SvgPicture.asset('assets/icons/svg/search.svg', width: 22, height: 22, colorFilter: const ColorFilter.mode(AppTheme.binanceGold, BlendMode.srcIn)), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'ابحث عن محادثة...',
                hintStyle: const TextStyle(color: Color(0xFF5E6673)),
                prefixIcon: SvgPicture.asset('assets/icons/svg/search.svg', width: 20, height: 20, colorFilter: const ColorFilter.mode(AppTheme.binanceGold, BlendMode.srcIn)),
                filled: true,
                fillColor: AppTheme.binanceCard,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppTheme.binanceGold,
              labelColor: AppTheme.binanceGold,
              unselectedLabelColor: const Color(0xFF9CA3AF),
              onTap: (_) => setState(() {}),
              tabs: [
                Tab(text: 'جميع (${_allChats.length})'),
                Tab(text: 'غير مقروء (${_unreadChats.length})'),
                Tab(text: 'مجموعات (${_groupChats.length})'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _filteredChats.isEmpty
                ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SvgPicture.asset('assets/icons/svg/chat.svg', width: 64, height: 64, colorFilter: ColorFilter.mode(AppTheme.binanceGold.withOpacity(0.3), BlendMode.srcIn)),
                    const SizedBox(height: 16),
                    Text('لا توجد محادثات', style: TextStyle(color: AppTheme.binanceGold.withOpacity(0.5))),
                  ]))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredChats.length,
                    itemBuilder: (_, i) => _buildChatCard(_filteredChats[i]),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewChatDialog(),
        backgroundColor: AppTheme.binanceGold,
        child: SvgPicture.asset('assets/icons/svg/add.svg', width: 24, height: 24, colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
      ),
    );
  }

  Widget _buildChatCard(ChatModel chat) {
    return Dismissible(
      key: Key(chat.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(color: AppTheme.binanceRed, borderRadius: BorderRadius.circular(16)),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: SvgPicture.asset('assets/icons/svg/delete.svg', width: 24, height: 24, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
      ),
      onDismissed: (_) {
        setState(() => _allChats.removeWhere((c) => c.id == chat.id));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم حذف المحادثة'), backgroundColor: AppTheme.binanceGreen));
      },
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatDetailScreen(chat: chat))),
        onLongPress: () => _showChatOptions(chat),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: chat.unread > 0 ? const Color(0xFF1A2A44) : AppTheme.binanceCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: chat.unread > 0 ? AppTheme.binanceGold.withOpacity(0.3) : AppTheme.binanceBorder),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: chat.avatar.isNotEmpty ? NetworkImage(chat.avatar) : null,
                    child: chat.avatar.isEmpty ? Icon(Icons.store, color: AppTheme.binanceGold) : null,
                  ),
                  if (chat.isOnline)
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: AppTheme.binanceGreen,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.binanceDark, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(chat.name, style: TextStyle(color: Colors.white, fontWeight: chat.unread > 0 ? FontWeight.bold : FontWeight.normal, fontSize: 15), maxLines: 1, overflow: TextOverflow.ellipsis)),
                        Text(chat.time, style: const TextStyle(color: Color(0xFF5E6673), fontSize: 11)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(child: Text(chat.lastMessage, style: TextStyle(color: chat.unread > 0 ? Colors.white : const Color(0xFF9CA3AF), fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis)),
                        if (chat.unread > 0) Container(margin: const EdgeInsets.only(left: 8), padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppTheme.binanceRed, borderRadius: BorderRadius.circular(12)), child: Text('${chat.unread}', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(chat.type, style: TextStyle(color: AppTheme.binanceGold, fontSize: 10)),
                  ],
                ),
              ),
              if (chat.isPinned) Padding(padding: const EdgeInsets.only(left: 8), child: SvgPicture.asset('assets/icons/svg/pin.svg', width: 16, height: 16, colorFilter: const ColorFilter.mode(AppTheme.binanceGold, BlendMode.srcIn))),
            ],
          ),
        ),
      ),
    );
  }

  void _showChatOptions(ChatModel chat) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.binanceCard,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(leading: SvgPicture.asset('assets/icons/svg/pin.svg', width: 24, height: 24), title: Text(chat.isPinned ? 'إلغاء التثبيت' : 'تثبيت المحادثة', style: const TextStyle(color: Colors.white)), onTap: () { setState(() => chat.isPinned = !chat.isPinned); Navigator.pop(context); }),
          ListTile(leading: SvgPicture.asset('assets/icons/svg/mute.svg', width: 24, height: 24), title: const Text('كتم الإشعارات', style: TextStyle(color: Colors.white)), onTap: () { Navigator.pop(context); }),
          ListTile(leading: SvgPicture.asset('assets/icons/svg/delete.svg', width: 24, height: 24), title: const Text('حذف المحادثة', style: TextStyle(color: AppTheme.binanceRed)), onTap: () { setState(() => _allChats.removeWhere((c) => c.id == chat.id)); Navigator.pop(context); }),
        ]),
      ),
    );
  }

  void _showNewChatDialog() {
    final List<Map<String, dynamic>> _availableStores = [
      {'name': 'متجر التقنية', 'storeId': '1', 'avatar': 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=200'},
      {'name': 'مطعم مندي الملكي', 'storeId': '2', 'avatar': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200'},
      {'name': 'الأزياء العصرية', 'storeId': '3', 'avatar': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200'},
      {'name': 'عطور الشرق', 'storeId': '4', 'avatar': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=200'},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.binanceCard,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: AppTheme.binanceBorder, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 20),
            const Text('بدء محادثة جديدة', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _availableStores.length,
                itemBuilder: (_, i) => ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(_availableStores[i]['avatar'])),
                  title: Text(_availableStores[i]['name'], style: const TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                    final newChat = ChatModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: _availableStores[i]['name'],
                      lastMessage: 'بدء محادثة جديدة',
                      time: 'الآن',
                      unread: 0,
                      isOnline: true,
                      isPinned: false,
                      type: 'متجر',
                      avatar: _availableStores[i]['avatar'],
                      storeId: _availableStores[i]['storeId'],
                    );
                    setState(() => _allChats.insert(0, newChat));
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ChatDetailScreen(chat: newChat)));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
