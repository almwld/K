class YemenPaymentGateway {
  final String id;
  final String name;
  final String nameAr;
  final String logoUrl;
  final String type;
  final String accountNumber;
  final String instructions;
  final double feePercentage;
  final double fixedFee;
  final bool isActive;
  final String color;

  YemenPaymentGateway({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.logoUrl,
    required this.type,
    required this.accountNumber,
    required this.instructions,
    this.feePercentage = 0.0,
    this.fixedFee = 0.0,
    this.isActive = true,
    this.color = '#D4AF37',
  });
}

class YemenWalletsData {
  static List<YemenPaymentGateway> getAllWallets() {
    return [
      // 1. جيب - Jeeb
      YemenPaymentGateway(
        id: 'jeeb',
        name: 'Jeeb',
        nameAr: 'جيب',
        logoUrl: 'https://play-lh.googleusercontent.com/JR5M7DqEwCbAQnQyZTG4QqGQxNBlxq6NlFk7XQk7X0w?w=240',
        type: 'محفظة إلكترونية',
        accountNumber: '777123456',
        instructions: 'حول إلى رقم جيب: 777123456',
        feePercentage: 0.5,
        fixedFee: 10,
        color: '#1A5F7A',
      ),
      
      // 2. جوالي - YOU Mobile
      YemenPaymentGateway(
        id: 'you_mobile',
        name: 'YOU Mobile',
        nameAr: 'جوالي',
        logoUrl: 'https://play-lh.googleusercontent.com/KbuAbEfH1ZvPzPwYxXpY-7xYpY-7xYpY-7xYpY=w240',
        type: 'محفظة إلكترونية',
        accountNumber: '771234567',
        instructions: 'حول إلى رقم جوالي: 771234567',
        feePercentage: 0.3,
        fixedFee: 5,
        color: '#E31937',
      ),
      
      // 3. ون كاش - One Cash
      YemenPaymentGateway(
        id: 'one_cash',
        name: 'One Cash',
        nameAr: 'ون كاش',
        logoUrl: 'https://play-lh.googleusercontent.com/onecash_logo=w240',
        type: 'محفظة إلكترونية',
        accountNumber: '770123456',
        instructions: 'حول إلى رقم ون كاش: 770123456',
        feePercentage: 0.0,
        fixedFee: 0,
        color: '#00A859',
      ),
      
      // 4. كاش - Cash
      YemenPaymentGateway(
        id: 'cash_wallet',
        name: 'Cash Wallet',
        nameAr: 'كاش',
        logoUrl: 'https://play-lh.googleusercontent.com/cash_wallet_logo=w240',
        type: 'محفظة إلكترونية',
        accountNumber: '773123456',
        instructions: 'حول إلى رقم كاش: 773123456',
        feePercentage: 0.2,
        fixedFee: 8,
        color: '#F5821F',
      ),
      
      // 5. محفظتي - Mahfazati
      YemenPaymentGateway(
        id: 'mahfazati',
        name: 'Mahfazati',
        nameAr: 'محفظتي',
        logoUrl: 'https://play-lh.googleusercontent.com/mahfazati_logo=w240',
        type: 'محفظة إلكترونية',
        accountNumber: '774123456',
        instructions: 'حول إلى رقم محفظتي: 774123456',
        feePercentage: 0.0,
        fixedFee: 0,
        color: '#6B3FA0',
      ),
      
      // 6. فلوسك - Floosak
      YemenPaymentGateway(
        id: 'floosak',
        name: 'Floosak',
        nameAr: 'فلوسك',
        logoUrl: 'https://play-lh.googleusercontent.com/floosak_logo=w240',
        type: 'محفظة إلكترونية',
        accountNumber: '775123456',
        instructions: 'حول إلى رقم فلوسك: 775123456',
        feePercentage: 0.4,
        fixedFee: 12,
        color: '#2E86AB',
      ),
      
      // 7. إيزي يمن - Easy Yemen
      YemenPaymentGateway(
        id: 'easy_yemen',
        name: 'Easy Yemen',
        nameAr: 'إيزي يمن',
        logoUrl: 'https://play-lh.googleusercontent.com/easy_yemen_logo=w240',
        type: 'محفظة إلكترونية',
        accountNumber: '776123456',
        instructions: 'حول إلى رقم إيزي يمن: 776123456',
        feePercentage: 0.1,
        fixedFee: 3,
        color: '#009688',
      ),
      
      // 8. فلكس باي - Flex Pay (المحفظة الخاصة بالمنصة)
      YemenPaymentGateway(
        id: 'flex_pay',
        name: 'Flex Pay',
        nameAr: 'فلكس باي',
        logoUrl: 'https://cdn-icons-png.flaticon.com/512/2331/2331970.png',
        type: 'محفظة المنصة',
        accountNumber: 'فلكس باي',
        instructions: 'استخدم رصيد فلكس باي للدفع',
        feePercentage: 0.0,
        fixedFee: 0,
        color: '#D4AF37',
      ),
    ];
  }
  
  static List<YemenPaymentGateway> getActiveWallets() {
    return getAllWallets().where((w) => w.isActive).toList();
  }
  
  static List<YemenPaymentGateway> getFreeWallets() {
    return getAllWallets().where((w) => w.feePercentage == 0 && w.fixedFee == 0).toList();
  }
}

