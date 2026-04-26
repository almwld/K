import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';

class StoryModel {
  final String id;
  final String name;
  final String imageUrl;
  final String time;
  final bool isViewed;
  final bool isUser;

  StoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.time,
    this.isViewed = false,
    this.isUser = false,
  });
}

class StoriesWidget extends StatefulWidget {
  final List<StoryModel> stories;
  final VoidCallback? onAddStory;

  const StoriesWidget({
    super.key,
    required this.stories,
    this.onAddStory,
  });

  @override
  State<StoriesWidget> createState() => _StoriesWidgetState();
}

class _StoriesWidgetState extends State<StoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.stories.length,
        itemBuilder: (context, index) {
          final story = widget.stories[index];
          return GestureDetector(
            onTap: () => _showStory(story),
            child: Container(
              width: 70,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: story.isViewed
                              ? null
                              : const LinearGradient(
                                  colors: [Color(0xFFD4AF37), Color(0xFFB8962E)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: story.isUser
                                ? Container(
                                    color: AppTheme.binanceCard,
                                    child: Icon(Icons.add, color: AppTheme.binanceGold, size: 30),
                                  )
                                : CachedNetworkImage(
                                    imageUrl: story.imageUrl,
                                    fit: BoxFit.cover,
                                    placeholder: (_, __) => Container(color: AppTheme.binanceCard),
                                    errorWidget: (_, __, ___) => Icon(Icons.person, color: AppTheme.binanceGold),
                                  ),
                          ),
                        ),
                      ),
                      if (story.isUser)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: AppTheme.binanceGold,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppTheme.binanceDark, width: 2),
                            ),
                            child: const Icon(Icons.add, size: 12, color: Colors.black),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    story.name,
                    style: TextStyle(
                      color: story.isViewed ? const Color(0xFF9CA3AF) : Colors.white,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showStory(StoryModel story) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => StoryViewer(story: story),
    );
  }
}

class StoryViewer extends StatefulWidget {
  final StoryModel story;

  const StoryViewer({super.key, required this.story});

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _controller.forward();
    _controller.addListener(() {
      if (_controller.isCompleted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.story.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // شريط التقدم
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(
              value: _controller.value,
              backgroundColor: Colors.white.withOpacity(0.3),
              color: AppTheme.binanceGold,
            ),
          ),
          // معلومات المستخدم
          Positioned(
            top: 40,
            left: 16,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.story.imageUrl),
                  onBackgroundImageError: (_, __) {},
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.story.name,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.story.time,
                      style: const TextStyle(color: Colors.white70, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // زر إغلاق
          Positioned(
            top: 40,
            right: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
