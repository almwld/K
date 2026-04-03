import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class FlexTransfersScreen extends StatelessWidget {
  const FlexTransfersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'فلكس حوالات'),
      body: const Center(child: Text('فلكس حوالات - قيد التطوير')),
    );
  }
}
