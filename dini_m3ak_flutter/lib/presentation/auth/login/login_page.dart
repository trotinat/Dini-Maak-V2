// ignore_for_file: use_build_context_synchronously

import 'package:dini_maak/presentation/auth/provider/auth_provider.dart';
import 'package:dini_maak/presentation/auth/signup/signup_page.dart';
import 'package:dini_maak/presentation/bottomnav/navigation_page.dart';
import 'package:dini_maak/shared/widgets/my_button.dart';
import 'package:dini_maak/shared/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static String logininPage = "/login";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _authProvider.fullNameController = TextEditingController();
    _authProvider.passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _authProvider.fullNameController.dispose();
    _authProvider.passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
                const Gap(10),
                MyTextField(
                  controller: _authProvider.fullNameController,
                  hintText: "Usename",
                  prefix: const Icon(
                    Iconsax.user,
                  ),
                ),
                const Gap(15),
                MyTextField(
                  controller: _authProvider.passwordController,
                  hintText: "Password",
                  obscureText: true,
                  suffix: const Icon(Iconsax.eye_slash),
                  prefix: const Icon(
                    Iconsax.lock,
                  ),
                ),
                const Gap(15),
                Consumer<AuthProvider>(
                  builder: (_, data, __) => MyButton(
                    isLoading: data.isRegistring,
                    color: Colors.blue.shade700,
                    text: "Login",
                    onClick: () async {
                      var res = await _authProvider.login();

                      if (res) {
                        Navigator.of(context).pushNamed(NavigationPage.navPage);
                      }
                    },
                    textColor: Colors.white,
                  ),
                ),
                const Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t you have an account?"),
                    const Gap(2),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, SignupPage.signupPage);
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
