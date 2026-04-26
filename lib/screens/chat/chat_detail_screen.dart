import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../theme/app_theme.dart';
import 'chat_screen.dart';

class MessageModel {
  final String id, text, time, type;
  final bool isMine;
  final bool isRead;
  final String? imageUrl;
  final String? fileUrl;

  MessageModel({
    required this.id,
    required this.text,
    required this.time,
    required this.isMine,
    this.isRead = false,
    this.type = 'text',
    this.imageUrl,
    this.fileUrl,
  });
}

class ChatDetailScreen extends StatefulWidget {
  final ChatModel chat;
  const ChatDetailScreen({super.key, required this.chat});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<MessageModel> _messages = [];
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  bool _showEmojiPicker = false;
  String _selectedEmoji = '';

  final List<String> _emojiList = [
    '😀', '😁', '😂', '🤣', '😃', '😄', '😅', '😆', '😉', '😊', '😋', '😎', '😍', '😘', '🥰', '😗',
    '😙', '😚', '🙂', '🤗', '🤩', '🤔', '🤨', '😐', '😑', '😶', '🙄', '😏', '😣', '😥', '😮', '🤐',
    '😌', '😔', '😪', '🤤', '😴', '😷', '🤒', '🤕', '🤢', '🤮', '🤧', '🥵', '🥶', '🥴', '😵', '🤯',
    '👍', '👎', '👌', '✌️', '🤞', '🤟', '🤘', '🤙', '👈', '👉', '👆', '👇', '🖕', '🙏', '💪', '🦾',
    '❤️', '🧡', '💛', '💚', '💙', '💜', '🖤', '🤍', '🤎', '💔', '❤️‍🔥', '💖', '💗', '💓', '💞', '💕',
    '🎉', '🎊', '🎈', '✨', '🌟', '⭐', '🔥', '💯', '✅', '❌', '❓', '❗', '💢', '💬', '🗨️', '👋',
  ];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() {
    _messages.addAll([
      MessageModel(id: '1', text: 'مرحباً! كيف يمكنني مساعدتك؟', time: '10:00', isMine: false, type: 'text'),
      MessageModel(id: '2', text: 'هل منتج iPhone 15 Pro متوفر؟', time: '10:05', isMine: true, type: 'text'),
      MessageModel(id: '3', text: 'نعم متوفر، السعر 350,000 ريال', time: '10:07', isMine: false, type: 'text'),
      MessageModel(id: '4', text: 'تمام، سأطلبه الآن', time: '10:10', isMine: true, type: 'text'),
    ]);
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty && _selectedEmoji.isEmpty) return;
    
    final text = _selectedEmoji.isNotEmpty ? _selectedEmoji : _messageController.text;
    
    setState(() {
      _messages.add(MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: text,
        time: '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
        isMine: true,
        type: 'text',
      ));
      _messageController.clear();
      _selectedEmoji = '';
      _showEmojiPicker = false;
    });
    _scrollToBottom();
    
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add(MessageModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            text: 'تم استلام رسالتك! سأتواصل معك قريباً.',
            time: '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
            isMine: false,
            type: 'text',
          ));
        });
        _scrollToBottom();
      }
    });
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _messages.add(MessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: 'صورة',
          time: '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
          isMine: true,
          type: 'image',
          imageUrl: image.path,
        ));
      });
      _scrollToBottom();
    }
  }

  Future<void> _pickFile() async {
    final XFile? file = await _picker.pickMedia();
    if (file != null) {
      setState(() {
        _messages.add(MessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: 'ملف',
          time: '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
          isMine: true,
          type: 'file',
          fileUrl: file.path,
        ));
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
    });
  }

  void _addEmoji(String emoji) {
    setState(() {
      _selectedEmoji = emoji;
      _messageController.text = emoji;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        backgroundColor: AppTheme.binanceDark,
        elevation: 0,
        leading: IconButton(icon: SvgPicture.asset('assets/icons/svg/back.svg', width: 24, height: 24), onPressed: () => Navigator.pop(context)),
        title: Row(
          children: [
            CircleAvatar(radius: 18, backgroundImage: widget.chat.avatar.isNotEmpty ? NetworkImage(widget.chat.avatar) : null, child: widget.chat.avatar.isEmpty ? Icon(Icons.store, color: AppTheme.binanceGold) : null),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.chat.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                if (widget.chat.isOnline)
                  const Text('متصل الآن', style: TextStyle(color: AppTheme.binanceGreen, fontSize: 11)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: SvgPicture.asset('assets/icons/svg/phone.svg', width: 22, height: 22), onPressed: () {}),
          IconButton(icon: SvgPicture.asset('assets/icons/svg/more.svg', width: 22, height: 22), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: false,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _buildMessageBubble(_messages[index]),
            ),
          ),
          if (_showEmojiPicker)
            Container(
              height: 250,
              color: AppTheme.binanceCard,
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemCount: _emojiList.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => _addEmoji(_emojiList[index]),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.binanceDark,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(_emojiList[index], style: const TextStyle(fontSize: 24)),
                    ),
                  ),
                ),
              ),
            ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(MessageModel message) {
    final isMine = message.isMine;
    
    if (message.type == 'image' && message.imageUrl != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isMine)
              CircleAvatar(radius: 16, backgroundImage: widget.chat.avatar.isNotEmpty ? NetworkImage(widget.chat.avatar) : null),
            const SizedBox(width: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(File(message.imageUrl!), width: 150, height: 150, fit: BoxFit.cover),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMine)
            CircleAvatar(radius: 16, backgroundImage: widget.chat.avatar.isNotEmpty ? NetworkImage(widget.chat.avatar) : null),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                gradient: isMine ? AppTheme.goldGradient : null,
                color: isMine ? null : AppTheme.binanceCard,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: isMine ? const Radius.circular(16) : const Radius.circular(4),
                  bottomRight: isMine ? const Radius.circular(4) : const Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(message.text, style: TextStyle(color: isMine ? Colors.black : Colors.white, fontSize: 14)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(message.time, style: TextStyle(color: isMine ? Colors.black54 : const Color(0xFF9CA3AF), fontSize: 10)),
                      if (isMine) ...[
                        const SizedBox(width: 4),
                        SvgPicture.asset('assets/icons/svg/done_all.svg', width: 12, height: 12, colorFilter: const ColorFilter.mode(message.isRead ? AppTheme.binanceGold : Color(0xFF9CA3AF), BlendMode.srcIn)),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.binanceCard,
        border: Border(top: BorderSide(color: AppTheme.binanceBorder)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: _toggleEmojiPicker,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: AppTheme.binanceDark, borderRadius: BorderRadius.circular(30)),
                  child: const Text('😊', style: TextStyle(fontSize: 22)),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: AppTheme.binanceDark, borderRadius: BorderRadius.circular(30)),
                  child: SvgPicture.asset('assets/icons/svg/image.svg', width: 22, height: 22, colorFilter: const ColorFilter.mode(AppTheme.binanceGold, BlendMode.srcIn)),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _pickFile,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: AppTheme.binanceDark, borderRadius: BorderRadius.circular(30)),
                  child: SvgPicture.asset('assets/icons/svg/attachment.svg', width: 22, height: 22, colorFilter: const ColorFilter.mode(AppTheme.binanceGold, BlendMode.srcIn)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.binanceDark,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'اكتب رسالتك...',
                      hintStyle: TextStyle(color: Color(0xFF5E6673)),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _sendMessage,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    gradient: AppTheme.goldGradient,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset('assets/icons/svg/send.svg', width: 22, height: 22, colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
