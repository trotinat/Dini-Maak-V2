class UserModel {
  final String id;
  final String username;
  final String email;
  final String profilePicture;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.profilePicture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      username: json['username'],
      email: json["email"],
      profilePicture: json["profilePicture"],
    );
  }
}
