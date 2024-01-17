import 'dart:convert';

import 'package:dini_maak/data/models/user/user_model.dart';
import 'package:dini_maak/main.dart';
import 'package:dini_maak/shared/constants/app_constants.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<UserModel?> getLoggedInUserInformation() async {
    var response = await http.get(Uri.parse("${baseUrl}User"), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    }

    return null;
  }
}
