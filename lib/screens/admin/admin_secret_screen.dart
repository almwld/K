import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/app_theme.dart';
import '../../services/admin_service.dart';
import 'admin_main_screen.dart';

class AdminSecretScreen extends StatefulWidget {
  const AdminSecretScreen({super.key});

  @override
  State<AdminSecretScreen> createState() => _AdminSecretScreenState();
}

class _AdminSecretScreenState extends State<AdminSecretScreen> {
  final TextEditingController _codeController = TextEditingController();
  final AdminService _adminService = AdminService();
  bool _isLoading = false;

  Future<void> _verifyCode() async {
    final code = _codeController.text.trim();
    if (code.isEmpty) return;

    setState(() => _isLoading = true);
    
    final success = await _adminService.activateAdminMode(code);
    
    setState(() => _isLoading = false);
    
    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminMainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الكود غير صحيح'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.admin_panel_settings, color: AppTheme.goldPrimary, size: 80),
                const SizedBox(height: 30),
                const Text('وضع المشرف', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
                  child: TextField(
                    controller: _codeController,
                    style: const TextStyle(color: Colors.white, fontSize: 24, letterSpacing: 8),
                    textAlign: TextAlign.center,
                    obscureText: true,
                    decoration: const InputDecoration(hintText: '********', hintStyle: TextStyle(color: Colors.grey, fontSize: 24, letterSpacing: 8), border: InputBorder.none),
                    inputFormatters: [UpperCaseTextFormatter()],
                    onSubmitted: (_) => _verifyCode(),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _verifyCode,
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldPrimary, padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: _isLoading ? const CircularProgressIndicator() : const Text('دخول', style: TextStyle(fontSize: 18)),
                  ),
                ),
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء', style: TextStyle(color: Colors.grey))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
