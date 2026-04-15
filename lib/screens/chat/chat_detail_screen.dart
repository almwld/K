import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../theme/app_theme.dart';
import '../../services/chat_service.dart';
import '../../models/chat_message.dart';

class ChatDetailScreen extends StatefulWidget {
  final String conversationId;
  final String otherUserId;

  const ChatDetailScreen({
    super.key,
    required this.conversationId,
    required this.otherUserId,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  late ChatService _chatService;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  
  Map<String, dynamic>? _otherUser;
  bool _isTyping = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initChat();
    _loadOtherUser();
  }

  Future<void> _initChat() async {
    _chatService = ChatService();
    await _chatService.init(widget.conversationId);
    _chatService.addMessageListener(_onNewMessage);
    setState(() => _isLoading = false);
    _scrollToBottom();
  }

  void _onNewMessage(ChatMessage message) {
    _scrollToBottom();
  }

  Future<void> _loadOtherUser() async {
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from('profiles')
        .select()
        .eq('id', widget.otherUserId)
        .single();
    setState(() => _otherUser = response);
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final message = _messageController.text;
    _messageController.clear();
    await _chatService.sendMessage(widget.conversationId, message);
    _scrollToBottom();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // رفع الصورة إلى Supabase Storage
      final supabase = Supabase.instance.client;
      final fileName = 'chat/${DateTime.now().millisecondsSinceEpoch}.jpg';
      await supabase.storage.from('chat').upload(fileName, File(image.path));
      final imageUrl = supabase.storage.from('chat').getPublicUrl(fileName);
      
      await _chatService.sendMessage(widget.conversationId, 'صورة', type: 'image', mediaUrl: imageUrl);
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showReactionDialog(String messageId) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildReactionButton('👍', messageId),
            _buildReactionButton('❤️', messageId),
            _buildReactionButton('😂', messageId),
            _buildReactionButton('😮', messageId),
            _buildReactionButton('😢', messageId),
            _buildReactionButton('👏', messageId),
          ],
        ),
      ),
    );
  }

  Widget _buildReactionButton(String reaction, String messageId) {
    return GestureDetector(
      onTap: () {
        _chatService.addReaction(messageId, reaction);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(reaction, style: const TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: _otherUser?['avatar_url'] != null 
                  ? NetworkImage(_otherUser!['avatar_url']) 
                  : null,
              child: _otherUser?['avatar_url'] == null 
                  ? Text(_otherUser?['name']?[0] ?? '?', style: const TextStyle(fontSize: 14))
                  : null,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_otherUser?['name'] ?? 'محادثة', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                if (_isTyping)
                  const Text('يكتب...', style: TextStyle(fontSize: 11, color: AppTheme.goldColor)),
              ],
            ),
          ],
        ),
        backgroundColor: AppTheme.goldColor,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    reverse: true,
                    itemCount: _chatService.messages.length,
                    itemBuilder: (context, index) {
                      final message = _chatService.messages.reversed.toList()[index];
                      final isMe = message.isMine;
                      return _buildMessageBubble(message, isMe);
                    },
                  ),
                ),
                _buildMessageInput(),
              ],
            ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, bool isMe) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onLongPress: () => _showReactionDialog(message.id),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              // رد الفعل
              if (message.reaction != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(message.reaction!),
                ),
              // محتوى الرسالة
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isMe ? AppTheme.goldColor : (isDark ? Colors.grey[800] : Colors.grey[200]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: message.type == 'image'
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          message.mediaUrl!,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Text(
                        message.message,
                        style: TextStyle(
                          color: isMe ? Colors.black : (isDark ? Colors.white : Colors.black),
                        ),
                      ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _formatTime(message.createdAt),
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  const SizedBox(width: 4),
                  if (isMe)
                    Icon(
                      message.isRead ? Icons.done_all : Icons.done,
                      size: 14,
                      color: message.isRead ? Colors.blue : Colors.grey,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkSurface : Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.photo_camera),
            onPressed: _pickImage,
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'اكتب رسالة...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: AppTheme.goldColor,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.black),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _chatService.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
