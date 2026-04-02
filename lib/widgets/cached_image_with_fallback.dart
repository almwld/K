import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/image_cache_service.dart';

class CachedImageWithFallback extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  
  const CachedImageWithFallback({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  State<CachedImageWithFallback> createState() => _CachedImageWithFallbackState();
}

class _CachedImageWithFallbackState extends State<CachedImageWithFallback> {
  final ImageCacheService _cacheService = ImageCacheService();
  bool _isLoading = true;
  bool _hasError = false;
  FileImage? _cachedImage;

  @override
  void initState() {
    super.initState();
    _loadCachedImage();
  }

  Future<void> _loadCachedImage() async {
    final cachedFile = await _cacheService.getCachedImage(widget.imageUrl);
    if (mounted) {
      setState(() {
        if (cachedFile != null && await cachedFile.exists()) {
          _cachedImage = FileImage(cachedFile);
        }
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    
    if (_isLoading) {
      imageWidget = Container(
        width: widget.width,
        height: widget.height,
        color: Colors.grey[300],
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    } else if (_cachedImage != null) {
      imageWidget = Image(
        image: _cachedImage!,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
      );
    } else {
      // استخدام CachedNetworkImage كبديل مع تخزين مؤقت تلقائي
      imageWidget = CachedNetworkImage(
        imageUrl: widget.imageUrl,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        placeholder: (context, url) => Container(
          color: Colors.grey[300],
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[300],
          child: const Icon(
            Icons.image_not_supported,
            color: Colors.grey,
            size: 40,
          ),
        ),
      );
    }
    
    if (widget.borderRadius != null) {
      return ClipRRect(
        borderRadius: widget.borderRadius!,
        child: imageWidget,
      );
    }
    
    return imageWidget;
  }
}
