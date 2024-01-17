import 'dart:convert';

class AuthLoginRequest {
  final String username;
  final String password;

  AuthLoginRequest({required this.username, required this.password});

  String toJson() {
    return jsonEncode({"username": username, "password": password});
  }
}
