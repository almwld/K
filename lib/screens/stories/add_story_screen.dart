import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../theme/app_theme.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({super.key});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  XFile? _selectedImage;
  XFile? _selectedVideo;
  String _storyText = '';
  bool _isLoading = false;
  int _selectedType = 0; // 0: نص, 1: صورة, 2: فيديو
  VideoPlayerController? _videoController;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
        _selectedVideo = null;
        _selectedType = 1;
      });
    }
  }

  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        _selectedVideo = video;
        _selectedImage = null;
        _selectedType = 2;
        _videoController = VideoPlayerController.file(File(video.path))
          ..initialize().then((_) {
            setState(() {});
            _videoController?.play();
          });
      });
    }
  }

  void _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _selectedImage = photo;
        _selectedVideo = null;
        _selectedType = 1;
      });
    }
  }

  void _publishStory() {
    if (_selectedType == 0 && _storyText.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال نص الحالة'), backgroundColor: AppTheme.binanceRed),
      );
      return;
    }
    if (_selectedType == 1 && _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار صورة'), backgroundColor: AppTheme.binanceRed),
      );
      return;
    }
    if (_selectedType == 2 && _selectedVideo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار فيديو'), backgroundColor: AppTheme.binanceRed),
      );
      return;
    }

    setState(() => _isLoading = true);

    // محاكاة رفع الحالة
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم نشر الحالة بنجاح!'), backgroundColor: AppTheme.binanceGreen),
      );
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('إضافة حالة', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _publishStory,
            child: Text('نشر', style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.binanceGold))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // خيارات نوع الحالة
                  Row(
                    children: [
                      _buildTypeButton('نص', Icons.text_fields, 0),
                      const SizedBox(width: 12),
                      _buildTypeButton('صورة', Icons.image, 1),
                      const SizedBox(width: 12),
                      _buildTypeButton('فيديو', Icons.videocam, 2),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // محتوى الحالة حسب النوع
                  if (_selectedType == 0) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.binanceCard : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.binanceBorder),
                      ),
                      child: TextField(
                        maxLines: 5,
                        onChanged: (value) => _storyText = value,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'اكتب حالتك هنا...',
                          hintStyle: TextStyle(color: isDark ? Colors.grey.shade500 : Colors.grey.shade600),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],

                  if (_selectedType == 1) ...[
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.binanceCard : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.binanceBorder),
                      ),
                      child: _selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.file(
                                File(_selectedImage!.path),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image, size: 64, color: AppTheme.binanceGold.withOpacity(0.5)),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: _pickImage,
                                      icon: const Icon(Icons.photo_library),
                                      label: const Text('اختيار من المعرض'),
                                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceGold),
                                    ),
                                    const SizedBox(width: 12),
                                    ElevatedButton.icon(
                                      onPressed: _takePhoto,
                                      icon: const Icon(Icons.camera_alt),
                                      label: const Text('تصوير'),
                                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceCard),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ),
                  ],

                  if (_selectedType == 2) ...[
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.binanceCard : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.binanceBorder),
                      ),
                      child: _selectedVideo != null && _videoController != null && _videoController!.value.isInitialized
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                VideoPlayer(_videoController!),
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: IconButton(
                                    icon: Icon(
                                      _videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _videoController!.value.isPlaying
                                            ? _videoController!.pause()
                                            : _videoController!.play();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.videocam, size: 64, color: AppTheme.binanceGold.withOpacity(0.5)),
                                const SizedBox(height: 16),
                                ElevatedButton.icon(
                                  onPressed: _pickVideo,
                                  icon: const Icon(Icons.video_library),
                                  label: const Text('اختيار فيديو'),
                                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceGold),
                                ),
                              ],
                            ),
                    ),
                  ],

                  const SizedBox(height: 24),

                  // خيارات إضافية
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.binanceCard : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.binanceBorder),
                    ),
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text('مشاركة مع الجميع'),
                          value: true,
                          onChanged: (_) {},
                          activeColor: AppTheme.binanceGold,
                        ),
                        const Divider(),
                        SwitchListTile(
                          title: const Text('إشعار عند المشاهدة'),
                          value: false,
                          onChanged: (_) {},
                          activeColor: AppTheme.binanceGold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildTypeButton(String label, IconData icon, int type) {
    final isSelected = _selectedType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedType = type;
            if (type != 1) _selectedImage = null;
            if (type != 2) {
              _selectedVideo = null;
              _videoController?.dispose();
              _videoController = null;
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.binanceGold : (isDark ? AppTheme.binanceCard : Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.binanceBorder),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? Colors.black : AppTheme.binanceGold),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.black : AppTheme.binanceGold,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// إضافة import للمكتبات المطلوبة
import 'dart:io';
