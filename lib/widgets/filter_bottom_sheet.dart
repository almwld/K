import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(RangeValues, double, String) onApply;
  final RangeValues initialPriceRange;
  final double initialMinRating;
  final String initialDeliveryOption;

  const FilterBottomSheet({
    super.key,
    required this.onApply,
    this.initialPriceRange = const RangeValues(0, 10000),
    this.initialMinRating = 0,
    this.initialDeliveryOption = 'all',
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late RangeValues _priceRange;
  late double _minRating;
  late String _deliveryOption;

  @override
  void initState() {
    super.initState();
    _priceRange = widget.initialPriceRange;
    _minRating = widget.initialMinRating;
    _deliveryOption = widget.initialDeliveryOption;
  }

  static void show(BuildContext context, {
    required Function(RangeValues, double, String) onApply,
    RangeValues initialPriceRange = const RangeValues(0, 10000),
    double initialMinRating = 0,
    String initialDeliveryOption = 'all',
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => FilterBottomSheet(
        onApply: onApply,
        initialPriceRange: initialPriceRange,
        initialMinRating: initialMinRating,
        initialDeliveryOption: initialDeliveryOption,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setModalState) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'تصفية النتائج',
                    style: TextStyle(fontFamily: 'Changa', fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView(
                  children: [
                    const Text('نطاق السعر', style: TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold)),
                    RangeSlider(
                      values: _priceRange,
                      min: 0,
                      max: 10000,
                      divisions: 100,
                      labels: RangeLabels('${_priceRange.start.round()} ر.ي', '${_priceRange.end.round()} ر.ي'),
                      onChanged: (values) {
                        setModalState(() => _priceRange = values);
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('التقييم', style: TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 8,
                      children: [0, 3, 4, 4.5].map((rating) {
                        final isSelected = _minRating == rating;
                        return ChoiceChip(
                          label: Text(rating == 0 ? 'الكل' : '$rating+ نجوم'),
                          selected: isSelected,
                          onSelected: (_) {
                            setModalState(() => _minRating = rating.toDouble());
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    const Text('التوصيل', style: TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold)),
                    ...['all', 'free', 'fast'].map((option) {
                      return RadioListTile<String>(
                        title: Text(
                          option == 'all' ? 'الكل' : option == 'free' ? 'توصيل مجاني' : 'توصيل سريع',
                          style: const TextStyle(fontFamily: 'Changa'),
                        ),
                        value: option,
                        groupValue: _deliveryOption,
                        onChanged: (value) {
                          setModalState(() => _deliveryOption = value!);
                        },
                      );
                    }),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setModalState(() {
                          _priceRange = const RangeValues(0, 10000);
                          _minRating = 0;
                          _deliveryOption = 'all';
                        });
                      },
                      child: const Text('مسح الكل'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onApply(_priceRange, _minRating, _deliveryOption);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
                      child: const Text('تطبيق', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
