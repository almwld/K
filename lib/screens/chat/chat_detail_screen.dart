import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/chat_model.dart';

class ChatDetailScreen extends StatefulWidget {
  final ChatModel chat;
  const ChatDetailScreen({super.key, required this.chat});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<MessageModel> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages.addAll([
      MessageModel(id: '1', text: 'مرحباً! كيف يمكنني مساعدتك؟', isMine: false, time: DateTime.now().subtract(const Duration(hours: 2)), status: MessageStatus.read),
      MessageModel(id: '2', text: 'هل منتج iPhone 15 Pro متوفر؟', isMine: true, time: DateTime.now().subtract(const Duration(hours: 1, minutes: 55)), status: MessageStatus.read),
      MessageModel(id: '3', text: 'نعم، متوفر حالياً. السعر 350,000 ريال', isMine: false, time: DateTime.now().subtract(const Duration(hours: 1, minutes: 50)), status: MessageStatus.read),
      MessageModel(id: '4', text: 'تمام، سأطلب واحداً', isMine: true, time: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)), status: MessageStatus.read),
      MessageModel(id: '5', text: 'شكراً لك! سيصلك خلال 3 أيام', isMine: false, time: DateTime.now().subtract(const Duration(hours: 1, minutes: 40)), status: MessageStatus.read),
    ]);
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    setState(() { _messages.add(MessageModel(id: DateTime.now().millisecondsSinceEpoch.toString(), text: _messageController.text, isMine: true, time: DateTime.now(), status: MessageStatus.sent)); _messageController.clear(); });
    Future.delayed(const Duration(seconds: 1), () { if (mounted) setState(() => _messages.add(MessageModel(id: DateTime.now().millisecondsSinceEpoch.toString(), text: 'تم استلام رسالتك!', isMine: false, time: DateTime.now(), status: MessageStatus.read))); });
  }

  @override
  void dispose() { _messageController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        title: Row(children: [Container(width: 40, height: 40, decoration: BoxDecoration(shape: BoxShape.circle, color: widget.chat.avatarColor.withOpacity(0.2)), child: Icon(widget.chat.avatar, color: widget.chat.avatarColor, size: 22)), const SizedBox(width: 12), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(widget.chat.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), if (widget.chat.statusText.isNotEmpty) Text(widget.chat.statusText, style: TextStyle(color: widget.chat.statusColor, fontSize: 11))])]),
        centerTitle: false, backgroundColor: Colors.transparent, elevation: 0,
        actions: [IconButton(icon: const Icon(Icons.more_vert, color: Color(0xFFF0B90B)), onPressed: () {})],
      ),
      body: Column(children: [
        Expanded(child: ListView.builder(reverse: true, padding: const EdgeInsets.all(16), itemCount: _messages.length, itemBuilder: (_, i) => _buildBubble(_messages[_messages.length - 1 - i]))),
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF1E2329), border: Border(top: BorderSide(color: const Color(0xFF2B3139)))), child: Row(children: [
          IconButton(icon: const Icon(Icons.attach_file, color: Color(0xFFF0B90B)), onPressed: () {}),
          Expanded(child: TextField(controller: _messageController, decoration: InputDecoration(hintText: 'اكتب رسالتك...', hintStyle: const TextStyle(color: Color(0xFF5E6673)), filled: true, fillColor: const Color(0xFF0B0E11), border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)), style: const TextStyle(color: Colors.white), maxLines: null)),
          const SizedBox(width: 8),
          Container(decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFF0B90B), Color(0xFFAA8C2C)]), shape: BoxShape.circle), child: IconButton(icon: const Icon(Icons.send, color: Colors.black), onPressed: _sendMessage)),
        ])),
      ]),
    );
  }

  Widget _buildBubble(MessageModel msg) {
    return Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(mainAxisAlignment: msg.isMine ? MainAxisAlignment.end : MainAxisAlignment.start, children: [
      if (!msg.isMine) Container(width: 32, height: 32, margin: const EdgeInsets.only(right: 8), decoration: BoxDecoration(shape: BoxShape.circle, color: widget.chat.avatarColor.withOpacity(0.2)), child: Icon(widget.chat.avatar, color: widget.chat.avatarColor, size: 18)),
      Flexible(child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10), decoration: BoxDecoration(gradient: msg.isMine ? const LinearGradient(colors: [Color(0xFFF0B90B), Color(0xFFAA8C2C)]) : null, color: msg.isMine ? null : const Color(0xFF1E2329), borderRadius: BorderRadius.only(topLeft: const Radius.circular(16), topRight: const Radius.circular(16), bottomLeft: msg.isMine ? const Radius.circular(16) : const Radius.circular(4), bottomRight: msg.isMine ? const Radius.circular(4) : const Radius.circular(16))), child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text(msg.text, style: TextStyle(color: msg.isMine ? Colors.black : Colors.white, fontSize: 14)), const SizedBox(height: 4), Row(mainAxisSize: MainAxisSize.min, children: [Text('${msg.time.hour}:${msg.time.minute.toString().padLeft(2, '0')}', style: TextStyle(color: msg.isMine ? Colors.black54 : const Color(0xFF9CA3AF), fontSize: 10)), if (msg.isMine) ...[const SizedBox(width: 4), Icon(msg.status == MessageStatus.read ? Icons.done_all : Icons.done, size: 12, color: msg.status == MessageStatus.read ? const Color(0xFFF0B90B) : const Color(0xFF9CA3AF))]])]))),
    ]));
  }
}
