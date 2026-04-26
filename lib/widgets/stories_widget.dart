import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';

class StoriesWidget extends StatelessWidget {
  final List<Map<String, dynamic>> stories;
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
          final isUser = story['isUser'] == true;
          return GestureDetector(
            onTap: () {},
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
                          gradient: story['isViewed'] == true ? null : const LinearGradient(
                            colors: [Color(0xFFD4AF37), Color(0xFFB8962E)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: isUser
                                ? Container(color: AppTheme.binanceCard, child: const Icon(Icons.add, color: AppTheme.binanceGold, size: 30))
                                : CachedNetworkImage(
                                    imageUrl: story['imageUrl'] as String,
                                    fit: BoxFit.cover,
                                    placeholder: (_, __) => Container(color: AppTheme.binanceCard),
                                    errorWidget: (_, __, ___) => Icon(Icons.person, color: AppTheme.binanceGold),
                                  ),
                          ),
                        ),
                      ),
                      if (isUser)
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
                    story['name'] as String,
                    style: TextStyle(
                      color: story['isViewed'] == true ? const Color(0xFF9CA3AF) : Colors.white,
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
}
