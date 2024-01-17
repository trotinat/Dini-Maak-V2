import 'dart:io';

import 'package:dini_maak/data/models/auth/auth_login_request.dart';
import 'package:dini_maak/data/models/auth/auth_register_request.dart';
import 'package:dini_maak/data/remote/auth_service.dart';
import 'package:dini_maak/di/locator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  bool isRegistring = false;

  final authService = locator.get<AuthService>();

  File? selectedProfileImage;
  pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedProfileImage = File(image.path);
    }

    notifyListeners();
  }

  Future<bool> registerUser() async {
    isRegistring = true;
    final res = await authService.registerUser(
      authRegisterRequest: AuthRegisterRequest(
        fullname: fullNameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        password: passwordController.text,
        profilePicture: selectedProfileImage!,
      ),
    );
    isRegistring = false;
    return res;
  }

  Future<bool> login() async {
    return authService.loginUser(
      authLoginRequest: AuthLoginRequest(
        username: fullNameController.text,
        password: passwordController.text,
      ),
    );
  }
}
