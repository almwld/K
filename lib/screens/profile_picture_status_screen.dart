import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class ProfilePictureStatusScreen extends StatefulWidget {
  const ProfilePictureStatusScreen({super.key});

  @override
  State<ProfilePictureStatusScreen> createState() => _ProfilePictureStatusScreenState();
}

class _ProfilePictureStatusScreenState extends State<ProfilePictureStatusScreen> {
  String? avatarUrl;
  final List<String> statuses = [];
  final TextEditingController statusC = TextEditingController();

  void _pickAvatar() {
    setState(() => avatarUrl = null); // demo: set to null or sample url
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم تغيير الصورة')));
  }

  void _addStatus() {
    if (statusC.text.isEmpty) return;
    setState(() {
      statuses.insert(0, statusC.text);
      statusC.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم نشر الحالة')));
  }

  void _removeStatus(int i) {
    setState(() => statuses.removeAt(i));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الصورة والحالات'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickAvatar,
              child: CircleAvatar(radius: 42, backgroundColor: AppTheme.getCardColor(context), child: avatarUrl == null ? const Icon(Icons.camera_alt) : null),
            ),
            const SizedBox(height: 12),
            TextField(controller: statusC, decoration: const InputDecoration(labelText: 'اكتب حالة يومية', border: OutlineInputBorder())),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _addStatus,
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldPrimary, foregroundColor: Colors.black),
                    child: const Text('نشر الحالة'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: statuses.isEmpty
                  ? Center(child: Text('لا توجد حالات', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))))
                  : ListView.separated(
                      itemCount: statuses.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, i) {
                        return ListTile(
                          tileColor: AppTheme.getCardColor(context),
                          title: Text(statuses[i]),
                          trailing: IconButton(onPressed: () => _removeStatus(i), icon: const Icon(Icons.close, color: Colors.red)),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
