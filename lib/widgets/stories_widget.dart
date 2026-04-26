import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';

class StoryModel {
  final String id, name, imageUrl, time;
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

class StoriesWidget extends StatelessWidget {
  final List<StoryModel> stories;
  final VoidCallback? onAddStory;

  const StoriesWidget({
    super.key,
    required this.stories,
    this.onAddStory,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return GestureDetector(
            onTap: story.isUser ? onAddStory : () => _showStory(story),
            child: Container(
              width: 70,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
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
                      child: ClipOval(
                        child: story.isUser
                            ? Container(
                                color: AppTheme.binanceCard,
                                child: SvgPicture.asset('assets/icons/svg/add.svg', width: 30, height: 30),
                              )
                            : (story.imageUrl.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: story.imageUrl,
                                    fit: BoxFit.cover,
                                    placeholder: (_, __) => Container(color: AppTheme.binanceCard),
                                    errorWidget: (_, __, ___) => Icon(Icons.person, color: AppTheme.binanceGold),
                                  )
                                : Container(
                                    color: AppTheme.binanceCard,
                                    child: Icon(Icons.store, color: AppTheme.binanceGold),
                                  )),
                      ),
                    ),
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
    // يمكن إضافة عرض الحالة لاحقاً
  }
}
