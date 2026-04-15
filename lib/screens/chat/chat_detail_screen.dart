import 'package:flutter/material.dart';
import '../../services/chat_service.dart';
import '../../models/chat_message.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class ChatDetailScreen extends StatefulWidget {
  final String conversationId;
  final String userName;

  const ChatDetailScreen({super.key, required this.conversationId, required this.userName});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ChatMessage> _messages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _chatService.messagesStream.listen((messages) {
      setState(() {
        _messages = messages;
        _isLoading = false;
      });
      _scrollToBottom();
    });
  }

  Future<void> _loadMessages() async {
    final messages = await _chatService.getMessages(widget.conversationId);
    setState(() {
      _messages = messages;
      _isLoading = false;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    _chatService.sendMessage(widget.conversationId, _messageController.text.trim());
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(title: widget.userName, actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.call, color: AppTheme.goldColor)), IconButton(onPressed: () {}, icon: const Icon(Icons.videocam, color: AppTheme.goldColor))]),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: AppTheme.goldColor))
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final isMe = message.senderId == 'user';
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
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? AppTheme.goldColor : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isMe ? 20 : 5),
            bottomRight: Radius.circular(isMe ? 5 : 20),
          ),
        ),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(message.content, style: TextStyle(color: isMe ? Colors.white : Colors.black87)),
            const SizedBox(height: 4),
            Text(_formatTime(message.timestamp), style: TextStyle(fontSize: 10, color: isMe ? Colors.white70 : Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, -2))]),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.attach_file, color: AppTheme.goldColor)),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(hintText: 'اكتب رسالتك...', filled: true, fillColor: Colors.grey[100], border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
            ),
          ),
          IconButton(onPressed: _sendMessage, icon: Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: AppTheme.goldColor, shape: BoxShape.circle), child: const Icon(Icons.send, color: Colors.white, size: 18))),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
