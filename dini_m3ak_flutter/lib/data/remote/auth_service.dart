import 'dart:convert';
import 'package:dini_maak/data/models/auth/auth_login_request.dart';
import 'package:dini_maak/data/models/auth/auth_register_request.dart';
import 'package:dini_maak/di/locator.dart';
import 'package:dini_maak/shared/constants/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _pref = locator.get<SharedPreferences>();
  Future<bool> registerUser({
    required AuthRegisterRequest authRegisterRequest,
  }) async {
    try {
      var request =
          http.MultipartRequest("POST", Uri.parse("${baseUrl}Auth/Register"));

      request.fields['fullname'] = authRegisterRequest.fullname;
      request.fields['email'] = authRegisterRequest.email;
      request.fields['phoneNumber'] = authRegisterRequest.phoneNumber;
      request.fields['password'] = authRegisterRequest.password;

      // Adding file
      // Adding file
      var profilePicStream = http.ByteStream(
          Stream.castFrom(authRegisterRequest.profilePicture.openRead()));
      var length = await authRegisterRequest.profilePicture.length();
      var multipartFile = http.MultipartFile(
        'profilePicture',
        profilePicStream,
        length,
        filename: authRegisterRequest.profilePicture.path.split('/').last,
      );
      request.files.add(multipartFile);

      // Sending the request
      var response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> loginUser({required AuthLoginRequest authLoginRequest}) async {
    try {
      var response = await http.post(
        Uri.parse("${baseUrl}Auth/Login"),
        headers: {"Content-Type": "application/json"},
        body: authLoginRequest.toJson(),
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        _pref.setString("token", responseBody["accessToken"]);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
