import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DatePickerDropdown extends StatefulWidget {
  final String label;
  final Function(int year, int month, int day) onDateSelected;
  final int? initialYear;
  final int? initialMonth;
  final int? initialDay;

  const DatePickerDropdown({
    super.key,
    required this.label,
    required this.onDateSelected,
    this.initialYear,
    this.initialMonth,
    this.initialDay,
  });

  @override
  State<DatePickerDropdown> createState() => _DatePickerDropdownState();
}

class _DatePickerDropdownState extends State<DatePickerDropdown> {
  int? _selectedYear;
  int? _selectedMonth;
  int? _selectedDay;

  List<int> get _years {
    final currentYear = DateTime.now().year;
    return List.generate(100, (i) => currentYear - i);
  }
  
  List<int> get _months => List.generate(12, (i) => i + 1);
  
  List<int> get _days {
    if (_selectedYear == null || _selectedMonth == null) return [];
    final daysInMonth = DateTime(_selectedYear!, _selectedMonth!, 0).day;
    return List.generate(daysInMonth, (i) => i + 1);
  }

  @override
  void initState() {
    super.initState();
    _selectedYear = widget.initialYear;
    _selectedMonth = widget.initialMonth;
    _selectedDay = widget.initialDay;
  }

  void _updateDate() {
    if (_selectedYear != null && _selectedMonth != null && _selectedDay != null) {
      widget.onDateSelected(_selectedYear!, _selectedMonth!, _selectedDay!);
    }
  }

  String _getMonthName(int month) {
    const months = [
      'يناير', 'فبراير', 'مارس', 'إبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey[300] : Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[800] : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: _selectedYear,
                    hint: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text('سنة', style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[500])),
                    ),
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                    items: _years.map((year) {
                      return DropdownMenuItem(
                        value: year,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(year.toString()),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedYear = value;
                        _selectedDay = null;
                      });
                      _updateDate();
                    },
                  ),
                ),
              ),
              Container(width: 1, height: 30, color: isDark ? Colors.grey[700] : Colors.grey[300]),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: _selectedMonth,
                    hint: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text('شهر', style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[500])),
                    ),
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                    items: _months.map((month) {
                      return DropdownMenuItem(
                        value: month,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(_getMonthName(month)),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedMonth = value;
                        _selectedDay = null;
                      });
                      _updateDate();
                    },
                  ),
                ),
              ),
              Container(width: 1, height: 30, color: isDark ? Colors.grey[700] : Colors.grey[300]),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: _selectedDay,
                    hint: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text('يوم', style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[500])),
                    ),
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                    items: _days.map((day) {
                      return DropdownMenuItem(
                        value: day,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(day.toString()),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDay = value;
                      });
                      _updateDate();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
