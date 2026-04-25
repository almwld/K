import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(backgroundColor: const Color(0xFF0B0E11), elevation: 0, title: const Text('الدردشة', style: TextStyle(color: Colors.white)), actions: [IconButton(icon: SvgPicture.asset('assets/icons/svg/edit.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)), onPressed: () {})]),
      body: ListView.builder(padding: const EdgeInsets.all(16), itemCount: 8, itemBuilder: (_, i) => Container(
        margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF2B3139))),
        child: Row(children: [
          Container(width: 50, height: 50, decoration: BoxDecoration(shape: BoxShape.circle, gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFAA8C2C)])), child: const Center(child: Icon(Icons.person, color: Colors.white))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Text('متجر ${i + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const Spacer(), Text('${i + 1}:${(i * 7) % 60}', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 11))]), const SizedBox(height: 4), Text('آخر رسالة في المحادثة...', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis)])),
        ]),
      )),
    );
  }
}
