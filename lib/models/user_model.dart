class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String? avatarUrl;
  final String userType; // customer, merchant, guest
  final DateTime? createdAt;
  final bool isVerified;
  final bool isGuest;
  
  // بيانات إضافية
  final String? nationalId;
  final String? nationality;
  final DateTime? birthDate;
  final String? address;
  final String? city;
  final String? jobTitle;
  final String? companyName;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    this.avatarUrl,
    this.userType = 'customer',
    this.createdAt,
    this.isVerified = false,
    this.isGuest = false,
    this.nationalId,
    this.nationality,
    this.birthDate,
    this.address,
    this.city,
    this.jobTitle,
    this.companyName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      avatarUrl: json['avatar_url'],
      userType: json['user_type'] ?? 'customer',
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      isVerified: json['is_verified'] ?? false,
      isGuest: json['is_guest'] ?? false,
      nationalId: json['national_id'],
      nationality: json['nationality'],
      birthDate: json['birth_date'] != null ? DateTime.parse(json['birth_date']) : null,
      address: json['address'],
      city: json['city'],
      jobTitle: json['job_title'],
      companyName: json['company_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'avatar_url': avatarUrl,
      'user_type': userType,
      'created_at': createdAt?.toIso8601String(),
      'is_verified': isVerified,
      'is_guest': isGuest,
      'national_id': nationalId,
      'nationality': nationality,
      'birth_date': birthDate?.toIso8601String(),
      'address': address,
      'city': city,
      'job_title': jobTitle,
      'company_name': companyName,
    };
  }
}
