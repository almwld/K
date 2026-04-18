import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class UploadDocumentsScreen extends StatefulWidget {
  const UploadDocumentsScreen({super.key});

  @override
  State<UploadDocumentsScreen> createState() => _UploadDocumentsScreenState();
}

class _UploadDocumentsScreenState extends State<UploadDocumentsScreen> {
  final List<Map<String, String>> docs = [];

  void _pickDocument() async {
    // In real app use file_picker / image_picker
    setState(() => docs.add({'name': 'مستند-${docs.length + 1}.pdf', 'size': '120 KB'}));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم رفع الملف')));
  }

  void _removeDoc(int index) {
    setState(() => docs.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إزالة الملف')));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المستندات والملفات'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: _pickDocument,
              icon: const Icon(Icons.upload_file),
              label: const Text('رفع مستند'),
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold, foregroundColor: Colors.black),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: docs.isEmpty
                  ? Center(child: Text('لا توجد مستندات', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)))
                  : ListView.separated(
                      itemCount: docs.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, i) {
                        final d = docs[i];
                        return ListTile(
                          tileColor: Theme.of(context).cardColor,
                          leading: const Icon(Icons.insert_drive_file),
                          title: Text(d['name']!),
                          subtitle: Text(d['size']!),
                          trailing: IconButton(
                            onPressed: () => _removeDoc(i),
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
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
