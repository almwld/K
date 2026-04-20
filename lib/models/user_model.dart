class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String? phone;
  final String? avatarUrl;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    this.phone,
    this.avatarUrl,
  });
}

