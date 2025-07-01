class UserModel {
  final String email;

  UserModel({required this.email});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(email: map['email']);
  }
}
