import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class QuickCommandsGrid extends StatelessWidget {
  final Function(String) onCommandSelected;

  const QuickCommandsGrid({
    super.key,
    required this.onCommandSelected,
  });

  final List<Map<String, dynamic>> _commands = const [
    {'icon': Icons.shopping_cart, 'label': 'شراء', 'command': 'شراء', 'color': 0xFF4CAF50},
    {'icon': Icons.gavel, 'label': 'مزاد', 'command': 'مزاد', 'color': 0xFFFF9800},
    {'icon': Icons.home, 'label': 'عقارات', 'command': 'عقارات', 'color': 0xFF2196F3},
    {'icon': Icons.directions_car, 'label': 'سيارات', 'command': 'سيارات', 'color': 0xFFE74C3C},
    {'icon': Icons.devices, 'label': 'إلكترونيات', 'command': 'إلكترونيات', 'color': 0xFF9C27B0},
    {'icon': Icons.checkroom, 'label': 'أزياء', 'command': 'أزياء', 'color': 0xFFE91E63},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _commands.length,
        itemBuilder: (context, index) {
          final cmd = _commands[index];
          return GestureDetector(
            onTap: () => onCommandSelected(cmd['command']),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Color(cmd['color']).withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(cmd['icon'], color: Color(cmd['color']), size: 28),
                  const SizedBox(height: 8),
                  Text(
                    cmd['label'],
                    style: TextStyle(
                      color: AppTheme.getTextColor(context),
                      fontSize: 12,
                    ),
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

