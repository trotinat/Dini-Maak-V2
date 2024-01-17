import 'dart:io';

class AuthRegisterRequest {
  final String fullname;
  final String email;
  final String phoneNumber;
  final String password;
  final File profilePicture;

  AuthRegisterRequest({
    required this.fullname,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.profilePicture,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "fullname": fullname,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
      "profilePicture": profilePicture
    };
  }
}
