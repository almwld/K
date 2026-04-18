import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class SavedCardsScreen extends StatefulWidget {
  const SavedCardsScreen({super.key});

  @override
  State<SavedCardsScreen> createState() => _SavedCardsScreenState();
}

class _SavedCardsScreenState extends State<SavedCardsScreen> {
  bool _isAddingCard = false;
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  final List<Map<String, dynamic>> _savedCards = [
    {
      'id': '1',
      'cardNumber': '**** **** **** 1234',
      'cardHolder': 'AHMED ALI',
      'expiry': '12/26',
      'type': 'visa',
      'color': 0xFF1A237E,
      'isDefault': true,
    },
    {
      'id': '2',
      'cardNumber': '**** **** **** 5678',
      'cardHolder': 'AHMED ALI',
      'expiry': '08/25',
      'type': 'mastercard',
      'color': 0xFFD32F2F,
      'isDefault': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'البطاقات المحفوظة'),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: _savedCards.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.credit_card_off, size: 80, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text('لا توجد بطاقات محفوظة', style: TextStyle(color: Colors.grey[600])),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => setState(() => _isAddingCard = true),
                              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldAccent),
                              child: const Text('إضافة بطاقة جديدة'),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _savedCards.length,
                        itemBuilder: (context, index) => _buildCardItem(_savedCards[index]),
                      ),
              ),
            ],
          ),
          if (_isAddingCard) _buildAddCardOverlay(),
        ],
      ),
      floatingActionButton: _savedCards.isNotEmpty
          ? FloatingActionButton(
              onPressed: () => setState(() => _isAddingCard = true),
              backgroundColor: AppTheme.goldAccent,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildCardItem(Map<String, dynamic> card) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(card['color']), Color(card['color']).withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 16,
            right: 16,
            child: Image.asset(
              card['type'] == 'visa'
                  ? 'assets/icons/visa.png'
                  : 'assets/icons/mastercard.png',
              height: 40,
              errorBuilder: (_, __, ___) => Icon(
                card['type'] == 'visa' ? Icons.credit_card : Icons.credit_card,
                color: Colors.white.withOpacity(0.5),
                size: 40,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  card['cardNumber'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('حامل البطاقة', style: TextStyle(color: Colors.white70, fontSize: 10)),
                          Text(card['cardHolder'], style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('تاريخ الانتهاء', style: TextStyle(color: Colors.white70, fontSize: 10)),
                        Text(card['expiry'], style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (card['isDefault'])
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('البطاقة الافتراضية', style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: PopupMenuButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text('تعيين كافتراضية'),
                  onTap: () => _setDefaultCard(card),
                ),
                PopupMenuItem(
                  child: const Text('حذف البطاقة'),
                  onTap: () => _deleteCard(card),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCardOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('إضافة بطاقة جديدة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => setState(() => _isAddingCard = false),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'رقم البطاقة',
                  prefixIcon: const Icon(Icons.credit_card),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _cardHolderController,
                decoration: InputDecoration(
                  labelText: 'اسم حامل البطاقة',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _expiryController,
                      decoration: InputDecoration(
                        labelText: 'MM/YY',
                        prefixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _cvvController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'CVV',
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => setState(() => _isAddingCard = false),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppTheme.goldAccent),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('إلغاء'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _addCard,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.goldAccent,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('إضافة'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addCard() {
    if (_cardNumberController.text.length < 16) {
      _showError('يرجى إدخال رقم بطاقة صحيح');
      return;
    }
    if (_cardHolderController.text.isEmpty) {
      _showError('يرجى إدخال اسم حامل البطاقة');
      return;
    }

    final newCard = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'cardNumber': '**** **** **** ${_cardNumberController.text.substring(_cardNumberController.text.length - 4)}',
      'cardHolder': _cardHolderController.text.toUpperCase(),
      'expiry': _expiryController.text,
      'type': _cardNumberController.text.startsWith('4') ? 'visa' : 'mastercard',
      'color': _cardNumberController.text.startsWith('4') ? 0xFF1A237E : 0xFFD32F2F,
      'isDefault': _savedCards.isEmpty,
    };

    setState(() {
      _savedCards.add(newCard);
      _isAddingCard = false;
      _clearControllers();
    });

    _showSuccess('تمت إضافة البطاقة بنجاح');
  }

  void _setDefaultCard(Map<String, dynamic> card) {
    setState(() {
      for (var c in _savedCards) {
        c['isDefault'] = false;
      }
      card['isDefault'] = true;
    });
    _showSuccess('تم تعيين البطاقة كافتراضية');
  }

  void _deleteCard(Map<String, dynamic> card) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('حذف البطاقة'),
        content: const Text('هل أنت متأكد من حذف هذه البطاقة؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _savedCards.remove(card);
                if (card['isDefault'] && _savedCards.isNotEmpty) {
                  _savedCards[0]['isDefault'] = true;
                }
              });
              Navigator.pop(context);
              _showSuccess('تم حذف البطاقة بنجاح');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  void _clearControllers() {
    _cardNumberController.clear();
    _cardHolderController.clear();
    _expiryController.clear();
    _cvvController.clear();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }
}
